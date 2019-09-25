use std::fmt;
use std::time::{Duration, Instant};

use egg::{
    egraph::{EClass, Metadata},
    expr::{Expr, Language, RecExpr},
    extract::Extractor,
};

use crate::solve::{solve, VecFormula};

use log::*;
use ordered_float::NotNan;
use smallvec::SmallVec;

pub type EGraph = egg::egraph::EGraph<Cad, Meta>;
pub type Num = NotNan<f64>;

#[derive(Debug, PartialEq, Eq, Hash, Clone)]
pub enum Cad {
    Unit,
    Sphere,
    Cylinder,
    Empty,
    Nil,
    Num(Num),
    MapI(usize, VecFormula),
    Repeat,

    Float,

    Trans,
    Scale,
    Rotate,

    Union,
    Diff,

    Map,
    FoldUnion,
    Vec,

    Cons,

    Add,
    Mul,
    Div,
}

impl std::str::FromStr for Cad {
    type Err = ();
    fn from_str(s: &str) -> Result<Self, ()> {
        if let Ok(v) = f64::from_str(s) {
            let f = NotNan::new(v).unwrap();
            return Ok(Cad::Num(f));
        }

        Ok(match s.trim() {
            "Unit" => Cad::Unit,
            "Sphere" => Cad::Sphere,
            "Cylinder" => Cad::Cylinder,
            "Empty" => Cad::Empty,
            "Nil" => Cad::Nil,
            "Repeat" => Cad::Repeat,

            "Float" => Cad::Float,

            "Trans" => Cad::Trans,
            "Scale" => Cad::Scale,
            "Rotate" => Cad::Rotate,

            "Union" => Cad::Union,
            "Diff" => Cad::Diff,

            "Map" => Cad::Map,
            "FoldUnion" => Cad::FoldUnion,
            "Vec" => Cad::Vec,

            "Cons" => Cad::Cons,

            "+" => Cad::Add,
            "*" => Cad::Mul,
            "/" => Cad::Div,

            _ => return Err(()),
        })
    }
}

impl fmt::Display for Cad {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            Cad::Nil => write!(f, "Nil"),
            Cad::Empty => write!(f, "Empty"),
            Cad::Unit => write!(f, "Unit"),
            Cad::Sphere => write!(f, "Sphere"),
            Cad::Cylinder => write!(f, "Cylinder"),
            Cad::Num(float) => {
                if float.fract() == 0.0 {
                    write!(f, "{:3.0}", float)
                } else {
                    write!(f, "{:5.2}", float)
                }
            }
            Cad::MapI(i, form) => write!(f, "MapI({}, {})", i, form),
            Cad::Repeat => write!(f, "Repeat"),

            Cad::Trans => write!(f, "Trans"),
            Cad::Scale => write!(f, "Scale"),
            Cad::Rotate => write!(f, "Rotate"),

            Cad::Float => write!(f, "Float"),

            Cad::Union => write!(f, "Union"),
            Cad::Diff => write!(f, "Diff"),

            Cad::Map => write!(f, "Map"),
            Cad::FoldUnion => write!(f, "FoldUnion"),
            Cad::Vec => write!(f, "Vec"),

            Cad::Cons => write!(f, "Cons"),

            Cad::Add => write!(f, "+"),
            Cad::Mul => write!(f, "*"),
            Cad::Div => write!(f, "/"),
        }
    }
}

#[derive(Debug, Clone)]
pub struct Meta {
    cost: u64,
    best: RecExpr<Cad>,
    list: Option<Vec<(NotNan<f64>, NotNan<f64>, NotNan<f64>)>>,
}

fn eval(op: Cad, args: &[Cad]) -> Option<Cad> {
    use Cad::*;
    let a = |i: usize| args[i].clone();
    match op {
        Add => {
            assert_eq!(args.len(), 2);
            match (a(0), a(1)) {
                (Num(f1), Num(f2)) => Some(Num(f1 + f2)),
                _ => panic!(),
            }
        }
        Mul => {
            assert_eq!(args.len(), 2);
            match (a(0), a(1)) {
                (Num(f1), Num(f2)) => Some(Num(f1 * f2)),
                _ => panic!(),
            }
        }
        Div => {
            assert_eq!(args.len(), 2);
            match (a(0), a(1)) {
                (Num(f1), Num(f2)) => Some(Num(f1 / f2)),
                _ => panic!(),
            }
        }
        _ => None,
    }
}

fn get_float(expr: &RecExpr<Cad>) -> NotNan<f64> {
    match expr.as_ref().op {
        Cad::Num(f) => f.clone(),
        _ => panic!("Expected float, got {}", expr.to_sexp()),
    }
}

fn get_vec(expr: &RecExpr<Cad>) -> Option<(NotNan<f64>, NotNan<f64>, NotNan<f64>)> {
    if Cad::Vec == expr.as_ref().op {
        let args = &expr.as_ref().children;
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
        let expr = if expr.children.is_empty() {
            expr
        } else {
            let args = &expr.children;
            let const_args: Option<Vec<Cad>> = args
                .iter()
                .map(|meta| {
                    let e = meta.best.as_ref();
                    if e.children.is_empty() {
                        Some(e.op.clone())
                    } else {
                        None
                    }
                })
                .collect();

            const_args
                .and_then(|a| eval(expr.op.clone(), &a))
                .map(Expr::unit)
                .unwrap_or_else(|| Expr::new(expr.op.clone(), args.clone()))
        };

        let list = match &expr.op {
            Cad::Nil => Some(vec![]),
            Cad::Cons => {
                let args = &expr.children;
                assert_eq!(args.len(), 2);
                let v = get_vec(&args[0].best);
                let rest = args[1].list.as_ref();
                if let (Some(v), Some(rest)) = (v, rest) {
                    let mut list = vec![v];
                    list.extend(rest.iter().cloned());
                    Some(list)
                } else {
                    None
                }
            }
            _ => None,
        };

        Self {
            best: expr.map_children(|c| c.best.clone()).into(),
            cost: expr.map_children(|c| c.cost).cost(),
            list,
        }
    }

    fn modify(eclass: &mut EClass<Cad, Self>) {
        if let Some(list) = eclass.metadata.list.as_ref() {
            if list.len() > 3 {
                if let Some(formula) = solve(list) {
                    println!("Found formula {:?}", formula);
                    let i = list.len();
                    eclass.nodes.push(Expr::unit(Cad::MapI(i, formula)));
                }
            }
        }
        let best = eclass.metadata.best.as_ref();
        if best.children.is_empty() {
            eclass.nodes.push(Expr::unit(best.op.clone()))
        }
    }
}

impl Language for Cad {
    fn cost(&self, children: &[u64]) -> u64 {
        use Cad::*;
        let cost = match self {
            Num(_) => 1,
            MapI(_, _) => 1,
            Unit | Empty | Nil | Sphere | Cylinder => 1,
            Repeat => 5,

            Trans => 10,
            Scale => 10,
            Rotate => 10,

            Union => 10,
            Diff => 10,

            FoldUnion => 9,
            Map => 9,

            Cons => 3,
            Vec => 0,

            Add => 3,
            Mul => 3,
            Div => 3,
            Float => 3,
        };

        cost + children.iter().sum::<u64>()
    }
}

fn pretty(expr: &RecExpr<Cad>) -> RecExpr<Cad> {
    let e = expr.as_ref();
    if e.op == Cad::Cons {
        let args = &e.children;
        assert_eq!(args.len(), 2);
        let args: SmallVec<[_; 2]> = args.iter().map(pretty).collect();
        let e1 = args[1].as_ref();
        let args = match e1.op {
            Cad::Cons => {
                let mut a = e1.children.clone();
                a.insert(0, args[0].clone());
                a
            }
            Cad::Nil => args.clone(),
            // _ => panic!("Cons of {}", p.to_sexp()),
            _ => args.clone(),
        };
        Expr::new(Cad::Cons, args)
    } else {
        e.map_children(|a| pretty(&a))
    }
    .into()
}

pub fn pretty_print(expr: &RecExpr<Cad>) -> String {
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

pub fn run_rules<M>(
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
