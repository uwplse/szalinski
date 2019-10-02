use ordered_float::NotNan;
use std::fmt;

use smallvec::smallvec;

use crate::cad::{Cad, EGraph, Num, Vec3};
use egg::{egraph::AddResult, expr::{Expr, Id}};

static EPSILON: f64 = 0.001;

fn float_eq(a: impl Into<f64>, b: impl Into<f64>) -> bool {
    (a.into() - b.into()).abs() < EPSILON
}

fn to_float(f: usize) -> Num {
    NotNan::new(f as f64).unwrap()
}

#[derive(Debug, PartialEq, Eq, Hash, Clone)]
pub struct VecFormula {
    x: Formula,
    y: Formula,
    z: Formula,
}

impl fmt::Display for VecFormula {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "{{ x: {}, y: {}, z: {} }}", self.x, self.y, self.z)
    }
}

#[derive(Debug, PartialEq, Eq, Hash, Clone)]
enum Formula {
    Deg1(Deg1),
    Deg2(Deg2),
}

impl fmt::Display for Formula {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            Formula::Deg1(soln) => {
                if soln.a.into_inner() == 0.0 {
                    write!(f, "{}", soln.b)
                } else {
                    write!(f, "{:.2} * i + {:.2}", soln.a, soln.b)
                }
            }
            Formula::Deg2(soln) => {
                // if a = 0 then it is just Deg1
                if soln.b.into_inner() == 0.0 {
                    write!(f, "{:.2} * i * i + {:.2}", soln.a, soln.c)
                } else {
                    write!(
                        f,
                        "{:.2} * i * i + {:.2} * i + {:.2}",
                        soln.a, soln.b, soln.c
                    )
                }
            }
        }
    }
}

#[derive(Debug, PartialEq, Eq, Hash, Clone)]
struct Deg1 {
    a: Num,
    b: Num,
}
#[derive(Debug, PartialEq, Eq, Hash, Clone)]
struct Deg2 {
    a: Num,
    b: Num,
    c: Num,
}

fn solve_deg1(vs: &[Num]) -> Option<Deg1> {
    let i1 = to_float(0);
    let i2 = to_float(1);
    let o1 = vs[0];
    let o2 = vs[1];
    let b = (o1 * i2) - (o2 * i1) / (i2 - i1);
    let a = (o2 - b) / i2;
    let mut ivs = vs.iter().enumerate();
    if ivs.all(|(i, &v)| float_eq(a * to_float(i) + b, v)) {
        Some(Deg1 { a, b })
    } else {
        None
    }
}

fn solve_deg2(vs: &[Num]) -> Option<Deg2> {
    let i1 = to_float(0);
    let i2 = to_float(1);
    let i3 = to_float(2);
    let o1 = vs[0];
    let o2 = vs[1];
    let o3 = vs[2];
    let a = (((o2 * i3) - (o3 * i2)) - ((i2 - i3) * (((o1 * i2) - (o2 * i1)) / (i1 - i2))))
        / ((i2 - i3) * ((i2 * i3) - (i1 * i2)));
    let c = (a * i1 * i2) - (((o1 * i2) - (o2 * i1)) / (i1 - i2));
    let b = (o3 - c - (a * i3 * i3)) / i3;
    let mut ivs = vs.iter().enumerate();

    let works = ivs.all(|(i, &v)| {
        let f = to_float(i);
        float_eq(a * f * f + b * f + c, v)
    });

    if works {
        Some(Deg2 { a, b, c })
    } else {
        None
    }
}

fn solve_one(xs: &[Num], ys: &[Num], zs: &[Num]) -> Option<VecFormula> {
    let x = solve_deg1(&xs).map(Formula::Deg1)?;
    let y = solve_deg1(&ys).map(Formula::Deg1)?;
    let z = solve_deg1(&zs).map(Formula::Deg1)?;
    Some(VecFormula { x, y, z })
}

fn solve_vec(egraph: &mut EGraph, list: &[Vec3]) -> Vec<AddResult> {
    let xs: Vec<Num> = list.iter().map(|v| v.0).collect();
    let ys: Vec<Num> = list.iter().map(|v| v.1).collect();
    let zs: Vec<Num> = list.iter().map(|v| v.2).collect();

    let len = xs.len();
    assert_eq!(len, ys.len());
    assert_eq!(len, zs.len());

    let mut results = vec![];

    if let Some(formula) = solve_one(&xs, &ys, &zs) {
        let e = Expr::unit(Cad::MapI(len, formula));
        results.push(egraph.add(e));
    }

    let perms = [
        permutation::sort(&xs[..]),
        permutation::sort(&ys[..]),
        permutation::sort(&zs[..]),
    ];

    for perm in &perms {
        let xs = perm.apply_slice(&xs[..]);
        let ys = perm.apply_slice(&ys[..]);
        let zs = perm.apply_slice(&zs[..]);
        if let Some(formula) = solve_one(&xs, &ys, &zs) {
            let p = Cad::Variable(format!("{:?}", perm));
            let e = Expr::new(
                Cad::Unsort,
                smallvec![
                    egraph.add(Expr::unit(p)).id,
                    egraph.add(Expr::unit(Cad::MapI(len, formula))).id,
                ],
            );
            results.push(egraph.add(e));
        }
    }
    results
}

fn polar_one(center: Vec3, v: Vec3) -> Vec3 {
    let (x, y, z) = v;
    let (a, b, c) = center;
    let (xa, yb, zc) = (x - a, y - b, z - c);
    let r = (xa * xa + yb * yb + zc * zc).sqrt();
    println!("r: {}", r);
    let zero = 0.0.into();
    let theta = if xa == zero { 90.0 } else { (yb / xa).atan() };
    let phi = if r == 0.0 { 0.0 } else { (zc / r).acos() };
    (r.into(), theta.into(), phi.into())
}

fn polarize(list: &[Vec3]) -> (Vec3, Vec<Vec3>) {
    let xc: Num = list.iter().map(|v| v.0.into_inner()).sum::<f64>().into();
    let yc: Num = list.iter().map(|v| v.1.into_inner()).sum::<f64>().into();
    let zc: Num = list.iter().map(|v| v.2.into_inner()).sum::<f64>().into();
    let n = to_float(list.len());
    let center = (xc / n, yc / n, zc / n);
    let new_list = list.iter().map(|&v| polar_one(center, v)).collect();
    (center, new_list)
}

fn add_vec(egraph: &mut EGraph, v: Vec3) -> Id {
    let x = egraph.add(Expr::unit(Cad::Num(v.0))).id;
    let y = egraph.add(Expr::unit(Cad::Num(v.1))).id;
    let z = egraph.add(Expr::unit(Cad::Num(v.2))).id;
    egraph.add(Expr::new(Cad::Vec, smallvec![x, y, z])).id
}

pub fn solve(egraph: &mut EGraph, list: &[Vec3]) -> Vec<AddResult> {
    let mut results = solve_vec(egraph, list);
    println!("{:?}", list);
    let (center, polar_list) = polarize(&list);
    for res in solve_vec(egraph, &polar_list) {
        let e = Expr::new(Cad::Unpolar, smallvec![add_vec(egraph, center), res.id]);
        results.push(egraph.add(e));
    }
    results
}

#[cfg(test)]
mod tests {
    use super::*;

    fn mk_test_vec(v: &[f64]) -> Vec<Num> {
        v.iter().map(|v| NotNan::new(*v).unwrap()).collect()
    }

    #[test]
    fn deg1_test1() {
        let input = mk_test_vec(&[1.0, 2.0, 3.0, 4.0]);
        let res = solve_deg1(&input).unwrap();
        assert_eq!(res.a.into_inner(), 1.0);
    }

    #[test]
    fn deg1_test2() {
        let input = mk_test_vec(&[0.0, 0.0, 0.0, 0.0]);
        let res = solve_deg1(&input).unwrap();
        assert_eq!(res.a.into_inner(), 0.0);
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
        assert_eq!(res.a.into_inner(), 1.0);
    }

    #[test]
    fn deg2_fail() {
        let input = mk_test_vec(&[0.0, 1.0, 14.0, 9.0]);
        assert_eq!(solve_deg2(&input), None);
    }
}
