use egg::RecExpr;
use szalinski_egg::{cad::Cad, eval::Scad};
use wasm_bindgen::prelude::wasm_bindgen;

#[wasm_bindgen]
pub fn greet(name: &str) -> String {
    format!("Hi, {}!", name)
}

#[wasm_bindgen]
pub fn caddy_to_csg(s: String) -> String {
    let cad: RecExpr<Cad> = s.parse().unwrap();
    let _scad = Scad(&cad);
    format!("{:?}", cad)
}
