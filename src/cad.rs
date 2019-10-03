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
pub type Vec3 = (Num, Num, Num);

#[derive(Debug, PartialEq, Eq, Hash, Clone)]
pub enum Cad {
    Unit,
    Sphere,
    Cylinder,
    Hexagon,
    Empty,
    Nil,
    Num(Num),
    Variable(String),

    MapI,
    ListVar(&'static str),
    Repeat,

    Float,

    Trans,
    TransPolar,
    Scale,
    Rotate,

    Union,
    Diff,
    Inter,

    Map,
    Do,
    FoldUnion,
    FoldInter,
    Vec,

    Cons,
    Concat,
    List,
    Unsort,
    Unpolar,

    Add,
    Sub,
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
            "Hexagon" => Cad::Hexagon,
            "Empty" => Cad::Empty,
            "Nil" => Cad::Nil,
            "Repeat" => Cad::Repeat,

            "Float" => Cad::Float,

            "Trans" => Cad::Trans,
            "TransPolar" => Cad::TransPolar,
            "Scale" => Cad::Scale,
            "Rotate" => Cad::Rotate,

            "Union" => Cad::Union,
            "Diff" => Cad::Diff,
            "Inter" => Cad::Inter,

            "MapI" => Cad::MapI,
            "i" => Cad::ListVar("i"),
            "j" => Cad::ListVar("j"),
            "k" => Cad::ListVar("k"),

            "Map" => Cad::Map,
            "Do" => Cad::Do,
            "FoldUnion" => Cad::FoldUnion,
            "FoldInter" => Cad::FoldInter,
            "Vec" => Cad::Vec,
            "Unsort" => Cad::Unsort,
            "Unpolar" => Cad::Unpolar,

            "Cons" => Cad::Cons,
            "Concat" => Cad::Concat,
            "List" => Cad::List,

            "+" => Cad::Add,
            "-" => Cad::Sub,
            "*" => Cad::Mul,
            "/" => Cad::Div,

            s => {
                println!("Parsing a variable: {}", s);
                Cad::Variable(s.into())
            }
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
            Cad::Hexagon => write!(f, "Hexagon"),
            Cad::Num(float) => {
                // write!(f, "{:.150}", float)
                if float.fract() == 0.0 {
                    write!(f, "{:3.0}", float)
                } else {
                    write!(f, "{:5.2}", float)
                }
            }
            Cad::MapI => write!(f, "MapI"),
            Cad::ListVar(s) => write!(f, "{}", s),
            Cad::Repeat => write!(f, "Repeat"),

            Cad::Trans => write!(f, "Trans"),
            Cad::TransPolar => write!(f, "TransPolar"),
            Cad::Scale => write!(f, "Scale"),
            Cad::Rotate => write!(f, "Rotate"),

            Cad::Float => write!(f, "Float"),

            Cad::Union => write!(f, "Union"),
            Cad::Diff => write!(f, "Diff"),
            Cad::Inter => write!(f, "Inter"),

            Cad::Map => write!(f, "Map"),
            Cad::Do => write!(f, "Do"),
            Cad::FoldUnion => write!(f, "FoldUnion"),
            Cad::FoldInter => write!(f, "FoldInter"),
            Cad::Vec => write!(f, "Vec"),

            Cad::Cons => write!(f, "Cons"),
            Cad::Concat => write!(f, "Concat"),
            Cad::List => write!(f, "List"),
            Cad::Unsort => write!(f, "Unsort"),
            Cad::Unpolar => write!(f, "Unpolar"),

            Cad::Add => write!(f, "+"),
            Cad::Sub => write!(f, "-"),
            Cad::Mul => write!(f, "*"),
            Cad::Div => write!(f, "/"),

            Cad::Variable(s) => write!(f, "var'{}'", s),
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
                _ => None,
            }
        }
        Sub => {
            assert_eq!(args.len(), 2);
            match (a(0), a(1)) {
                (Num(f1), Num(f2)) => Some(Num(f1 - f2)),
                _ => None,
            }
        }
        Mul => {
            assert_eq!(args.len(), 2);
            match (a(0), a(1)) {
                (Num(f1), Num(f2)) => Some(Num(f1 * f2)),
                _ => None,
            }
        }
        Div => {
            assert_eq!(args.len(), 2);
            match (a(0), a(1)) {
                (Num(f1), Num(f2)) => Some(Num(f1 / f2)),
                _ => None,
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
    }
}

impl Language for Cad {
    fn cost(&self, children: &[u64]) -> u64 {
        use Cad::*;
        let cost = match self {
            Num(_) => 1,
            Unit | Empty | Nil | Sphere | Cylinder | Hexagon => 1,
            Repeat => 5,

            Trans => 10,
            TransPolar => 10,
            Scale => 10,
            Rotate => 10,

            Union => 10,
            Diff => 10,
            Inter => 10,

            MapI => 1,
            ListVar(_) => 1,

            FoldUnion => 9,
            FoldInter => 9,
            Map => 9,
            Do => 3,

            Cons => 3,
            Concat => 3,
            List => 3,
            Unsort | Unpolar => 3,
            Vec => 2,

            Add => 3,
            Sub => 3,
            Mul => 3,
            Div => 3,
            Float => 3,

            Variable(_) => 3,
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
            let actually_matched = m.apply_with_limit(egraph, limit).len();
            if egraph.total_size() > limit {
                error!("Node limit exceeded. {} > {}", egraph.total_size(), limit);
                break 'outer;
            }

            applied += actually_matched;
            if actually_matched > 0 {
                println!("Applied {} {} times", m.rewrite.name, actually_matched);
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
