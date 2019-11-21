//base thickness
base = 0.7;
//number of magnets
magnets = 4;
//height of each magnet
magnet_height = 1;
//diameter of each magnet
magnet_diameter = 5.5;
//wall thickness around magnets
walls = 1.2;
//material above magnets
top = 1.5;
//change this to change the thickness of the top part
top_curve = 1.7;
hole_diameter = 2.2;

/* [Hidden] */
$fn=100;
//Calculations
top_thickness = magnet_diameter + 2*walls - top_curve*2;

difference(){
	union(){
		difference(){
			//external cylinder
			cylinder(h = magnets*magnet_height + base + top + top_curve, d = magnet_diameter + 2*walls);
			//internal cylinder
			translate([0,0,base]) cylinder(h = magnets*magnet_height, d = magnet_diameter);
			translate([-(magnet_diameter + 2*walls)/2,top_thickness/2 + top_curve,magnets*magnet_height + base + top + top_curve])rotate([0,90,0])cylinder(h = magnet_diameter + 2*walls, r = top_curve);
			translate([-(magnet_diameter + 2*walls)/2,-(top_thickness/2 + top_curve),magnets*magnet_height + base + top + top_curve])rotate([0,90,0])cylinder(h = magnet_diameter + 2*walls, r = top_curve);
		}

		intersection(){
			translate([0,0,magnets*magnet_height + base + top + top_curve]) cylinder(h = top_thickness/2, d = magnet_diameter + 2*walls);
			translate([-(magnet_diameter + 2*walls)/2,0,magnets*magnet_height + base + top + top_curve])rotate([0,90,0])cylinder(h = magnet_diameter + 2*walls, d = top_thickness);
		}
	}
	translate([0,(magnet_diameter + 2*walls)/2,magnets*magnet_height + base + top + top_curve])rotate([90,0,0])cylinder(h = magnet_diameter + 2*walls, d= hole_diameter);
}