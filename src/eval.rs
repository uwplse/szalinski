use std::collections::HashMap;

use std::fmt;

use egg::{ENode, RecExpr};

use crate::cad::Cad;

macro_rules! rec {
    ($op:expr) => {RecExpr::from(ENode::leaf($op))};
    ($op:expr, $($arg:expr),*) => {
        RecExpr::from(ENode::new($op, vec![$($arg),*]))
    };
}

pub fn remove_empty(expr: &RecExpr<Cad>) -> Option<RecExpr<Cad>> {
    let e = expr.as_ref();
    let child = |i: usize| &e.children[i];
    let recurse = |i: usize| remove_empty(&e.children[i]);
    use Cad::*;
    let res = match e.op {
        Empty => None,
        BlackBox(ref b) => {
            let args: Vec<_> = e
                .children
                .iter()
                .map(|c| remove_empty(c).unwrap_or_else(|| rec!(Empty)))
                .collect();
            Some(ENode::new(BlackBox(b.clone()), args).into())
        }
        Hull => Some(rec!(Hull, recurse(0)?)),
        List => {
            let args: Vec<_> = e
                .children
                .iter()
                .map(|c| remove_empty(c).unwrap_or_else(|| rec!(Empty)))
                .collect();
            Some(ENode::new(List, args).into())
        }
        Cube => {
            let v = get_vec3_nums(child(0));
            if v.0 == 0.0 || v.1 == 0.0 || v.2 == 0.0 {
                None
            } else {
                Some(expr.clone())
            }
        }
        Sphere => {
            let r = get_num(child(0));
            if r == 0.0 {
                None
            } else {
                Some(expr.clone())
            }
        }
        Cylinder => {
            let (h, r1, r2) = get_vec3_nums(child(0));
            if h == 0.0 || (r1, r2) == (0.0, 0.0) {
                None
            } else {
                Some(expr.clone())
            }
        }
        Affine => {
            let cad = recurse(2)?;
            Some(rec!(Affine, child(0).clone(), child(1).clone(), cad))
            // TODO check scale
        }
        Binop => {
            let bop = child(0).as_ref().op.clone();
            let a = recurse(1);
            let b = recurse(2);
            match bop {
                Union => {
                    if a.is_none() || b.is_none() {
                        a.or(b)
                    } else {
                        Some(rec!(Binop, rec!(bop), a.unwrap(), b.unwrap()))
                    }
                }
                Inter => {
                    if a.is_none() || b.is_none() {
                        None
                    } else {
                        Some(rec!(Binop, rec!(bop), a.unwrap(), b.unwrap()))
                    }
                }
                Diff => {
                    if a.is_none() {
                        b
                    } else if b.is_none() {
                        a
                    } else {
                        Some(rec!(Binop, rec!(bop), a.unwrap(), b.unwrap()))
                    }
                }
                _ => panic!("unexpected binop: {:?}", bop),
            }
        }
        Fold => {
            let bop = child(0).as_ref().op.clone();
            let list = child(1);
            assert_eq!(list.as_ref().op, List);
            let listargs = list.as_ref().children.iter().map(|e| remove_empty(e));
            match bop {
                Union => {
                    let non_empty: Vec<RecExpr<Cad>> = listargs.filter_map(|e| e).collect();
                    if non_empty.is_empty() {
                        None
                    } else {
                        let listexpr = ENode::new(List, non_empty);
                        Some(rec!(Fold, rec!(Union), listexpr.into()))
                    }
                }
                Inter => {
                    let args: Option<Vec<RecExpr<Cad>>> = listargs.collect();
                    let listexpr = ENode::new(List, args?);
                    Some(rec!(Fold, rec!(Inter), listexpr.into()))
                }
                Diff => {
                    let mut listargs = listargs;
                    // if first is empty, then we are empty
                    let first = listargs.next().unwrap()?;

                    let non_empty: Vec<RecExpr<Cad>> = listargs.filter_map(|e| e).collect();
                    if non_empty.is_empty() {
                        Some(first)
                    } else {
                        let mut args = vec![first];
                        args.extend(non_empty);
                        let listexpr = ENode::new(List, args);
                        Some(rec!(Fold, rec!(Diff), listexpr.into()))
                    }
                }
                _ => panic!("unexpected binop: {:?}", bop),
            }
        }
        _ => panic!("unexpected cad: {}", expr.pretty(80)),
    };
    if res.is_none() {
        // println!("Found empty: {}", expr.pretty(80));
    }
    res
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
    ENode::new(Cad::List, exprs).into()
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
        Cad::BlackBox(ref b) => {
            let args: Vec<_> = e.children.iter().map(|c| eval(cx, c)).collect();
            ENode::new(Cad::BlackBox(b.clone()), args).into()
        }
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
        Cad::Sub => {
            let a = get_num(&eval(cx, arg(0)));
            let b = get_num(&eval(cx, arg(1)));
            rec!(Cad::Num((a - b).into()))
        }
        Cad::Mul => {
            let a = get_num(&eval(cx, arg(0)));
            let b = get_num(&eval(cx, arg(1)));
            rec!(Cad::Num((a * b).into()))
        }
        Cad::Div => {
            let a = get_num(&eval(cx, arg(0)));
            let b = get_num(&eval(cx, arg(1)));
            rec!(Cad::Num((a / b).into()))
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
        // Cad::Hexagon => rec!(Cad::Hexagon),
        Cad::Empty => rec!(Cad::Empty),
        Cad::Vec3 => rec!(
            Cad::Vec3,
            eval(cx, arg(0)),
            eval(cx, arg(1)),
            eval(cx, arg(2))
        ),
        Cad::Hull => rec!(Cad::Hull, eval(cx, arg(0))),

        Cad::Trans | Cad::Scale | Cad::Rotate | Cad::TransPolar => {
            if !e.children.is_empty() {
                panic!("Got an affine with children: {}", expr.pretty(80))
            }
            rec!(e.op.clone())
        }

        Cad::Affine => {
            let aff = eval(cx, arg(0)).as_ref().op.clone();
            match aff {
                Cad::Trans | Cad::Scale | Cad::Rotate => {
                    let param = eval(cx, arg(1));
                    let cad = eval(cx, arg(2));
                    rec!(Cad::Affine, rec!(aff), param, cad)
                }
                Cad::TransPolar => {
                    let param = eval(cx, arg(1));
                    let cad = eval(cx, arg(2));
                    let pnums = get_vec3_nums(&param);
                    let cnums = to_cartesian(pnums);
                    rec!(Cad::Affine, rec!(Cad::Trans), mk_vec(cnums), cad)
                }
                _ => panic!("expected affine kind, got {:?}", aff),
            }
        }

        Cad::Diff => rec!(Cad::Diff),
        Cad::Inter => rec!(Cad::Inter),
        Cad::Union => rec!(Cad::Union),

        Cad::Fold => rec!(Cad::Fold, eval(cx, arg(0)), eval(cx, arg(1))),
        Cad::Binop => rec!(
            Cad::Fold,
            eval(cx, arg(0)),
            rec!(Cad::List, eval(cx, arg(1)), eval(cx, arg(2)))
        ),

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
        Cad::Map2 => {
            let op = &e.children[0].as_ref().op;
            let params: Vec<_> = eval_list(cx, &e.children[1]);
            let cads: Vec<_> = eval_list(cx, &e.children[2]);
            mk_list(
                params
                    .into_iter()
                    .zip(cads)
                    .map(|(p, c)| rec!(Cad::Affine, rec!(op.clone()), p, c))
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
        Cad::GetAt => {
            let list = eval_list(cx, arg(0));
            let idx = eval(cx, arg(1));
            let num = get_num(&idx) as usize;
            list.into_iter().nth(num).unwrap()
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
            // Cad::Hexagon => writeln!(f, "cylinder();"),
            Cad::Hull => {
                write!(f, "hull() {{")?;
                for cad in &arg(0).as_ref().children {
                    write!(f, "  {}", Scad(cad))?;
                }
                write!(f, "}}")
            }

            Cad::Trans => write!(f, "translate"),
            Cad::Scale => write!(f, "scale"),
            Cad::Rotate => write!(f, "rotate"),
            Cad::Affine => write!(f, "{} ({}) {}", child(0), child(1), child(2)),

            Cad::Union => write!(f, "union"),
            Cad::Inter => write!(f, "intersection"),
            Cad::Diff => write!(f, "difference"),
            Cad::Fold => {
                writeln!(f, "{} () {{", child(0))?;
                for cad in &arg(1).as_ref().children {
                    write!(f, "  {}", Scad(cad))?;
                }
                write!(f, "}}")
            }
            Cad::BlackBox(b) => {
                writeln!(f, "{} {{", b)?;
                for cad in &expr.children {
                    write!(f, "  {}", Scad(cad))?;
                }
                write!(f, "}}")
            }
            cad => panic!("TODO: {:?}", cad),
        }
    }
}
