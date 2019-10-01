use ordered_float::NotNan;
use std::fmt;

use smallvec::smallvec;

use crate::cad::{Cad, EGraph};
use egg::{egraph::AddResult, expr::Expr};

pub type Float = NotNan<f64>;

fn to_float(f: usize) -> Float {
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
    Trig(Trig),
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
                }
                else {
                   write!(f, "{:.2} * i * i + {:.2} * i + {:.2}", soln.a, soln.b, soln.c) 
                }
            }
            Formula::Trig(soln) => {
                if soln.a.into_inner() == 0.0 {
                    // TODO: not sure of this case 
                    write!(f, "no trig solution: a = 0")
                } else {
                    if soln.b.into_inner() == 0.0 {
                    // TODO: not sure of this case
                        write!(f, "no trig solution: b = 0")
                    }
                    else {
                        write!(f, "{:2} * Sin ({:2} * i + {:2})", soln.a, soln.b, soln.c)
                    }
                }
            }
        }
    }
}

#[derive(Debug, PartialEq, Eq, Hash, Clone)]
struct Deg1 {
    a: Float,
    b: Float,
}
#[derive(Debug, PartialEq, Eq, Hash, Clone)]
struct Deg2 {
    a: Float,
    b: Float,
    c: Float,
}

#[derive(Debug, PartialEq, Eq, Hash, Clone)]
struct Trig {
    a: Float,
    b: Float,
    c: Float,
}

fn solve_deg1(vs: &[Float]) -> Option<Deg1> {
    let i1 = to_float(0);
    let i2 = to_float(1);
    let o1 = vs[0];
    let o2 = vs[1];
    let b = (o1 * i2) - (o2 * i1) / (i2 - i1);
    let a = (o2 - b) / i2;
    let mut ivs = vs.iter().enumerate();
    if ivs.all(|(i, &v)| a * to_float(i) + b == v) {
        Some(Deg1 { a, b })
    } else {
        None
    }
}

fn solve_deg2(vs: &[Float]) -> Option<Deg2> {
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
        a * f * f + b * f + c == v
    });

    if works {
        Some(Deg2 { a, b, c })
    } else {
        None
    }
}


fn solve_trig(vs: &[Float]) -> Option<Trig> {
    let mut a_init : Float = ordered_float::NotNan::from(1.414); // sqrt(2)
    let mut b_init : Float = to_float(1);
    let mut c_init : Float = ordered_float::NotNan::from(3.14159 / 4.0); // pi / 4
    let mut ivs = vs.iter().enumerate();
    let mut found = false;
    let mut trials = 10;
    // if no solution after 10 periods, give up.
    while !found && trials > 0 {
        if ivs.all(|(i, &v)| a_init * ((b_init * (3.14159 / 2.0) * (to_float(i))) + c_init).sin() == v) {
            found = true;
        } else {
            b_init = b_init + to_float(1);
        }
        trials = trials - 1;
    }
    if found == true {
        let a = a_init;
        let b = b_init;
        let c = c_init;
        Some(Trig {a, b, c})
    } else {
        None
    }
}

fn solve_one(xs: &[Float], ys: &[Float], zs: &[Float]) -> Option<VecFormula> {
    let x = solve_deg1(&xs).map(Formula::Deg1)?;
    let y = solve_deg1(&ys).map(Formula::Deg1)?;
    let z = solve_deg1(&zs).map(Formula::Deg1)?;
    Some(VecFormula { x, y, z })
}

pub fn solve(egraph: &mut EGraph, list: &[(Float, Float, Float)]) -> Vec<AddResult> {
    let xs: Vec<Float> = list.iter().map(|v| v.0).collect();
    let ys: Vec<Float> = list.iter().map(|v| v.1).collect();
    let zs: Vec<Float> = list.iter().map(|v| v.2).collect();

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

#[cfg(test)]
mod tests {
    use super::*;

    fn mk_test_vec(v: &[f64]) -> Vec<Float> {
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

    #[test]
    fn trig_test1() {
        let input = mk_test_vec(&[1.0, 1.0, -1.0, -1.0]);
        let res = solve_trig(&input).unwrap();
        assert_eq!(res.b.into_inner(), 5.0);
    }
}
