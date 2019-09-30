use std::time::Instant;

use egg::{extract::calculate_cost, parse::ParsableLanguage};
use szalinski_egg::cad::{run_rules, Cad, EGraph};

#[test]
fn cad_simple() {
    let _ = env_logger::builder().is_test(true).try_init();
    let start = "
       (Union
         (Trans 0 0 0  Unit)
         (Union
           (Trans  0 0 0  Unit)
           (Trans  0 0 0  Unit)))";
    let start_expr = Cad::parse_expr(start).unwrap();
    println!("Expr: {:?}", start_expr);
    let mut egraph = EGraph::default();
    let root = egraph.add_expr(&start_expr);
    run_rules(&mut egraph, root, 5, 20_000);
}

#[test]
fn cad_simple2() {
    let _ = env_logger::builder().is_test(true).try_init();
    let start = "
       (Union
         (Trans  6 7 8  Unit)
         (Union
           (Trans  1 2 3  (Trans  5 5 5  Unit))
           (Trans  4 4 4  (Trans  2 3 4  Unit))))";
    let start_expr = Cad::parse_expr(start).unwrap();
    println!("Expr: {:?}", start_expr);
    let mut egraph = EGraph::default();
    let root = egraph.add_expr(&start_expr);
    run_rules(&mut egraph, root, 3, 20_000);
}

macro_rules! test_file {
    ($name:ident, $cost:expr,  $file:literal) => {
        #[test]
        fn $name() {
            let _ = env_logger::builder().is_test(true).try_init();
            let start = std::fs::read_to_string($file).unwrap();
            let start_expr = Cad::parse_expr(&start).unwrap();
            println!("Expr: {:?}", start_expr);
            let mut egraph = EGraph::default();
            let root = egraph.add_expr(&start_expr);

            let start = Instant::now();
            let best = run_rules(&mut egraph, root, 100, 3_000_000);
            println!("Initial cost: {}", calculate_cost(&start_expr));
            println!("Total time: {:?}", start.elapsed());
            assert_eq!(best.cost, $cost);
        }
    };
}

test_file! {soldering_fingers, 457, "cads/soldering-fingers.csexp" }
test_file! {tape,               86, "cads/tape.csexp" }
test_file! {dice_same,         193, "cads/dice.csexp" }
test_file! {dice_different,    210, "cads/dice-different.csexp" }
test_file! {gear_inl,          186, "cads/gear_flat_inl.csexp" }
test_file! {two_loops,          81, "cads/two-loops.csexp" }
test_file! {wardrobe,          319, "cads/wardrobe.csexp" }
