

// Printout a drill guide for Skateboard trucks.
// Drill guide always has both sets of holes.
// Neon22 at Thingiverse 


// Truck bolts traditionally 3/16". So hole min is 3/16" = 4.7625mm
// holes go up to 13/64 (5.16mm) for looser and 7/32 (5.56mm)for very loose.
// in Metric countries M5 is usual replacement.

// Holes. 3/16in=4.76mm
Hole_dia = 5;   // mm

// Border factors in mm
Border_width = 6;  //[3:10]
// Corner rounding
Rounding = 6;      //[2:20]
Guide_height = 8;  //[6:12]
// width of slot
centerline_width = 1; //[0.2:0.2:2]

/* [Hidden] */
Truck_width = 41.28;  // in mm
New_school = 53.98;
Old_school = 63.5;


// global appearance and Boolean helpers
thin = 0.001;
Delta = 0.1;
cyl_res = 80;

// Border round outside 
module border()  {
	linear_extrude(height=Guide_height, convexity=4) {
		minkowski() {
			circle(d=Rounding, $fn=cyl_res);
			square(size=[Truck_width+Border_width*2, Old_school+Border_width*2]);
		}
	}
}

// Holes
module hole(my_height) {
	cylinder(h=my_height, d=Hole_dia, $fn=cyl_res);
}

// place holes referenced from 0,0
module holes() {
	cyl_height = Guide_height+Delta*2;  // nice clean hole
	translate([0,0,-Guide_height/2-Delta]) {
		hole(cyl_height);
		translate([0,New_school,0]) hole(cyl_height);
		translate([0,Old_school,0]) hole(cyl_height);
		translate([Truck_width, 0,0]) hole(cyl_height);
		translate([Truck_width, New_school,0]) hole(cyl_height);
		translate([Truck_width, Old_school,0]) hole(cyl_height);
	}
}

// centerline guides
module notch() {
	translate([(Guide_height-centerline_width)/2,-Delta,-Guide_height/2-Delta])
		cube(size=[centerline_width,Guide_height+Delta*2,Guide_height+Delta*2]);
}

module end_guide() {
	difference() {
		// wedge shaped block
		translate([0,Guide_height,-Guide_height/2])
		hull() {
			cube(size=Guide_height);
			translate([Guide_height/2-centerline_width,-Guide_height,0])
				cube(size=centerline_width*2);
		}
		// cut a notch in it
		notch();
	}
}

module centerguide() {
	translate([(Truck_width-Guide_height)/2,-Guide_height-Rounding,0])
		end_guide();
	// other end
	translate([(Truck_width+Guide_height)/2,Old_school+Guide_height+Rounding,0])
	rotate([0,0,180])
		end_guide();
}

// main module
module Drill_guide () {
	difference() {
		union() {
			// The outer rounded shape
			translate([-Border_width,-Border_width,-Guide_height/2])
				border();
			// centerline end guides
			centerguide();
			}
		// subtract holes
		holes();
		// recessed top centerline
		translate([(Truck_width-centerline_width)/2,-Delta-Border_width-Rounding/2,Guide_height/2-1])
			cube(size=[centerline_width,Old_school+Rounding+Border_width*2+Delta*2,2]);
	}
	
}

Drill_guide();
