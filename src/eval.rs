use std::fmt;
use std::time::Instant;

use smallvec::smallvec;

use egg::{
    egraph::EClass,
    expr::{Expr, Language, RecExpr},
    extract::{CostExpr, Extractor},
};

use crate::solve::VecFormula;

use log::*;
use ordered_float::NotNan;

use crate::cad::*;
use crate::num::*;

macro_rules! rec {
    ($op:expr) => {RecExpr::from(Expr::unit($op))};
    ($op:expr, $($arg:expr),*) => {
        RecExpr::from(Expr::new($op, smallvec![$($arg),*]))
    };
}

fn get_num(expr: &RecExpr<Cad>) -> f64 {
    let expr = expr.as_ref();
    match expr.op {
        Cad::Num(num) => num.0.into_inner() as f64,
        _ => panic!("Not a num"), // is panic the right thing?
    }
}

fn eval_fun(expr: &RecExpr<Cad>, i: usize) -> f64 {
    let expr = expr.as_ref();
    match &expr.op {
        Cad::Num(num) => get_num(&rec!(expr.op.clone())),
        Cad::Variable(v) => i as f64,
        Cad::Add => {
            let a = expr.children[0].clone();
            let b = expr.children[1].clone();
            eval_fun(&a, i) + eval_fun(&b, i)
        }
        Cad::Mul => {
            let a = expr.children[0].clone();
            let b = expr.children[1].clone();
            eval_fun(&a, i) * eval_fun(&b, i)
        }
        // TODO sub and div
        _ => panic!("Cannot evaluate non-arithmetic functions"),
    }
}

fn eval_mapi(expr: &RecExpr<Cad>) -> Vec<(f64, f64, f64)> {
    let mapi = expr.as_ref();
    let mut v = Vec::new();
    let n = mapi.children[0].clone();
    let vec = mapi.children[1].as_ref();
    let x = vec.children[0].clone();
    let y = vec.children[1].clone();
    let z = vec.children[2].clone();
    for i in 0..(get_num(&n) as usize) {
        let res = (eval_fun(&x, i), eval_fun(&y, i), eval_fun(&z, i));
        v.push(res);
    }
    v
}

pub fn cads_to_union(cs: Vec<RecExpr<Cad>>) -> RecExpr<Cad> {
    let mut cad = rec!(Cad::Empty);
    for c in cs {
        cad = rec!(Cad::Union, c, cad);
    }
    cad
}

pub fn eval(expr: &RecExpr<Cad>) -> RecExpr<Cad> {
    let expr = expr.as_ref();
    let arg = |i: usize| expr.children[i].clone();
    match &expr.op {
        Cad::Unit => rec!(Cad::Unit),
        Cad::Sphere => rec!(Cad::Sphere),
        Cad::Cylinder => rec!(Cad::Cylinder),
        Cad::Hexagon => rec!(Cad::Hexagon),
        Cad::Empty => rec!(Cad::Empty),
        Cad::Trans => rec!(Cad::Trans, arg(0), arg(1)),
        Cad::TransPolar => rec!(Cad::Trans, arg(0), arg(1)),
        Cad::Scale => rec!(Cad::Scale, arg(0), arg(1)),
        Cad::Rotate => rec!(Cad::Rotate, arg(0), arg(1)),
        Cad::Diff => rec!(Cad::Diff, arg(0), arg(1)),
        Cad::Inter => rec!(Cad::Inter, arg(0), arg(1)),
        Cad::Union => rec!(Cad::Union, arg(0), arg(1)),
        Cad::Repeat => rec!(Cad::Repeat, arg(0), arg(1)),
        Cad::FoldUnion => eval(&expr.children[0]),
        Cad::Map => {
            let op = &expr.children[0].as_ref().op;
            let mapi = &expr.children[1];
            let fs = eval_mapi(&mapi);
            let rep = &expr.children[2];
            let c = eval(&rep.as_ref().children[1]);
            let mut v = Vec::new();
            for i in 0..fs.len() {
                let vx = rec!(Cad::Num(fs[i].0.into()));
                let vy = rec!(Cad::Num(fs[i].1.into()));
                let vz = rec!(Cad::Num(fs[i].2.into()));
                let a = rec!(Cad::Vec, vx, vy, vz);
                v.push(rec!(op.clone(), a, c.clone()));
            }
            cads_to_union(v)
        }
        _ => RecExpr::from(expr.clone()),
    }
}

struct Scad<'a>(&'a RecExpr<Cad>);

impl<'a> fmt::Display for Scad<'a> {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        let expr = eval(self.0);
        let expr = expr.as_ref();
        let child = |i: usize| Scad(&expr.children[i]);
        match expr.op {
            Cad::Num(float) => write!(f, "{}", float),
            Cad::Empty => write!(f, "sphere(r=0);"),
            Cad::Unit => write!(f, "cube();"),
            Cad::Sphere => write!(f, "sphere($fn = 50);"),
            Cad::Cylinder => write!(f, "cylinder($fn = 50);"),
            Cad::Hexagon => write!(f, "cylinder();"),
            Cad::Trans => write!(f, "translate({}) {}", child(0), child(1)),
            Cad::TransPolar => write!(f, "translate({}) {}", child(0), child(1)),
            Cad::Scale => write!(f, "scale ({}) {}", child(0), child(1)),
            Cad::Rotate => write!(f, "rotate ({}) {}", child(0), child(1)),
            Cad::Union => write!(f, "union () {{ {} {} }}", child(0), child(1)),
            Cad::Inter => write!(f, "intersection () {{ {} {} }}", child(0), child(1)),
            Cad::Diff => write!(f, "difference () {{ {} {} }}", child(0), child(1)),
            Cad::Vec => write!(f, "[{}, {}, {}]", child(0), child(1), child(2)),
            Cad::Add => write!(f, "{} + {}", child(0), child(1)),
            Cad::Sub => write!(f, "{} - {}", child(0), child(1)),
            Cad::Mul => write!(f, "{} * {}", child(0), child(1)),
            Cad::Div => write!(f, "{} / {}", child(0), child(1)),
            _ => write!(f, "TODO"),
        }
    }
}

#[test]
fn eval_prim() {
    let input = rec!(Cad::Sphere);
    let output = eval(&input);
    assert_eq!(output, rec!(Cad::Sphere));
}

#[test]
fn eval_affine() {
    let input = rec!(
        Cad::Trans,
        rec!(
            Cad::Vec,
            rec!(Cad::Num(2.into())),
            rec!(Cad::Num(3.into())),
            rec!(Cad::Num(5.into()))
        ),
        rec!(Cad::Unit)
    );
    let output = eval(&input);
    assert_eq!(output, input);
}

#[test]
fn scad_foldunion() {
    let fx = rec!(Cad::Add, rec!(Cad::Mul, rec!(Cad::Num(2.into())), rec!(Cad::Variable(Variable("i".into())))), rec!(Cad::Num(3.into())));
    let fy = rec!(Cad::Num(5.into()));
    let fz = rec!(Cad::Num(7.into()));
    let mapi = rec!(Cad::MapI, rec!(Cad::Num(3.into())), rec!(Cad::Vec, fx, fy, fz));
    let map = rec!(Cad::Map, rec!(Cad::TransPolar), mapi, rec!(Cad::Repeat, rec!(Cad::Num(3.into())), rec!(Cad::Sphere)));
    let input = rec!(Cad::FoldUnion, map);
    let output = eval(&input);
    assert_eq!(format!("{}", Scad(&input)), format!("{}", Scad(&output)));
}
