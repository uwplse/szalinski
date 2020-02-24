use std::collections::HashMap;
use std::io::{Result, Write};
use std::sync::{Arc, Mutex};

use rand::{seq::SliceRandom, SeedableRng};
use rand_pcg::Pcg64;

use pest::{iterators::Pair, Parser};
use pest_derive::Parser;

use szalinski_egg::sz_param;

#[derive(Parser)]
#[grammar_inline = r###"
    WHITESPACE = _{ " " | "\t" | "\r" | "\n" }
    ident = @{ "$"? ~ (ASCII_ALPHANUMERIC | "_")+ }

    program = { SOI ~ instr* ~ EOI }

    instr = _{ empty_group | group | union | diff | inter | matrix |
              cylinder | cube | sphere | anything | anything_one }
        empty_group = { "group();" }
        group      = { "group()" ~ scope }
        union      = { "union()" ~ scope }
        diff       = { "difference()" ~ scope }
        inter      = { "intersection()" ~ scope }
        matrix     = { "multmatrix(" ~ mat ~ ")" ~ scope }
        cylinder   = { "cylinder(" ~ args ~ ")" ~ scope }
        cube       = { "cube(" ~ args ~ ")" ~ scope }
        sphere     = { "sphere(" ~ args ~ ")" ~ scope }
        anything   = { ident ~ "(" ~ args ~ ")" ~ scope }
        anything_one = { ident ~ "(" ~ value ~ ")" ~ scope }

    scope = _{ "{" ~ ("#"? ~ instr)* ~ "}" | ";" }

    num = {
       "-"? ~ ASCII_DIGIT+ ~ ("." ~ ASCII_DIGIT*)?
       ~ ("e" ~ ("-" | "+")? ~ ASCII_DIGIT+)?
    }
    vec4 = { "[" ~ num ~ "," ~ num ~ "," ~ num ~ "," ~ num ~ "]" }
    mat  =  { "[" ~ vec4 ~ "," ~ vec4 ~ "," ~ vec4 ~ "," ~ vec4 ~ "]" }
    vec3 = { "[" ~ num ~ "," ~ num ~ "," ~ num ~ "]" }

    list =  { "[" ~ values ~ "]" }
    string = @{ "\"" ~ (!"\"" ~ ANY)* ~ "\"" }

    values = _{ value? ~ ("," ~ value)* }
    value = _{ num | vec3 | bool | list | string | undef }
    undef = { "undef" }
    bool = { "true" | "false" }

    arg = { ident ~ "=" ~ value }
    args = { arg? ~ ("," ~ arg)* }
"###]
pub struct CSGParser;

fn indent(w: &mut impl Write, depth: usize) -> Result<()> {
    write!(w, "\n")?;
    for _ in 0..depth {
        write!(w, "  ")?;
    }
    Ok(())
}

fn eps(a: f64, b: f64) -> bool {
    (a - b).abs() < 0.001
}

sz_param!(PARSE_BINARIZE: bool);
sz_param!(
    PARSE_SHUFFLE_RNG: Option<Arc<Mutex<Pcg64>>> = |seed: u64| {
        if seed == 0 {
            None
        } else {
            let rng = Pcg64::seed_from_u64(seed);
            Some(Arc::new(Mutex::new(rng)))
        }
    }
);

fn write_op<'a>(
    w: &mut impl Write,
    depth: usize,
    name: &str,
    ps: impl IntoIterator<Item = Pair<'a, Rule>>,
) -> Result<()> {
    fn write_op_rec<'a>(
        w: &mut impl Write,
        depth: usize,
        name: &str,
        ps: &mut Vec<Pair<'a, Rule>>,
    ) -> Result<()> {
        match ps.len() {
            0 => panic!("Found an empty subtree under {}", name),
            1 => write_csg(w, depth, ps[0].clone()),
            _ => {
                let last = ps.pop().unwrap();
                write!(w, "(Binop {}", name)?;
                indent(w, depth + 1)?;
                write_op_rec(w, depth + 1, name, ps)?;
                indent(w, depth + 1)?;
                write_csg(w, depth + 1, last)?;
                write!(w, ")")
            }
        }
    }

    let mut ps: Vec<_> = ps.into_iter().filter(|p| has_content(p.clone())).collect();
    // let mut ps: Vec<_> = ps.into_iter().collect();
    // ps = filter_content(ps);
    // let mut ps: Vec<_> = ps.into_iter().collect();

    if let Some(rng) = PARSE_SHUFFLE_RNG.as_ref() {
        let mut rng = rng.lock().unwrap();
        if name.contains("Diff") {
            ps[1..].shuffle(&mut *rng)
        } else {
            ps.shuffle(&mut *rng)
        }
    }

    if *PARSE_BINARIZE {
        write_op_rec(w, depth, name, &mut ps)
    } else {
        match ps.len() {
            0 => panic!(),
            1 => write_csg(w, depth, ps[0].clone()),
            2 => {
                write!(w, "(Binop {}", name)?;
                for p in ps {
                    indent(w, depth + 1)?;
                    write_csg(w, depth + 1, p)?;
                }
                write!(w, ")")
            }
            _ => {
                write!(w, "(Fold {} (List", name)?;
                for p in ps {
                    indent(w, depth + 1)?;
                    write_csg(w, depth + 1, p)?;
                }
                write!(w, "))")
            }
        }
    }
}

fn float(p: Pair<Rule>) -> f64 {
    assert_eq!(p.as_rule(), Rule::num);
    p.as_str().parse().unwrap()
}

fn vec3(p: Pair<Rule>) -> (f64, f64, f64) {
    assert_eq!(p.as_rule(), Rule::vec3);
    let mut a = p.into_inner();
    (
        float(a.next().unwrap()),
        float(a.next().unwrap()),
        float(a.next().unwrap()),
    )
}

fn mkdict(args: Pair<Rule>) -> HashMap<String, Pair<Rule>> {
    assert_eq!(args.as_rule(), Rule::args);
    let d = args
        .into_inner()
        .map(|p| {
            let mut ps = p.into_inner();
            let k = ps.next().unwrap().as_str().into();
            let v = ps.next().unwrap();
            (k, v)
        })
        .collect();
    // println!("dict: {:?}", d);
    d
}

macro_rules! matrix_assert {
    ($a:expr, $b:expr) => {
        if !eps($a, $b) {
            return None;
        }
    };
}

fn get_scale(mat: &[Vec<f64>]) -> Option<(f64, f64, f64)> {
    for i in 0..4 {
        for j in 0..4 {
            if i != j {
                matrix_assert!(mat[i][j], 0.0);
            }
        }
    }
    assert_eq!(mat[3][3], 1.0);
    Some((mat[0][0], mat[1][1], mat[2][2]))
}

fn get_trans(mat: &[Vec<f64>]) -> Option<(f64, f64, f64)> {
    for i in 0..4 {
        for j in 0..4 {
            if i == j {
                matrix_assert!(mat[i][j], 1.0);
            } else if j != 3 {
                matrix_assert!(mat[i][j], 0.0);
            }
        }
    }
    Some((mat[0][3], mat[1][3], mat[2][3]))
}

fn get_rotate(mat: &[Vec<f64>]) -> Option<(f64, f64, f64)> {
    assert_eq!(mat[3][0], 0.0);
    assert_eq!(mat[3][1], 0.0);
    assert_eq!(mat[3][2], 0.0);

    assert_eq!(mat[0][3], 0.0);
    assert_eq!(mat[1][3], 0.0);
    assert_eq!(mat[2][3], 0.0);

    assert_eq!(mat[3][3], 1.0);

    let (x, y, z) = if eps(mat[2][0].abs(), 1.0) {
        let atan = (mat[0][1] / mat[0][2]).atan();
        // let atan = mat[0][1].atan2(mat[0][2]);
        let (y, x) = if mat[2][0] < 0.0 {
            (std::f64::consts::PI / 2.0, atan)
        } else {
            (3.0 * std::f64::consts::PI / 2.0, -atan)
        };
        (x, y, 0.0)
    } else {
        let y = -mat[2][0].asin();
        let cosy = y.cos();
        let x = (mat[2][1] / cosy).atan2(mat[2][2] / cosy);
        let z = (mat[1][0] / cosy).atan2(mat[0][0] / cosy);
        (x, y, z)
    };

    // let (cx, cy, cz) = (x.cos(), y.cos(), z.cos());
    // let (sx, sy, sz) = (x.sin(), y.sin(), z.sin());

    // #[rustfmt::skip]
    // let guess = vec![
    //     vec![cy*cz, cz*sx*sy - cx*sz, cx*cz*sy + sx*sz, 0.0],
    //     vec![cy*sz, cx*cz + sx*sy*sz, cx*sy*sz - cz*sx, 0.0],
    //     vec![  -sy,            cy*sx,            cx*cy, 0.0],
    //     vec![  0.0,              0.0,              0.0, 1.0]
    // ];

    // if guess != mat {
    //     return None;
    // }


    let r2deg = |f| {
        let d = 180.0 * f / std::f64::consts::PI;
        if d < 0.0 {
            d + 360.0
        } else {
            d
        }
    };
    Some((r2deg(x), r2deg(y), r2deg(z)))
    // Some(dbg!((r2deg(x), r2deg(y), r2deg(z))))
}

fn has_content(pair: Pair<Rule>) -> bool {
    let rule = pair.as_rule();
    match rule {
        Rule::empty_group => false,
        Rule::sphere | Rule::cube | Rule::cylinder => true,
        Rule::group | Rule::union | Rule::diff | Rule::inter | Rule::matrix => {
            pair.into_inner().any(|p| has_content(p))
        }
        Rule::mat => false,
        Rule::anything => true,
        Rule::anything_one => true,
        r => panic!(r#"Unexpected rule "{:?}""#, r),
    }
}

fn write_csg(w: &mut impl Write, depth: usize, pair: Pair<Rule>) -> Result<()> {
    let rule = pair.as_rule();
    let mut args = pair.into_inner();
    let d = depth + 1;

    match rule {
        Rule::anything | Rule::anything_one => {
            let op = args.next().unwrap();
            let inside = args.next().unwrap().as_str().replace('"', "\\\"");
            write!(w, "(\"{}({})\"", op.as_str(), inside)?;
            indent(w, d)?;
            for arg in args.filter(|p| has_content(p.clone())) {
                write_csg(w, d + 1, arg)?;
            }
            write!(w, ")")
        }
        Rule::empty_group => Ok(()),
        Rule::group => write_op(w, d, "Union", args),
        Rule::union => write_op(w, d, "Union", args),
        Rule::diff => write_op(w, d, "Diff", args),
        Rule::inter => write_op(w, d, "Inter", args),
        Rule::matrix => {
            let mat = args.next().unwrap();
            let mat: Vec<Vec<f64>> = mat
                .into_inner()
                .map(|row| {
                    assert_eq!(row.as_rule(), Rule::vec4);
                    row.into_inner().map(float).collect()
                })
                .collect();

            if let Some((x, y, z)) = get_trans(&mat) {
                write!(w, "(Affine Trans (Vec3 {} {} {})", x, y, z)?;
            } else if let Some((x, y, z)) = get_scale(&mat) {
                write!(w, "(Affine Scale (Vec3 {} {} {})", x, y, z)?;
            } else if let Some((x, y, z)) = get_rotate(&mat) {
                write!(w, "(Affine Rotate (Vec3 {} {} {})", x, y, z)?;
            } else {
                #[rustfmt::skip]
                panic!(
                    "Unknown transform: [
  [{} {} {} {}],
  [{} {} {} {}],
  [{} {} {} {}],
  [{} {} {} {}]
]",
                    mat[0][0], mat[0][1], mat[0][2], mat[0][3],
                    mat[1][0], mat[1][1], mat[1][2], mat[1][3],
                    mat[2][0], mat[2][1], mat[2][2], mat[2][3],
                    mat[3][0], mat[3][1], mat[3][2], mat[3][3],
                );
            }
/*
                #[rustfmt::skip]
                write!(
                    w,
                    r#"("multmatrix([
  [{}, {}, {}, {}],
  [{}, {}, {}, {}],
  [{}, {}, {}, {}],
  [{}, {}, {}, {}]
])""#,
                    mat[0][0], mat[0][1], mat[0][2], mat[0][3],
                    mat[1][0], mat[1][1], mat[1][2], mat[1][3],
                    mat[2][0], mat[2][1], mat[2][2], mat[2][3],
                    mat[3][0], mat[3][1], mat[3][2], mat[3][3],
                )?;
            }
*/
            indent(w, d)?;
            write_op(w, d, "Union", args)?;
            write!(w, ")")
        }

        Rule::sphere => {
            let a = mkdict(args.next().unwrap());
            write!(
                w,
                "(Sphere {} (Vec3 {} {} {}))",
                a["r"].as_str(),
                a["$fn"].as_str(),
                a["$fa"].as_str(),
                a["$fs"].as_str(),
            )
        }

        Rule::cube => {
            let a = mkdict(args.next().unwrap());
            let (x, y, z) = vec3(a["size"].clone());
            write!(
                w,
                "(Cube (Vec3 {} {} {}) {})",
                x,
                y,
                z,
                a["center"].as_str(),
            )
        }
        Rule::cylinder => {
            let a = mkdict(args.next().unwrap());
            write!(
                w,
                "(Cylinder (Vec3 {} {} {}) (Vec3 {} {} {}) {})",
                a["h"].as_str(),
                a["r1"].as_str(),
                a["r2"].as_str(),
                a["$fn"].as_str(),
                a["$fa"].as_str(),
                a["$fs"].as_str(),
                a["center"].as_str(),
            )
        }
        r => panic!(r#"Unexpected rule "{:?}""#, r),
    }
}

fn main() {
    let _ = env_logger::builder().is_test(false).try_init();
    let args: Vec<String> = std::env::args().collect();
    if args.len() != 3 {
        panic!("Usage: parse-csg <input> <output>")
    }
    let input = std::fs::read_to_string(&args[1]).expect("failed to read input");
    let mut output = vec![];
    parse(&mut output, &input).unwrap();
    std::fs::File::create(&args[2])
        .expect("failed to open output")
        .write_all(&output)
        .expect("failed to write");
}

fn parse(w: &mut impl Write, s: &str) -> Result<()> {
    let program = CSGParser::parse(Rule::program, s)
        .expect("failed parse")
        .next()
        .expect("no programs");

    let mut top_level: Vec<_> = program.into_inner().collect();
    let eoi = top_level.pop().unwrap();
    assert_eq!(eoi.as_rule(), Rule::EOI);
    write_op(w, 0, "Union", top_level)
}

#[test]
fn test_file() {
    let stdout = std::io::stdout();
    let s = std::fs::read_to_string("test.csg").unwrap();
    parse(&mut stdout.lock(), &s).unwrap();
}
