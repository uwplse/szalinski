// Outer diameter of cylinder.
od = 10;
// Length of main cylinder.
body_height = 25;
// Angle of the tip measured from vertical.
tip_half_angle = 30; // [30:60]
// Width of the gap to place caliper arm into.
gap_width = 3.6;
// Length of the caliper arm gap.
gap_height = 20;

/* [Hidden] */
// Make everything nice and round.
$fa = 5;
$fs = 0.5;

slop = 0.1;

difference() {
  union() {
    cylinder(h=body_height, r=od/2);
    translate([0, 0, body_height]) cylinder(h=od/2 / tan(tip_half_angle), r1=od/2, r2=0);
  }
  translate([0, -gap_width/2, -slop]) cube([od/2+slop, gap_width, gap_height+slop]);
}