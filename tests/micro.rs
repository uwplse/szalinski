use std::fs::{read_dir, read_to_string};
use std::time::Instant;

use egg::{
    extract::{calculate_cost, CostExpr},
    parse::ParsableLanguage,
};
use szalinski_egg::cad::{pretty_print, run_rules, Cad, EGraph};

macro_rules! micro {
    ($name:ident, $start:expr, $end:expr) => {
        #[test]
        fn $name() {
            println!("Testing {}", stringify!($name));
            let _ = env_logger::builder().is_test(true).try_init();
            let start_expr = Cad::parse_expr($start).unwrap();
            let init_cost = calculate_cost(&start_expr);
            println!("Start ({})\n{}", init_cost, pretty_print(&start_expr));

            let mut egraph = EGraph::default();
            let root = egraph.add_expr(&start_expr);

            let start = Instant::now();
            let best = run_rules(&mut egraph, root, 100, 3_000_000);
            println!("Initial cost: {}", init_cost);
            println!("Total time: {:?}", start.elapsed());

            let end_expr = Cad::parse_expr($end).unwrap();
            let equivs = egraph.equivs(&start_expr, &end_expr);
            if equivs.is_empty() {
                panic!("Couldn't prove");
            }
            assert_eq!(equivs.len(), 1);
        }
    };
}

micro! {micro_union_same, "(Union a a)",  "a"}
micro! {micro_lift_union, "(Union (Trans 1 1 1 a) (Trans 1 1 1 b))",  "(Trans 1 1 1 (Union a b))"}
