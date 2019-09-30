use std::fmt;
use std::time::Instant;

use egg::{
    egraph::EClass,
    expr::{Expr, Language, RecExpr},
    extract::{CostExpr, Extractor},
};

use crate::solve::VecFormula;

use log::*;
use ordered_float::NotNan;

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
    Do,
    FoldUnion,
    Vec,

    Cons,
    Concat,
    List,

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
            "Do" => Cad::Do,
            "FoldUnion" => Cad::FoldUnion,
            "Vec" => Cad::Vec,

            "Cons" => Cad::Cons,
            "Concat" => Cad::Concat,
            "List" => Cad::List,

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
            Cad::Do => write!(f, "Do"),
            Cad::FoldUnion => write!(f, "FoldUnion"),
            Cad::Vec => write!(f, "Vec"),

            Cad::Cons => write!(f, "Cons"),
            Cad::Concat => write!(f, "Concat"),
            Cad::List => write!(f, "List"),

            Cad::Add => write!(f, "+"),
            Cad::Mul => write!(f, "*"),
            Cad::Div => write!(f, "/"),
        }
    }
}

#[derive(Debug, Clone)]
pub struct Meta {
    pub cost: u64,
    pub best: RecExpr<Cad>,
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

        Self {
            best: expr.map_children(|c| c.best.clone()).into(),
            cost: expr.map_children(|c| c.cost).cost(),
        }
    }

    fn modify(eclass: &mut EClass<Cad, Self>) {
        let best = eclass.metadata.best.as_ref();
        if best.children.is_empty() {
            eclass.nodes.push(Expr::unit(best.op.clone()))
        }
        // NOTE
        // this prunes away any conses that are hanging around if
        // there's already a list in the eclass
        if eclass.nodes.iter().find(|e| e.op == Cad::List).is_some() {
            let len = eclass.nodes.len();
            eclass.nodes.retain(|e| e.op != Cad::Cons);
            debug!("Dropped {} conses", len - eclass.nodes.len());
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
            Do => 3,

            Cons => 3,
            Concat => 3,
            List => 3,
            Vec => 2,

            Add => 3,
            Mul => 3,
            Div => 3,
            Float => 3,
        };

        cost + children.iter().sum::<u64>()
    }
}

pub fn pretty_print(expr: &RecExpr<Cad>) -> String {
    use std::fmt::{Result, Write};
    use symbolic_expressions::Sexp;

    let sexp = expr.to_sexp();

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

pub fn run_rules(
    egraph: &mut egg::egraph::EGraph<Cad, Meta>,
    root: u32,
    iters: usize,
    limit: usize,
) -> CostExpr<Cad> {
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
        }

        println!("Search time: {:?}", search_time.elapsed());

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

        println!("Match time: {:?}", match_time.elapsed());

        let rebuild_time = Instant::now();
        egraph.rebuild();
        println!("Rebuild time: {:?}", rebuild_time.elapsed());
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
    println!("Rules time: {:?}", rules_time);

    let ext = Extractor::new(&egraph);
    let best = ext.find_best(root);
    println!("Best ({})\n{}", best.cost, pretty_print(&best.expr));

    best
}
