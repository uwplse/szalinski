use std::f64::consts;

use smallvec::smallvec;

use crate::{
    cad::{Cad, EGraph, ListVar as LV, Vec3},
    num::Num,
    permute::Permutation,
};
use egg::{
    egraph::AddResult,
    expr::{Expr, Id},
};

fn f(u: usize) -> f64 {
    u as f64
}

#[derive(Debug, PartialEq)]
pub struct VecFormula {
    x: Formula,
    y: Formula,
    z: Formula,
}

#[derive(Debug, PartialEq)]
enum Formula {
    Deg1(Deg1),
    Deg2(Deg2),
}

macro_rules! eadd {
    ($egraph:expr, $op:expr) => {$egraph.add(Expr::unit($op)).id};
    ($egraph:expr, $op:expr, $($arg:expr),*) => {
        $egraph.add(Expr::new($op, smallvec![$($arg),*])).id
    };
}

impl Formula {
    fn add_to_egraph(&self, e: &mut EGraph) -> Id {
        use Cad::*;
        let i = eadd!(e, ListVar(LV("i")));
        match self {
            Formula::Deg1(f) => {
                let a = eadd!(e, Num(f.a.into()));
                let b = eadd!(e, Num(f.b.into()));
                let mul = eadd!(e, Mul, a, i);
                eadd!(e, Add, mul, b)
            }
            Formula::Deg2(f) => {
                let a = eadd!(e, Num(f.a.into()));
                let b = eadd!(e, Num(f.b.into()));
                let c = eadd!(e, Num(f.c.into()));
                let ii = eadd!(e, Mul, i, i);
                let a2 = eadd!(e, Mul, a, ii);
                let b1 = eadd!(e, Mul, b, i);
                let ab = eadd!(e, Add, a2, b1);
                eadd!(e, Add, ab, c)
            }
        }
    }
}

fn add_mapi(egraph: &mut EGraph, n: usize, vf: VecFormula) -> AddResult {
    let n = egraph.add(Expr::unit(Cad::Num(n.into()))).id;
    let x = vf.x.add_to_egraph(egraph);
    let y = vf.y.add_to_egraph(egraph);
    let z = vf.z.add_to_egraph(egraph);
    let vec = egraph.add(Expr::new(Cad::Vec, smallvec![x, y, z])).id;
    egraph.add(Expr::new(Cad::MapI, smallvec![n, vec]))
}

#[derive(Debug, PartialEq)]
struct Deg1 {
    a: f64,
    b: f64,
}

#[derive(Debug, PartialEq)]
struct Deg2 {
    a: f64,
    b: f64,
    c: f64,
}

fn solve_deg1(vs: &[Num]) -> Option<Deg1> {
    let i1 = 0.0;
    let i2 = 1.0;
    let o1 = vs[0].to_f64();
    let o2 = vs[1].to_f64();
    let b = (o1 * i2) - (o2 * i1) / (i2 - i1);
    let a = (o2 - b) / i2;
    let mut ivs = vs.iter().enumerate();
    if ivs.all(|(i, &v)| v.is_close(a * f(i) + b)) {
        Some(Deg1 { a, b })
    } else {
        None
    }
}

fn solve_deg2(vs: &[Num]) -> Option<Deg2> {
    let i1 = 0.0;
    let i2 = 1.0;
    let i3 = 2.0;
    let o1 = vs[0].to_f64();
    let o2 = vs[1].to_f64();
    let o3 = vs[2].to_f64();
    let a = (((o2 * i3) - (o3 * i2)) - ((i2 - i3) * (((o1 * i2) - (o2 * i1)) / (i1 - i2))))
        / ((i2 - i3) * ((i2 * i3) - (i1 * i2)));
    let c = (a * i1 * i2) - (((o1 * i2) - (o2 * i1)) / (i1 - i2));
    let b = (o3 - c - (a * i3 * i3)) / i3;
    let mut ivs = vs.iter().enumerate();

    let works = ivs.all(|(i, &v)| v.is_close(a * f(i * i) + b * f(i) + c));

    if works {
        // dbg!(
        Some(Deg2 { a, b, c })
    // )
    } else {
        None
    }
}

fn solve_list_fn(xs: &[Num]) -> Option<Formula> {
    if let Some(sol1) = solve_deg1(&xs) {
        return Some(Formula::Deg1(sol1));
    }
    if xs.len() > 3 {
        return solve_deg2(&xs).map(Formula::Deg2);
    }
    None
}

fn solve_one(xs: &[Num], ys: &[Num], zs: &[Num]) -> Option<VecFormula> {
    let x = solve_list_fn(xs)?;
    let y = solve_list_fn(ys)?;
    let z = solve_list_fn(zs)?;
    Some(VecFormula { x, y, z })
}

fn solve_vec(egraph: &mut EGraph, list: &[Vec3]) -> Vec<AddResult> {
    // print!("Solving: [");
    // for v in list {
    //     print!("({:.2}, {:.2}, {:.2}), ", v.0, v.1, v.2);
    // }
    // println!("]");

    if list.iter().all(|&v| v == list[0]) {
        // don't infer here, it'll become a repeat
        return vec![];
    }

    let xs: Vec<Num> = list.iter().map(|v| v.0).collect();
    let ys: Vec<Num> = list.iter().map(|v| v.1).collect();
    let zs: Vec<Num> = list.iter().map(|v| v.2).collect();

    let len = xs.len();
    assert_eq!(len, ys.len());
    assert_eq!(len, zs.len());

    let mut results = vec![];

    if let Some(formula) = solve_one(&xs, &ys, &zs) {
        results.push(add_mapi(egraph, len, formula));
    }

    let perms = [
        Permutation::sort(&xs),
        Permutation::sort(&ys),
        Permutation::sort(&zs),
    ];

    for perm in &perms {
        // println!("Trying sort {:?}", perm);
        let xs = perm.apply(&xs);
        let ys = perm.apply(&ys);
        let zs = perm.apply(&zs);
        if let Some(formula) = solve_one(&xs, &ys, &zs) {
            // println!("Found with sort {:?}: {:?}", perm, formula);
            let p = Cad::Permutation(perm.clone());
            let e = Expr::new(
                Cad::Unsort,
                smallvec![
                    egraph.add(Expr::unit(p)).id,
                    add_mapi(egraph, len, formula).id,
                ],
            );
            results.push(egraph.add(e));
        }
    }
    results
}

fn polar_one(center: (f64, f64, f64), v: Vec3) -> Vec3 {
    let (x, y, z) = (v.0.to_f64(), v.1.to_f64(), v.2.to_f64());
    let (a, b, c) = center;
    let (xa, yb, zc) = (x - a, y - b, z - c);
    let r = (xa * xa + yb * yb + zc * zc).sqrt();
    // println!("r: {}", r);
    let theta = yb.atan2(xa) * 180.0 / consts::PI;
    let phi = if r == 0.0 {
        0.0
    } else {
        (zc / r).acos() * 180.0 / consts::PI
    };
    // println!("xa: {} yb: {} zc: {}", xa, yb, zc);
    // println!("r: {} t: {} p: {}", r, theta, phi);
    (r.into(), theta.into(), phi.into())
}

// k = (((x1 - x3) * (x1^2 + y1^2 - x2^2 - y2^2)) - ((x1 - x2) * (x1^2 + y1^2 - x3^2 - y3^2))) / (2 (x1y3 - x1y2 + x2y1 - x3y1 + x3y2 - x2y3))
// h = x1^2 + y1^2 - x2^2 - y2^2 - (2k * (y1 - y2)) / 2 * (x1 - x2)
// r = sqrt ((x1 - h)^2 + (y1 - k)^2)

// NOTE: only when zs are the same for now
fn circ_center(xs: Vec<f64>, ys: Vec<f64>, zs: Vec<f64>) -> (f64, f64, f64) {
    let k_numer = ((xs[0] - xs[2])
        * ((xs[0] * xs[0]) + (ys[0] * ys[0]) - (xs[1] * xs[1]) - (ys[1] * ys[1])))
        - ((xs[0] - xs[1])
            * ((xs[0] * xs[0]) + (ys[0] * ys[0]) - (xs[2] * xs[2]) - (ys[2] * ys[2])));
    let k_denom = 2.0
        * ((xs[0] * ys[2]) - (xs[0] * ys[1]) + (xs[1] * ys[0]) - (xs[2] * ys[0]) + (xs[2] * ys[1])
            - (xs[1] * ys[2]));
    println!("k_numer: {}", k_numer);
    println!("k_denom: {}", k_denom);
    let k = k_numer / k_denom;
    println!("k: {}", k);
    let k = k_numer / k_denom;
    println!("xs[0]: {}", xs[0]);
    println!("ys[0]: {}", ys[0]);
    println!("xs[1]: {}", xs[1]);
    println!("ys[1]: {}", ys[1]);
    let h_numer = (xs[0] * xs[0]) + (ys[0] * ys[0])
        - (xs[1] * xs[1])
        - (ys[1] * ys[1])
        - (2.0 * k * (ys[0] - ys[1]));

    let h_denom = if xs[0] != xs[1] {
        2.0 * (xs[0] - xs[1])
    } else {
        2.0 * (xs[0] - xs[2])
    };
    println!("h_numer: {}", h_numer);
    println!("h_denom: {}", h_denom);
    let h = h_numer / h_denom;
    //let r = f64::sqrt(f64::powi(xs[0] - h, 2) + f64::powi(ys[0] - k, 2));
    (h, k, zs[0])
}

// TODO
fn collinear(xs: &Vec<f64>, ys: &Vec<f64>, zs: &Vec<f64>) -> bool {
    true
}

fn polarize(list: &[Vec3]) -> (Vec3, Vec<Vec3>) {
    let xc = list.iter().map(|v| v.0.to_f64()).sum::<f64>();
    let yc = list.iter().map(|v| v.1.to_f64()).sum::<f64>();
    let zc = list.iter().map(|v| v.2.to_f64()).sum::<f64>();
    let n = f(list.len());
    let mut center = (0.0, 0.0, 0.0);
    let xs: Vec<f64> = list.iter().map(|v| v.0.to_f64()).collect();
    let ys: Vec<f64> = list.iter().map(|v| v.1.to_f64()).collect();
    let zs: Vec<f64> = list.iter().map(|v| v.2.to_f64()).collect();
    if zs.iter().all(|v| v.clone() == zs[0].clone()) && !(collinear(&xs, &ys, &zs)) {
        center = circ_center(xs, ys, zs);
    } else {
        center = (xc / n, yc / n, zc / n);
    }
    let new_list = list.iter().map(|&v| polar_one(center, v)).collect();
    let num_center = (center.0.into(), center.1.into(), center.2.into());
    (num_center, new_list)
}

fn add_num(egraph: &mut EGraph, n: Num) -> Id {
    static NS: &[f64] = &[consts::SQRT_2, 0.0, 90.0, 180.0, 270.0, 360.0];

    for &known_n in NS {
        if n == known_n.into() {
            return egraph.add(Expr::unit(Cad::Num(known_n.into()))).id;
        }
    }
    egraph.add(Expr::unit(Cad::Num(n))).id
}

fn add_vec(egraph: &mut EGraph, v: Vec3) -> Id {
    let x = add_num(egraph, v.0);
    let y = add_num(egraph, v.1);
    let z = add_num(egraph, v.2);
    egraph.add(Expr::new(Cad::Vec, smallvec![x, y, z])).id
}

pub fn solve(egraph: &mut EGraph, list: &[Vec3]) -> Vec<AddResult> {
    let mut results = solve_vec(egraph, list);
    // println!("Solving {:?} -> {:?}", list, results);
    let (center, polar_list) = polarize(&list);
    for res in solve_vec(egraph, &polar_list) {
        let e = Expr::new(
            Cad::Unpolar,
            smallvec![
                add_num(egraph, list.len().into()),
                add_vec(egraph, center),
                res.id
            ],
        );
        results.push(egraph.add(e));
    }
    results
}

#[cfg(test)]
mod tests {
    use super::*;

    fn mk_test_vec(v: &[f64]) -> Vec<Num> {
        v.iter().map(|&v| v.into()).collect()
    }

    #[test]
    fn deg1_test1() {
        let input = mk_test_vec(&[1.0, 2.0, 3.0, 4.0]);
        let res = solve_deg1(&input).unwrap();
        assert_eq!(res.a, 1.0);
    }

    #[test]
    fn deg1_test2() {
        let input = mk_test_vec(&[0.0, 0.0, 0.0, 0.0]);
        let res = solve_deg1(&input).unwrap();
        assert_eq!(res.a, 0.0);
    }

    #[test]
    fn deg1_fail() {
        let input = mk_test_vec(&[0.0, 0.0, 0.0, 1.0]);
        assert_eq!(solve_deg1(&input), None);
    }

    #[test]
    fn deg2_test1() {
        let input = mk_test_vec(&[0.0, 1.0, 4.0, 9.0]);
        let res = solve_deg2(&input).unwrap();
        assert_eq!(res.a, 1.0);
    }

    #[test]
    fn deg2_fail() {
        let input = mk_test_vec(&[0.0, 1.0, 14.0, 9.0]);
        assert_eq!(solve_deg2(&input), None);
    }

    #[test]
    fn test_solve() {
        let xs = mk_test_vec(&[-6.0, -6.0, -6.0]);
        let ys = mk_test_vec(&[-37.0, -23.0, -9.0]);
        let zs = mk_test_vec(&[5.0, 5.0, 5.0]);
        assert_ne!(solve_one(&xs, &ys, &zs), None);
    }
}
