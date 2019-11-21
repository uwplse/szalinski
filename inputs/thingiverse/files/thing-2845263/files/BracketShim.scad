// Overall length
length = 100;
// Width at the bottom
width1 = 32;
// Width at the top (diameter of circle at the end)
width2 = 13;
// Diameter of holes
hole_dia = 4.2;

// Offsets of the two lower holes downwardss relative to the top hole
offset1 = 80;
offset2 = 75;
// Offsets of the two lower holes out from the center.
center_offset_1 = 8.5;
center_offset_2 = 8.5;

// Thickness of the piece
thickness = 2;

difference() {
    $fn=20;
    top_hole_y = length - width2/2;
    linear_extrude(thickness) {
      polygon([[0, 0], [width1/2 - width2/2, length - width2/2], [width1/2+width2/2, length-width2/2], [width1, 0]]);
      translate([width1/2, length-width2/2,0])
        circle(d=width2);
    }
    translate([width1/2 + center_offset_2, top_hole_y - offset1, -1]) {
      cylinder(d=hole_dia, h=thickness+2);
    }
    translate([width1/2 - center_offset_1, top_hole_y - offset2, -1]) {
      cylinder(d=hole_dia, h=thickness+2);
    }
    translate([width1/2, top_hole_y, -1]) {
      cylinder(d=hole_dia, h=thickness+2);
    }
  }