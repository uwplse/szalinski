use wasm_bindgen::prelude::wasm_bindgen;
use szalinski_egg::{eval, synthesize, cad};
use egg::*;

#[wasm_bindgen]
pub fn caddy_to_scad(s: String) -> String {
    let caddy: RecExpr<cad::Cad> = s.parse().expect("Couldn't parse input");
    let scad = eval::Scad::new(&caddy);
    scad.to_string()
}

#[wasm_bindgen]
pub fn synthesize_caddy(s: String) -> String {
    let report = synthesize::optimize_with_au(s);
    report.final_scad
    
}
