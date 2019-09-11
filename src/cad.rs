use std::fmt;
use std::time::{Duration, Instant};

use egg::{
    egraph::{EClass, Metadata},
    expr::{Expr, Language, Name, QuestionMarkName, RecExpr},
    extract::{calculate_cost, Extractor},
    parse::ParsableLanguage,
    pattern::Rewrite,
};

use log::*;
use ordered_float::NotNan;
use strum_macros::{Display, EnumString};

type EGraph = egg::egraph::EGraph<Cad, Meta>;

#[derive(Debug, PartialEq, Eq, Hash, Clone)]
struct Cad;

#[derive(Debug, PartialEq, Eq, Hash, Clone, Copy)]
enum Constant {
    Unit,
    Empty,
    Nil,
    Float(NotNan<f64>),
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
        }
    }
}

#[derive(Debug, PartialEq, Eq, Hash, Clone, EnumString, Display)]
enum Op {
    Float,

    Trans,
    Scale,
    Rotate,

    Union,
    Diff,

    FoldUnion,

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
}

fn eval(op: Op, args: &[Constant]) -> Option<Constant> {
    use Constant::*;
    match op {
        Op::Add => {
            assert_eq!(args.len(), 2);
            match (args[0], args[1]) {
                (Float(f1), Float(f2)) => Some(Float(f1 + f2)),
                _ => panic!(),
            }
        }
        Op::Mul => {
            assert_eq!(args.len(), 2);
            match (args[0], args[1]) {
                (Float(f1), Float(f2)) => Some(Float(f1 * f2)),
                _ => panic!(),
            }
        }
        Op::Div => {
            assert_eq!(args.len(), 2);
            match (args[0], args[1]) {
                (Float(f1), Float(f2)) => Some(Float(f1 / f2)),
                _ => panic!(),
            }
        }
        _ => None,
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
                        Expr::Constant(c) => Some(*c),
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

        Self {
            best: expr.map_children(|c| c.best.clone()).into(),
            cost: Cad::cost(&expr.map_children(|c| c.cost)),
        }
    }

    fn modify(eclass: &mut EClass<Cad, Self>) {
        match &eclass.metadata.best.as_ref() {
            Expr::Constant(c) => eclass.nodes.push(Expr::Constant(*c)),
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

                    Op::Cons => 3,

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

fn rw(name: &str, lhs: &str, rhs: &str) -> Rewrite<Cad> {
    Cad.parse_rewrite(name, lhs, rhs).unwrap()
}

#[rustfmt::skip]
fn rules() -> Vec<Rewrite<Cad>> {
    vec![
        rw("defloat", "(Float ?a)", "?a"),

        rw("lift_union", "(Union ?a ?b)", "(FoldUnion Empty (Cons ?a (Cons ?b Nil)))"),
        rw("union_rec", "(Union ?a (FoldUnion ?b ?c))", "(FoldUnion ?b (Cons ?a ?c))"),
        // rw("union_rec2", "(Union (FoldUnion ?a ?b) ?c)", "(FoldUnion ?a (Cons ?c ?b))"),
        rw("union_self", "(Union ?a ?a)", "?a"),

        rw("union_commute", "(Union ?a ?b)", "(Union ?b ?a)"),

        rw("union_trans",
           "(Union (Trans ?x ?y ?z ?a) (Trans ?x ?y ?z ?b))",
           "(Trans ?x ?y ?z (Union ?a ?b))"),

        rw("diff_union",
           "(Diff (Union ?a ?b) ?c)",
           "(Union ?a (Diff ?b ?c))"),

        rw("diff",
           "(Diff (Diff ?a ?b) ?c)",
           "(Diff ?a (Union ?b ?c))"),

        // NOTE this explode the egraph
        // rw("diff2",
        //    "(Diff ?a (Union ?b ?c))",
        //    "(Diff (Diff ?a ?b) ?c)"),

        rw("combine_trans",
           "(Trans ?x1 ?y1 ?z1 (Trans ?x2 ?y2 ?z2 ?a))",
           "(Trans (+ ?x1 ?x2) (+ ?y1 ?y2) (+ ?z1 ?z2) ?a)"),
        rw("no_trans", "(Trans 0 0 0 ?a)", "?a"),

        rw("lift_scale",
           "(Union (Scale ?x ?y ?z ?a) (Scale ?x ?y ?z ?b))",
           "(Scale ?x ?y ?z (Union ?a ?b))"),

        rw("scale_trans",
           "(Scale ?a ?b ?c (Trans ?x ?y ?z ?m))",
           "(Trans (* ?a ?x) (* ?b ?y) (* ?c ?z) (Scale ?a ?b ?c ?m))"),

        rw("trans_scale",
           "(Trans ?x ?y ?z (Scale ?a ?b ?c ?m))",
           "(Scale ?a ?b ?c (Trans (/ ?x ?a) (/ ?y ?b) (/ ?z ?c) ?m))"),

        rw("scale_rotate",
           "(Scale ?a ?a ?a (Rotate ?x ?y ?z ?m))",
           "(Rotate ?x ?y ?z (Scale ?a ?a ?a ?m))"),

        rw("combine_rotate",
           "(Rotate ?x1 ?y1 ?z1 (Rotate ?x2 ?y2 ?z2 ?a))",
           "(Rotate (+ ?x1 ?x2) (+ ?y1 ?y2) (+ ?z1 ?z2) ?a)"),

        rw("rotate_zero", "(Rotate 0 0 0 ?a)", "?a"),
    ]
}

fn pretty(expr: &RecExpr<Cad>) -> RecExpr<Cad> {
    match expr.as_ref() {
        Expr::Operator(Op::Cons, args) => {
            assert_eq!(args.len(), 2);
            let args = match pretty(&args[1]).as_ref() {
                Expr::Operator(Op::Cons, child_args) => {
                    let mut a = child_args.clone();
                    a.insert(0, args[0].clone());
                    a
                }
                Expr::Constant(Constant::Nil) => args.clone(),
                _ => panic!(),
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
    let rules = rules();
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
    }

    println!(
        "Final size: n={}, e={}",
        egraph.total_size(),
        egraph.number_of_classes()
    );

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
        "cads/soldering-fingers.csexp",
        // "cads/tape.csexp",
        // "cads/dice.csexp",
        // "cads/gear_flat_inl.csexp",
    ];

    for file in files {
        let start = std::fs::read_to_string(file).unwrap();
        let start_expr = Cad.parse_expr(&start).unwrap();
        println!("Expr: {:?}", start_expr);
        let mut egraph = EGraph::default();
        let root = egraph.add_expr(&start_expr);

        let start = Instant::now();
        run_rules(&mut egraph, root, 100, 1_000_000);
        println!("Initial cost: {}", calculate_cost(&start_expr));
        print_time("Total time: ", start.elapsed());
    }
}
