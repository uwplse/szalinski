use egg::RecExpr;
use szalinski_egg::{cad::Cad, eval::Scad};
use wasm_bindgen::prelude::wasm_bindgen;

#[wasm_bindgen]
pub fn greet(name: &str) -> String {
    format!("Hi, {}!", name)
}

#[wasm_bindgen]
pub fn caddy_to_scad(_s: String) -> String {
    // TODO: parse Caddy to SCAD
    "cube([100, 200, 300], center=true);".to_string()
}
