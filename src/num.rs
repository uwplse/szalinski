use std::fmt;
use std::str::FromStr;

#[derive(PartialOrd, Ord, PartialEq, Eq, Hash, Default, Clone, Copy)]
pub struct Num(pub ordered_float::NotNan<f64>);

const EPSILON: f64 = 0.1;

pub fn num(n: impl Into<Num>) -> Num {
    n.into()
}

impl Num {
    pub fn to_f64(self) -> f64 {
        self.0.into()
    }

    pub fn is_close(self, other: f64) -> bool {
        (self.to_f64() - other).abs() < EPSILON
    }
}

// conversions

impl From<f64> for Num {
    fn from(f: f64) -> Num {
        Num(f.into())
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
        s.parse().map(Num)
    }
}

impl fmt::Display for Num {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        let float = self.to_f64();
        if float.fract() == 0.0 {
            write!(f, "{:3.0}", float)
        } else {
            write!(f, "{:5.2}", float)
        }
    }
}

impl fmt::Debug for Num {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "Num({})", self.to_f64())
    }
}
