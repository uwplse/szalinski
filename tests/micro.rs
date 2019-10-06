use std::time::Instant;

use egg::{extract::calculate_cost, parse::ParsableLanguage};
use szalinski_egg::cad::{run_rules, Cad, EGraph};

macro_rules! micro {
    ($name:ident, $start:expr, $end:expr) => {
        #[test]
        fn $name() {
            println!("Testing {}", stringify!($name));
            let _ = env_logger::builder().is_test(true).try_init();
            let start_expr = Cad::parse_expr($start).unwrap();
            let init_cost = calculate_cost(&start_expr);
            println!("Start ({})\n{}", init_cost, start_expr.pretty(80));

            let mut egraph = EGraph::default();
            let root = egraph.add_expr(&start_expr);

            let start = Instant::now();
            let _best = run_rules(&mut egraph, root, 100, 3_000_000);
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
micro! {micro_mapi_deg1, "(List (Vec 1 0 0) (Vec 2 0 0) (Vec 3 0 0))",  "(MapI 3 (Vec (+ i 1) 0 0))"}
micro! {micro_mapi_polar,
"(List (Vec 0 -1 0) (Vec 1 0 0) (Vec 0 1 0) (Vec -1 0 0))",
"(Unpolar 4
            (Vec   0   0   0)
            (MapI   4 (Vec   1 (+ -90 (* i  90))  90)))" }

micro! {micro_fold_polar,
"(Union (Trans  0 -1 0 Unit)
         (Union (Trans  1  0 0 Unit)
         (Union (Trans  0  1 0 Unit)
                (Trans -1  0 0 Unit))))",
"(FoldUnion
            (Map
                TransPolar
                (MapI   4 (Vec   1 (+ -90 (* i  90))  90))
                (Repeat   4 Unit)))" }
