use std::f64::consts;

use smallvec::smallvec;
use std::fmt;
use std::fs::{read_dir, read_to_string};

use egg::expr::{Expr, RecExpr};
use egg::parse::ParsableLanguage;

use crate::cad::Cad;
use crate::cad::ListVar;
use crate::cad::Variable;

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

fn eval_fun(expr: &RecExpr<Cad>, i: usize) -> f64 {
    let expr = expr.as_ref();
    match &expr.op {
        Cad::Num(_) => get_num(&rec!(expr.op.clone())),
        Cad::ListVar(_) => i as f64,
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
        _ => panic!("Cannot evaluate non-arithmetic functions: {}", expr.op),
    }
}

fn eval_vecs(op: &Cad, expr: &RecExpr<Cad>) -> Vec<(f64, f64, f64)> {
    let mapi = expr.as_ref();
    match &mapi.op {
        Cad::Repeat => {
            let mut v = Vec::new();
            let n = get_num(&mapi.children[0].clone());
            let vc = mapi.children[1].as_ref();
            let x = get_num(&vc.children[0].clone());
            let y = get_num(&vc.children[1].clone());
            let z = get_num(&vc.children[2].clone());
            match op {
                Cad::TransPolar => {
                    for _i in 0..n as usize {
                        let (x, y, z) = to_cartesian((x, y, z));
                        v.push((x, y, z));
                    }
                }
                _ =>  {
                    for _i in 0..n as usize {
                        v.push((x, y, z));
                    }
                }
            }
            v
        },
        Cad::List => {
            let mut v = Vec::new();
            let vs = mapi.children.clone();
            for i in 0..vs.len() {
                let vc = vs[i].as_ref();
                let x = get_num(&vc.children[0].clone());
                let y = get_num(&vc.children[1].clone());
                let z = get_num(&vc.children[2].clone());
                match op {
                    Cad::TransPolar => {
                        let (x, y, z) = to_cartesian((x, y, z));
                        v.push((x, y, z));
                    }
                    _ => {
                        v.push((x, y, z));
                    }
                }
            }
            v
        },
        Cad::Cons => {
            let hd = mapi.children[0].as_ref();
            let tl = mapi.children[1].clone();
            let mut v: Vec<(f64, f64, f64)> = eval_vecs(op, &tl);
            let x = get_num(&hd.children[0].clone());
            let y = get_num(&hd.children[1].clone());
            let z = get_num(&hd.children[2].clone());
            match op  {
                Cad::TransPolar => {
                    let (x, y, z) = to_cartesian((x, y, z));
                    v.push((x, y, z));
                }
                _ => {
                    v.push((x, y, z));
                }
            }
            v
        },
        Cad::MapI => {
            let mut v = Vec::new();
            if mapi.children.len() == 2 {
                let n = mapi.children[0].clone();
                let vec = mapi.children[1].as_ref();
                let x = vec.children[0].clone();
                let y = vec.children[1].clone();
                let z = vec.children[2].clone();
                for i in 0..(get_num(&n) as usize) {
                    let (fx, fy, fz) = (eval_fun(&x, i), eval_fun(&y, i), eval_fun(&z, i));
                    match op {
                        Cad::TransPolar => {
                            let (px, py, pz) = to_cartesian((fx, fy, fz));
                            v.push((px, py, pz));
                        }
                        _ => {
                            v.push((fx, fy, fz));
                        }
                    }
                }
            } else if mapi.children.len() == 3 {
                let nx = mapi.children[0].clone();
                let ny = mapi.children[1].clone();
                let vec = mapi.children[2].as_ref();
                let x = vec.children[0].clone();
                let y = vec.children[1].clone();
                let z = vec.children[2].clone();
                for i in 0..(get_num(&nx) as usize) {
                    for j in 0..(get_num(&ny) as usize) {
                        let (fx, fy, fz) = (eval_fun(&x, i), eval_fun(&y, j), eval_fun(&z, i));
                        match op {
                            Cad::TransPolar => {
                                let (px, py, pz) = to_cartesian((fx, fy, fz));
                                v.push((px, py, pz));
                            }
                            _ => {
                                v.push((fx, fy, fz));
                            }
                        }
                    }
                }
            } else {
                let nx = mapi.children[0].clone();
                let ny = mapi.children[1].clone();
                let nz = mapi.children[2].clone();
                let vec = mapi.children[3].as_ref();
                let x = vec.children[0].clone();
                let y = vec.children[1].clone();
                let z = vec.children[2].clone();
                for i in 0..(get_num(&nx) as usize) {
                    for j in 0..(get_num(&ny) as usize) {
                        for k in 0..(get_num(&nz) as usize) {
                            let (fx, fy, fz) = (eval_fun(&x, i), eval_fun(&y, j), eval_fun(&z, k));
                            match op {
                                Cad::TransPolar => {
                                    let (px, py, pz) = to_cartesian((fx, fy, fz));
                                    v.push((px, py, pz));
                                }
                                _ => {
                                    v.push((fx, fy, fz));
                                }
                            }
                        }
                    }
                }
            }
            v
        }
        Cad::Concat => {
            let cs = mapi.children.clone();
            let mut vs = Vec::new();
            for i in 0..(cs.len()) {
                let mut v = eval_vecs(op, &cs[i]);
                vs.append(&mut v);
            }
            vs
        },
        _ => panic!("eval_vecs: not a mapi, list, cons, repeat, or concat "),
    }
}

fn cads_to_union(cs: Vec<RecExpr<Cad>>) -> RecExpr<Cad> {
    let mut cad = rec!(Cad::Empty);
    for c in cs {
        cad = rec!(Cad::Union, c, cad);
    }
    cad
}

fn union_to_cads(c: RecExpr<Cad>) -> Vec<RecExpr<Cad>> {
    let c = c.as_ref();
    match &c.op {
        Cad::Empty => {
            vec![rec!(Cad::Empty)]
        }
        Cad::Union => {
            let c1 = c.children[0].clone();
            let c2 = c.children[1].clone();
            let mut v = union_to_cads(c2);
            v.push(c1);
            v
        }
        _ => panic!("union_to_cads: not a union"),
    }
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
        Cad::Num(f) => rec!(Cad::Num(*f)),
        Cad::Vec => rec!(Cad::Vec, eval(&arg(0)), eval(&arg(1)), eval(&arg(2))),
        Cad::Hull => rec!(Cad::Hull, eval(&arg(0))),
        Cad::Trans => rec!(
            Cad::Trans,
            eval(&arg(0)),
            eval(&arg(1)),
            eval(&arg(2)),
            eval(&arg(3))
        ),
        Cad::TransPolar => rec!(
            Cad::Trans,
            eval(&arg(0)),
            eval(&arg(1)),
            eval(&arg(2)),
            eval(&arg(3))
        ),
        Cad::Scale => rec!(
            Cad::Scale,
            eval(&arg(0)),
            eval(&arg(1)),
            eval(&arg(2)),
            eval(&arg(3))
        ),
        Cad::Rotate => rec!(
            Cad::Rotate,
            eval(&arg(0)),
            eval(&arg(1)),
            eval(&arg(2)),
            eval(&arg(3))
        ),
        Cad::Diff => rec!(Cad::Diff, eval(&arg(0)), eval(&arg(1))),
        Cad::Inter => rec!(Cad::Inter, eval(&arg(0)), eval(&arg(1))),
        Cad::Union => rec!(Cad::Union, eval(&arg(0)), eval(&arg(1))),
        Cad::Repeat => {
            let mut v = Vec::new();
            let n = get_num(&eval(&arg(0)));
            let c = eval(&arg(1)).clone();
            for _i in 0..(n as usize) {
                v.push(c.clone());
            }
            cads_to_union(v)
        }
        Cad::FoldUnion => eval(&expr.children[0]),
        Cad::Cons => rec!(Cad::Union, eval(&arg(0)), eval(&arg(1))),
        Cad::Concat => {
            let mut l1 = union_to_cads(eval(&arg(0)).clone());
            let mut l2 = union_to_cads(eval(&arg(1)).clone());
            l1.append(&mut l2);
            cads_to_union(l1)
        },
        Cad::Map => {
            let op = &expr.children[0].as_ref().op;
            let mapi_list_cons = &expr.children[1];
            let fs = eval_vecs(op, &mapi_list_cons);
            let cads = eval(&expr.children[2]);
            let cs = union_to_cads(cads.clone());
            // NOTE: first element is always Empty due to union_to_cads, so remove it.
            // TODO: should clean this up.
            let mut ne_cs = Vec::new();
            for i in 1..(cs.len()) {
                ne_cs.push(cs[i].clone())
            }
            assert_eq!(ne_cs.len(), fs.len());
            let mut v = Vec::new();
            for i in 0..fs.len() {
                let vx = rec!(Cad::Num(fs[i].0.into()));
                let vy = rec!(Cad::Num(fs[i].1.into()));
                let vz = rec!(Cad::Num(fs[i].2.into()));
                v.push(rec!(op.clone(), vx, vy, vz, ne_cs[i].clone()));
            }
            cads_to_union(v)
        }
        _ => panic!("EVAL TODO"),
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
            Cad::Vec => write!(f, "[{}, {}, {}]", child(0), child(1), child(2)),
            Cad::Add => write!(f, "{} + {}", child(0), child(1)),
            Cad::Sub => write!(f, "{} - {}", child(0), child(1)),
            Cad::Mul => write!(f, "{} * {}", child(0), child(1)),
            Cad::Div => write!(f, "{} / {}", child(0), child(1)),
            Cad::Empty => write!(f, "sphere(r=0);"),
            Cad::Unit => write!(f, "cube(center = true);"),
            Cad::Sphere => write!(f, "sphere($fn = 50);"),
            Cad::Cylinder => write!(f, "cylinder($fn = 50);"),
            Cad::Hexagon => write!(f, "cylinder();"),
            Cad::Hull => write!(f, "hull() {{ {} }}", child(0)),
            Cad::Trans => write!(
                f,
                "translate ([{}, {}, {}]) {}",
                child(0),
                child(1),
                child(2),
                child(3)
            ),
            Cad::Scale => write!(
                f,
                "scale ([{}, {}, {}]) {}",
                child(0),
                child(1),
                child(2),
                child(3)
            ),
            Cad::Rotate => write!(
                f,
                "rotate ([{}, {}, {}]) {}",
                child(0),
                child(1),
                child(2),
                child(3)
            ),
            Cad::Union => write!(f, "union () {{ {} {} }}", child(0), child(1)),
            Cad::Inter => write!(f, "intersection () {{ {} {} }}", child(0), child(1)),
            Cad::Diff => write!(f, "difference () {{ {} {} }}", child(0), child(1)),
            _ => write!(f, "TODO"),
        }
    }
}

macro_rules! test_eval {
    ($name:ident, $file:literal) => {
        #[test]
        fn $name() {
            println!("Testing {}", stringify!($name));
            let input = read_to_string($file).unwrap();
            let outfile = $file.replace("expected/", "scad-output/");
            let output = read_to_string(&outfile);
            let start = Cad::parse_expr(&input).unwrap();
            let actual = format!("{}", Scad(&start)).trim().to_string();
            println!("{}", actual);
            if outfile.contains("scad-output/") && output.is_ok() {
                let expected = &output.unwrap();
                let expected = expected.trim().to_string();
                if actual != expected {
                    let actual = actual.as_ref();
                    let expected = expected.as_ref();
                    let diff = colored_diff::PrettyDifference { expected, actual };
                    panic!("Didn't match expected. {}", diff)
                }
                assert_eq!(actual, expected);
            } else {
                eprintln!("Didn't find expected scad for {}", stringify!($name));
            }
        }
    };
}

test_eval! {eval_flower, "cads/pldi2020-eval/expected/flower.csexp" }
test_eval! {eval_cnc_hull, "cads/pldi2020-eval/expected/cnc_endmill_with_hull.csexp" }
test_eval! {eval_dice, "cads/pldi2020-eval/expected/dice.csexp" }
test_eval! {eval_gear, "cads/pldi2020-eval/expected/gear_flat.csexp" }
test_eval! {eval_hcbit, "cads/pldi2020-eval/expected/hcbitholder.csexp" }
// commented ones are wrong due to hand written csexps as inputs
// test_eval! {eval_box_flat, "cads/pldi2020-eval/expected/box_flat.csexp" }
// test_eval! {eval_compose, "cads/pldi2020-eval/expected/composition_card.csexp" }
// test_eval! {eval_med, "cads/pldi2020-eval/expected/medslide.csexp" }
// test_eval! {eval_nintendo, "cads/pldi2020-eval/expected/nintendo.csexp" }
// test_eval! {eval_pin, "cads/pldi2020-eval/expected/pinheader.csexp" }
// test_eval! {eval_relay, "cads/pldi2020-eval/expected/relay_box.csexp" }
// test_eval! {eval_sand, "cads/pldi2020-eval/expected/sanding.csexp" }
// test_eval! {eval_tape, "cads/pldi2020-eval/expected/tape.csexp" }
// test_eval! {eval_solder, "cads/pldi2020-eval/expected/soldering.csexp" }
// test_eval! {eval_sdcard, "cads/pldi2020-eval/expected/sdcard_manual_engineered.csexp" }
// test_eval! {eval_wardrobe, "cads/pldi2020-eval/expected/wardrobe.csexp" }


#[test]
fn eval_prim() {
    let input = rec!(Cad::Sphere);
    let output = eval(&input);
    assert_eq!(output, rec!(Cad::Sphere));
}

#[test]
fn eval_affine1() {
    let input = rec!(
        Cad::Trans,
        rec!(Cad::Num(2.into())),
        rec!(Cad::Num(3.into())),
        rec!(Cad::Num(5.into())),
        rec!(Cad::Unit)
    );
    let output = eval(&input);
    assert_eq!(output, input);
}

#[test]
fn eval_affine2() {
    let input = rec!(
        Cad::Scale,
        rec!(Cad::Num(2.into())),
        rec!(Cad::Num(3.into())),
        rec!(Cad::Num(5.into())),
        rec!(Cad::Unit)
    );
    let output = eval(&input);
    assert_eq!(output, input);
}

#[test]
fn scad_foldunion() {
    let fx = rec!(
        Cad::Add,
        rec!(
            Cad::Mul,
            rec!(Cad::Num(2.into())),
            rec!(Cad::ListVar(ListVar(&"i")))
        ),
        rec!(Cad::Num(3.into()))
    );
    let fy = rec!(Cad::Num(5.into()));
    let fz = rec!(Cad::Num(7.into()));
    let mapi = rec!(
        Cad::MapI,
        rec!(Cad::Num(3.into())),
        rec!(Cad::Vec, fx, fy, fz)
    );
    let map = rec!(
        Cad::Map,
        rec!(Cad::TransPolar),
        mapi,
        rec!(Cad::Repeat, rec!(Cad::Num(3.into())), rec!(Cad::Sphere))
    );
    let input = rec!(Cad::FoldUnion, map);
    let output = eval(&input);
    assert_eq!(format!("{}", Scad(&input)), format!("{}", Scad(&output)));
}
