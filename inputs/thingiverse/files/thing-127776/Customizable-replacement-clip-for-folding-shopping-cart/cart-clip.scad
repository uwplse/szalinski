// Distance between wires (perimeter-to-perimeter) in folded position
length = 60;
// Clip overall thickness (choose based on extrusion width; mine is 0.42 and with 2.8 Slic3r produces exactly 3+3 walls total thickness with no infill)
thickness = 2.8;

/* [Wire] */
// Diameter of wire
diameter = 2.7;
// Clip lip vertical thickness (larger makes clip harder to insert/remove; must be smaller than wire diameter, recommended setting just under diameter/4)
first_lip = 0.75;
// Clip lip vertical thickness (larger makes clip harder to insert/remove; must be smaller than wire diameter, recommended setting just under diameter/2)
second_lip = 1.2;

/* [Hidden] */

ir = (diameter - .05)/2;
thk = thickness;
l = length - diameter;
w = 12;

slack1 = first_lip;
slack2 = second_lip;

$fn = 27;

module fillet(h, r) {
  difference() {
    cube([h, r, r]);
    translate([-0.1, r, r]) rotate([0, 90, 0]) cylinder(h = h+.2, r = r, $fn=18);
  }
}

module main() {
  difference() {
    union() {
      translate([0, ir, 0]) cube([l, thk, w]);
      cylinder(r=ir+thk, h=w);
      translate([l, 0, 0]) cylinder(r=ir+thk, h=w);
    }
    translate([0, 0, -1]) cylinder(r=ir, h=w+2);
    translate([l, 0, -1]) cylinder(r=ir, h=w+2);
    translate([0, -ir+slack1, -1]) cube([ir+thk, 2*ir-slack1, w+2]);
    translate([l-ir-thk, -ir+slack2, -1]) cube([ir+thk, 2*ir-slack2, w+2]);
    translate([ir+thk, -ir+slack1+0.05, -1]) rotate([0, -90, 90]) fillet(r=0.66*thk, h=w+2);
    translate([l-ir-thk, -ir+slack2+0.05, -1]) rotate([0, -90, 180]) fillet(r=0.66*thk, h=w+2);
  }
}

main();