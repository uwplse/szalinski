use std::collections::HashMap;

use smallvec::smallvec;
use std::fmt;

use egg::expr::{Expr, RecExpr};

use crate::cad::Cad;

macro_rules! rec {
    ($op:expr) => {RecExpr::from(Expr::unit($op))};
    ($op:expr, $($arg:expr),*) => {
        RecExpr::from(Expr::new($op, smallvec![$($arg),*]))
    };
}

fn get_num(expr: &RecExpr<Cad>) -> f64 {
    let expr = expr.as_ref();
    match expr.op {
        Cad::Num(num) => num.to_f64(),
        _ => panic!("Not a num"), // is panic the right thing?
    }
}

fn get_vec3_nums(expr: &RecExpr<Cad>) -> (f64, f64, f64) {
    let expr = expr.as_ref();
    let arg = |i: usize| expr.children[i].clone();
    match expr.op {
        Cad::Vec3 => (get_num(&arg(0)), get_num(&arg(1)), get_num(&arg(2))),
        _ => panic!("Not a vec3"), // is panic the right thing?
    }
}

// from (r, theta, phi) to (x, y, z)
// x=rsinϕcosθ
// y=rsinϕsinθ
// z=rcosϕ
// https://keisan.casio.com/exec/system/1359534351
fn to_cartesian(v: (f64, f64, f64)) -> (f64, f64, f64) {
    fn to_rad(deg: f64) -> f64 {
        deg * std::f64::consts::PI / 180.0
    }
    let r = v.0;
    let th = to_rad(v.1);
    let ph = to_rad(v.2);
    let x = r * ph.sin() * th.cos();
    let y = r * ph.sin() * th.sin();
    let z = r * ph.cos();
    (x, y, z)
}

type FunCtx = HashMap<&'static str, usize>;

fn mk_vec((x, y, z): (f64, f64, f64)) -> RecExpr<Cad> {
    rec!(
        Cad::Vec3,
        rec!(Cad::Num(x.into())),
        rec!(Cad::Num(y.into())),
        rec!(Cad::Num(z.into()))
    )
}

fn mk_list(exprs: Vec<RecExpr<Cad>>) -> RecExpr<Cad> {
    Expr::new(Cad::List, exprs.into()).into()
}

fn eval_list(cx: Option<&FunCtx>, expr: &RecExpr<Cad>) -> Vec<RecExpr<Cad>> {
    let list = eval(cx, expr);
    let list = list.as_ref();
    match &list.op {
        Cad::List => list.children.clone().into_vec(),
        cad => panic!("expected list, got {:?}", cad),
    }
}

pub fn eval(cx: Option<&FunCtx>, expr: &RecExpr<Cad>) -> RecExpr<Cad> {
    let e = expr.as_ref();
    let arg = |i: usize| &e.children[i];
    match &e.op {
        // arith
        Cad::Bool(_) => expr.clone(),
        Cad::Num(_) => expr.clone(),
        Cad::ListVar(v) => {
            let n = cx.unwrap()[v.0];
            rec!(Cad::Num(n.into()))
        }
        Cad::Add => {
            let a = get_num(&eval(cx, arg(0)));
            let b = get_num(&eval(cx, arg(1)));
            rec!(Cad::Num((a + b).into()))
        }
        Cad::Mul => {
            let a = get_num(&eval(cx, arg(0)));
            let b = get_num(&eval(cx, arg(1)));
            rec!(Cad::Num((a * b).into()))
        }
        // cad
        Cad::Cube => rec!(Cad::Cube, eval(cx, arg(0)), eval(cx, arg(1))),
        Cad::Sphere => rec!(Cad::Sphere, eval(cx, arg(0)), eval(cx, arg(1))),
        Cad::Cylinder => rec!(
            Cad::Cylinder,
            eval(cx, arg(0)),
            eval(cx, arg(1)),
            eval(cx, arg(2))
        ),
        Cad::Hexagon => rec!(Cad::Hexagon),
        Cad::Empty => rec!(Cad::Empty),
        Cad::Vec3 => rec!(
            Cad::Vec3,
            eval(cx, arg(0)),
            eval(cx, arg(1)),
            eval(cx, arg(2))
        ),
        Cad::Hull => rec!(Cad::Hull, eval(cx, arg(0))),
        Cad::Trans => rec!(Cad::Trans, eval(cx, arg(0)), eval(cx, arg(1))),
        Cad::TransPolar => {
            let param = eval(cx, arg(0));
            let pnums = get_vec3_nums(&param);
            let cnums = to_cartesian(pnums);
            rec!(Cad::Trans, mk_vec(cnums), eval(cx, arg(1)))
        }
        Cad::Scale => rec!(Cad::Scale, eval(cx, arg(0)), eval(cx, arg(1))),
        Cad::Rotate => rec!(Cad::Rotate, eval(cx, arg(0)), eval(cx, arg(1))),
        Cad::Diff => rec!(Cad::Diff, eval(cx, arg(0)), eval(cx, arg(1))),
        Cad::Inter => rec!(Cad::Inter, eval(cx, arg(0)), eval(cx, arg(1))),
        Cad::Union => rec!(Cad::Union, eval(cx, arg(0)), eval(cx, arg(1))),
        Cad::FoldUnion => rec!(Cad::FoldUnion, eval(cx, arg(0))),
        Cad::FoldInter => rec!(Cad::FoldInter, eval(cx, arg(0))),

        // lists
        Cad::Nil => mk_list(vec![]),
        Cad::Cons => {
            let mut list = eval_list(cx, arg(1));
            list.insert(0, eval(cx, arg(0)));
            mk_list(list)
        }
        Cad::List => mk_list(e.children.iter().map(|e| eval(cx, e)).collect()),
        Cad::Repeat => {
            let n = get_num(&eval(cx, arg(0)));
            let t = eval(cx, arg(1));
            mk_list(vec![t.clone(); n as usize])
        }
        Cad::Concat => {
            let mut vec = Vec::new();
            for list in eval_list(cx, &e.children[0]) {
                for c in eval_list(cx, &list) {
                    vec.push(c)
                }
            }
            mk_list(vec)
        }
        Cad::Map => {
            let op = &e.children[0].as_ref().op;
            let params: Vec<_> = eval_list(cx, &e.children[1]);
            let cads: Vec<_> = eval_list(cx, &e.children[2]);
            mk_list(
                params
                    .into_iter()
                    .zip(cads)
                    .map(|(p, c)| rec!(op.clone(), p, c))
                    .collect(),
            )
        }
        Cad::MapI => {
            let body = e.children.last().unwrap();
            let bounds: Vec<usize> = e.children[..e.children.len() - 1]
                .iter()
                .map(|n| get_num(n) as usize)
                .collect();
            let mut ctx = HashMap::new();
            let mut vec = Vec::new();
            match bounds.len() {
                1 => {
                    for i in 0..bounds[0] {
                        ctx.insert("i", i);
                        vec.push(eval(Some(&ctx), body));
                    }
                }
                2 => {
                    for i in 0..bounds[0] {
                        ctx.insert("i", i);
                        for j in 0..bounds[1] {
                            ctx.insert("j", j);
                            vec.push(eval(Some(&ctx), body));
                        }
                    }
                }
                3 => {
                    for i in 0..bounds[0] {
                        ctx.insert("i", i);
                        for j in 0..bounds[1] {
                            ctx.insert("j", j);
                            for k in 0..bounds[2] {
                                ctx.insert("k", k);
                                vec.push(eval(Some(&ctx), body));
                            }
                        }
                    }
                }
                _ => unimplemented!(),
            }

            mk_list(vec)
        }
        cad => panic!("can't eval({:?})", cad),
    }
}

pub struct Scad<'a>(pub &'a RecExpr<Cad>);

impl<'a> fmt::Display for Scad<'a> {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        let expr = eval(None, self.0);
        let expr = expr.as_ref();
        let arg = |i: usize| expr.children[i].clone();
        let child = |i: usize| Scad(&expr.children[i]);
        match &expr.op {
            Cad::Num(float) => write!(f, "{}", float),
            Cad::Bool(b) => write!(f, "{}", b),
            Cad::Vec3 => write!(f, "[{}, {}, {}]", child(0), child(1), child(2)),
            Cad::Add => write!(f, "{} + {}", child(0), child(1)),
            Cad::Sub => write!(f, "{} - {}", child(0), child(1)),
            Cad::Mul => write!(f, "{} * {}", child(0), child(1)),
            Cad::Div => write!(f, "{} / {}", child(0), child(1)),
            Cad::Empty => writeln!(f, "sphere(r=0);"),
            Cad::Cube => writeln!(f, "cube({}, center={});", child(0), child(1)),
            Cad::Sphere => writeln!(
                f,
                "sphere(r = {}, $fn = {}, $fa = {}, $fs = {});",
                child(0),
                get_vec3_nums(&arg(1)).0,
                get_vec3_nums(&arg(1)).1,
                get_vec3_nums(&arg(1)).2
            ),
            Cad::Cylinder => writeln!(
                f,
                "cylinder(h = {}, r1 = {}, r2 = {}, $fn = {}, $fa = {}, $fs = {}, center = {});",
                get_vec3_nums(&arg(0)).0,
                get_vec3_nums(&arg(0)).1,
                get_vec3_nums(&arg(0)).2,
                get_vec3_nums(&arg(1)).0,
                get_vec3_nums(&arg(1)).1,
                get_vec3_nums(&arg(1)).2,
                child(2),
            ),
            Cad::Hexagon => writeln!(f, "cylinder();"),
            Cad::Hull => write!(f, "hull() {{ {} }}", child(0)),
            Cad::Trans => write!(f, "translate ({}) {}", child(0), child(1)),
            Cad::Scale => write!(f, "scale ({}) {}", child(0), child(1)),
            Cad::Rotate => write!(f, "rotate ({}) {}", child(0), child(1)),
            Cad::Union => write!(f, "union () {{ {} {} }}", child(0), child(1)),
            Cad::Inter => write!(f, "intersection () {{ {} {} }}", child(0), child(1)),
            Cad::Diff => write!(f, "difference () {{ {} {} }}", child(0), child(1)),
            Cad::FoldUnion => {
                write!(f, "union () {{")?;
                for cad in &arg(0).as_ref().children {
                    write!(f, "  {}", Scad(cad))?;
                }
                write!(f, "}}")
            }
            Cad::FoldInter => {
                write!(f, "intersection () {{")?;
                for cad in &arg(0).as_ref().children {
                    write!(f, "  {}", Scad(cad))?;
                }
                write!(f, "}}")
            }
            cad => panic!("TODO: {:?}", cad),
        }
    }
}
