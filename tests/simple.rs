use std::time::Instant;

use egg::{
    extract::{calculate_cost, CostExpr},
    parse::ParsableLanguage,
};
use szalinski_egg::cad::{run_rules, Cad, EGraph};

fn optimize(s: &str) -> CostExpr<Cad> {
    let _ = env_logger::builder().is_test(true).try_init();
    let start_expr = Cad::parse_expr(s).unwrap();
    println!("Expr: {:?}", start_expr);
    let mut egraph = EGraph::default();
    let root = egraph.add_expr(&start_expr);

    let start = Instant::now();
    let best = run_rules(&mut egraph, root, 100, 3_000_000);
    println!("Initial cost: {}", calculate_cost(&start_expr));
    println!("Total time: {:?}", start.elapsed());
    best
}

macro_rules! test_file {
    ($name:ident, $cost:expr, $file:literal) => {
        #[test]
        fn $name() {
            let start = std::fs::read_to_string($file).unwrap();
            let best = optimize(&start);
            assert_eq!(best.cost, $cost);
        }
    };
}

test_file! {file_soldering_old, 51, "cads/pldi2020-eval/input/soldering.csexp" }
test_file! {file_soldering,    457, "cads/pldi2020-eval/input/soldering.csexp.failed" }
test_file! {file_tape,          86, "cads/pldi2020-eval/input/tape.csexp" }
test_file! {file_dice,         193, "cads/pldi2020-eval/input/dice.csexp" }
test_file! {file_gear,         136, "cads/pldi2020-eval/input/gear_flat.csexp" }
test_file! {file_wardrobe,     319, "cads/pldi2020-eval/input/wardrobe.csexp" }
// test_file! {dice_different,    210, "cads/dice-different.csexp" }
// test_file! {two_loops,          81, "cads/two-loops.csexp" }
