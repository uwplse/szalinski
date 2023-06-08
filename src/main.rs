use std::time::{Instant, Duration};

use egg::{Extractor, CostFunction, BackoffScheduler};
use log::info;
use szalinski_egg::{eval::{Scad, remove_empty}, loop_inference::{ast_size, ast_depth, depth_under_mapis, n_mapis, RunResult, MyRunner}, cad::CostFn, sz_param, csg_parser::parse};

sz_param!(PRE_EXTRACT: bool);
fn main() {
    let _ = env_logger::builder().is_test(false).try_init();
    let args: Vec<String> = std::env::args().collect();
    if args.len() != 3 {
        panic!("Usage: optimize <input>.scad <output>.json")
    }
    let csg = std::fs::read_to_string(&args[1]).expect("failed to read input scad");
    let mut csg_parse = vec![];
    parse(&mut csg_parse, &csg).unwrap();

    sz_param!(ITERATIONS: usize);
    sz_param!(NODE_LIMIT: usize);
    sz_param!(TIMEOUT: f64);

    let initial_expr = std::str::from_utf8(&csg_parse).expect("Couldn't serialize csg").parse().expect("Couldn't parse csg");
    let initial_expr = remove_empty(&initial_expr).expect("input was empty");
    let initial_cost = CostFn.cost_rec(&initial_expr);

    let initial_expr = if *PRE_EXTRACT {
        let pre_rules = szalinski_egg::rules::pre_rules();
        let runner = MyRunner::default()
            .with_iter_limit(*ITERATIONS)
            .with_node_limit(*NODE_LIMIT)
            .with_time_limit(Duration::from_secs_f64(1.0))
            .with_expr(&initial_expr)
            .run(&pre_rules);
        Extractor::new(&runner.egraph, CostFn)
            .find_best(runner.roots[0])
            .1
    } else {
        initial_expr
    };

    let rules = szalinski_egg::rules::rules();
    let runner = MyRunner::default()
        .with_iter_limit(*ITERATIONS)
        .with_node_limit(*NODE_LIMIT)
        .with_time_limit(Duration::from_secs_f64(*TIMEOUT))
        .with_scheduler(
            BackoffScheduler::default()
                .with_ban_length(5)
                .with_initial_match_limit(1_000)
        )
        .with_expr(&initial_expr)
        .run(&rules);

    info!(
        "Stopping after {} iters: {:?}",
        runner.iterations.len(),
        runner.stop_reason
    );

    let root = runner.roots[0];
    let extract_time = Instant::now();
    let best = Extractor::new(&runner.egraph, CostFn).find_best(root);
    let extract_time = extract_time.elapsed().as_secs_f64();

    println!("Best ({}): {}", best.0, best.1.pretty(80));

    let report = RunResult {
        initial_expr: initial_expr.pretty(80),
        initial_cost,
        iterations: runner.iterations,
        final_cost: best.0,
        final_expr: best.1.pretty(80),
        extract_time,
        final_scad: format!("{}", Scad(&best.1)),
        stop_reason: runner.stop_reason.unwrap(),
        ast_size: ast_size(&best.1),
        ast_depth: ast_depth(&best.1),
        n_mapis: n_mapis(&best.1),
        depth_under_mapis: depth_under_mapis(&best.1),
    };

    let out_file = std::fs::File::create(&args[2]).expect("failed to open output");
    serde_json::to_writer_pretty(out_file, &report).unwrap();
}
