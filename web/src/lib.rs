use egg::*;
use szalinski_egg::{cad, eval, synthesize};
use wasm_bindgen::prelude::wasm_bindgen;
use web_sys::console;

#[wasm_bindgen]
pub fn caddy_to_scad(s: String) -> String {
    console::log_1(&format!("Starting caddy_to_scad with {}", s).into());
    let caddy: RecExpr<cad::Cad> = s.parse().expect("Couldn't parse input");
    let scad = eval::Scad::new(&caddy);
    console::log_1(&format!("Result: {}", scad.to_string()).into());
    scad.to_string()
}

#[wasm_bindgen]
pub fn synthesize_caddy(s: String) -> String {
    console::log_1(&format!("Starting synthesize_caddy with {}", s).into());
    let report = synthesize::optimize_with_au(s);
    console::log_1(&format!("Result: {}", report.final_expr.clone()).into());
    report.final_expr
}
