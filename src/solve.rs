use std::f64::consts;

use log::*;

use indexmap::{indexset, IndexMap};

use crate::{
    cad::{Cad, EGraph, ListVar as LV, Vec3},
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

impl Formula {
    fn add_to_egraph(&self, e: &mut EGraph, i: Id) -> Id {
        use Cad::*;
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

fn solve_and_add(egraph: &mut EGraph, xs: &[Num], ys: &[Num], zs: &[Num]) -> Option<Id> {
    // println!("Solving:\n  x={:?}\n  y={:?}\n  z={:?}", xs, ys, zs);
    assert_eq!(xs.len(), ys.len());
    assert_eq!(xs.len(), zs.len());
    let mut by_chunk = IndexMap::<usize, Vec<_>>::default();
    by_chunk.entry(chunk_length(xs)).or_default().push((0, xs));
    by_chunk.entry(chunk_length(ys)).or_default().push((1, ys));
    by_chunk.entry(chunk_length(zs)).or_default().push((2, zs));
    by_chunk.sort_by(|k1, _, k2, _| k2.cmp(k1));

    if !by_chunk.keys().any(|len| *len == xs.len()) {
        return None;
    }

    let inners: Vec<usize> = (0..by_chunk.len())
        .map(|i| by_chunk.get_index(i + 1).map(|(k, _)| *k).unwrap_or(1))
        .collect();

    let vars = &[
        Cad::ListVar(LV("i")),
        Cad::ListVar(LV("j")),
        Cad::ListVar(LV("k")),
    ];
    let mut inserted = vec![None; 3];

    for (((&chunk_len, lists), inner), var) in by_chunk.iter().zip(&inners).zip(vars) {
        for (index, list) in lists {
            let slice = &list[..chunk_len];
            let nums = unrun(slice, *inner)?;
            let fun = solve_list_fn(&nums)?;
            // println!("Found: {:?}", fun);
            let var_id = egraph.add(var.clone());
            inserted[*index] = Some(fun.add_to_egraph(egraph, var_id));
        }
    }

    let mut lens = vec![];
    let mut children: Vec<_> = by_chunk
        .keys()
        .zip(&inners)
        .map(|(n, inner)| {
            assert_eq!(n % inner, 0);
            let len = n / inner;
            lens.push(len);
            egraph.add(Cad::Num(len.into()))
        })
        .collect();
    // println!("lens: {:?}, {:?}", lens, xs);
    assert_eq!(lens.iter().product::<usize>(), xs.len());
    let x = inserted[0].unwrap();
    let y = inserted[1].unwrap();
    let z = inserted[2].unwrap();
    let vec = egraph.add(Cad::Vec3([x, y, z]));
    children.push(vec);
    let map = egraph.add(Cad::MapI(children));
    // println!("inserted map: {:?}", map);
    Some(map)
}

fn solve_vec(egraph: &mut EGraph, list: &[Vec3]) -> Vec<Id> {
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

    let xys: Vec<(Num, Num)> = list.iter().map(|v| (v.0, v.1)).collect();
    let yxs: Vec<(Num, Num)> = list.iter().map(|v| (v.1, v.0)).collect();

    let yzs: Vec<(Num, Num)> = list.iter().map(|v| (v.1, v.2)).collect();
    let zys: Vec<(Num, Num)> = list.iter().map(|v| (v.2, v.1)).collect();

    let xzs: Vec<(Num, Num)> = list.iter().map(|v| (v.0, v.2)).collect();
    let zxs: Vec<(Num, Num)> = list.iter().map(|v| (v.2, v.0)).collect();

    let len = xs.len();
    assert_eq!(len, ys.len());
    assert_eq!(len, zs.len());

    let mut results = vec![];

    results.extend(solve_and_add(egraph, &xs, &ys, &zs));

    let perms = indexset![
        Permutation::sort(&xs),
        Permutation::sort(&ys),
        Permutation::sort(&zs),
        Permutation::sort(&xys),
        Permutation::sort(&yxs),
        Permutation::sort(&yzs),
        Permutation::sort(&zys),
        Permutation::sort(&xzs),
        Permutation::sort(&zxs),
    ];

    for perm in &perms {
        if perm.is_ordered() {
            continue;
        }
        let xs = perm.apply(&xs);
        let ys = perm.apply(&ys);
        let zs = perm.apply(&zs);
        if let Some(added_mapi) = solve_and_add(egraph, &xs, &ys, &zs) {
            let p = Cad::Permutation(perm.clone());
            let e = Cad::Unsort([egraph.add(p), added_mapi]);
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

fn polarize(list: &[Vec3]) -> (Vec3, Vec<Vec3>) {
    let xc = list.iter().map(|v| v.0.to_f64()).sum::<f64>();
    let yc = list.iter().map(|v| v.1.to_f64()).sum::<f64>();
    let zc = list.iter().map(|v| v.2.to_f64()).sum::<f64>();
    let n = f(list.len());
    let center = (xc / n, yc / n, zc / n);
    let new_list = list.iter().map(|&v| polar_one(center, v)).collect();
    let num_center = (center.0.into(), center.1.into(), center.2.into());
    (num_center, new_list)
}

fn add_num(egraph: &mut EGraph, n: Num) -> Id {
    static NS: &[f64] = &[consts::SQRT_2, 0.0, 90.0, 180.0, 270.0, 360.0];

    for &known_n in NS {
        if n == known_n.into() {
            return egraph.add(Cad::Num(known_n.into()));
        }
    }
    egraph.add(Cad::Num(n))
}

fn add_vec(egraph: &mut EGraph, v: Vec3) -> Id {
    let x = add_num(egraph, v.0);
    let y = add_num(egraph, v.1);
    let z = add_num(egraph, v.2);
    egraph.add(Cad::Vec3([x, y, z]))
}

pub fn solve(egraph: &mut EGraph, list: &[Vec3]) -> Vec<Id> {
    let mut results = solve_vec(egraph, list);
    debug!("Solved {:?} -> {:?}", list, results);
    let (center, polar_list) = polarize(&list);
    for res in solve_vec(egraph, &polar_list) {
        let e = Cad::Unpolar([
            add_num(egraph, list.len().into()),
            add_vec(egraph, center),
            res,
        ]);
        results.push(egraph.add(e));
    }
    results
}

fn chunk_length(list: &[Num]) -> usize {
    if list.iter().all(|&x| x == list[0]) {
        return list.len();
    }

    for n in 2..list.len() {
        if list.len() % n == 0 {
            if list
                .chunks_exact(n)
                .skip(1)
                .all(|chunk| &list[..n] == chunk)
            {
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

    let all_same = |slice: &[Num]| slice.iter().all(|&x| x == slice[0]);
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
