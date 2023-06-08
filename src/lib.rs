#[macro_export]
#[allow(dead_code)]
macro_rules! sz_param {
    ($name:ident : $ty:ty) => {
        $crate::sz_param!($name : $ty = |x: $ty| x);
    };
    ($name:ident : $ty:ty = |$arg:ident : $parse_ty:ty| $($body:tt)+) => {
        $crate::sz_param!($name : $ty =
                          { panic!("No default for {}", stringify!($name)) }
                          @func |$arg: $parse_ty| $($body)+);
    };
    ($name:ident : $ty:ty = $default:expr) => {
        $crate::sz_param!($name : $ty = { $default } @func |x: $ty| x);
    };
    ($name:ident : $ty:ty = { $default:expr } @func |$arg:ident : $parse_ty:ty| $($body:tt)+) => {
        static $name: once_cell::sync::Lazy<$ty> = once_cell::sync::Lazy::new(|| {
            let var = std::concat!("SZ_", stringify!($name));
            match std::env::var(var) {
                Ok(s) => match s.parse::<$parse_ty>() {
                    Ok(t) => {
                        log::info!("Parsed {}={}", var, t);
                        (|$arg: $parse_ty| $($body)+)(t)
                    }
                    Err(err) => panic!("Couldn't parse '{}={}': {}", var, s, err),
                }
                Err(std::env::VarError::NotPresent) => $default,
                Err(err) => panic!("Couldn't read {}: {}", var, err)
            }
        });
    }
}

pub mod cad;
pub mod rules;

pub mod au;
pub mod eval;
pub mod num;
mod permute;
mod solve;
