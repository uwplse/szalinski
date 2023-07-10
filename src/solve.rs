use itertools::Itertools;
use log::*;

use indexmap::{indexset, IndexMap};

use crate::{
    au::{CadCtx, SolveResult},
    cad::{Cad, EGraph, ListVar as LV},
    num::Num,
    permute::Permutation,
};

use egg::Id;

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
    ($egraph:expr, $op:expr) => {$egraph.add($op)};
    ($egraph:expr, $op:expr, $($arg:expr),*) => {
        $egraph.add($op([$($arg),*]))
    };
}
sz_param!(ABS_EPSILON: f64 = 0.0001);
fn approx(v: f64, k: f64) -> bool {
    k - *ABS_EPSILON < v && v < k + *ABS_EPSILON
}

impl Formula {
    fn add_to_egraph(&self, e: &mut EGraph, i: Id) -> Id {
        use Cad::*;
        match self {
            Formula::Deg1(f) => {
                if approx(f.a, 0.) {
                    eadd!(e, Num(f.b.into()))
                } else {
                    let ax = if approx(f.a, 1.) {
                        // eadd!(e, Num(f.b.into()))
                        i
                    } else {
                        let a = eadd!(e, Num(f.a.into()));
                        eadd!(e, Mul, a, i)
                    };
                    if approx(f.a, 0.) {
                        ax
                    } else {
                        let b = eadd!(e, Num(f.b.into()));
                        eadd!(e, Add, ax, b)
                    }
                }
            }
            Formula::Deg2(f) => {
                assert!(!approx(f.a, 0.));
                let ii = eadd!(e, Mul, i, i);
                let ax2 = if approx(f.a, 1.) {
                    ii
                } else {
                    let a = eadd!(e, Num(f.a.into()));
                    eadd!(e, Mul, a, ii)
                };

                if approx(f.b, 0.) && approx(f.c, 0.) {
                    ax2
                } else {
                    let bxc = Formula::Deg1(Deg1 { a: f.a, b: f.b }).add_to_egraph(e, i);
                    eadd!(e, Add, ax2, bxc)
                }
            }
        }
    }
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

sz_param!(SOLVE_ROUND: f64 = 0.01);

fn solve_deg1(vs: &[Num]) -> Option<Deg1> {
    let i1 = 0.0;
    let i2 = 1.0;
    let o1 = vs[0].to_f64();
    let o2 = vs[1].to_f64();
    let b = (o1 * i2) - (o2 * i1) / (i2 - i1);
    let a = (o2 - b) / i2;

    let rnd = *SOLVE_ROUND;
    let aa = (a / rnd).round() * rnd;
    let bb = (b / rnd).round() * rnd;

    let close = |a, b| {
        vs.iter()
            .enumerate()
            .all(|(i, &v)| v.is_close(a * f(i) + b))
    };

    if close(aa, bb) {
        Some(Deg1 { a: aa, b: bb })
    } else if close(a, b) {
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

fn solve_and_add(
    egraph: &mut EGraph,
    proj_list: &[Vec<Num>],
    template: &CadCtx,
    should_always_insert: bool,
) -> Option<Id> {
    let mut by_chunk = IndexMap::<usize, Vec<_>>::default();
    let col_len = proj_list.len();
    let row_len = proj_list[0].len();
    for i in 0..col_len {
        by_chunk
            .entry(chunk_length(&proj_list[i]))
            .or_default()
            .push((i, &proj_list[i]));
    }
    by_chunk.sort_by(|k1, _, k2, _| k2.cmp(k1));
    if !by_chunk.keys().any(|len| len == &row_len) {
        // TODO should we really return?
        return None;
    }

    let inners: Vec<usize> = (0..by_chunk.len())
        .map(|i| by_chunk.get_index(i + 1).map(|(k, _)| *k).unwrap_or(1))
        .collect();

    let vars = (0..by_chunk.len())
        .map(|i| Cad::ListVar(LV(format!("i{}", i))))
        .collect::<Vec<_>>();
    let mut inserted = vec![None; col_len];

    let mut should_insert = should_always_insert;
    let mut get_ats = vec![];
    for (((&chunk_len, lists), inner), var) in by_chunk.iter().zip(&inners).zip(vars) {
        for (index, list) in lists {
            let slice = &list[..chunk_len];
            let var_id = egraph.add(var.clone());

            // if it can be unrunned, we can reroll the expression based on one index,
            // if it cannot be unrunned, we need to compose indices i.e., i1*n*m + i2*m + i3
            if let Some(nums) = unrun(slice, *inner) {
                let solving_result = solve_list_fn(&nums);
                match solving_result {
                    Some(fun) => {
                        should_insert = true;
                        inserted[*index] = Some(fun.add_to_egraph(egraph, var_id));
                    }
                    None => {
                        get_ats.push((nums, index, var_id));
                    }
                }
            } else {
                // TODO: we should not return None, but only modify when we can achieve the same result
                // as original szalinski
                return None;
            }
        }
    }

    if !should_insert {
        return None;
    }

    for (nums, index, var_id) in get_ats {
        let children = nums
            .iter()
            .map(|num| egraph.add(Cad::Num(*num)))
            .collect_vec();
        let list = egraph.add(Cad::List(children));
        inserted[*index] = Some(egraph.add(Cad::GetAt([list, var_id])));
    }

    let mut lens = vec![];
    let ranges: Vec<_> = by_chunk
        .keys()
        .zip(&inners)
        .map(|(n, inner)| {
            assert_eq!(n % inner, 0);
            let len = n / inner;
            lens.push(len);
            egraph.add(Cad::Num(len.into()))
        })
        .collect();
    assert_eq!(lens.iter().product::<usize>(), row_len);

    let args = inserted.into_iter().map(|i| i.unwrap()).collect_vec();
    let solve_result = SolveResult::from_loop_params(ranges, args);
    let map = solve_result.assemble(egraph, template);
    Some(map)
}

// This function takes an array of arglist (and convert them to an array of columns)
fn solve_vec(egraph: &mut EGraph, list: &[Vec<Num>], template: &CadCtx) -> Vec<Id> {
    let col_len = list[0].len();

    let mut results = vec![];
    let arr_of_cols: Vec<Vec<Num>> = (0..col_len)
        .map(|i| list.iter().map(|row| row[i]).collect())
        .collect();

    let mut perms = indexset![];
    let perm = Permutation::sort(list);
    perms.insert(perm);
    for i in 0..col_len {
        for j in 0..col_len {
            let cols: Vec<(Num, Num)> = list.iter().map(|v| (v[i], v[j])).collect();
            let perm = Permutation::sort(&cols);
            perms.insert(perm);
        }
    }

    let mut flag = true;
    // TODO: magic number
    for perm in perms.into_iter().take(100) {
        let arr_of_cols: Vec<Vec<Num>> = arr_of_cols.iter().map(|col| perm.apply(col)).collect();
        if let Some(added_mapi) = solve_and_add(egraph, &arr_of_cols, template, flag) {
            results.push(added_mapi);
        }
        flag = false;
    }

    // results may be empty
    results
}

// fn polar_one(center: (f64, f64, f64), v: Vec3) -> Vec3 {
//     let (x, y, z) = (v.0.to_f64(), v.1.to_f64(), v.2.to_f64());
//     let (a, b, c) = center;
//     let (xa, yb, zc) = (x - a, y - b, z - c);
//     let r = (xa * xa + yb * yb + zc * zc).sqrt();
//     // println!("r: {}", r);
//     let theta = yb.atan2(xa) * 180.0 / consts::PI;
//     let phi = if r == 0.0 {
//         0.0
//     } else {
//         (zc / r).acos() * 180.0 / consts::PI
//     };
//     // println!("xa: {} yb: {} zc: {}", xa, yb, zc);
//     // println!("r: {} t: {} p: {}", r, theta, phi);
//     (r.into(), theta.into(), phi.into())
// }

// fn polarize(list: &[Vec3]) -> (Vec3, Vec<Vec3>) {
//     let xc = list.iter().map(|v| v.0.to_f64()).sum::<f64>();
//     let yc = list.iter().map(|v| v.1.to_f64()).sum::<f64>();
//     let zc = list.iter().map(|v| v.2.to_f64()).sum::<f64>();
//     let n = f(list.len());
//     let center = (xc / n, yc / n, zc / n);
//     let new_list = list.iter().map(|&v| polar_one(center, v)).collect();
//     let num_center = (center.0.into(), center.1.into(), center.2.into());
//     (num_center, new_list)
// }

// fn add_num(egraph: &mut EGraph, n: Num) -> Id {
//     static NS: &[f64] = &[consts::SQRT_2, 0.0, 90.0, 180.0, 270.0, 360.0];

//     for &known_n in NS {
//         if n == known_n.into() {
//             return egraph.add(Cad::Num(known_n.into()));
//         }
//     }
//     egraph.add(Cad::Num(n))
// }

// fn add_vec(egraph: &mut EGraph, v: Vec3) -> Id {
//     let x = add_num(egraph, v.0);
//     let y = add_num(egraph, v.1);
//     let z = add_num(egraph, v.2);
//     egraph.add(Cad::Vec3([x, y, z]))
// }

pub fn solve(egraph: &mut EGraph, list: &[Vec<Num>], template: &CadCtx) -> Vec<Id> {
    let results = solve_vec(egraph, list, template);
    debug!("Solved {:?} -> {:?}", list, results);
    // TODO(yz): Add polarize back
    // It is potentially tricker, because we may also want these "constant coordinates" to solve for a closed form
    // let (center, polar_list) = polarize(&list);
    // for res in solve_vec(egraph, &polar_list) {
    //     let e = Cad::Unpolar([
    //         add_num(egraph, list.len().into()),
    //         add_vec(egraph, center),
    //         res,
    //     ]);
    //     results.push(egraph.add(e));
    // }
    results
}

fn chunk_length(list: &[Num]) -> usize {
    if list.iter().all(|&x| x.is_close(list[0])) {
        return list.len();
    }

    for n in 2..list.len() {
        if list.len() % n == 0 {
            if list.chunks_exact(n).skip(1).all(|chunk| {
                list[..n]
                    .iter()
                    .zip(chunk.iter())
                    .all(|(a, b)| a.is_close(*b))
            }) {
                return n;
            }
        }
    }

    list.len()
}

fn unrun(list: &[Num], n: usize) -> Option<Vec<Num>> {
    if list.len() % n != 0 {
        return None;
    }

    let all_same = |slice: &[Num]| slice.iter().all(|&x| x.is_close(slice[0]));
    if list.chunks_exact(n).all(all_same) {
        Some(list.iter().copied().step_by(n).collect())
    } else {
        None
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    macro_rules! nums {
        ($($e:expr),*$(,)?) => {{
            let vec: Vec<Num> = vec![$($e.into()),*];
            vec
        }}
    }

    #[test]
    fn test_chunk_length() {
        let nums = nums![0, 0, 0];
        assert_eq!(chunk_length(&nums), 3);
        let nums = nums![1, 2, 3, 4];
        assert_eq!(chunk_length(&nums), 4);
        let nums = nums![1, 2, 3, 1, 2, 3];
        assert_eq!(chunk_length(&nums), 3);
        let nums = nums![1, 2, 3, 1, 2, 3, 1, 2, 4];
        assert_eq!(chunk_length(&nums), 9);
    }

    #[test]
    fn test_unrun() {
        let nums = nums![0, 0, 1, 1, 2, 2];
        assert_eq!(unrun(&nums, 2), Some(nums![0, 1, 2]));
        let nums = nums![0, 0, 0, 1, 1, 1];
        assert_eq!(unrun(&nums, 3), Some(nums![0, 1]));
    }

    #[test]
    fn deg1_test1() {
        let input = nums![1, 2, 3, 4];
        let res = solve_deg1(&input).unwrap();
        assert_eq!(res.a, 1.0);
    }

    #[test]
    fn deg1_test2() {
        let input = nums![0, 0, 0, 0];
        let res = solve_deg1(&input).unwrap();
        assert_eq!(res.a, 0.0);
    }

    #[test]
    fn deg1_fail() {
        let input = nums![0, 0, 0, 1];
        assert_eq!(solve_deg1(&input), None);
    }

    #[test]
    fn deg2_test1() {
        let input = nums![0, 1, 4, 9];
        let res = solve_deg2(&input).unwrap();
        assert_eq!(res.a, 1.0);
    }

    #[test]
    fn deg2_fail() {
        let input = nums![0, 1, 14, 9];
        assert_eq!(solve_deg2(&input), None);
    }
}
