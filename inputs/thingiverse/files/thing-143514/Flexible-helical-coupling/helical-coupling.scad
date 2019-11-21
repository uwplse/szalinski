
// Tip: Make the larger rod hole the upper one

// Outer diameter of the coupling
coupling_outer_dia = 20;

// Diameter of the upper hole
hole_dia_top = 10;
// Length of the holder for the upper hole
length_top = 10;

// Diameter for the lower hole
hole_dia_bottom = 6;
// Length of the holder for the lower hole
length_bottom = 10;

// Length of the helix itself
helix_length = 10;

// Hole size for the fastener screws
screw_diameter = 3;

$fn = 100;

// Top
translate([0,0,helix_length+length_top/2])
rod_connector(length_top, coupling_outer_dia, hole_dia_top, screw_diameter);

// Bottom
translate([0,0,-length_bottom/2])
rod_connector(length_bottom, coupling_outer_dia, hole_dia_bottom, screw_diameter);

// Helix
linear_extrude(height = helix_length, center = false, convexity = 0, twist = 360*2)
difference() {
  circle(r=coupling_outer_dia/2);
  circle(r=coupling_outer_dia/4);
  translate([-coupling_outer_dia/2,0])
  square([coupling_outer_dia, coupling_outer_dia]);
}

module rod_connector(length, outer_dia, inner_dia, screw_hole_dia) {
difference(){
  cylinder(r=outer_dia/2, h=length, center=true);
  cylinder(r=inner_dia/2, h=length+0.1, center=true);
  rotate([0,90,0])
    cylinder(r=screw_hole_dia/2, h=outer_dia+0.1, center=true);
  rotate([0,90,90])
    cylinder(r=screw_hole_dia/2, h=outer_dia+0.1, center=true);
}}
