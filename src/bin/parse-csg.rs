use std::collections::HashMap;
use std::fmt::Write;

use pest::{
    iterators::{Pair, Pairs},
    Parser,
};
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

fn indent(buf: &mut String, depth: usize) {
    buf.push('\n');
    for _ in 0..depth {
        buf.push_str("  ");
    }
}

fn eps(a: f64, b: f64) -> bool {
    (a - b).abs() < 0.001
}

fn write_op<'a>(
    depth: usize,
    buf: &mut String,
    name: &str,
    ps: impl IntoIterator<Item = Pair<'a, Rule>>,
) -> std::fmt::Result {
    let mut ps: Vec<_> = ps.into_iter().collect();
    ps.reverse();

    fn fold(d: usize, buf: &mut String, name: &str, v: &mut Vec<Pair<Rule>>) -> std::fmt::Result {
        if v.is_empty() {
            return Ok(());
        }

        if v.len() == 1 {
            return write_csg(d, v.pop().unwrap(), buf);
        }

        buf.push('(');
        buf.push_str(name);

        indent(buf, d);
        write_csg(d, v.pop().unwrap(), buf)?;

        if v.len() == 1 {
            indent(buf, d);
            write_csg(d, v.pop().unwrap(), buf)?;
        } else if v.len() > 1 {
            indent(buf, d);
            fold(d + 1, buf, name, v)?;
        }

        buf.push(')');
        Ok(())
    }

    fold(depth, buf, name, &mut ps)
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

fn write_csg(depth: usize, pair: Pair<Rule>, buf: &mut String) -> std::fmt::Result {
    let rule = pair.as_rule();
    let mut args = pair.into_inner();
    let d = depth + 1;

    match rule {
        Rule::group => write_op(d, buf, "Union", args),
        Rule::union => write_op(d, buf, "Union", args),
        Rule::diff => write_op(d, buf, "Diff", args),
        Rule::inter => write_op(d, buf, "Inter", args),
        Rule::hull => {
            write!(buf, "(Hull")?;
            indent(buf, d);
            write_op(d, buf, "Union", args)?;
            buf.push(')');
            Ok(())
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
                write!(buf, "(Scale {} {} {}", x, y, z)?;
            } else if let Some((x, y, z)) = get_trans(&mat) {
                write!(buf, "(Trans {} {} {}", x, y, z)?;
            } else {
                println!("Unknown transform {:?}", mat);
                write!(buf, "(Matrix")?;
            }
            indent(buf, d);
            write_op(d, buf, "Union", args)?;
            buf.push(')');
            Ok(())
        }

        Rule::sphere => {
            let dict = mkdict(args.next().unwrap());
            let r = float(dict["r"].clone());
            if r == 1.0 {
                write!(buf, "Sphere")
            } else {
                write!(buf, "(Scale {} {} {} Sphere)", r, r, r)
            }
        }

        Rule::cube => {
            let dict = mkdict(args.next().unwrap());
            let (x, y, z) = vec3(dict["size"].clone());
            if (x, y, x) == (1.0, 1.0, 1.0) {
                write!(buf, "Cube")
            } else {
                write!(buf, "(Scale {} {} {} Cube)", x, y, z)
            }
        }
        Rule::cylinder => {
            let dict = mkdict(args.next().unwrap());
            let h = float(dict["h"].clone());
            let r1 = float(dict["r1"].clone());
            let r2 = float(dict["r2"].clone());
            if (h, r1, r2) == (1.0, 1.0, 1.0) {
                write!(buf, "Cylinder")
            } else if r1 == r2 {
                write!(buf, "(Scale {} {} {} Cylinder)", h, r1, r2)
            } else {
                panic!("its a cone")
            }
        }
        r => panic!(r#"Unexpected rule "{:?}""#, r),
    }
}

fn main() {
    use std::io::Write;
    let args: Vec<String> = std::env::args().collect();
    if args.len() != 3 {
        panic!("Please pass two arguments: input and output")
    }
    let s = parse_file(&args[1]);
    let path = &args[2];
    if path == "-" {
        println!("{}", s);
    } else {
        let mut file = std::fs::File::create(&args[2]).unwrap();
        file.write_all(s.as_bytes()).expect("write failed");
    }
}

fn parse_file(path: &str) -> String {
    let unparsed_file =
        std::fs::read_to_string(path).unwrap_or_else(|_| panic!("cannot read file {}", path));
    let program = CSGParser::parse(Rule::program, &unparsed_file)
        .expect("failed parse")
        .next()
        .expect("no programs");

    let mut top_level: Vec<_> = program.into_inner().collect();
    let eoi = top_level.pop().unwrap();
    assert_eq!(eoi.as_rule(), Rule::EOI);
    let mut s = String::new();
    write_op(0, &mut s, "Union", top_level).unwrap();
    s
}

#[test]
fn test_file() {
    let s = parse_file("test.csg");
    println!("{}", s);
}
