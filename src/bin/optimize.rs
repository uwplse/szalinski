use std::io::Write;
use std::time::Instant;

use log::*;

use egg::{
    extract::calculate_cost,
    parse::ParsableLanguage,
};
use szalinski_egg::cad::{run_rules, Cad, EGraph};

fn main() {
    let args: Vec<String> = std::env::args().collect();
    if args.len() != 3 {
        panic!("Usage: optimize <input> <output>")
    }
    let input = std::fs::read_to_string(&args[1]).expect("failed to read input");

    let _ = env_logger::builder().is_test(true).try_init();
    let start_expr = Cad::parse_expr(&input).unwrap();
    let init_cost = calculate_cost(&start_expr);
    info!("Start ({})\n{}", init_cost, start_expr.pretty(80));

    let mut egraph = EGraph::default();
    let root = egraph.add_expr(&start_expr);

    let start = Instant::now();
    let best = run_rules(&mut egraph, root, 100, 3_000_000);
    let elapsed = start.elapsed();
    debug!("Initial cost: {}", init_cost);
    debug!("Total time: {:?}", start.elapsed());

    let mut output = std::fs::File::create(&args[2])
        .expect("failed to open output");
    write!(
        output,
        r#"{{
  "best": {best:?},
  "init_cost": {init_cost},
  "cost": {cost},
  "time": {time}
}}"#,
        time = elapsed.as_secs_f64(),
        best = best.expr.pretty(80),
        cost = best.cost,
        init_cost = init_cost,
    ).expect("failed to write");
}
