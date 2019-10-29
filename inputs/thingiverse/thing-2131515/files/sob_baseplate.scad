// adjustable
base_thickness = 1.6;
x_length = 50;
y_length = 50; //DP5050
standoff_height = base_thickness * 2;
peg_height = standoff_height + 1.6;

// shouldn't have to touch these
corner_radius = 4;
mounting_hole = 3.2;
hole_offset = 4;
standoff_diameter = mounting_hole + 2.8;

union() {
    BasePlate();
    Pegs();
    Standoffs();
}

module BasePlate() {
hull() {
// 0,0
translate( [ corner_radius, corner_radius, 0 ] )
    cylinder( h = base_thickness, r = corner_radius, $fn = 50 );

// X,0
translate( [ x_length - corner_radius, corner_radius, 0 ] ) cylinder( h = base_thickness, r = corner_radius, $fn = 50 );

// 0,Y
translate( [ corner_radius, y_length - corner_radius, 0 ] ) cylinder( h = base_thickness, r = corner_radius, $fn = 50 );

translate( [ x_length - corner_radius, y_length - corner_radius, 0 ] ) cylinder( h = base_thickness, r = corner_radius, $fn = 50 );
}
}

// pegs
module Pegs(){
// 0,0
translate( [ hole_offset, hole_offset, base_thickness ] )
    cylinder( h = base_thickness + peg_height, d = mounting_hole, $fn = 50 );

// X,0
translate( [ x_length - hole_offset, hole_offset, base_thickness ] )
    cylinder( h = base_thickness + peg_height, d = mounting_hole, $fn = 50 );

// 0,Y
translate( [ hole_offset, y_length - hole_offset, base_thickness ] )
    cylinder( h = base_thickness + peg_height, d = mounting_hole, $fn = 50 );

// X,Y
translate( [ x_length - hole_offset, y_length - hole_offset, base_thickness ] )
    cylinder( h = base_thickness + peg_height, d = mounting_hole, $fn = 50 );
}

// standoffs
module Standoffs() {
// 0,0
translate( [ hole_offset, hole_offset, base_thickness ] )
    cylinder( h = base_thickness + standoff_height, d = standoff_diameter, $fn = 50 );

// X,0
translate( [ x_length - hole_offset, hole_offset, base_thickness ] )
    cylinder( h = base_thickness + standoff_height, d = standoff_diameter, $fn = 50 );

// 0,Y
translate( [ hole_offset, y_length - hole_offset, base_thickness ] )
    cylinder( h = base_thickness + standoff_height, d = standoff_diameter, $fn = 50 );

// X,Y
translate( [ x_length - hole_offset, y_length - hole_offset, base_thickness ] )
    cylinder( h = base_thickness + standoff_height, d = standoff_diameter, $fn = 50 );
}