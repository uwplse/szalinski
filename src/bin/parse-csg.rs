use std::collections::HashMap;
use std::io::{Result, Write};

use pest::{iterators::Pair, Parser};
use pest_derive::Parser;

#[derive(Parser)]
#[grammar_inline = r#"
    WHITESPACE = _{ " " | "\t" | "\r" | "\n" }
    ident = { "$"? ~ ASCII_ALPHANUMERIC* }

    program = { SOI ~ instr* ~ EOI }

    instr = _{ empty_group | group | hull | union | diff | inter | matrix |
              cylinder | cube | sphere }
        empty_group = { "group();" }
        group      = { "group()" ~ scope }
        hull       = { "hull()" ~ scope }
        union      = { "union()" ~ scope }
        diff       = { "difference()" ~ scope }
        inter      = { "intersection()" ~ scope }
        matrix     = { "multmatrix(" ~ mat ~ ")" ~ scope }
        cylinder   = { "cylinder(" ~ args ~ ")" ~ scope }
        cube       = { "cube(" ~ args ~ ")" ~ scope }
        sphere     = { "sphere(" ~ args ~ ")" ~ scope }

    scope = _{ "{" ~ instr* ~ "}" | ";" }

    num = {
       "-"? ~ ASCII_DIGIT+ ~ ("." ~ ASCII_DIGIT*)?
       ~ ("e" ~ ("-" | "+")? ~ ASCII_DIGIT+)?
    }
    vec4 = { "[" ~ num ~ "," ~ num ~ "," ~ num ~ "," ~ num ~ "]" }
    mat  =  { "[" ~ vec4 ~ "," ~ vec4 ~ "," ~ vec4 ~ "," ~ vec4 ~ "]" }

    vec3 = { "[" ~ num ~ "," ~ num ~ "," ~ num ~ "]" }
    value = _{ num | vec3 | bool }
    bool = { "true" | "false" }

    arg = { ident ~ "=" ~ value }
    args = { arg ~ ("," ~ arg)* }
"#]
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

fn write_op<'a>(
    w: &mut impl Write,
    depth: usize,
    name: &str,
    ps: impl IntoIterator<Item = Pair<'a, Rule>>,
) -> Result<()> {
    let ps: Vec<_> = ps.into_iter().collect();
    match ps.len() {
        0 => panic!("shouldn't be empty: {}", name),
        // 0 => Ok(()),
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
        },
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
    args.into_inner()
        .map(|p| {
            let mut ps = p.into_inner();
            let k = ps.next().unwrap().as_str().into();
            let v = ps.next().unwrap();
            (k, v)
        })
        .collect()
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

    let r2deg = |f| {
        let d = 180.0 * f / std::f64::consts::PI;
        if d < 0.0 {
            d + 360.0
        } else {
            d
        }
    };
    Some((r2deg(x), r2deg(y), r2deg(z)))
}

fn write_csg(w: &mut impl Write, depth: usize, pair: Pair<Rule>) -> Result<()> {
    let rule = pair.as_rule();
    let mut args = pair.into_inner();
    let d = depth + 1;

    match rule {
        Rule::empty_group => write!(w, "Empty"),
        Rule::group => write_op(w, d, "Union", args),
        Rule::union => write_op(w, d, "Union", args),
        Rule::diff => write_op(w, d, "Diff", args),
        Rule::inter => write_op(w, d, "Inter", args),
        Rule::hull => {
            write!(w, "(Hull")?;
            indent(w, d)?;
            write_op(w, d, "Union", args)?;
            write!(w, ")")
        }
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
