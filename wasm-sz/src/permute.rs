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

    pub fn is_ordered(&self) -> bool {
        self.order.iter().enumerate().all(|(a, b)| a == *b)
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

#[derive(PartialEq, Eq, Hash, Debug, Clone)]
pub struct Partitioning {
    pub lengths: Vec<usize>,
}

impl fmt::Display for Partitioning {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "{:?}", self.lengths)
    }
}

impl FromStr for Partitioning {
    type Err = ();
    fn from_str(_: &str) -> Result<Self, Self::Err> {
        Err(())
    }
}

impl Partitioning {
    pub fn total_len(&self) -> usize {
        for len in &self.lengths {
            assert_ne!(*len, 0);
        }
        self.lengths.iter().sum()
    }

    pub fn from_vec(lengths: Vec<usize>) -> Partitioning {
        Partitioning { lengths }
    }

    pub fn apply<T: Clone>(&self, list: &[T]) -> Vec<Vec<T>> {
        assert_eq!(self.total_len(), list.len());
        let mut i = 0;
        self.lengths
            .iter()
            .map(|&len| {
                let start = i;
                i += len;
                list[start..i].to_vec()
            })
            .collect()
    }
}
