use std::fmt;
use std::str::FromStr;

use egg::{
    define_term,
    expr::{Expr, Language, RecExpr},
};

use crate::{
    num::{num, Num},
    permute::{Permutation, Partitioning},
};

use log::*;
pub type EGraph = egg::egraph::EGraph<Cad, Meta>;
pub type EClass = egg::egraph::EClass<Cad, Meta>;
pub type Rewrite = egg::pattern::Rewrite<Cad, Meta>;

pub type Vec3 = (Num, Num, Num);

#[derive(PartialEq, Eq, Hash, Debug, Clone)]
pub struct ListVar(pub &'static str);
impl FromStr for ListVar {
    type Err = ();
    fn from_str(s: &str) -> Result<Self, Self::Err> {
        match s {
            "i" => Ok(ListVar("i")),
            "j" => Ok(ListVar("j")),
            "k" => Ok(ListVar("k")),
            _ => Err(()),
        }
    }
}
impl fmt::Display for ListVar {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "{}", self.0)
    }
}

#[derive(PartialEq, Eq, Hash, Debug, Clone)]
pub struct Variable(pub String);
impl FromStr for Variable {
    type Err = ();
    fn from_str(s: &str) -> Result<Self, Self::Err> {
        warn!("Parsing a variable: {}", s);
        Ok(Variable(s.into()))
    }
}
impl fmt::Display for Variable {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "{}", self.0)
    }
}

define_term! {
    #[derive(Debug, PartialEq, Eq, Hash, Clone)]
    pub enum Cad {
        Cube = "Cube",
        Sphere = "Sphere",
        Cylinder = "Cylinder",
        Hexagon = "Hexagon",
        Empty = "Empty",
        Hull = "Hull",
        Nil = "Nil",
        Num(Num),
        Bool(bool),

        MapI = "MapI",
        ListVar(ListVar),
        Repeat = "Repeat",

        Float = "Float",

        Trans = "Trans",
        TransPolar = "TransPolar",
        Scale = "Scale",
        Rotate = "Rotate",

        Union = "Union",
        Diff = "Diff",
        Inter = "Inter",

        Map = "Map",
        Do = "Do",
        FoldUnion = "FoldUnion",
        FoldInter = "FoldInter",
        Vec3 = "Vec3",

        Cons = "Cons",
        Concat = "Concat",
        List = "List",

        Sort = "Sort",
        Unsort = "Unsort",
        Part = "Part",
        Unpart = "Unpart",
        Unpolar = "Unpolar",

        Permutation(Permutation),
        Partitioning(Partitioning),

        Add = "+",
        Sub = "-",
        Mul = "*",
        Div = "/",

        Variable(Variable),
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
                (Num(f1), Num(f2)) => Some(Num(num(f1.to_f64() + f2.to_f64()))),
                _ => None,
            }
        }
        Sub => {
            assert_eq!(args.len(), 2);
            match (a(0), a(1)) {
                (Num(f1), Num(f2)) => Some(Num(num(f1.to_f64() - f2.to_f64()))),
                _ => None,
            }
        }
        Mul => {
            assert_eq!(args.len(), 2);
            match (a(0), a(1)) {
                (Num(f1), Num(f2)) => Some(Num(num(f1.to_f64() * f2.to_f64()))),
                _ => None,
            }
        }
        Div => {
            assert_eq!(args.len(), 2);
            match (a(0), a(1)) {
                (Num(f1), Num(f2)) => {
                    let f = f1.to_f64() / f2.to_f64();
                    if f.is_finite() {
                        Some(Num(num(f)))
                    } else {
                        None
                    }
                }
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

    fn modify(eclass: &mut EClass) {
        if let Some(list1) = eclass.nodes.iter().find(|n| n.op == Cad::List) {
            for list2 in eclass.nodes.iter().filter(|n| n.op == Cad::List) {
                assert_eq!(list1.children.len(), list2.children.len(), "at id {}", eclass.id)
            }
        }

        // here we prune away excess unsorts, as that will cause some stuff to spin out
        let mut n_unsorts = 1000;
        eclass.nodes.retain(|n| match n.op {
            Cad::Unsort => {
                n_unsorts -= 1;
                n_unsorts >= 0
            }
            _ => true,
        });

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
            Bool(_) => 1,
            Cube | Empty | Nil | Sphere | Cylinder | Hexagon | Hull => 1,
            Repeat => 1,

            Trans => 10,
            TransPolar => 10,
            Scale => 10,
            Rotate => 10,

            Union => 10,
            Diff => 10,
            Inter => 10,

            MapI => return 1,
            ListVar(_) => 1,

            FoldUnion => 9,
            FoldInter => 9,
            Map => 1,
            Do => 30,

            Cons => 3,
            Concat => 1,
            List => 4,
            Vec3 => 2,

            Unpolar => 1000,
            Sort | Unsort | Part | Unpart => 1000,
            Partitioning(_)  => 1000,
            Permutation(_) => 1000,

            Add => 1,
            Sub => 1,
            Mul => 1,
            Div => 1,
            Float => 1,

            Variable(_) => 3,
        };

        cost + children.iter().sum::<u64>()
    }
}
