total_height = 33; // [100]
bottom_diameter = 4; // [0:0.1:10]
// The diameter of where the head touches the pin
top_diameter = 5.5; // [0:0.1:7.5]
ball_diameter = 7.5; // [4:0.1:10]
ball_height = 5.5; // [0:0.1:10]
rim_diameter = 6; // [0:0.1:10]
rim_height = 1.5; // [0:0.1:10]

// Number of facets (high values are more round)
$fn = 120;

/* [Hidden] */

function pythdiff (a, b) = sqrt(a * a / 4 - b * b / 4);

module BridgePin (he = total_height - ball_height, rd = max(rim_diameter, top_diameter), bh = min(ball_height, ball_diameter)) {
  difference() {
    union() {
      cylinder(h = he + 0.001, d1 = bottom_diameter, d2 = top_diameter);
      translate([0, 0, total_height - ball_height / 2])
        scale([1, 1, ball_height / ball_diameter])
        translate([0, 0, -pythdiff(ball_diameter, bh)/2])
        sphere(d = ball_diameter);
      translate([0, 0, he])
        scale([1, 1, rim_height / rd])
        translate([0, 0, -pythdiff(rd, top_diameter)])
        sphere(d = rd);
    }
    translate([bottom_diameter/2, 0, -1])
      scale([1, 0.5, 1])
      cylinder(h = he + 1, d = bottom_diameter);
  }
}
  
color("white") BridgePin();