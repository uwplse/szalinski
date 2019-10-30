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

fn get_vec3_comps(expr: &RecExpr<Cad>) -> (RecExpr<Cad>, RecExpr<Cad>, RecExpr<Cad>) {
    let expr = expr.as_ref();
    let arg = |i: usize| expr.children[i].clone();
    match expr.op {
        Cad::Vec3 => (arg(0), arg(1), arg(2)),
        _ => panic!("Not a vec3"), // is panic the right thing?
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

fn eval_fun(expr: &RecExpr<Cad>, ctx: &FunCtx) -> f64 {
    let expr = expr.as_ref();
    match &expr.op {
        Cad::Num(_) => get_num(&rec!(expr.op.clone())),
        Cad::ListVar(v) => ctx[v.0] as f64,
        Cad::Add => {
            let a = expr.children[0].clone();
            let b = expr.children[1].clone();
            eval_fun(&a, ctx) + eval_fun(&b, ctx)
        }
        Cad::Mul => {
            let a = expr.children[0].clone();
            let b = expr.children[1].clone();
            eval_fun(&a, ctx) * eval_fun(&b, ctx)
        }
        // TODO sub and div
        _ => panic!("Cannot evaluate non-arithmetic functions: {}", expr.op),
    }
}

fn eval_list(expr: &RecExpr<Cad>) -> Vec<RecExpr<Cad>> {
    let e = expr.as_ref();
    let arg = |i: usize| &e.children[i];
    match &e.op {
        Cad::Cons => {
            let mut list = eval_list(arg(1));
            list.insert(0, eval(arg(0)));
            list
        }
        Cad::List => e.children.iter().map(|e| eval(e)).collect(),
        Cad::Repeat => {
            let n = get_num(&eval(arg(0)));
            let t = eval(arg(1));
            vec![t.clone(); n as usize]
        }
        Cad::Concat => unimplemented!(),
        Cad::Map => {
            let op = &e.children[0].as_ref().op;
            let params: Vec<_> = eval_list(&e.children[1]);
            let cads: Vec<_> = eval_list(&e.children[2]);
            params
                .into_iter()
                .zip(cads)
                .map(|(p, c)| rec!(op.clone(), p, c))
                .collect()
        }
        Cad::MapI => {
            let (x, y, z) = get_vec3_comps(e.children.last().unwrap());
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
                        vec.push((eval_fun(&x, &ctx), eval_fun(&y, &ctx), eval_fun(&z, &ctx)));
                    }
                }
                2 => {
                    for i in 0..bounds[0] {
                        ctx.insert("i", i);
                        for j in 0..bounds[1] {
                            ctx.insert("j", j);
                            vec.push((eval_fun(&x, &ctx), eval_fun(&y, &ctx), eval_fun(&z, &ctx)));
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
                                vec.push((eval_fun(&x, &ctx), eval_fun(&y, &ctx), eval_fun(&z, &ctx)));
                            }
                        }
                    }
                }
                _ => unimplemented!(),
            }

            vec.into_iter().map(mk_vec).collect()
        }
        _ => vec![expr.clone()],
    }
}

pub fn eval(expr: &RecExpr<Cad>) -> RecExpr<Cad> {
    let expr = expr.as_ref();
    let arg = |i: usize| &expr.children[i];
    match &expr.op {
        Cad::Bool(b) => rec!(Cad::Bool(*b)),
        Cad::Cube => rec!(Cad::Cube, eval(arg(0)), eval(arg(1))),
        Cad::Sphere => rec!(Cad::Sphere, eval(arg(0)), eval(arg(1))),
        Cad::Cylinder => rec!(Cad::Cylinder, eval(arg(0)), eval(arg(1))),
        Cad::Hexagon => rec!(Cad::Hexagon),
        Cad::Empty => rec!(Cad::Empty),
        Cad::Num(f) => rec!(Cad::Num(*f)),
        Cad::Vec3 => rec!(Cad::Vec3, eval(arg(0)), eval(arg(1)), eval(arg(2))),
        Cad::Hull => rec!(Cad::Hull, eval(arg(0))),
        Cad::Trans => rec!(Cad::Trans, eval(arg(0)), eval(arg(1))),
        Cad::TransPolar => {
            let param = eval(arg(0));
            let pnums = get_vec3_nums(&param);
            let cnums = to_cartesian(pnums);
            rec!(Cad::Trans, mk_vec(cnums), eval(arg(1)))
        }
        Cad::Scale => rec!(Cad::Scale, eval(arg(0)), eval(arg(1))),
        Cad::Rotate => rec!(Cad::Rotate, eval(arg(0)), eval(arg(1))),
        Cad::Diff => rec!(Cad::Diff, eval(arg(0)), eval(arg(1))),
        Cad::Inter => rec!(Cad::Inter, eval(arg(0)), eval(arg(1))),
        Cad::Union => rec!(Cad::Union, eval(arg(0)), eval(arg(1))),
        Cad::FoldUnion => {
            let list = eval_list(arg(0));
            rec!(Cad::FoldUnion, Expr::new(Cad::List, list.into()).into())
        }
        Cad::FoldInter => {
            let list = eval_list(arg(0));
            rec!(Cad::FoldInter, Expr::new(Cad::List, list.into()).into())
        }
        cad => panic!("EVAL TODO: {:?}", cad),
        //{error!("EVAL TODO: {:?}", cad); rec!(Cad::Empty)}
    }
}

pub struct Scad<'a>(pub &'a RecExpr<Cad>);

impl<'a> fmt::Display for Scad<'a> {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        let expr = eval(self.0);
        let expr = expr.as_ref();
        let arg = |i: usize| expr.children[i].clone();
        let child = |i: usize| Scad(&expr.children[i]);
        match &expr.op {
            Cad::Num(float) => write!(f, "{}", float),
            Cad::Bool(b) => write!(f, "center = {}", b),
            Cad::Vec3 => write!(f, "[{}, {}, {}]", child(0), child(1), child(2)),
            Cad::Add => write!(f, "{} + {}", child(0), child(1)),
            Cad::Sub => write!(f, "{} - {}", child(0), child(1)),
            Cad::Mul => write!(f, "{} * {}", child(0), child(1)),
            Cad::Div => write!(f, "{} / {}", child(0), child(1)),
            Cad::Empty => writeln!(f, "sphere(r=0);"),
            Cad::Cube => writeln!(f, "cube({}, {});", child(0), child(1)),
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
                "cylinder(h = {}, r1 = {}, r2 = {}, $fn = {}, $fa = {}, $fs = {});",
                get_vec3_nums(&arg(0)).0,
                get_vec3_nums(&arg(0)).1,
                get_vec3_nums(&arg(0)).2,
                get_vec3_nums(&arg(1)).0,
                get_vec3_nums(&arg(1)).1,
                get_vec3_nums(&arg(1)).2
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
