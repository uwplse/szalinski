/*
  OneUp bed platform nut holder(s)
  
  M3 nut used with heated bed on TwoUp (v2) and OneUp v2
  M4 nut used with basic bed (v2)
  
  Changes:
    Thicker vertical wall
    Removed lip on upper horizontal surface
    Resized hexagonal and circular holes to conform to M3 bolt and screw sizes
    
*/

x_origin = 0;
y_origin = 0;
z_origin = 0;
x_long_inset = 9.4;
x_riser = 3.5;
x_length = x_long_inset + x_riser;
x_overhang = 3;
z_base = 5;
z_riser = 7;
z_top = 2.5;
z_height = z_base + z_riser + z_top;

y_constant = 11;                            // Piece is always 10mm wide
x_hole_offset = 5.5;                        // Hole is always 5.0mm from innermost edge
y_hole_offset = y_constant / 2;             // Center the hole

spring_diameter = 8.0;    // spring is 8mm

// Hardware specs (with extra allowance for 
M3_adjustment = 0.75;
M4_adjustment = 0.75;
M3_bolt_diameter = 3;
M4_bolt_diameter = 4;
M3_nut_diameter = 6.5;
M4_nut_diameter = 10;
M3_nut_height = 2.5;
M4_nut_height = 3.0;

// Point to either M3 or M4 specs
bolt_diameter = M3_bolt_diameter + M3_adjustment;
nut_diameter = M3_nut_diameter + M3_adjustment;
nut_height = M3_nut_height;                                 // Did not add adjustment because z-axis pretty accurate
nut_offset = z_base - nut_height;

// To make the actual code easier to read
x_cutout_1 = x_long_inset;
x_cutout_2 = x_long_inset - x_overhang;
z_origin_cutout_1 = z_origin + z_base;
z_origin_cutout_2 = z_origin + z_base + z_riser;
x_origin_hole = x_origin + x_hole_offset;
y_origin_hole = y_origin + y_hole_offset;
z_origin_hex_nut = z_origin + nut_offset;



rotate([0, 0, 0]) { difference () {
    // Create basic shape
    translate([x_origin, y_origin, z_origin])          cube([x_length, y_constant, z_height]);
    // Remove cutout 1
    translate([x_origin, y_origin, z_origin_cutout_1]) cube([x_long_inset , y_constant, z_riser]);
		
    // Remove cutout 2
    translate([x_origin, y_origin, z_origin_cutout_2])  cube([x_cutout_2, y_constant, z_top]);

    // Create hole for M3 bolt cylinder
    translate([x_origin_hole, y_origin_hole, z_origin]) cylinder(d=bolt_diameter, h=z_height, $fn=30);

    // Create hole for M3 hex nut holder
    translate([x_origin_hole, y_origin_hole, z_origin_hex_nut]) cylinder(d=nut_diameter, h=nut_height, $fn=6);
	
	// Cutout for spring on OneUp
	translate([x_origin_hole, y_origin_hole, z_height - z_top]) cylinder(d=spring_diameter, h=z_top, $fn=30);
}

// add support structure
translate([x_origin + x_cutout_2, y_origin, z_origin_cutout_1]) union() {
	color("red") difference() {
		linear_extrude(height=z_riser, center=false) union() {
			// side indented
			polygon(points=[
				[0,2], [0.5,2], [3,1.3],
				[3,0.7], [0.5,0], [0,0]
			]);
			translate([0, y_constant-2, 0]) polygon(points=[
				[0,2], [0.5,2], [3,1.3],
				[3,0.7], [0.5,0], [0,0]
			]);
		}
		translate([0, 1.6, 0]) cube([3 , y_constant-3.2, z_riser]);
		translate([1 , y_constant+1, 0]) rotate([90,0,0])
			linear_extrude(height=y_constant+2, center=false) union() {
				// bottom cutout
				polygon(points=[
					[0,1], [0.5,(z_riser/3)-0.2],
					[1.5,(z_riser/3)-0.2], [2,0.5]
				]);
				// middle cutout
				polygon(points=[
					[0,(z_riser/3)+0.2], [0.5,(z_riser*2/3)-0.2],
					[1.5,(z_riser*2/3)-0.2], [2,(z_riser/3)+0.2]
				]);
				// top cutout
				polygon(points=[
					[0,(z_riser*2/3)+0.2], [0.5,z_riser-0.5],
					[1.5,z_riser-0.5], [2,(z_riser*2/3)+0.2]
				]);
		};
	};
};

}
