use std::fmt;
use std::str::FromStr;

use egg::*;

use crate::{
    num::{num, Num},
    permute::{Partitioning, Permutation},
};

use log::debug;

pub type EGraph = egg::EGraph<Cad, Meta>;
pub type EClass = egg::EClass<Cad, Meta>;
pub type Rewrite = egg::Rewrite<Cad, Meta>;
pub type Cost = f64;

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
pub struct BlackBox(String);
impl FromStr for BlackBox {
    type Err = ();
    fn from_str(s: &str) -> Result<Self, Self::Err> {
        debug!("Parsing black box: {}", s);
        Ok(BlackBox(s.to_owned()))
    }
}
impl fmt::Display for BlackBox {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        let s = self.0.replace("\\\"", "\"");
        write!(f, "{}", s)
    }
}

define_language! {
    pub enum Cad {
        Cube = "Cube",
        Sphere = "Sphere",
        Cylinder = "Cylinder",
        Empty = "Empty",
        Hull = "Hull",
        Nil = "Nil",
        Num(Num),
        Bool(bool),

        MapI = "MapI",
        ListVar(ListVar),
        Repeat = "Repeat",

        Trans = "Trans",
        TransPolar = "TransPolar",
        Scale = "Scale",
        Rotate = "Rotate",

        Union = "Union",
        Diff = "Diff",
        Inter = "Inter",

        Map2 = "Map2",
        Fold = "Fold",
        Affine = "Affine",
        Binop = "Binop",

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
        BlackBox(BlackBox),
    }
}

#[derive(Debug, Clone)]
pub struct Meta {
    pub cost: Cost,
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
                    if f.is_finite() && !f2.is_close(0) {
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

impl Metadata<Cad> for Meta {
    type Error = std::convert::Infallible;
    fn merge(&self, other: &Self) -> Self {
        if self.cost <= other.cost {
            self.clone()
        } else {
            other.clone()
        }
    }

    fn make(expr: ENode<Cad, &Self>) -> Self {
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
                .map(ENode::leaf)
                .unwrap_or_else(|| ENode::new(expr.op.clone(), args.clone()))
        };

        Self {
            best: expr.map_children(|c| c.best.clone()).into(),
            cost: CostFn.cost(&expr.map_children(|c| c.cost)),
        }
    }

    fn modify(eclass: &mut EClass) {
        if let Some(list1) = eclass.nodes.iter().find(|n| n.op == Cad::List) {
            for list2 in eclass.nodes.iter().filter(|n| n.op == Cad::List) {
                assert_eq!(
                    list1.children.len(),
                    list2.children.len(),
                    "at id {}, nodes:\n{:#?}",
                    eclass.id,
                    eclass.nodes
                )
            }
        }

        // // here we prune away excess unsorts, as that will cause some stuff to spin out
        // let mut n_unsorts = 0;
        // let limit = 1000;
        // eclass.nodes.retain(|n| match n.op {
        //     Cad::Unsort => {
        //         n_unsorts += 1;
        //         n_unsorts <= limit
        //     }
        //     _ => true,
        // });
        // if n_unsorts > limit {
        //     warn!("Went over unsort limit: {} > {}", n_unsorts, limit);
        // }

        let best = eclass.metadata.best.as_ref();
        if best.children.is_empty() {
            eclass.nodes.push(ENode::leaf(best.op.clone()))
        }
    }
}


pub struct CostFn;
impl egg::CostFunction<Cad> for CostFn {
    type Cost = Cost;

    fn cost(&mut self, enode: &ENode<Cad, Cost>) -> Cost {
        use Cad::*;
        const BIG: f64 = 100_000_000.0;
        const SMALL: f64 = 0.001;

        let cost = match enode.op {
            Num(n) => {
                let s = format!("{}", n);
                0.000001 * s.len() as Cost
            }
            Bool(_) | ListVar(_) => SMALL,
            Add | Sub | Mul | Div => SMALL,

            BlackBox(_) => 1.0,
            Cube | Empty | Nil | Sphere | Cylinder | Hull => 1.0,

            Trans | TransPolar | Scale | Rotate => 1.0,

            Union | Diff | Inter => 1.0,

            Repeat => 0.99,
            MapI => 1.0,
            Fold => 1.0,
            Map2 => 1.0,
            Affine => 1.0,
            Binop => 1.0,

            Concat => 1.0,
            Cons => 1.0,
            List => 1.0,
            Vec3 => 1.0,

            Unpolar => BIG,
            Sort | Unsort | Part | Unpart => BIG,
            Partitioning(_) => BIG,
            Permutation(_) => BIG,
        };

        cost + enode.children.iter().sum::<Cost>()
    }
}

// impl Language for Cad {
// }
