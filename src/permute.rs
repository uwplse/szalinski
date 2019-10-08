use std::fmt;
use std::str::FromStr;

#[derive(PartialEq, Eq, Hash, Debug, Clone)]
pub struct Permutation {
    pub order: Vec<usize>,
}

impl FromStr for Permutation {
    type Err = ();
    fn from_str(_: &str) -> Result<Self, Self::Err> {
        Err(())
    }
}

impl fmt::Display for Permutation {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "{:?}", self.order)
    }
}

impl Permutation {
    pub fn len(&self) -> usize {
        self.order.len()
    }

    pub fn invert(&self) -> Permutation {
        Permutation::sort(&self.order)
    }

    pub fn from_vec(order: Vec<usize>) -> Permutation {
        Permutation { order }
    }

    pub fn sort<T: Ord>(list: &[T]) -> Permutation {
        let mut order: Vec<usize> = (0..list.len()).collect();
        order.sort_by_key(|&i| &list[i]);
        Permutation { order }
    }

    pub fn apply<T: Ord + Clone>(&self, list: &[T]) -> Vec<T> {
        assert_eq!(self.len(), list.len());
        self.order.iter().map(|&i| list[i].clone()).collect()
    }
}
