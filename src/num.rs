use std::fmt;
use std::str::FromStr;

use log::*;

use crate::cad::{EGraph, Cad};

#[derive(PartialOrd, Ord, PartialEq, Eq, Hash, Default, Clone, Copy)]
// pub struct Num(ordered_float::NotNan<f64>);
pub struct Num(u64);

const DEFAULT_MANTISSA_BITS: usize = 52;

sz_param!(ABS_EPSILON: f64);
sz_param!(REL_EPSILON: f64);
sz_param!(MANTISSA_BITS: usize);

// const ROUND_RELATIVE: f64 = 0.01;

pub fn num(n: impl Into<Num>) -> Num {
    n.into()
}

impl Num {
    pub fn to_f64(self) -> f64 {
        // self.0.into_inner()
        f64::from_bits(self.0)
    }

    pub fn is_close(self, other: impl Clone + Into<Num>) -> bool {
        let a = self.to_f64();
        let b = other.into().to_f64();

        let diff = (a - b).abs();
        if diff <= *ABS_EPSILON {
            return true;
        }

        let max = a.abs().max(b.abs());
        diff <= max * *REL_EPSILON
    }
}

// conversions

impl From<f64> for Num {
    fn from(f: f64) -> Num {
        // Num(f.into())
        let d = DEFAULT_MANTISSA_BITS - *MANTISSA_BITS;
        let mask: u64 = !0 << d;
        Num(f.to_bits() & mask)
        // let small = f * ROUND_RELATIVE;
        // let big = small.round() / ROUND_RELATIVE;
        // Num(big.into())
    }
}

impl From<usize> for Num {
    fn from(u: usize) -> Num {
        let f = u as f64;
        f.into()
    }
}

impl From<i32> for Num {
    fn from(i: i32) -> Num {
        let f = i as f64;
        f.into()
    }
}

// core traits

impl FromStr for Num {
    type Err = ordered_float::ParseNotNanError<std::num::ParseFloatError>;
    fn from_str(s: &str) -> Result<Self, Self::Err> {
        let f: ordered_float::NotNan<f64> = s.parse()?;
        Ok(f.into_inner().into())
    }
}

impl fmt::Display for Num {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        let float = self.to_f64();
        write!(f, "{}", float)
    }
}

impl fmt::Debug for Num {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "Num({})", self.to_f64())
    }
}

pub fn unify_close_nums(egraph: &mut EGraph) {
    let mut nums = vec![];
    for eclass in egraph.classes() {
        for node in &eclass.nodes {
            if let Cad::Num(num) = node.op {
                assert_eq!(node.children.len(), 0);
                nums.push((num, eclass.id));
            }
        }
    }

    let mut n_unified = 0;
    for (_n, e) in &mut nums {
        *e = egraph.find(*e);
    }

    nums.sort();
    for win in nums.windows(2) {
        let (num0, e0) = win[0];
        let (num1, e1) = win[1];
        if e0 != e1 && num0.is_close(num1) {
            egraph.union(e0, e1);
            n_unified += 1;
        }
    }

    info!("Unified {} nums", n_unified);
}
