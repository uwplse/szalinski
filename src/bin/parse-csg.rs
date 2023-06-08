use std::io::Write;
use szalinski_egg::csg_parser::parse;
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
