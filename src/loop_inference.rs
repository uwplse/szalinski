use serde::Serialize;

use egg::*;
use crate::cad::{Cad, Cost, CostFn, Meta};

// #[derive(Debug, Serialize)]
// pub enum StopReason {
//     Saturated,
//     NodeLimit(usize),
//     IterLimit(usize),
//     TimeOut(Duration),
// }

// #[derive(Serialize)]
// pub struct IterationResult {
//     pub egraph_nodes: usize,
//     pub egraph_classes: usize,
//     pub applied: IndexMap<String, usize>,
//     pub search_time: f64,
//     pub apply_time: f64,
//     pub rebuild_time: f64,
//     pub best_cost: Cost,
// }

// sz_param!(UNIFY_CLOSE_NUMS: bool);

// fn run_one(
//     start_time: &Instant,
//     egraph: &mut EGraph,
//     root: u32,
//     rules: &[Rewrite],
//     limit: usize,
//     timeout: Duration,
// ) -> (IterationResult, Option<StopReason>) {
//     let egraph_nodes = egraph.total_size();
//     let egraph_classes = egraph.number_of_classes();
//     let search_time = Instant::now();
//     let mut stop = None;

//     let mut applications = Vec::new();
//     let mut matches = Vec::new();
//     let mut should_apply = true;
//     for rule in rules.iter() {
//         let ms = rule.search(&egraph);
//         if !ms.is_empty() {
//             matches.push(ms);
//         }
//         if start_time.elapsed() > timeout {
//             stop = Some(StopReason::TimeOut(timeout));
//             should_apply = false;
//             break;
//         }
//     }

//     let search_time = search_time.elapsed().as_secs_f64();
//     info!("Search time: {}", search_time);

//     let apply_time = Instant::now();

//     if should_apply {
//         for m in matches {
//             debug!("Applying {} {} times", m.rewrite.name, m.len());
//             let actually_matched = m.apply_with_limit(egraph, limit).len();
//             if egraph.total_size() > limit {
//                 error!("Node limit exceeded. {} > {}", egraph.total_size(), limit);
//                 stop = Some(StopReason::NodeLimit(limit));
//                 break;
//             }

//             if actually_matched > 0 {
//                 applications.push((&m.rewrite.name, actually_matched));
//                 info!("Applied {} {} times", m.rewrite.name, actually_matched);
//             }

//             if start_time.elapsed() > timeout {
//                 stop = Some(StopReason::TimeOut(timeout));
//                 break;
//             }
//         }
//     }

//     let apply_time = apply_time.elapsed().as_secs_f64();
//     info!("Apply time: {}", apply_time);

//     let mut applied = IndexMap::new();
//     for (name, count) in applications {
//         let c = applied.entry(name.clone()).or_default();
//         *c += count;
//     }

//     let rebuild_time = Instant::now();
//     if *UNIFY_CLOSE_NUMS {
//         szalinski_egg::num::unify_close_nums(egraph);
//     }
//     egraph.rebuild();
//     let rebuild_time = rebuild_time.elapsed().as_secs_f64();
//     info!("Rebuild time: {}", rebuild_time);
//     info!(
//         "Size: n={}, e={}",
//         egraph.total_size(),
//         egraph.number_of_classes()
//     );

//     let best_cost = Extractor::new(&egraph).find_best(root).cost;

//     let it = IterationResult {
//         applied,
//         egraph_nodes,
//         egraph_classes,
//         search_time,
//         apply_time,
//         rebuild_time,
//         best_cost,
//     };
//     if stop.is_none() && it.applied.is_empty() {
//         stop = Some(StopReason::Saturated);
//     }
//     (it, stop)
// }

#[derive(Serialize)]
pub struct RunResult {
    pub initial_expr: String,
    pub initial_cost: Cost,
    pub iterations: Vec<Iteration<MyIterData>>,
    pub final_expr: String,
    pub final_cost: Cost,
    pub extract_time: f64,
    pub final_scad: String,
    pub stop_reason: StopReason,

    // metrics
    pub ast_size: usize,
    pub ast_depth: usize,
    pub n_mapis: usize,
    pub depth_under_mapis: usize,
}

// pub fn pre_optimize(egraph: &mut EGraph, root: u32) {
//     // let (mut egraph, root) = EGraph::from_expr(&expr);
//     let pre_rule_time = Instant::now();
//     let pre_rules = szalinski_egg::rules::pre_rules();
//     let iters = 100;
//     let limit = 50_000;
//     let timeout = Duration::from_secs(1);
//     let stop_reason = (0..iters)
//         .find_map(|i| {
//             info!("\n\nIteration {}\n", i);
//             let (_, stop) = run_one(&pre_rule_time, egraph, root, &pre_rules, limit, timeout);
//             stop
//         })
//         .unwrap_or(StopReason::IterLimit(iters));
//     info!("Stopping {:?}", stop_reason);
//     // let mut old_size = 0;
//     // for i in 0..100 {
//     //     info!("Pre iter {}. time: {:?}", i, pre_rule_time.elapsed());
//     //     for rule in &pre_rules {
//     //         if egraph.total_size() > 50_000 {
//     //             break
//     //         }
//     //         rule.run(egraph);
//     //     }
//     //     let new_size = egraph.total_size();
//     //     if new_size == old_size {
//     //         break;
//     //     }
//     //     old_size = new_size;
//     //     egraph.rebuild();
//     // }
//     let pre_rule_time = pre_rule_time.elapsed();
//     info!("Pre rule time: {:?}", pre_rule_time);
// }

// sz_param!(PRE_EXTRACT: bool);

// pub fn optimize(initial_expr: &str, iters: usize, limit: usize, timeout: Duration) -> RunResult {
//     let initial_expr = initial_expr.to_string();
//     let initial_expr_cad = Cad::parse_expr(&initial_expr).unwrap();
//     let initial_cost = calculate_cost(&initial_expr_cad);
//     let initial_expr_cad = remove_empty(&initial_expr_cad).expect("input was empty");
//     info!("Without empty: {}", initial_expr_cad.pretty(80));

//     let (mut egraph, mut root) = EGraph::from_expr(&initial_expr_cad);
//     pre_optimize(&mut egraph, root);

//     if *PRE_EXTRACT {
//         let best = Extractor::new(&egraph).find_best(root).expr;
//         info!("Pre extracting: {}", best.pretty(80));
//         let (eg, r) = EGraph::from_expr(&best);
//         egraph = eg;
//         root = r;
//     }

//     let root = root;

//     let mut rules = szalinski_egg::rules::rules();
//     let mut iterations = vec![];

//     let start_time = Instant::now();
//     let stop_reason = (0..iters)
//         .find_map(|i| {
//             info!("\n\nIteration {}\n", i);
//             let (res, stop) = run_one(&start_time, &mut egraph, root, &rules, limit, timeout);
//             rules.retain(|r| {
//                 let count = res.applied.get(&r.name).copied().unwrap_or(0);
//                 let apply_limit = 200_000;
//                 if count > apply_limit {
//                     warn!(
//                         "Applied {} too many times: {} > {}",
//                         r.name, count, apply_limit
//                     );
//                     false
//                 } else {
//                     true
//                 }
//             });
//             iterations.push(res);
//             stop
//         })
//         .unwrap_or(StopReason::IterLimit(iters));
//     info!("Stopping {:?}", stop_reason);

//     let extract_time = Instant::now();
//     let best = Extractor::new(&egraph).find_best(root);
//     let extract_time = extract_time.elapsed().as_secs_f64();
//     let pretty = best.expr.pretty(80);

//     info!("Extract time: {}", extract_time);
//     info!("Initial cost: {}", initial_cost);
//     info!("Final cost: {}", best.cost);
//     info!("Final: {}", pretty);

//     // let to_scad_in = Cad::parse_expr(&pretty).unwrap();
//     let final_scad = format!("{}", Scad(&best.expr));
//     info!("Final Scad: {}", final_scad);

//     RunResult {
//         initial_expr,
//         initial_cost,
//         iterations,
//         final_cost: best.cost,
//         final_expr: pretty,
//         extract_time,
//         final_scad,
//         stop_reason,
//         ast_size: ast_size(&best.expr),
//         ast_depth: ast_depth(&best.expr),
//         n_mapis: n_mapis(&best.expr),
//         depth_under_mapis: depth_under_mapis(&best.expr),
//     }
// }

pub fn ast_size(e: &RecExpr<Cad>) -> usize {
    let e = e.as_ref();
    let sum_children: usize = e.children.iter().map(ast_size).sum();
    match e.op {
        Cad::Vec3 => 1,
        _ => 1 + sum_children,
    }
}

pub fn ast_depth(e: &RecExpr<Cad>) -> usize {
    let e = e.as_ref();
    let max_children = e.children.iter().map(ast_depth).max().unwrap_or(0);
    match e.op {
        Cad::Vec3 => 1,
        _ => 1 + max_children,
    }
}

pub fn n_mapis(e: &RecExpr<Cad>) -> usize {
    let e = e.as_ref();
    let sum_children: usize = e.children.iter().map(n_mapis).sum();
    sum_children
        + match e.op {
            Cad::MapI => 1,
            _ => 0,
        }
}

pub fn depth_under_mapis(expr: &RecExpr<Cad>) -> usize {
    let e = expr.as_ref();
    match e.op {
        Cad::MapI => ast_depth(expr) - 1,
        _ => e.children.iter().map(n_mapis).sum(),
    }
}

#[derive(Serialize)]
pub struct MyIterData {
    best_cost: Cost,
}

impl IterationData<Cad, Meta> for MyIterData {
    fn make(runner: &MyRunner) -> Self {
        let root = runner.roots[0];
        let best_cost = Extractor::new(&runner.egraph, CostFn).find_best(root).0;
        MyIterData { best_cost }
    }
}

pub type MyRunner = egg::Runner<Cad, Meta, MyIterData>;
