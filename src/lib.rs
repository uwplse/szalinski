
#[macro_export]
macro_rules! sz_param {
    ($name:ident : $ty:ty) => {
        static $name: once_cell::sync::Lazy<$ty> = once_cell::sync::Lazy::new(|| {
            let var = std::concat!("SZ_", stringify!($name));
            match std::env::var(var) {
                Ok(s) => match s.parse() {
                    Ok(t) => {
                        log::info!("Parsed {}={}", var, t);
                        t
                    }
                    Err(err) => panic!("Couldn't parse '{}={}': {}", var, s, err),
                }
                Err(err) => panic!("Couldn't read {}: {}", var, err)
            }
        });
    }
}

pub mod cad;
pub mod rules;

pub mod eval;
mod num;
mod permute;
mod solve;
