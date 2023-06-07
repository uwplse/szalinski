use egg::*;
use std::fs;

use wasm_bindgen::prelude::*;

#[wasm_bindgen]
pub fn greet(name: &str) -> String {
    format!("Hello, {}!", name)
}

#[wasm_bindgen]
pub fn to_csg(s: String) -> String {
    let c: RecExpr<Cad> = s.parse();
    format!("{}", s.len())
}
