use wasm_bindgen::prelude::wasm_bindgen;

#[wasm_bindgen]
pub fn caddy_to_scad(_s: String) -> String {
    // TODO: parse Caddy to SCAD
    "difference () {
  translate ([0, 0, 0]) cube([120, 95, 2.5], center=false);
  translate ([10, 9.999899999999997, 0]) cube([100, 75, 2.5], center=false);
  translate ([10, 9.999899999999997, 0]) cube([100, 75, 1], center=false);
  translate ([0, 0, 0]) union () {
  translate ([77.6, 35.975, 0]) scale ([32.4, 23.975, 1]) cube([1, 1, 1], center=false);
  translate ([44.300000000000004, 35.975, 0]) scale ([32.3, 23.975, 1]) cube([1, 1, 1], center=false);
  translate ([10, 35.975, 0]) scale ([33.3, 23.975, 1]) cube([1, 1, 1], center=false);
  translate ([44.300000000000004, 10, 0]) scale ([32.3, 24.975, 1]) cube([1, 1, 1], center=false);
  translate ([77.6, 10, 0]) scale ([32.4, 24.975, 1]) cube([1, 1, 1], center=false);
  translate ([10, 10, 0]) scale ([33.3, 24.975, 1]) cube([1, 1, 1], center=false);
  translate ([44.300000000000004, 60.94999999999999, 0]) scale ([32.3, 24.05, 1]) cube([1, 1, 1], center=false);
  translate ([10, 60.94999999999999, 0]) scale ([33.3, 24.05, 1]) cube([1, 1, 1], center=false);
  translate ([77.6, 60.94999999999999, 0]) scale ([32.4, 24.05, 1]) cube([1, 1, 1], center=false);
}}".to_string()
}

#[wasm_bindgen]
pub fn synthesize_caddy(_s: String, technique: &str) -> String {
    // TODO: actually generate the Caddy
    let dummy_caddy = "(Fold
  Diff
  (Map2
    Trans
    (MapI
      4
      (Vec3
        (+ (* (* i i) -5) (* i 15))
        (+ (* (* i i) -4.999949999999998) (* i 14.999849999999995))
        0))
    (List
      (Cube (Vec3 120 95 2.5) false)
      (Cube (Vec3 100 75 2.5) false)
      (Cube (Vec3 100 75 1) false)
      (Fold
        Union
        (Map2
          Trans
          (List
            (Vec3 77.6 35.975 0)
            (Vec3 44.300000000000004 35.975 0)
            (Vec3 10 35.975 0)
            (Vec3 44.300000000000004 10 0)
            (Vec3 77.6 10 0)
            (Vec3 10 10 0)
            (Vec3 44.300000000000004 60.94999999999999 0)
            (Vec3 10 60.94999999999999 0)
            (Vec3 77.6 60.94999999999999 0))
          (Map2
            Scale
            (List
              (Vec3 32.4 23.975 1)
              (Vec3 32.3 23.975 1)
              (Vec3 33.3 23.975 1)
              (Vec3 32.3 24.975 1)
              (Vec3 32.4 24.975 1)
              (Vec3 33.3 24.975 1)
              (Vec3 32.3 24.05 1)
              (Vec3 33.3 24.05 1)
              (Vec3 32.4 24.05 1))
            (Repeat 9 (Cube (Vec3 1 1 1) false))))))))"
        .to_string();
    match technique {
        "szalinski" => (), // do something,
        "AU" => (),        // do something else,
        _ => panic!("Unsupported synthesis technique: {}", technique),
    };
    dummy_caddy
}
