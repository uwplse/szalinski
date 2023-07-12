use std::fmt;
use std::str::FromStr;
use std::sync::Arc;

use egg::*;

use crate::num::{num, Num};

use log::debug;

pub type EGraph = egg::EGraph<Cad, MetaAnalysis>;
pub type EClass = egg::EClass<Cad, MetaAnalysis>;
pub type Rewrite = egg::Rewrite<Cad, MetaAnalysis>;
pub type Cost = f64;

pub type Vec3 = (Num, Num, Num);

#[derive(PartialEq, Eq, Hash, Debug, Clone, PartialOrd, Ord)]
pub struct ListVar(pub String);
impl FromStr for ListVar {
    type Err = ();
    fn from_str(s: &str) -> Result<Self, Self::Err> {
        if s.starts_with("i") {
            Ok(ListVar(s.into()))
        } else {
            Err(())
        }
    }
}
impl fmt::Display for ListVar {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "{}", self.0)
    }
}

#[derive(PartialEq, Eq, Hash, Debug, Clone, PartialOrd, Ord)]
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

#[derive(Debug, PartialEq, Eq, PartialOrd, Ord, Hash, Clone)]
pub struct VecId(Arc<Vec<Id>>);

impl LanguageChildren for VecId {
    fn len(&self) -> usize {
        self.0.len()
    }
    fn can_be_length(_: usize) -> bool {
        true
    }
    fn from_vec(v: Vec<Id>) -> Self {
        VecId(Arc::new(v))
    }
    fn as_slice(&self) -> &[Id] {
        &self.0
    }
    fn as_mut_slice(&mut self) -> &mut [Id] {
        Arc::make_mut(&mut self.0).as_mut()
    }
}

impl VecId {
    pub fn new(v: Vec<Id>) -> Self {
        VecId(Arc::new(v))
    }
    pub fn as_vec(&self) -> &Vec<Id> {
        &self.0
    }
    pub fn len(&self) -> usize {
        self.0.len()
    }
    pub fn iter(&self) -> impl Iterator<Item = &Id> {
        self.0.iter()
    }
}

define_language! {
    pub enum Cad {
        "Cube" = Cube([Id; 2]),
        "Sphere" = Sphere([Id; 2]),
        "Cylinder" = Cylinder([Id; 3]),
        "Empty" = Empty,
        "Hull" = Hull([Id; 1]),
        "Nil" = Nil,
        Num(Num),
        Bool(bool),

        // TODO: mapI could be a smallvec
        "MapI" = MapI(Vec<Id>),
        ListVar(ListVar),
        "Repeat" = Repeat([Id; 2]),

        "Trans" = Trans,
        "TransPolar" = TransPolar,
        "Scale" = Scale,
        "Rotate" = Rotate,

        "Union" = Union,
        "Diff" = Diff,
        "Inter" = Inter,

        "Map2" = Map2([Id; 3]),
        "Fold" = Fold([Id; 2]),
        "Affine" = Affine([Id; 3]),
        "Binop" = Binop([Id; 3]),

        "Vec3" = Vec3([Id; 3]),

        "Cons" = Cons([Id; 2]),
        "Concat" = Concat([Id; 1]),
        "List" = List(VecId),

        // "Sort" = Sort([Id; 2]),
        "Unsort" = Unsort([Id; 2]),
        // "Part" = Part([Id; 2]),
        "Unpart" = Unpart([Id; 2]),
        "Unpolar" = Unpolar([Id; 3]),

        // Permutation(Permutation),
        // Partitioning(Partitioning),

        "+" = Add([Id; 2]),
        "-" = Sub([Id; 2]),
        "*" = Mul([Id; 2]),
        "/" = Div([Id; 2]),
        "GetAt" = GetAt([Id; 2]),
        BlackBox(BlackBox, Vec<Id>),
    }
}

#[derive(Debug, Default)]
pub struct MetaAnalysis {
    pub checking_enabled: bool,
}

#[derive(Debug, Clone)]
pub struct Meta {
    pub list: Option<VecId>,
    pub cost: Cost,
    pub best: Cad,
}

fn eval(egraph: &EGraph, enode: &Cad) -> Option<Cad> {
    use Cad::*;
    // let a = |i: usize| enode.children()[i].clone();
    match enode {
        Add(args) => {
            assert_eq!(args.len(), 2);
            match (&egraph[args[0]].data.best, &egraph[args[1]].data.best) {
                (Num(f1), Num(f2)) => Some(Num(num(f1.to_f64() + f2.to_f64()))),
                _ => None,
            }
        }
        Sub(args) => {
            assert_eq!(args.len(), 2);
            match (&egraph[args[0]].data.best, &egraph[args[1]].data.best) {
                (Num(f1), Num(f2)) => Some(Num(num(f1.to_f64() - f2.to_f64()))),
                _ => None,
            }
        }
        Mul(args) => {
            assert_eq!(args.len(), 2);
            match (&egraph[args[0]].data.best, &egraph[args[1]].data.best) {
                (Num(f1), Num(f2)) => Some(Num(num(f1.to_f64() * f2.to_f64()))),
                _ => None,
            }
        }
        Div(args) => {
            assert_eq!(args.len(), 2);
            match (&egraph[args[0]].data.best, &egraph[args[1]].data.best) {
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

impl Analysis<Cad> for MetaAnalysis {
    type Data = Meta;

    fn merge(&mut self, a: &mut Self::Data, b: Self::Data) -> DidMerge {
        let mut did_merge = DidMerge(false, false);
        did_merge.0 |= a.list.is_none() && b.list.is_some();
        did_merge.1 |= a.list.is_some() && b.list.is_none();
        did_merge.0 |= a.cost > b.cost;
        did_merge.1 |= a.cost < b.cost;
        if a.list.is_none() {
            a.list = b.list;
        }

        if a.cost > b.cost {
            a.cost = b.cost;
            a.best = b.best;
        }

        did_merge
    }
    fn make(egraph: &EGraph, enode: &Cad) -> Self::Data {
        // let const_args: Option<Vec<Cad>> = enode
        //     .map_children(|&id| {
        //         let e: &Cad = egraph[id].data.best.as_ref();
        //         if e.children().is_empty() {
        //             Some(e.op.clone())
        //         } else {
        //             None
        //         }
        //     })
        //     .collect();

        let best = eval(&egraph, enode).unwrap_or_else(|| enode.clone());

        let cost = CostFn.cost(enode, |id| egraph[id].data.cost);

        let list = match enode {
            Cad::Nil => Some(VecId::new(vec![])),
            Cad::Cons(args) => {
                assert_eq!(args.len(), 2);
                let head = std::iter::once(args[0]);
                let tail_meta = &egraph[args[1]].data;
                tail_meta
                    .list
                    .as_ref()
                    .map(|tail| VecId::new(head.chain(tail.as_vec().iter().copied()).collect()))
                // let tail = tail_meta
                //     .list
                //     .as_ref()
                //     .expect("should be a list here")
                //     .iter()
                //     .copied();
                // Some(head.chain(tail).collect())
            }
            Cad::List(list) => Some(list.clone()),
            _ => None,
        };

        Self::Data { list, best, cost }
    }

    fn modify(egraph: &mut EGraph, id: Id) {
        let eclass = &egraph[id];
        if egraph.analysis.checking_enabled {
            if let Some(list1) = eclass.nodes.iter().find(|n| matches!(n, Cad::List(_))) {
                for list2 in eclass.nodes.iter().filter(|n| matches!(n, Cad::List(_))) {
                    assert_eq!(
                        list1.children().len(),
                        list2.children().len(),
                        // "at id {}, nodes:\n{:#?}",
                        "at id {}",
                        eclass.id,
                        // eclass.nodes
                    )
                }
            }
        }

        if let Some(list) = &eclass.data.list {
            let list = list.clone();
            let id2 = egraph.add(Cad::List(list));
            egraph.union(id, id2);
        }
        let eclass = &egraph[id];

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

        let best = &eclass.data.best;
        if best.is_leaf() {
            let best = best.clone();
            let id2 = egraph.add(best);
            egraph.union(id, id2);
        }
    }
}

pub struct CostFn;
impl egg::CostFunction<Cad> for CostFn {
    type Cost = Cost;

    fn cost<C>(&mut self, enode: &Cad, mut costs: C) -> Self::Cost
    where
        C: FnMut(Id) -> Self::Cost,
    {
        use Cad::*;
        const BIG: f64 = 100_000_000.0;
        const SMALL: f64 = 0.001;

        let cost = match enode {
            Num(n) => {
                let s = format!("{}", n);
                1. + (0.000001 * s.len() as Cost)
            }
            Bool(_) | ListVar(_) => SMALL,
            Add(_args) | Sub(_args) | Mul(_args) | Div(_args) => SMALL,

            BlackBox(..) => 1.0,
            Cube(_) | Empty | Nil | Sphere(_) | Cylinder(_) | Hull(_) => 1.0,

            Trans | TransPolar | Scale | Rotate => 1.0,

            Union | Diff | Inter => 1.0,

            Repeat(_) => 0.99,
            MapI(_) => 1.0,
            Fold(_) => 1.0,
            Map2(_) => 1.0,
            Affine(_) => 1.0,
            Binop(_) => 1.0,

            Concat(_) => 1.0,
            Cons(_) => 1.0,
            List(_) => 1.0,
            Vec3(_) => 1.0,

            Unpolar(_) => BIG,
            Unsort(_) | Unpart(_) => BIG,
            GetAt(_) => 1.0,
            // Sort(_) | Part(_) => BIG,
            // Partitioning(_) => BIG,
            // Permutation(_) => BIG,
        };

        enode.fold(cost, |sum, i| sum + costs(i))
    }
}

pub fn println_cad(egraph: &EGraph, id: Id) {
    pub fn println_cad_impl(egraph: &EGraph, id: Id) {
        let best = &egraph[id].data.best;
        if best.is_leaf() {
            print!("{}", best.to_string());
            return;
        }
        print!("(");
        print!("{}", best.to_string());
        best.for_each(|i| {
            print!(" ");
            println_cad_impl(egraph, i);
        });
        print!(")");
    }
    println_cad_impl(egraph, id);
    println!();
}

// impl Language for Cad {
// }
