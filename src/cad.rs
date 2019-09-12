use std::fmt;
use std::time::{Duration, Instant};

use egg::{
    egraph::{EClass, Metadata},
    expr::{Expr, Language, Name, QuestionMarkName, RecExpr},
    extract::{calculate_cost, Extractor},
    parse::ParsableLanguage,
    pattern::Rewrite,
};

use crate::solve::{solve, VecFormula};

use log::*;
use ordered_float::NotNan;
use smallvec::SmallVec;
use strum_macros::{Display, EnumString};

type EGraph = egg::egraph::EGraph<Cad, Meta>;

#[derive(Debug, PartialEq, Eq, Hash, Clone)]
pub struct Cad;

#[derive(Debug, PartialEq, Eq, Hash, Clone)]
pub enum Constant {
    Unit,
    Empty,
    Nil,
    Float(NotNan<f64>),
    MapI(usize, VecFormula),
}

impl std::str::FromStr for Constant {
    type Err = ();
    fn from_str(s: &str) -> Result<Self, ()> {
        if let Ok(v) = f64::from_str(s) {
            let f = NotNan::new(v).unwrap();
            return Ok(Constant::Float(f));
        }

        Ok(match s.trim() {
            "Unit" => Constant::Unit,
            "Empty" => Constant::Empty,
            "Nil" => Constant::Nil,
            _ => return Err(()),
        })
    }
}

impl fmt::Display for Constant {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            Constant::Nil => write!(f, "Nil"),
            Constant::Empty => write!(f, "Empty"),
            Constant::Unit => write!(f, "Unit"),
            Constant::Float(float) => write!(f, "{:5.2}", float),
            Constant::MapI(i, form) => write!(f, "MapI({}, {})", i, form),
        }
    }
}

#[derive(Debug, PartialEq, Eq, Hash, Clone, EnumString, Display)]
pub enum Op {
    Float,

    Trans,
    Scale,
    Rotate,

    Union,
    Diff,

    MapTrans,
    MapRotate,
    FoldUnion,
    Vec,

    Cons,

    #[strum(serialize = "+")]
    Add,
    #[strum(serialize = "*")]
    Mul,
    #[strum(serialize = "/")]
    Div,
}

#[derive(Debug, Clone)]
struct Meta {
    cost: u64,
    best: RecExpr<Cad>,
    list: Option<Vec<(NotNan<f64>, NotNan<f64>, NotNan<f64>)>>,
}

fn eval(op: Op, args: &[Constant]) -> Option<Constant> {
    use Constant::*;
    let a = |i: usize| args[i].clone();
    match op {
        Op::Add => {
            assert_eq!(args.len(), 2);
            match (a(0), a(1)) {
                (Float(f1), Float(f2)) => Some(Float(f1 + f2)),
                _ => panic!(),
            }
        }
        Op::Mul => {
            assert_eq!(args.len(), 2);
            match (a(0), a(1)) {
                (Float(f1), Float(f2)) => Some(Float(f1 * f2)),
                _ => panic!(),
            }
        }
        Op::Div => {
            assert_eq!(args.len(), 2);
            match (a(0), a(1)) {
                (Float(f1), Float(f2)) => Some(Float(f1 / f2)),
                _ => panic!(),
            }
        }
        _ => None,
    }
}

fn get_float(expr: &RecExpr<Cad>) -> NotNan<f64> {
    match expr.as_ref() {
        Expr::Constant(Constant::Float(f)) => f.clone(),
        _ => panic!("Expected float, got {}", expr.to_sexp()),
    }
}

fn get_vec(expr: &RecExpr<Cad>) -> Option<(NotNan<f64>, NotNan<f64>, NotNan<f64>)> {
    if let Expr::Operator(Op::Vec, args) = expr.as_ref() {
        assert_eq!(args.len(), 3);
        let f0 = get_float(&args[0]);
        let f1 = get_float(&args[1]);
        let f2 = get_float(&args[2]);
        Some((f0, f1, f2))
    } else {
        None
    }
}

impl egg::egraph::Metadata<Cad> for Meta {
    type Error = std::convert::Infallible;
    fn merge(&self, other: &Self) -> Self {
        if self.cost <= other.cost {
            self.clone()
        } else {
            other.clone()
        }
    }

    fn make(expr: Expr<Cad, &Self>) -> Self {
        let expr = match expr {
            Expr::Operator(op, args) => {
                let const_args: Option<Vec<Constant>> = args
                    .iter()
                    .map(|meta| match meta.best.as_ref() {
                        Expr::Constant(c) => Some(c.clone()),
                        _ => None,
                    })
                    .collect();

                const_args
                    .and_then(|a| eval(op.clone(), &a))
                    .map(Expr::Constant)
                    .unwrap_or_else(|| Expr::Operator(op, args))
            }
            expr => expr,
        };

        let list = match &expr {
            Expr::Constant(Constant::Nil) => Some(vec![]),
            Expr::Operator(Op::Cons, args) => {
                assert_eq!(args.len(), 2);
                get_vec(&args[0].best).map(|v| {
                    let mut list = vec![v];
                    list.extend(args[1].list.as_ref().unwrap().iter().cloned());
                    list
                })
            }
            _ => None,
        };

        Self {
            best: expr.map_children(|c| c.best.clone()).into(),
            cost: Cad::cost(&expr.map_children(|c| c.cost)),
            list,
        }
    }

    fn modify(eclass: &mut EClass<Cad, Self>) {
        if let Some(list) = eclass.metadata.list.as_ref() {
            if list.len() > 3 {
                if let Some(formula) = solve(list) {
                    println!("Found formula {:?}", formula);
                    let i = list.len();
                    eclass
                        .nodes
                        .push(Expr::Constant(Constant::MapI(i, formula)));
                }
            }
        }
        match &eclass.metadata.best.as_ref() {
            Expr::Constant(c) => eclass.nodes.push(Expr::Constant(c.clone())),
            Expr::Variable(v) => eclass.nodes.push(Expr::Variable(v.clone())),
            _ => (),
        }
    }
}

impl Language for Cad {
    type Constant = Constant;
    type Operator = Op;
    type Variable = Name;
    type Wildcard = QuestionMarkName;

    fn cost(node: &Expr<Self, u64>) -> u64 {
        match node {
            Expr::Constant(_) | Expr::Variable(_) => 1,
            Expr::Operator(op, child_costs) => {
                let cost = match op {
                    Op::Trans => 10,
                    Op::Scale => 10,
                    Op::Rotate => 10,

                    Op::Union => 10,
                    Op::Diff => 10,

                    Op::FoldUnion => 9,
                    Op::MapTrans => 9,
                    Op::MapRotate => 9,

                    Op::Cons => 3,
                    Op::Vec => 0,

                    Op::Add => 3,
                    Op::Mul => 3,
                    Op::Div => 3,
                    Op::Float => 3,
                };

                cost + child_costs.iter().sum::<u64>()
            }
        }
    }
}

fn pretty(expr: &RecExpr<Cad>) -> RecExpr<Cad> {
    match expr.as_ref() {
        Expr::Operator(Op::Cons, args) => {
            assert_eq!(args.len(), 2);
            let args: SmallVec<[_; 2]> = args.iter().map(pretty).collect();
            let args = match args[1].as_ref() {
                Expr::Operator(Op::Cons, child_args) => {
                    let mut a = child_args.clone();
                    a.insert(0, args[0].clone());
                    a
                }
                Expr::Constant(Constant::Nil) => args.clone(),
                // _ => panic!("Cons of {}", p.to_sexp()),
                _ => args.clone(),
            };
            Expr::Operator(Op::Cons, args)
        }
        e => e.map_children(|a| pretty(&a)),
    }
    .into()
}

fn pretty_print(expr: &RecExpr<Cad>) -> String {
    use std::fmt::{Result, Write};
    use symbolic_expressions::Sexp;

    let sexp = pretty(&expr).to_sexp();

    fn pp(buf: &mut String, sexp: &Sexp, level: usize) -> Result {
        if let Sexp::List(list) = sexp {
            let indent = sexp.to_string().len() > 80;
            write!(buf, "(")?;

            for (i, val) in list.iter().enumerate() {
                if indent && i > 0 {
                    write!(buf, "\n")?;
                    for _ in 0..level {
                        write!(buf, "  ")?;
                    }
                }
                pp(buf, val, level + 1)?;
                if i < list.len() - 1 {
                    write!(buf, " ")?;
                }
            }

            write!(buf, ")")?;
            Ok(())
        } else {
            // I don't care about quotes
            write!(buf, "{}", sexp.to_string().trim_matches('"'))
        }
    }

    let mut buf = String::new();
    pp(&mut buf, &sexp, 1).unwrap();
    buf
}

fn print_time(name: &str, duration: Duration) {
    println!(
        "{}: {}.{:06}",
        name,
        duration.as_secs(),
        duration.subsec_micros()
    );
}

fn run_rules<M>(
    egraph: &mut egg::egraph::EGraph<Cad, M>,
    root: u32,
    iters: usize,
    limit: usize,
) -> Duration
where
    M: Metadata<Cad>,
{
    let rules = crate::rules::rules();
    let start_time = Instant::now();

    'outer: for i in 0..iters {
        println!("\n\nIteration {}\n", i);

        let search_time = Instant::now();

        let mut applied = 0;
        let mut total_matches = 0;
        let mut last_total_matches = 0;
        let mut matches = Vec::new();
        for rule in rules.iter() {
            let ms = rule.search(&egraph);
            if !ms.is_empty() {
                matches.push(ms);
            }
            // rule.run(&mut egraph);
            // egraph.rebuild();
        }

        print_time("Search time", search_time.elapsed());

        let match_time = Instant::now();

        for m in matches {
            let actually_matched = m.apply_with_limit(egraph, limit);
            if egraph.total_size() > limit {
                error!("Node limit exceeded. {} > {}", egraph.total_size(), limit);
                break 'outer;
            }

            applied += actually_matched.len();
            total_matches += m.len();

            // log the growth of the egraph
            if total_matches - last_total_matches > 1000 {
                last_total_matches = total_matches;
                let elapsed = match_time.elapsed();
                debug!(
                    "nodes: {}, eclasses: {}, actual: {}, total: {}, us per match: {}",
                    egraph.total_size(),
                    egraph.number_of_classes(),
                    applied,
                    total_matches,
                    elapsed.as_micros() / total_matches as u128
                );
            }
        }

        print_time("Match time", match_time.elapsed());

        let rebuild_time = Instant::now();
        egraph.rebuild();
        print_time("Rebuild time", rebuild_time.elapsed());
        println!(
            "Size: n={}, e={}",
            egraph.total_size(),
            egraph.number_of_classes()
        );

        if applied == 0 {
            println!("Stopping early!");
            break;
        }
    }

    let rules_time = start_time.elapsed();
    print_time("Rules time", rules_time);

    let ext = Extractor::new(&egraph);
    let best = ext.find_best(root);
    println!("Best ({})\n{}", best.cost, pretty_print(&best.expr));

    rules_time
}

#[test]
fn cad_simple() {
    let _ = env_logger::builder().is_test(true).try_init();
    let start = "
       (Union
         (Trans 0 0 0  Unit)
         (Union
           (Trans  0 0 0  Unit)
           (Trans  0 0 0  Unit)))";
    let start_expr = Cad.parse_expr(start).unwrap();
    println!("Expr: {:?}", start_expr);
    let mut egraph = EGraph::default();
    let root = egraph.add_expr(&start_expr);
    run_rules(&mut egraph, root, 5, 20_000);
}

#[test]
fn cad_simple2() {
    let _ = env_logger::builder().is_test(true).try_init();
    let start = "
       (Union
         (Trans  6 7 8  Unit)
         (Union
           (Trans  1 2 3  (Trans  5 5 5  Unit))
           (Trans  4 4 4  (Trans  2 3 4  Unit))))";
    let start_expr = Cad.parse_expr(start).unwrap();
    println!("Expr: {:?}", start_expr);
    let mut egraph = EGraph::default();
    let root = egraph.add_expr(&start_expr);
    run_rules(&mut egraph, root, 3, 20_000);
}

#[test]
fn cad_files() {
    let _ = env_logger::builder().is_test(true).try_init();

    let files = &[
        // "cads/soldering-fingers.csexp",
        "cads/tape.csexp",
        // "cads/dice.csexp",
        // "cads/dice-different.csexp",
        // "cads/gear_flat_inl.csexp",
    ];

    for file in files {
        let start = std::fs::read_to_string(file).unwrap();
        let start_expr = Cad.parse_expr(&start).unwrap();
        println!("Expr: {:?}", start_expr);
        let mut egraph = EGraph::default();
        let root = egraph.add_expr(&start_expr);

        let start = Instant::now();
        run_rules(&mut egraph, root, 100, 3_000_000);
        println!("Initial cost: {}", calculate_cost(&start_expr));
        print_time("Total time: ", start.elapsed());
    }
}
