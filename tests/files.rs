use std::fs::{read_dir, read_to_string};
use std::time::Instant;

use egg::{
    extract::{calculate_cost, CostExpr},
    parse::ParsableLanguage,
};
use szalinski_egg::cad::{run_rules, Cad, EGraph};

fn optimize(s: &str) -> CostExpr<Cad> {
    let _ = env_logger::builder().is_test(true).try_init();
    let start_expr = Cad::parse_expr(s).unwrap();
    let init_cost = calculate_cost(&start_expr);
    println!("Start ({})\n{}", init_cost, start_expr.pretty(80));

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

            let outfile = $file.replace("input/", "expected/");
            let expected = read_to_string(&outfile);
            if outfile.contains("expected/") && expected.is_ok() {
                let expected = &expected.unwrap().trim().to_string();
                let actual = &best.expr.pretty(80).trim().to_string();
                if actual != expected {
                    let diff = colored_diff::PrettyDifference {expected, actual};
                    panic!("Didn't match expected. {}", diff);
                }
            } else {
                eprintln!("Didn't find expected for {}", stringify!($name));
            }

            assert_eq!(best.cost, $cost);
        }
    };
}

test_file! {file_soldering,    472, "cads/pldi2020-eval/input/soldering.csexp" }
test_file! {file_tape,          66, "cads/pldi2020-eval/input/tape.csexp" }
test_file! {file_dice,         196, "cads/pldi2020-eval/input/dice.csexp" }
test_file! {file_hcbit,         84, "cads/pldi2020-eval/input/hcbitholder.csexp" }
test_file! {file_wardrobe,     315, "cads/pldi2020-eval/input/wardrobe.csexp" }
test_file! {file_flower,        83, "cads/pldi2020-eval/input/flower.csexp" }
test_file! {file_pinheader,     84, "cads/pldi2020-eval/input/pinheader.csexp" }
test_file! {file_cnc_endmills_holder_nohull, 119, "cads/pldi2020-eval/input/cnc_endmills_holder_nohull.csexp" }

test_file! {file_icsg_011,     177, "cads/inverse-csg-solution/011/sketch_final.csexp" }
test_file! {file_icsg_039,    3759, "cads/inverse-csg-solution/039/sketch_final.csexp" }

// takes about too long in debug mode
test_file! { #[ignore] file_gear,     185, "cads/pldi2020-eval/input/gear_flat.csexp" }
test_file! { #[ignore] file_box_flat,  84, "cads/pldi2020-eval/input/box_flat.csexp" }

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
