use std::time::{Instant, Duration};

use egg::{Extractor, CostFunction, BackoffScheduler};
use log::info;
use szalinski_egg::{eval::{remove_empty}, loop_inference::{ast_size, ast_depth, depth_under_mapis, n_mapis, RunResult, MyRunner, loop_infer}, cad::CostFn, sz_param};

sz_param!(PRE_EXTRACT: bool);
fn main() {
    loop_infer()
}
