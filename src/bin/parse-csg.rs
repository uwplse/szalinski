use std::collections::HashMap;
use std::io::{Read, Result, Write};

use pest::{iterators::Pair, Parser};
use pest_derive::Parser;

#[derive(Parser)]
#[grammar_inline = r#"
    WHITESPACE = _{ " " | "\t" | "\r" | "\n" }
    ident = { "$"? ~ ASCII_ALPHANUMERIC* }

    program = { SOI ~ instr* ~ EOI }

    instr = _{ "group();" | group | hull | union | diff | inter | matrix |
              cylinder | cube | sphere }
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
    let mut ps: Vec<_> = ps.into_iter().collect();
    ps.reverse();

    fn fold(w: &mut impl Write, d: usize, name: &str, v: &mut Vec<Pair<Rule>>) -> Result<()> {
        if v.is_empty() {
            return Ok(());
        }

        if v.len() == 1 {
            return write_csg(w, d, v.pop().unwrap());
        }

        write!(w, "({}", name)?;
        indent(w, d)?;
        write_csg(w, d, v.pop().unwrap())?;

        if v.len() == 1 {
            indent(w, d)?;
            write_csg(w, d, v.pop().unwrap())?;
        } else if v.len() > 1 {
            indent(w, d)?;
            fold(w, d + 1, name, v)?;
        }

        write!(w, ")")
    }

    fold(w, depth, name, &mut ps)
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

fn get_scale(mat: &[Vec<f64>]) -> Option<(f64, f64, f64)> {
    for i in 0..4 {
        for j in 0..4 {
            if i != j && !eps(mat[i][j], 0.0) {
                return None;
            }
        }
    }
    assert_eq!(mat[3][3], 1.0);
    Some((mat[0][0], mat[1][1], mat[2][2]))
}

fn get_trans(mat: &[Vec<f64>]) -> Option<(f64, f64, f64)> {
    for i in 0..4 {
        for j in 0..4 {
            let x = mat[i][j];
            if (i == j && !eps(x, 1.0)) || (i != j && j != 3 && !eps(x, 0.0)) {
                return None;
            }
        }
    }
    Some((mat[0][3], mat[1][3], mat[2][3]))
}

fn write_csg(w: &mut impl Write, depth: usize, pair: Pair<Rule>) -> Result<()> {
    let rule = pair.as_rule();
    let mut args = pair.into_inner();
    let d = depth + 1;

    match rule {
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

            if let Some((x, y, z)) = get_scale(&mat) {
                write!(w, "(Scale {} {} {}", x, y, z)?;
            } else if let Some((x, y, z)) = get_trans(&mat) {
                write!(w, "(Trans {} {} {}", x, y, z)?;
            } else {
                println!("Unknown transform {:?}", mat);
                write!(w, "(Matrix")?;
            }
            indent(w, d)?;
            write_op(w, d, "Union", args)?;
            write!(w, ")")
        }

        Rule::sphere => {
            let dict = mkdict(args.next().unwrap());
            let r = float(dict["r"].clone());
            if r == 1.0 {
                write!(w, "Sphere")
            } else {
                write!(w, "(Scale {} {} {} Sphere)", r, r, r)
            }
        }

        Rule::cube => {
            let dict = mkdict(args.next().unwrap());
            let (x, y, z) = vec3(dict["size"].clone());
            if (x, y, x) == (1.0, 1.0, 1.0) {
                write!(w, "Cube")
            } else {
                write!(w, "(Scale {} {} {} Cube)", x, y, z)
            }
        }
        Rule::cylinder => {
            let dict = mkdict(args.next().unwrap());
            let h = float(dict["h"].clone());
            let r1 = float(dict["r1"].clone());
            let r2 = float(dict["r2"].clone());
            if (h, r1, r2) == (1.0, 1.0, 1.0) {
                write!(w, "Cylinder")
            } else if r1 == r2 {
                write!(w, "(Scale {} {} {} Cylinder)", h, r1, r2)
            } else {
                panic!("its a cone")
            }
        }
        r => panic!(r#"Unexpected rule "{:?}""#, r),
    }
}

fn main() {
    let stdin = std::io::stdin();
    let stdout = std::io::stdout();
    let mut s = String::new();
    stdin.lock().read_to_string(&mut s).unwrap();
    parse(&mut stdout.lock(), &s).unwrap();
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
