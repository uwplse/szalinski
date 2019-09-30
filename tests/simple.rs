use std::fs::{read_dir, read_to_string};
use std::time::Instant;

use egg::{
    extract::{calculate_cost, CostExpr},
    parse::ParsableLanguage,
};
use szalinski_egg::cad::{pretty_print, run_rules, Cad, EGraph};

fn optimize(s: &str) -> CostExpr<Cad> {
    let _ = env_logger::builder().is_test(true).try_init();
    let start_expr = Cad::parse_expr(s).unwrap();
    let init_cost = calculate_cost(&start_expr);
    println!("Start ({})\n{}", init_cost, pretty_print(&start_expr));

    let mut egraph = EGraph::default();
    let root = egraph.add_expr(&start_expr);

    let start = Instant::now();
    let best = run_rules(&mut egraph, root, 100, 3_000_000);
    println!("Initial cost: {}", init_cost);
    println!("Total time: {:?}", start.elapsed());
    best
}

macro_rules! test_file {
    ($name:ident, $cost:expr, $file:literal) => {
        #[test]
        fn $name() {
            println!("Testing {}", stringify!($name));
            let start = read_to_string($file).unwrap();
            let best = optimize(&start);
            assert_eq!(best.cost, $cost);
        }
    };
}

test_file! {file_soldering_old, 51, "cads/pldi2020-eval/input/soldering.csexp" }
test_file! {file_soldering,    470, "cads/pldi2020-eval/input/soldering.csexp.failed" }
test_file! {file_tape,          86, "cads/pldi2020-eval/input/tape.csexp" }
test_file! {file_dice,         193, "cads/pldi2020-eval/input/dice.csexp" }
test_file! {file_gear_var,     136, "cads/pldi2020-eval/input/gear_flat.csexp" }
test_file! {file_gear_inl,     186, "cads/pldi2020-eval/input/gear_flat.csexp.failed" }
test_file! {file_hcbit,         97, "cads/pldi2020-eval/input/hcbitholder.csexp" }
test_file! {file_wardrobe,     319, "cads/pldi2020-eval/input/wardrobe.csexp" }
// test_file! {dice_different,    210, "cads/dice-different.csexp" }
// test_file! {two_loops,          81, "cads/two-loops.csexp" }

#[test]
#[ignore]
fn do_all() {
    for entry in read_dir("cads/pldi2020-eval/input").unwrap() {
        let path = entry.unwrap().path();
        println!("Optimizing {:?}", path);
        let contents = read_to_string(path).unwrap();
        optimize(&contents);
    }
}
