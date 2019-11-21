// of the spool hole
diameter = 59; // [20:75]

rod_diameter = 9; // [4:15]

leg_thickness = 3; // [2:10]

leg_count = 5; // [3:7]

// of the bottom part
height = 7; // [5:20]

overall_height = 30; // [20:60]

/////////////////////////////////////////////////////////


// color([1, 0, 0, 0.5]) import("SpoolInsert.stl");

module leg() {
	intersection() {
		translate([0,0,-2]) cylinder(r=diameter/2, h=height+4, $fn=50);
		union() {
			translate([-rod_diameter*1.1, 0, 0]) cube([leg_thickness, diameter*0.6, height]);
			difference() {
				cylinder(r=diameter/2+1, h=height, $fn=50);
				translate([0,0,-1]) union() {
					cylinder(r=diameter/2-leg_thickness, h=height+2, $fn=50);
					translate([rod_diameter, -diameter, 0]) cube([diameter, diameter*2, height+2]);
					translate([-diameter-rod_diameter*1.1, -diameter, 0]) cube([diameter, diameter*2, height+2]);
					translate([-diameter, -diameter, 0]) cube([diameter*2, diameter, height+2]);
				}
			}
		}	
	}
}

module spool_insert() {
	// the main body
	difference() {
		union() {
			translate([0, 0, height]) cylinder(r1=rod_diameter*1.1, r2=rod_diameter/2+1, h=overall_height-height, $fn=50);
			cylinder(r=rod_diameter*1.1, h=height, $fn=50);
		}
		translate([0, 0, -1]) cylinder(r=rod_diameter/2, h=overall_height+2, $fn=50);
	}

	// and legs
	for(i=[0:leg_count-1])
		rotate(i*360/leg_count, [0,0,1]) leg();
}

////////////////////////////////////////////////////////

spool_insert();
