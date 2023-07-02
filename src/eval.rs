use std::collections::HashMap;

use egg::Id;
use egg::Language;
use egg::RecExpr;

use crate::cad::Cad;

// macro_rules! rec {
//     ($op:expr) => {RecExpr::from($op)};
//     ($op:expr, $($arg:expr),*) => {
//         RecExpr::from($op(vec![$($arg),*]))
//     };
// }

pub fn remove_empty(expr: &RecExpr<Cad>, p: Id, out: &mut RecExpr<Cad>) -> Option<Id> {
    let e = expr[p].clone();
    // let child = |i: usize| &expr[e.children()[i]];
    // let recurse = |i: usize| remove_empty(expr, e.children()[i], out);
    use Cad::*;
    let res = match e {
        Empty => None,
        BlackBox(ref b, args) => {
            let args: Vec<_> = args
                .iter()
                .map(|c| remove_empty(expr, *c, out).unwrap_or_else(|| out.add(Cad::Empty)))
                .collect();
            Some(out.add(BlackBox(b.clone(), args)))
        }
        Hull(args) => {
            let args =
                args.map(|c| remove_empty(expr, c, out).unwrap_or_else(|| out.add(Cad::Empty)));
            Some(out.add(Cad::Hull(args)))
        }
        List(args) => {
            let args: Vec<_> = args
                .iter()
                .map(|c| remove_empty(expr, *c, out).unwrap_or_else(|| out.add(Cad::Empty)))
                .collect();
            Some(out.add(List(args)))
        }
        Cube(args) => {
            let args =
                args.map(|c| remove_empty(expr, c, out).unwrap_or_else(|| out.add(Cad::Empty)));
            let v = get_vec3_nums(out, args[0]);
            if v.0 == 0.0 || v.1 == 0.0 || v.2 == 0.0 {
                None
            } else {
                Some(out.add(Cube(args)))
            }
        }
        Sphere(args) => {
            let args =
                args.map(|c| remove_empty(expr, c, out).unwrap_or_else(|| out.add(Cad::Empty)));
            let r = get_num(out, args[0]);
            if r == 0.0 {
                None
            } else {
                Some(out.add(Sphere(args)))
            }
        }
        Cylinder(args) => {
            let args =
                args.map(|c| remove_empty(expr, c, out).unwrap_or_else(|| out.add(Cad::Empty)));
            let (h, r1, r2) = get_vec3_nums(out, args[0]);
            if h == 0.0 || (r1, r2) == (0.0, 0.0) {
                None
            } else {
                Some(out.add(Cylinder(args)))
            }
        }
        Affine(args) => {
            let args =
                args.map(|c| remove_empty(expr, c, out).unwrap_or_else(|| out.add(Cad::Empty)));
            Some(out.add(Affine(args)))
            // TODO check scale
        }
        Binop(args) => {
            let args = args.map(|c| remove_empty(expr, c, out));
            let bop_id = args[0].expect("op should be valid");
            let bop = out[bop_id].clone();
            let a = args[1];
            let b = args[2];
            match bop {
                Union => {
                    if a.is_none() || b.is_none() {
                        a.or(b)
                    } else {
                        Some(out.add(Binop([bop_id, a.unwrap(), b.unwrap()])))
                    }
                }
                Inter => {
                    if a.is_none() || b.is_none() {
                        None
                    } else {
                        Some(out.add(Binop([bop_id, a.unwrap(), b.unwrap()])))
                    }
                }
                Diff => {
                    if a.is_none() {
                        b
                    } else if b.is_none() {
                        a
                    } else {
                        Some(out.add(Binop([bop_id, a.unwrap(), b.unwrap()])))
                    }
                }
                _ => panic!("unexpected binop: {:?}", bop),
            }
        }
        Fold(args) => {
            let bop = expr[args[0]].clone();
            let list = expr[args[1]].clone();
            assert!(matches!(list, List(_)));
            let listargs = list.children().iter().map(|e| remove_empty(expr, *e, out));
            match bop {
                Union => {
                    let non_empty: Vec<Id> = listargs.filter_map(|e| e).collect();
                    if non_empty.is_empty() {
                        None
                    } else {
                        let listexpr = List(non_empty);
                        let union_expr = out.add(Union);
                        let listexpr = out.add(listexpr);
                        Some(out.add(Fold([union_expr, listexpr])))
                    }
                }
                Inter => {
                    let args: Option<Vec<Id>> = listargs.collect();
                    let listexpr = List(args?);
                    let inter = out.add(Inter);
                    let listexpr = out.add(listexpr);
                    Some(out.add(Fold([inter, listexpr])))
                }
                Diff => {
                    let mut listargs = listargs;
                    // if first is empty, then we are empty
                    let first = listargs.next().unwrap()?;

                    let non_empty: Vec<Id> = listargs.filter_map(|e| e).collect();
                    if non_empty.is_empty() {
                        Some(first)
                    } else {
                        let mut args = vec![first];
                        args.extend(non_empty);
                        let listexpr = List(args);
                        let diff = out.add(Diff);
                        let listexpr = out.add(listexpr.into());
                        Some(out.add(Fold([diff, listexpr])))
                    }
                }
                _ => panic!("unexpected binop: {:?}", bop),
            }
        }
        _ => {
            let e =
                e.map_children(|id| remove_empty(expr, id, out).unwrap_or_else(|| out.add(Empty)));
            Some(out.add(e))
            // todo!()

            // panic!("unexpected cad: {} {}", e, expr.pretty(80))
        }
    };
    if res.is_none() {
        // println!("Found empty: {}", expr.pretty(80));
    }
    res
}

fn get_num(expr: &RecExpr<Cad>, p: Id) -> f64 {
    match expr[p] {
        Cad::Num(num) => num.to_f64(),
        _ => panic!("Not a num"), // is panic the right thing?
    }
}

fn get_vec3_nums(expr: &RecExpr<Cad>, p: Id) -> (f64, f64, f64) {
    match expr[p] {
        Cad::Vec3(arg) => (
            get_num(expr, arg[0]),
            get_num(expr, arg[1]),
            get_num(expr, arg[2]),
        ),
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

type FunCtx = HashMap<String, usize>;

fn mk_vec((x, y, z): (f64, f64, f64), out: &mut RecExpr<Cad>) -> Id {
    let x = out.add(Cad::Num(x.into()));
    let y = out.add(Cad::Num(y.into()));
    let z = out.add(Cad::Num(z.into()));
    out.add(Cad::Vec3([x, y, z]))
}

fn mk_list(exprs: Vec<Id>) -> Cad {
    Cad::List(exprs)
}

fn get_list(expr: &RecExpr<Cad>, list: Id) -> &Vec<Id> {
    match &expr[list] {
        Cad::List(list) => &list,
        cad => panic!("expected list, got {:?}", cad),
    }
}

fn eval_list(cx: Option<&FunCtx>, expr: &RecExpr<Cad>, p: Id, out: &mut RecExpr<Cad>) -> Vec<Id> {
    let list = eval(cx, expr, p, out);
    match &expr[list] {
        Cad::List(list) => list.clone(),
        cad => panic!("expected list, got {:?}", cad),
    }
}

pub fn eval(cx: Option<&FunCtx>, expr: &RecExpr<Cad>, p: Id, out: &mut RecExpr<Cad>) -> Id {
    let e = expr[p].clone();
    match &e {
        Cad::BlackBox(ref b, args) => {
            let args: Vec<_> = args.iter().map(|c| eval(cx, expr, *c, out)).collect();
            out.add(Cad::BlackBox(b.clone(), args))
        }
        // arith
        Cad::Bool(_) => out.add(e),
        Cad::Num(_) => out.add(e),
        Cad::ListVar(v) => {
            let n = cx.unwrap()[&v.0];
            out.add(Cad::Num(n.into()))
        }
        Cad::Add(args) => {
            let args = args.map(|arg| eval(cx, expr, arg, out));
            let a = get_num(out, args[0]);
            let b = get_num(out, args[1]);
            out.add(Cad::Num((a + b).into()))
        }
        Cad::Sub(args) => {
            let args = args.map(|arg| eval(cx, expr, arg, out));
            let a = get_num(out, args[0]);
            let b = get_num(out, args[1]);
            out.add(Cad::Num((a - b).into()))
        }
        Cad::Mul(args) => {
            let args = args.map(|arg| eval(cx, expr, arg, out));
            let a = get_num(out, args[0]);
            let b = get_num(out, args[1]);
            out.add(Cad::Num((a * b).into()))
        }
        Cad::Div(args) => {
            let args = args.map(|arg| eval(cx, expr, arg, out));
            let a = get_num(out, args[0]);
            let b = get_num(out, args[1]);
            out.add(Cad::Num((a / b).into()))
        }
        // cad
        Cad::Cube(args) => {
            let args = args.map(|arg| eval(cx, expr, arg, out));
            out.add(Cad::Cube(args))
        }
        Cad::Sphere(args) => {
            let args = args.map(|arg| eval(cx, expr, arg, out));
            out.add(Cad::Sphere(args))
        }
        Cad::Cylinder(args) => {
            let args = args.map(|arg| eval(cx, expr, arg, out));
            out.add(Cad::Cylinder(args))
        }
        // Cad::Hexagon => out.add(Cad::Hexagon),
        Cad::Empty => out.add(Cad::Empty),
        Cad::Vec3(args) => {
            let args = args.map(|arg| eval(cx, expr, arg, out));
            out.add(Cad::Vec3(args))
        }
        Cad::Hull(args) => {
            let args = args.map(|arg| eval(cx, expr, arg, out));
            out.add(Cad::Hull(args))
        }

        Cad::Trans | Cad::Scale | Cad::Rotate | Cad::TransPolar => {
            if !e.children().is_empty() {
                panic!("Got an affine with children: {}", expr.pretty(80))
            }
            out.add(e.clone())
        }

        Cad::Affine(args) => {
            let aff = eval(cx, expr, args[0], out);
            match out[aff] {
                Cad::Trans | Cad::Scale | Cad::Rotate => {
                    let param = eval(cx, expr, args[1], out);
                    let cad = eval(cx, expr, args[2], out);
                    out.add(Cad::Affine([aff, param, cad]))
                }
                Cad::TransPolar => {
                    let param = eval(cx, expr, args[1], out);
                    let cad = eval(cx, expr, args[2], out);
                    let pnums = get_vec3_nums(expr, param);
                    let cnums = to_cartesian(pnums);

                    let trans = out.add(Cad::Trans);
                    let cnums = mk_vec(cnums, out);
                    out.add(Cad::Affine([trans, cnums, cad]))
                }
                _ => panic!("expected affine kind, got {:?}", aff),
            }
        }

        Cad::Diff => out.add(Cad::Diff),
        Cad::Inter => out.add(Cad::Inter),
        Cad::Union => out.add(Cad::Union),

        Cad::Fold(args) => {
            let args = args.map(|arg| eval(cx, expr, arg, out));
            out.add(Cad::Fold(args))
        }
        Cad::Binop(args) => {
            let args = args.map(|arg| eval(cx, expr, arg, out));
            let list = out.add(Cad::List(vec![args[1], args[2]]));
            out.add(Cad::Fold([args[0], list]))
        }

        // lists
        Cad::Nil => out.add(mk_list(vec![])),
        Cad::Cons(args) => {
            let mut list = eval_list(cx, expr, args[1], out);
            list.insert(0, eval(cx, expr, args[0], out));
            out.add(mk_list(list))
        }
        Cad::List(list) => {
            let list = mk_list(list.iter().map(|e| eval(cx, expr, *e, out)).collect());
            out.add(list)
        }
        Cad::Repeat(args) => {
            let args = args.map(|arg| eval(cx, expr, arg, out));
            let n = get_num(out, args[0]);
            let t = args[1];
            out.add(mk_list(vec![t.clone(); n as usize]))
        }
        Cad::Concat(args) => {
            let mut vec = Vec::new();
            for list in eval_list(cx, expr, args[0], out) {
                for c in get_list(out, list) {
                    vec.push(*c)
                }
            }
            out.add(mk_list(vec))
        }
        Cad::Map2(args) => {
            let op = out.add(expr[e.children()[0]].clone());
            let params: Vec<_> = eval_list(cx, expr, args[1], out);
            let cads: Vec<_> = eval_list(cx, expr, args[2], out);
            let list = mk_list(
                params
                    .into_iter()
                    .zip(cads)
                    .map(|(p, c)| out.add(Cad::Affine([op, p, c])))
                    .collect(),
            );
            out.add(list)
        }
        Cad::MapI(args) => {
            let args: Vec<_> = args.iter().map(|arg| eval(cx, expr, *arg, out)).collect();
            let body = *args.last().unwrap();
            let bounds: Vec<usize> = args[..args.len() - 1]
                .iter()
                .map(|n| get_num(out, *n) as usize)
                .collect();
            let mut ctx = HashMap::new();
            let mut vec = Vec::new();
            match bounds.len() {
                1 => {
                    for i in 0..bounds[0] {
                        ctx.insert("i", i);
                        vec.push(body);
                    }
                }
                2 => {
                    for i in 0..bounds[0] {
                        ctx.insert("i", i);
                        for j in 0..bounds[1] {
                            ctx.insert("j", j);
                            vec.push(body);
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
                                vec.push(body);
                            }
                        }
                    }
                }
                _ => unimplemented!(),
            }

            out.add(mk_list(vec))
        }
        cad => panic!("can't eval({:?})", cad),
    }
}

pub struct Scad<'a>(pub &'a RecExpr<Cad>);

// impl<'a> fmt::Display for Scad<'a> {
//     fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
//         fn fmt_impl(p: Id, out: ) -> fmt::Result {
//             let expr = eval(None, self.0, p, out);
//             let expr = expr.as_ref();
//             // let arg = |i: usize| expr.children[i].clone();
//             let child = |i: usize| Scad(&expr.children()[i]);
//             match &expr.op {
//                 Cad::Num(float) => write!(f, "{}", float),
//                 Cad::Bool(b) => write!(f, "{}", b),
//                 Cad::Vec3(children) => write!(f, "[{}, {}, {}]", children[0], children[1], children[2]),
//                 Cad::Add(children) => write!(f, "{} + {}", children[0], children[1]),
//                 Cad::Sub(children) => write!(f, "{} - {}", children[0], children[1]),
//                 Cad::Mul(children) => write!(f, "{} * {}", children[0], children[1]),
//                 Cad::Div(children) => write!(f, "{} / {}", children[0], children[1]),
//                 Cad::Empty => writeln!(f, "sphere(r=0);"),
//                 Cad::Cube(_) => writeln!(f, "cube({}, center={});", child(0), child(1)),
//                 Cad::Sphere(_) => writeln!(
//                     f,
//                     "sphere(r = {}, $fn = {}, $fa = {}, $fs = {});",
//                     child(0),
//                     get_vec3_nums(&arg(1)).0,
//                     get_vec3_nums(&arg(1)).1,
//                     get_vec3_nums(&arg(1)).2
//                 ),
//                 Cad::Cylinder => writeln!(
//                     f,
//                     "cylinder(h = {}, r1 = {}, r2 = {}, $fn = {}, $fa = {}, $fs = {}, center = {});",
//                     get_vec3_nums(&arg(0)).0,
//                     get_vec3_nums(&arg(0)).1,
//                     get_vec3_nums(&arg(0)).2,
//                     get_vec3_nums(&arg(1)).0,
//                     get_vec3_nums(&arg(1)).1,
//                     get_vec3_nums(&arg(1)).2,
//                     child(2),
//                 ),
//                 // Cad::Hexagon => writeln!(f, "cylinder();"),
//                 Cad::Hull => {
//                     write!(f, "hull() {{")?;
//                     for cad in &arg(0).as_ref().children {
//                         write!(f, "  {}", Scad(cad))?;
//                     }
//                     write!(f, "}}")
//                 }

//                 Cad::Trans => write!(f, "translate"),
//                 Cad::Scale => write!(f, "scale"),
//                 Cad::Rotate => write!(f, "rotate"),
//                 Cad::Affine => write!(f, "{} ({}) {}", child(0), child(1), child(2)),

//                 Cad::Union => write!(f, "union"),
//                 Cad::Inter => write!(f, "intersection"),
//                 Cad::Diff => write!(f, "difference"),
//                 Cad::Fold => {
//                     writeln!(f, "{} () {{", child(0))?;
//                     for cad in &arg(1).as_ref().children {
//                         write!(f, "  {}", Scad(cad))?;
//                     }
//                     write!(f, "}}")
//                 }
//                 Cad::BlackBox(b) => {
//                     writeln!(f, "{} {{", b)?;
//                     for cad in &expr.children {
//                         write!(f, "  {}", Scad(cad))?;
//                     }
//                     write!(f, "}}")
//                 }
//                 cad => panic!("TODO: {:?}", cad),
//             }
//         }
//         fmt_impl((self.0.as_ref().len() - 1).into())
//     }
// }
