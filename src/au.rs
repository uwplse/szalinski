use std::{
    collections::{
        hash_map::{self, Entry},
        HashMap, HashSet,
    },
    mem::discriminant,
};

use egg::{Id, Language};
use indexmap::map::OccupiedEntry;
use itertools::Itertools;
use std::convert::TryInto;

sz_param!(STRUCTURE_MATCH_LIMIT: usize);

use crate::{
    cad::{println_cad, BlackBox, Cad, EGraph, ListVar},
    num::Num,
};

#[derive(Clone, Debug, Hash, PartialEq, PartialOrd, Ord, Eq)]
pub enum CadCtx {
    // Ctx relevant
    Hole,
    Id(Id),

    Cube([Box<CadCtx>; 2]),
    Sphere([Box<CadCtx>; 2]),
    Cylinder([Box<CadCtx>; 3]),
    Empty,
    Hull([Box<CadCtx>; 1]),
    Nil,
    Num(Num),
    Bool(bool),

    // TODO: mapI could be a smallvec
    MapI(Vec<Box<CadCtx>>),
    ListVar(ListVar),
    Repeat([Box<CadCtx>; 2]),

    Trans,
    TransPolar,
    Scale,
    Rotate,

    Union,
    Diff,
    Inter,

    Map2([Box<CadCtx>; 3]),
    Fold([Box<CadCtx>; 2]),
    Affine([Box<CadCtx>; 3]),
    Binop([Box<CadCtx>; 3]),

    Vec3([Box<CadCtx>; 3]),

    Cons([Box<CadCtx>; 2]),
    Concat([Box<CadCtx>; 1]),
    List(Vec<Box<CadCtx>>),

    Unpolar([Box<CadCtx>; 3]),

    Add([Box<CadCtx>; 2]),
    Sub([Box<CadCtx>; 2]),
    Mul([Box<CadCtx>; 2]),
    Div([Box<CadCtx>; 2]),
    BlackBox(BlackBox, Vec<Box<CadCtx>>),
    GetAt([Box<CadCtx>; 2]),
}
pub type ArgList = Vec<Num>;
impl CadCtx {
    pub fn get_params(&self, egraph: &EGraph, id: Id) -> Vec<ArgList> {
        macro_rules! f {
            ($templates:expr, $cad:path $(,[ $arg:ident $check:expr ])*) => {
                egraph[id]
                    .nodes
                    .iter()
                    .filter_map(|n| {
                        if let $cad($($arg,)* children) = n {
                            if true $(&& $check)* {
                                Some(children)
                            } else {
                                None
                            }
                        } else {
                            None
                        }
                    })
                    .flat_map(|children| {
                        $templates
                            .iter()
                            .zip(children.iter())
                            .map(|(temp, child)| temp.get_params(egraph, *child))
                            .multi_cartesian_product()
                            .map(|ms| ms.into_iter().flatten().collect::<ArgList>())
                            .take(*STRUCTURE_MATCH_LIMIT)
                    })
                    .take(*STRUCTURE_MATCH_LIMIT)
                    .collect()
            };
            ($cad:expr) => {
                if $cad == egraph[id].data.best {
                    vec![vec![]]
                } else {
                    vec![]
                }
            };
        }
        match self {
            CadCtx::Hole => {
                if let Cad::Num(n) = egraph[id].data.best {
                    vec![vec![n]]
                } else {
                    vec![]
                }
            }
            CadCtx::Id(id2) => {
                if &id == id2 {
                    vec![vec![]]
                } else {
                    vec![]
                }
            }
            CadCtx::Cube(templates) => f!(templates, Cad::Cube),
            CadCtx::Sphere(templates) => f!(templates, Cad::Sphere),
            CadCtx::Cylinder(templates) => f!(templates, Cad::Cylinder),
            CadCtx::Empty => f!(Cad::Empty),
            CadCtx::Hull(templates) => f!(templates, Cad::Hull),
            CadCtx::Nil => f!(Cad::Nil),
            CadCtx::Num(n) => f!(Cad::Num(*n)),
            CadCtx::Bool(b) => f!(Cad::Bool(*b)),
            CadCtx::MapI(_) => todo!(),
            CadCtx::ListVar(i) => f!(Cad::ListVar(i.clone())),
            CadCtx::Repeat(_) => todo!(),
            CadCtx::Trans => f!(Cad::Trans),
            CadCtx::TransPolar => f!(Cad::TransPolar),
            CadCtx::Scale => f!(Cad::Scale),
            CadCtx::Rotate => f!(Cad::Rotate),
            CadCtx::Union => f!(Cad::Union),
            CadCtx::Diff => f!(Cad::Diff),
            CadCtx::Inter => f!(Cad::Inter),
            CadCtx::Map2(templates) => f!(templates, Cad::Map2),
            CadCtx::Fold(templates) => f!(templates, Cad::Fold),
            CadCtx::Affine(templates) => f!(templates, Cad::Affine),
            CadCtx::Binop(templates) => f!(templates, Cad::Binop),
            CadCtx::Vec3(templates) => f!(templates, Cad::Vec3),
            CadCtx::Cons(templates) => f!(templates, Cad::Cons),
            CadCtx::Concat(templates) => f!(templates, Cad::Concat),
            CadCtx::List(templates) => f!(templates, Cad::List),
            CadCtx::Unpolar(templates) => f!(templates, Cad::Unpolar),
            CadCtx::Add(templates) => f!(templates, Cad::Add),
            CadCtx::Sub(templates) => f!(templates, Cad::Sub),
            CadCtx::Mul(templates) => f!(templates, Cad::Mul),
            CadCtx::Div(templates) => f!(templates, Cad::Div),
            CadCtx::BlackBox(b, templates) => f!(templates, Cad::BlackBox, [b1 b1 == b]),
            CadCtx::GetAt(templates) => f!(templates, Cad::GetAt),
        }
    }
    pub fn size(&self) -> usize {
        match self {
            CadCtx::Hole => 1,
            CadCtx::Id(_) => 1,
            CadCtx::Cube(children) => children.iter().map(|c| c.size()).sum::<usize>(),
            CadCtx::Sphere(children) => children.iter().map(|c| c.size()).sum::<usize>(),
            CadCtx::Cylinder(children) => children.iter().map(|c| c.size()).sum::<usize>(),
            CadCtx::Empty => 1,
            CadCtx::Hull(children) => children.iter().map(|c| c.size()).sum::<usize>(),
            CadCtx::Nil => 1,
            CadCtx::Num(_) => 1,
            CadCtx::Bool(_) => 1,
            CadCtx::MapI(children) => children.iter().map(|c| c.size()).sum::<usize>(),
            CadCtx::ListVar(_) => 1,
            CadCtx::Repeat(children) => children.iter().map(|c| c.size()).sum::<usize>(),
            CadCtx::Trans => 1,
            CadCtx::TransPolar => 1,
            CadCtx::Scale => 1,
            CadCtx::Rotate => 1,
            CadCtx::Union => 1,
            CadCtx::Diff => 1,
            CadCtx::Inter => 1,
            CadCtx::Map2(children) => children.iter().map(|c| c.size()).sum::<usize>() + 1,
            CadCtx::Fold(children) => children.iter().map(|c| c.size()).sum::<usize>() + 1,
            CadCtx::Affine(children) => children.iter().map(|c| c.size()).sum::<usize>() + 1,
            CadCtx::Binop(children) => children.iter().map(|c| c.size()).sum::<usize>() + 1,
            CadCtx::Vec3(children) => children.iter().map(|c| c.size()).sum::<usize>() + 1,
            CadCtx::Cons(children) => children.iter().map(|c| c.size()).sum::<usize>() + 1,
            CadCtx::Concat(children) => children.iter().map(|c| c.size()).sum::<usize>() + 1,
            CadCtx::List(children) => children.iter().map(|c| c.size()).sum::<usize>() + 1,
            CadCtx::Unpolar(children) => children.iter().map(|c| c.size()).sum::<usize>() + 1,
            CadCtx::Add(children) => children.iter().map(|c| c.size()).sum::<usize>() + 1,
            CadCtx::Sub(children) => children.iter().map(|c| c.size()).sum::<usize>() + 1,
            CadCtx::Mul(children) => children.iter().map(|c| c.size()).sum::<usize>() + 1,
            CadCtx::Div(children) => children.iter().map(|c| c.size()).sum::<usize>() + 1,
            CadCtx::BlackBox(_, children) => children.iter().map(|c| c.size()).sum::<usize>() + 1,
            CadCtx::GetAt(children) => children.iter().map(|c| c.size()).sum::<usize>() + 1,
        }
    }
}

pub struct AntiSubst(Vec<Id>);

pub struct AUResult {
    ctx: CadCtx,
    anti_substs: Vec<AntiSubst>,
}

type Cache = HashMap<(Id, Id), Vec<CadCtx>>;

#[derive(Default)]
pub struct AU {
    cache: Cache,
}

impl AU {
    pub fn anti_unify_class(&mut self, egraph: &EGraph, pair: &(Id, Id)) -> &Vec<CadCtx> {
        let pair = &(egraph.find(pair.0), egraph.find(pair.1));
        if self.cache.contains_key(pair) {
            return &self.cache[pair];
        }
        if pair.0 == pair.1 {
            self.cache.insert(pair.clone(), vec![CadCtx::Id(pair.0)]);
            return &self.cache[pair];
        }
        let e1 = &egraph[pair.0];
        let e2 = &egraph[pair.1];

        if let (Cad::Num(a), Cad::Num(b)) = (&e1.data.best, &e2.data.best) {
            assert!(a != b);
            self.cache.insert(pair.clone(), vec![CadCtx::Hole]);
            return &self.cache[pair];
        }

        self.cache.insert(pair.clone(), vec![]);

        let ns1 = &e1.nodes;
        let ns2 = &e2.nodes;
        // TODO: this can be improved
        // TODO: a pre-filtering pass that only process promising a and b (i.e., their children has constrs that match)
        let mut aus = vec![];
        for a in ns1 {
            for b in ns2 {
                if discriminant(a) == discriminant(b) && a.children().len() == b.children().len() {
                    let result = a
                        .children()
                        .iter()
                        .zip(b.children().iter())
                        .map(|(a, b)| self.anti_unify_class(egraph, &(*a, *b)).clone())
                        .multi_cartesian_product()
                        .map(|x| build_cad_ctx(a, x));
                    aus.extend(result);
                };
            }
        }

        // avoids duplicates
        aus.sort();
        aus.dedup();

        self.cache.insert(pair.clone(), aus);
        &self.cache[&pair]
    }
}

fn build_cad_ctx(a: &Cad, xs: Vec<CadCtx>) -> CadCtx {
    fn f<const N: usize>(xs: [CadCtx; N]) -> [Box<CadCtx>; N] {
        xs.map(|x| Box::new(x))
    }
    fn fv(xs: Vec<CadCtx>) -> Vec<Box<CadCtx>> {
        xs.into_iter().map(|x| Box::new(x)).collect()
    }
    match a {
        Cad::Cube(_) => CadCtx::Cube(f(xs.try_into().unwrap())),
        Cad::Sphere(_) => CadCtx::Sphere(f(xs.try_into().unwrap())),
        Cad::Cylinder(_) => CadCtx::Cylinder(f(xs.try_into().unwrap())),
        Cad::Empty => CadCtx::Empty,
        Cad::Hull(_) => CadCtx::Hull(f(xs.try_into().unwrap())),
        Cad::Nil => CadCtx::Nil,
        Cad::Num(n) => CadCtx::Num(*n),
        Cad::Bool(b) => CadCtx::Bool(*b),
        Cad::MapI(_) => CadCtx::MapI(fv(xs)),
        Cad::ListVar(v) => CadCtx::ListVar(v.clone()),
        Cad::Repeat(_) => CadCtx::Repeat(f(xs.try_into().unwrap())),
        Cad::Trans => CadCtx::Trans,
        Cad::TransPolar => CadCtx::TransPolar,
        Cad::Scale => CadCtx::Scale,
        Cad::Rotate => CadCtx::Rotate,
        Cad::Union => CadCtx::Union,
        Cad::Diff => CadCtx::Diff,
        Cad::Inter => CadCtx::Inter,
        Cad::Map2(_) => todo!(),
        Cad::Fold(_) => CadCtx::Fold(f(xs.try_into().unwrap())),
        Cad::Affine(_) => CadCtx::Affine(f(xs.try_into().unwrap())),
        Cad::Binop(_) => CadCtx::Binop(f(xs.try_into().unwrap())),
        Cad::Vec3(_) => CadCtx::Vec3(f(xs.try_into().unwrap())),
        Cad::Cons(_) => CadCtx::Cons(f(xs.try_into().unwrap())),
        Cad::Concat(_) => CadCtx::Concat(f(xs.try_into().unwrap())),
        Cad::List(_) => CadCtx::List(fv(xs)),
        Cad::Unsort(_) => todo!(),
        Cad::Unpart(_) => todo!(),
        Cad::Unpolar(_) => todo!(),
        Cad::Add(_) => CadCtx::Add(f(xs.try_into().unwrap())),
        Cad::Sub(_) => CadCtx::Sub(f(xs.try_into().unwrap())),
        Cad::Mul(_) => CadCtx::Mul(f(xs.try_into().unwrap())),
        Cad::Div(_) => CadCtx::Div(f(xs.try_into().unwrap())),
        Cad::BlackBox(bb, _) => CadCtx::BlackBox(bb.clone(), fv(xs)),
        Cad::GetAt(_) => CadCtx::GetAt(f(xs.try_into().unwrap())),
    }
}

#[derive(Debug)]
pub struct SolveResult {
    // we will only build loops when range is something
    pub ranges: Option<Vec<Id>>,
    pub args: Vec<Id>,
}
impl SolveResult {
    pub(crate) fn assemble(self, egraph: &mut EGraph, template: &CadCtx) -> Id {
        let mut pos_idx = 0;
        let body = self.assemble_impl(egraph, template, &mut pos_idx);
        assert_eq!(pos_idx, self.args.len());
        if let Some(mut children) = self.ranges {
            children.push(body);
            egraph.add(Cad::MapI(children))
        } else {
            body
        }
    }

    fn assemble_impl(&self, egraph: &mut EGraph, template: &CadCtx, arg_index: &mut usize) -> Id {
        macro_rules! f {
            ($templates:expr, $cad:path $(, $arg:expr )*) => {{
                let ids = $templates.iter().map(|temp| self.assemble_impl(egraph, &temp, arg_index)).collect::<Vec<_>>();
                egraph.add($cad($($arg,)* ids.try_into().unwrap()))
            }};

            (@vec $templates:expr, $cad:path $(, $arg:expr )*) => {{
                let ids = $templates.iter().map(|temp| self.assemble_impl(egraph, &temp, arg_index)).collect_vec();
                egraph.add($cad($($arg,)* ids))
            }};
        }
        match template {
            CadCtx::Hole => {
                let hole = self.args[*arg_index];
                *arg_index += 1;
                hole
            }
            CadCtx::Id(id) => *id,
            CadCtx::Cube(templates) => f!(templates, Cad::Cube),
            CadCtx::Sphere(templates) => f!(templates, Cad::Sphere),
            CadCtx::Cylinder(templates) => f!(templates, Cad::Cylinder),
            CadCtx::Empty => egraph.add(Cad::Empty),
            CadCtx::Hull(templates) => f!(templates, Cad::Hull),
            CadCtx::Nil => egraph.add(Cad::Nil),
            CadCtx::Num(n) => egraph.add(Cad::Num(*n)),
            CadCtx::Bool(b) => egraph.add(Cad::Bool(*b)),
            CadCtx::MapI(templates) => f!(@vec templates, Cad::MapI),
            CadCtx::ListVar(v) => egraph.add(Cad::ListVar(v.clone())),
            CadCtx::Repeat(templates) => f!(templates, Cad::Repeat),
            CadCtx::Trans => egraph.add(Cad::Trans),
            CadCtx::TransPolar => egraph.add(Cad::TransPolar),
            CadCtx::Scale => egraph.add(Cad::Scale),
            CadCtx::Rotate => egraph.add(Cad::Rotate),
            CadCtx::Union => egraph.add(Cad::Union),
            CadCtx::Diff => egraph.add(Cad::Diff),
            CadCtx::Inter => egraph.add(Cad::Inter),
            CadCtx::Map2(templates) => f!(templates, Cad::Map2),
            CadCtx::Fold(templates) => f!(templates, Cad::Fold),
            CadCtx::Affine(templates) => f!(templates, Cad::Affine),
            CadCtx::Binop(templates) => f!(templates, Cad::Binop),
            CadCtx::Vec3(templates) => f!(templates, Cad::Vec3),
            CadCtx::Cons(templates) => f!(templates, Cad::Cons),
            CadCtx::Concat(templates) => f!(templates, Cad::Concat),
            CadCtx::List(templates) => f!(@vec templates, Cad::List),
            CadCtx::Unpolar(templates) => f!(templates, Cad::Unpolar),
            CadCtx::Add(templates) => f!(templates, Cad::Add),
            CadCtx::Sub(templates) => f!(templates, Cad::Sub),
            CadCtx::Mul(templates) => f!(templates, Cad::Mul),
            CadCtx::Div(templates) => f!(templates, Cad::Div),
            CadCtx::BlackBox(b, templates) => f!(@vec templates, Cad::BlackBox, b.clone()),
            CadCtx::GetAt(templates) => f!(templates, Cad::GetAt),
        }
    }

    pub fn from_loop_params(ranges: Vec<Id>, args: Vec<Id>) -> SolveResult {
        SolveResult {
            ranges: Some(ranges),
            args,
        }
    }

    pub fn from_constants(args: Vec<Id>) -> SolveResult {
        SolveResult { ranges: None, args }
    }
}
