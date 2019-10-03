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
    ($(#[$meta:meta])* $name:ident, $cost:expr, $file:literal) => {
        $(#[$meta])*
        #[test]
        fn $name() {
            println!("Testing {}", stringify!($name));
            let start = read_to_string($file).unwrap();
            let best = optimize(&start);
            assert_eq!(best.cost, $cost);

            let outfile = $file.replace("input/", "expected/");
            if let Ok(expected) = read_to_string(&outfile) {
                let expected = expected.trim();
                // trim trailing spaces because the pretty printer is dumb
                let actual = &pretty_print(&best.expr).replace(" \n", "\n").trim().to_string();
                if actual != expected {
                    let diff = colored_diff::PrettyDifference {expected, actual};
                    panic!("Didn't match expected. {}", diff);
                } else {
                    eprintln!("Didn't find expected for {}", stringify!($name));
                }
            }
        }
    };
}

test_file! {file_soldering,    477, "cads/pldi2020-eval/input/soldering.csexp" }
test_file! {file_tape,          74, "cads/pldi2020-eval/input/tape.csexp" }
test_file! {file_dice,         193, "cads/pldi2020-eval/input/dice.csexp" }
test_file! {file_hcbit,         95, "cads/pldi2020-eval/input/hcbitholder.csexp" }
test_file! {file_wardrobe,     319, "cads/pldi2020-eval/input/wardrobe.csexp" }
test_file! {file_flower,        99, "cads/pldi2020-eval/input/flower.csexp" }

// takes about 10 seconds in debug mode
test_file! { #[ignore] file_gear,     193, "cads/pldi2020-eval/input/gear_flat.csexp" }

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
