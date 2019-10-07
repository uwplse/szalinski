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

use crate::cad::*;
use crate::num::*;

// the fx, fy, fz values for a given i
pub fn eval_funs (expr: &RecExpr<Cad>, i: usize) -> (f64, f64, f64) {
    let expr = expr.as_ref();
    (0.0, 0.0, 0.0)
}

fn get_num (expr: &RecExpr<Cad>) -> usize {
    let expr = expr.as_ref();
    match expr.op {
        Cad::Num(num) => num.0.into_inner() as usize,
        _ => panic!("Not a num") // is panic the right thing?
    }
}

pub fn cads_to_union (cs: Vec<RecExpr<Cad>>) -> RecExpr<Cad> {
    if cs.len() == 0 {
        RecExpr::from (Expr::unit(Cad::Empty))
    } else if cs.len() == 1 {
        let v = smallvec::SmallVec::new();
        v.push(RecExpr::from (Expr::unit(Cad::Empty)));
        v.push(cs[0]);
        RecExpr::from (Expr::new(Cad::Union, v))
    } else {
        let hd = cs[0];
        let tl = cs.split_off(1);
        let v = smallvec::SmallVec::new();
        v.push(hd);
        v.push(cads_to_union(tl));
        RecExpr::from (Expr::new(Cad::Union, v)) 
    }
}

pub fn eval(expr: &RecExpr<Cad>) -> RecExpr<Cad> {
    let expr = expr.as_ref();
    match expr.op {
        Cad::Unit => RecExpr::from (Expr::unit(Cad::Unit)),
        Cad::Sphere => RecExpr::from (Expr::unit(Cad::Sphere)),
        Cad::Cylinder => RecExpr::from (Expr::unit(Cad::Cylinder)),
        Cad::Hexagon => RecExpr::from (Expr::unit(Cad::Hexagon)),
        Cad::Empty => RecExpr::from (Expr::unit(Cad::Empty)),
        Cad::Repeat => {
            let v = Vec::new();
            let n = expr.children[0];
            let c = expr.children[1];
            for i in 0..(get_num (&n)) {
                v.push(eval(&c));
            }
            cads_to_union(v)
        },
        Cad::Map => {
            let op = expr.children[0];
            let mapi = expr.children[1].as_ref();
            let n = mapi.children[0];
            let fxyz = mapi.children[1];
            let rep = expr.children[2];
            RecExpr::from(Expr::unit(Cad::Unit)) // TODO
        },
        _ => RecExpr::from(Expr::new(expr.op, expr.children))
    }
}


struct Scad<'a>(&'a RecExpr<Cad>);


impl<'a> fmt::Display for Scad<'a> {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        let expr = self.0.as_ref();
        let child = |i: usize| Scad(&expr.children[i]);
        match expr.op {
            Cad::Num(float) => write!(f, "{}", float),
            Cad::Unit => write!(f, "cube()"),
            Cad::Sphere=> write!(f, "sphere($fn = 50)"),
            Cad::Cylinder => write!(f, "cylinder($fn = 50)"),
            Cad::Hexagon => write!(f, "cylinder()"),
            Cad::Trans => write!(f, "translate({}) {};", child(0), child(1)),
            Cad::TransPolar => write!(f, "translate({}) {};", child(0), child(1)),
            Cad::Scale => write!(f, "scale({}) {};", child(0), child(1)),
            Cad::Rotate => write!(f, "rotate({}) {};", child(0), child(1)),
            Cad::Union => write!(f, "union ({}, {})", child(0), child(1)),
            Cad::Inter=> write!(f, "intersection ({}, {})", child(0), child(1)),
            Cad::Diff => write!(f, "difference ({}, {})", child(0), child(1)),
            Cad::Vec => write!(f, "[{}, {}, {}]", child(0), child(1), child(2)),
            Cad::Add => write!(f, "{} + {}", child(0), child(1)),
            Cad::Sub => write!(f, "{} - {}", child(0), child(1)),
            Cad::Mul => write!(f, "{} * {}", child(0), child(1)),
            Cad::Div => write!(f, "{} / {}", child(0), child(1))
        }
    }
}


