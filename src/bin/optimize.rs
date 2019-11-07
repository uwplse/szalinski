use std::time::Instant;

use indexmap::IndexMap;
use log::*;
use serde::Serialize;

use egg::{
    expr::RecExpr,
    extract::{calculate_cost, Extractor},
    parse::ParsableLanguage,
};
use szalinski_egg::cad::{Cad, EGraph, Rewrite};
use szalinski_egg::eval::Scad;

#[derive(Serialize)]
pub struct IterationResult {
    pub egraph_nodes: usize,
    pub egraph_classes: usize,
    pub applied: IndexMap<String, usize>,
    pub search_time: f64,
    pub apply_time: f64,
    pub rebuild_time: f64,
}

fn run_one(egraph: &mut EGraph, rules: &[Rewrite], limit: usize) -> IterationResult {
    let egraph_nodes = egraph.total_size();
    let egraph_classes = egraph.number_of_classes();
    let search_time = Instant::now();

    let mut applications = Vec::new();
    let mut matches = Vec::new();
    for rule in rules.iter() {
        let ms = rule.search(&egraph);
        if !ms.is_empty() {
            matches.push(ms);
        }
    }

    let search_time = search_time.elapsed().as_secs_f64();
    info!("Search time: {}", search_time);

    let apply_time = Instant::now();

    for m in matches {
        debug!("Applying {} {} times", m.rewrite.name, m.len());
        let actually_matched = m.apply_with_limit(egraph, limit).len();
        if egraph.total_size() > limit {
            error!("Node limit exceeded. {} > {}", egraph.total_size(), limit);
            break;
        }

        if actually_matched > 0 {
            applications.push((&m.rewrite.name, actually_matched));
            info!("Applied {} {} times", m.rewrite.name, actually_matched);
        }
    }

    let apply_time = apply_time.elapsed().as_secs_f64();
    info!("Apply time: {}", apply_time);

    let mut applied = IndexMap::new();
    for (name, count) in applications {
        let c = applied.entry(name.clone()).or_default();
        *c += count;
    }

    let rebuild_time = Instant::now();
    egraph.rebuild();
    let rebuild_time = rebuild_time.elapsed().as_secs_f64();
    info!("Rebuild time: {}", rebuild_time);
    info!(
        "Size: n={}, e={}",
        egraph.total_size(),
        egraph.number_of_classes()
    );

    IterationResult {
        applied,
        egraph_nodes,
        egraph_classes,
        search_time,
        apply_time,
        rebuild_time,
    }
}

#[derive(Serialize)]
pub struct RunResult {
    pub initial_expr: String,
    pub initial_cost: u64,
    pub iterations: Vec<IterationResult>,
    pub final_expr: String,
    pub final_cost: u64,
    pub extract_time: f64,
    pub final_scad: String,
}

pub fn pre_optimize(expr: &RecExpr<Cad>) -> RecExpr<Cad> {
    let (mut egraph, root) = EGraph::from_expr(&expr);
    let pre_rule_time = Instant::now();
    let pre_rules = szalinski_egg::rules::pre_rules();
    let mut old_size = 0;
    loop {
        for rule in &pre_rules {
            rule.run(&mut egraph);
        }
        let new_size = egraph.total_size();
        if new_size == old_size {
            break;
        }
        old_size = new_size;
    }
    let pre_rule_time = pre_rule_time.elapsed();
    info!("Pre rule time: {:?}", pre_rule_time);

    let ext = Extractor::new(&egraph);
    let best = ext.find_best(root);
    info!("Pre-processed: {}", best.expr.pretty(80));
    best.expr
}

pub fn optimize(initial_expr: &str, iters: usize, limit: usize) -> RunResult {
    let initial_expr = initial_expr.to_string();
    let initial_expr_cad = Cad::parse_expr(&initial_expr).unwrap();
    let initial_cost = calculate_cost(&initial_expr_cad);

    let initial_expr_cad = pre_optimize(&initial_expr_cad);
    let (mut egraph, root) = EGraph::from_expr(&initial_expr_cad);

    let rules = szalinski_egg::rules::rules();
    let mut iterations = vec![];

    for i in 0..iters {
        info!("\n\nIteration {}\n", i);
        let res = run_one(&mut egraph, &rules, limit);
        let empty = res.applied.is_empty();
        iterations.push(res);
        if empty {
            info!("Stopping early!");
            break;
        }
    }

    let extract_time = Instant::now();
    let (final_cost, final_expr) = {
        let ext = Extractor::new(&egraph);
        let f = ext.find_best(root);
        (f.cost, f.expr.pretty(80))
    };
    let extract_time = extract_time.elapsed().as_secs_f64();

    info!("Extract time: {}", extract_time);
    info!("Initial cost: {}", initial_cost);
    info!("Final cost: {}", final_cost);
    info!("Final: {}", final_expr);

    let to_scad_in = Cad::parse_expr(&final_expr).unwrap();
    let final_scad = format!("{}", Scad(&to_scad_in));
    info!("Final Scad: {}", final_scad);

    RunResult {
        initial_expr,
        initial_cost,
        iterations,
        final_cost,
        final_expr,
        extract_time,
        final_scad,
    }
}

fn main() {
    let _ = env_logger::builder().is_test(false).try_init();
    let args: Vec<String> = std::env::args().collect();
    if args.len() != 3 {
        panic!("Usage: optimize <input> <output>")
    }
    let input = std::fs::read_to_string(&args[1]).expect("failed to read input");
    let iters = 100;
    let limit = 3_000_000;
    let result = optimize(&input, iters, limit);

    let out_file = std::fs::File::create(&args[2]).expect("failed to open output");
    serde_json::to_writer_pretty(out_file, &result).unwrap();
}
