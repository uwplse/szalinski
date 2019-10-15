// mm
loom_diameter = 75; // [20:200]
// mm
loom_height = 10; // [5:100]
number_of_pegs = 8; // [3:50]
// mm
peg_diameter = 5; // [1:50]
// mm
peg_height = 15; // [5:100]
// mm. If less than Peg Diameter, then knobs will not be generated
knob_diameter = 8; // [0:10]

union() {
  difference() {
    cylinder(h = loom_height, d = loom_diameter, $fa=1, $fs=0.5);
    cylinder(h = loom_height, d = loom_diameter - peg_diameter * 2, $fa=1, $fs=0.5);
  }
  for (i = [0 : number_of_pegs - 1]) {
    rotate(a = i * (360 / number_of_pegs), v = [0, 0, 1]) {
      translate([loom_diameter / 2 - peg_diameter / 2, 0, loom_height]) {
        union() {
          cylinder(h = peg_height, d = peg_diameter, $fa = 1, $fs=0.5);
          if (knob_diameter > peg_diameter) {
            translate([0, 0, peg_height]) {
              sphere(d = knob_diameter, $fa=1, $fs=0.5);
            }
          }
        }
      }      
    }
  }
}