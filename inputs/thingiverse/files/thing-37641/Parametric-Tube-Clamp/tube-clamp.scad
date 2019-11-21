
//------------------------------------------------------------
//	Tube Clamp
//
//	http://thingiverse.com/Benjamin
//	http://www.thingiverse.com/thing:37641
//------------------------------------------------------------

include <utils/build_plate.scad>


//	Tube diameter (mm)
tube_diameter=12;	//	[1:30]

//	Hole diameter (mm)
screw_diameter=4;//	[1:15]


build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]
build_plate_manual_x = 246; //[100:400]
build_plate_manual_y = 152; //[100:400]
build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);



//------------------------------------------------------------------
cyl_diameter = 12.4 *1;
top_cut = 0.3 *1;
cut = 6 *1;
insert = 3*1;
//------------------------------------------------------------------
entre_tube = 0*1;
sphere_diameter = cyl_diameter*3.2;
clearance = 0.25 *1;
precision = 24 *1;
precision_sphere = 32 *1;
thickness = 5 *1;
hole_diameter = cyl_diameter + clearance;
cube_hull_dist = 80 *1;
cube_hull_width = 40 *1;
//------------------------------------------------------------------
difference() {
	scale(tube_diameter/cyl_diameter)
	tubeClamp12();
	cylinder(r=screw_diameter/2 + clearance/2, h=3*sphere_diameter, $fn=precision, center=true);
}
//------------------------------------------------------------------
module tubeClamp12() {
	rotate([180, 0, 0])
	translate([0, 0, cut])
	difference() {
		intersection() {
			sphere(r=sphere_diameter/2, center=true, $fn=precision_sphere);
			
			translate([0, 0, -sphere_diameter/2])
			union () {
				pod(sphere_diameter/2);
				rotate([0, 0, 120])
				pod(sphere_diameter/2);
				rotate([0, 0, -120])
				pod(sphere_diameter/2);
			}
		}
		
		translate([0, 0, sphere_diameter -cut])
		cube([2*sphere_diameter, 2*sphere_diameter, 2*sphere_diameter], center=true);

		translate([0, 0, -sphere_diameter*1.5 +top_cut])
		cube([2*sphere_diameter, 2*sphere_diameter, 2*sphere_diameter], center=true);

		translate([0, 0, -insert]) rotate([80, 0, 0]) tiges();

		translate([sphere_diameter/2 + 8.6, 0, 0])
		cylinder(r=sphere_diameter/2, h = 3*sphere_diameter, $fn=precision*2, center=true);
		
		
		rotate([0, 0, 120])
		translate([sphere_diameter/2 + 8.6, 0, 0])
		cylinder(r=sphere_diameter/2, h = 3*sphere_diameter, $fn=2*precision, center=true);
		
		rotate([0, 0, -120])
		translate([sphere_diameter/2 + 8.6, 0, 0])
		cylinder(r=sphere_diameter/2, h = 3*sphere_diameter, $fn=2*precision, center=true);
	}

}
//------------------------------------------------------------------
module pod(pRayon) {
	translate([-pRayon/2, 0, pRayon/2])
	cube([pRayon*1.6, pRayon*0.8, pRayon], center=true);
}
//------------------------------------------------------------------
module tiges() {
	rotate([-45, 0, 0])
	rotate([0, 45, 0])
	union() {
	
		//color([0.7, 0.7, 0.9])
		translate ([hole_diameter/2 +entre_tube , hole_diameter/2 +entre_tube, 0])
		cylinder (r=hole_diameter/2, h = 300, $fn=precision, center = true);

		//color([0.7, 0.7, 0.9])
		translate ([hole_diameter/2 +entre_tube -hole_diameter*cos(45)/2, hole_diameter/2 +entre_tube+hole_diameter*cos(45)/2, 0])
		rotate([0, 0, 45])
		cube([cyl_diameter, cyl_diameter, 300], center=true);

		
		//color([0.7, 0.9, 0.7])
		translate ([-hole_diameter/2 -entre_tube, 0, -hole_diameter/2 -entre_tube])
		rotate([90, 0, 0])
		cylinder (r=hole_diameter/2, h = 300, $fn=precision, center = true);

		//color([0.7, 0.9, 0.7])
		translate ([-hole_diameter/2 -entre_tube-hole_diameter*cos(45)/2, 0, -hole_diameter/2 -entre_tube+hole_diameter*cos(45)/2])
		rotate([0, 45, 0])
		rotate([90, 0, 0])
		cube([cyl_diameter, cyl_diameter, 300], center=true);
		
		//color([0.9, 0.7, 0.7])
		translate ([0, -hole_diameter/2 -entre_tube , hole_diameter/2 +entre_tube ])
		rotate([0, 90, 0])
		cylinder (r=hole_diameter/2, h = 300, $fn=precision, center = true);

		//color([0.9, 0.7, 0.7])
		translate ([0, -hole_diameter/2 -entre_tube +hole_diameter*cos(45)/2, hole_diameter/2 +entre_tube +hole_diameter*cos(45)/2])
		rotate([45, 0, 0])
		rotate([0, 90, 0])
		cube([cyl_diameter, cyl_diameter, 300], center=true);
	}
}
//------------------------------------------------------------------

