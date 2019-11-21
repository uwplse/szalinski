innerWidth = 7; // The distance between the sides minus the rounded edges
thickness = 1.5;  // The thickness of a single wall (the bottom is double)
height = 15;  // The distance from the flat side to the rounded edges
width = 40;  // the width of the rounded edges
$fn = 32;  // Useful for getting the rounding right

module side() {
  linear_extrude(height = thickness) {
      polygon([[0, 0], [0, height], [width, height], [width, 0]]);
  }
}

module bottom() {
  linear_extrude(height = thickness) {
      polygon([[0, 0], [0, innerWidth + (thickness*2)], [width, innerWidth + (thickness*2)], [width, 0]]);
  }
}

module roundedEdge() {
    rotate([0, 90, 0]) {
      cylinder(width, thickness, thickness);
    }
}

rotate([90, 0, 0]) {
    side();
    translate([0, 0, innerWidth + thickness]) side();
    rotate([90, 0, 0]) {
        bottom();
    }
    translate([0, height, thickness]) {
        roundedEdge();
    }
    translate([0, height, thickness + innerWidth]) {
        roundedEdge();
    }   
}