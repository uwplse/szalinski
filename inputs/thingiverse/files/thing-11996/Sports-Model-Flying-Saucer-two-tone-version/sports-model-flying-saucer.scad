/*

New style, multicolor flying saucer
Gian Pablo Villamil
September 2011

*/

$fn = 32;

inset_offset = 2;
inset_rad = 35;

hull_height = 10;
hull_rad = 45;
hull_res = 128; // controls the $fn value for large hull pieces
				 // make this much bigger, like 128, before making STL

gap = 0.25;	// clearance between inserts and hull halves

num_turrets = 9;
turret_rad = 5;
turret_height = 3;

num_legs = 3;

cockpit_rad = 20;
cockpit_height = 15;
nozzle_rad = 15;
cockpit_depth = 6;

// basic utilities go here

module dome(rad, height) {
	difference() {
		scale([1,1,height/rad])
		sphere(rad);
		translate([0,0,-height/2])
		cube([rad*2,rad*2,height],center=true);
	}
}

module registration_pins(num_pins) {
	for (i=[0:num_pins-1]) {
		rotate([0,0,(360/num_pins)*i])
		translate([25,0,0])
		cylinder(r=1.65,h=10,center=true,$fn=12);
	}
}

module landing_leg(length, rad1, rad2, footrad ) {
	upper_length = length*.4 - (rad1-rad2)/2;
	lower_length = length*.6 - (rad1-rad2)/2;
	cylinder(r=rad1,h=upper_length);
	translate([0,0,upper_length]) cylinder(r1=rad1,r2=rad2,h=rad1-rad2);
	translate([0,0,upper_length+(rad1-rad2)])
	cylinder(r=rad2,h=lower_length);
	translate([0,0,length])
	sphere(footrad);

	strut_offset = length/2;
	strut_length = sqrt(pow(length,2)+pow(strut_offset,2));

	translate([-strut_offset,0,0])
	rotate([0,atan2(strut_offset,length),0])
	cylinder(r=rad2, h=strut_length);
	
}

module legs(num_legs, leg_rad) {
	for (i = [0:num_legs-1]) {
		rotate([0,0,(360/num_legs)*i])
		translate([leg_rad,0,0])
		rotate([0,10,0])
		landing_leg(15,2,1.5,3);
	}
}

module cockpit(rad,height) {
	difference() {
		dome(cockpit_rad,height,$fn=hull_res);
		dome(cockpit_rad-2,height-2,$fn=hull_res);
		translate([8,0,8])
		scale([1,1,0.45])
		sphere(cockpit_rad,$fn=hull_res);
	}
}

// the spaceship is assembled here

// this defines the negative shape that is cut out from the top hull 

module top_cutout() {
	translate([0,0,inset_offset]){
		difference() {
			union() {
				cylinder(r=inset_rad+gap, h=hull_height, $fn=hull_res);
				for (i = [0:num_turrets-1]){
					rotate([0,0,(360/num_turrets)*i])
					translate([inset_rad,0,0])
					cylinder(r=turret_rad+gap,h=hull_height);
				}
			}
		}
	}
}

// and here is the cutout for the bottom hull - main difference
// is the nozzle vs cockpit diameter

module bottom_cutout() {
	translate([0,0,inset_offset]){
		difference() {
			union() {
				cylinder(r=inset_rad+gap, h=hull_height, $fn=hull_res);
				for (i = [0:num_turrets-1]){
					rotate([0,0,(360/num_turrets)*i])
					translate([inset_rad,0,0])
					cylinder(r=turret_rad+gap,h=hull_height);
				}
			}
		}
	}
}

// this is the positive shape that fits in the top hull
// lots of details here

module top_insert() {
	translate([0,0,-inset_offset])

	difference() {

		// figure out the intersection with the hull
		union() {
			intersection() {
				dome(hull_rad, hull_height, $fn=hull_res);
				translate([0,0,inset_offset+gap])
				union(){ 
					cylinder(r=inset_rad,h=hull_height,$fn=hull_res); // main cutout
		
					for (i = [0:num_turrets-1]){ // turret bases
						rotate([0,0,(360/num_turrets)*i])
						translate([inset_rad,0,0])
						cylinder(r=turret_rad,h=hull_height);
					}
				}
			}
		
			// add the turrets
		
			for (i = [0:num_turrets-1]){
				rotate([0,0,(360/num_turrets)*i])
				translate([inset_rad+0.1,0,6])
				rotate([0,17,0])
				dome(turret_rad,turret_height);
			}
		}
		cylinder(r=cockpit_rad+gap,h=hull_height,$fn=hull_res);
	}
}

// and this is the insert for the bottom
// the landing gear is part of the insert

module bottom_insert () {
	translate([0,0,-inset_offset])

	difference() {
		union() {
			intersection() {
				dome(hull_rad, hull_height, $fn=hull_res);
				translate([0,0,inset_offset+gap])
				union(){ 
					cylinder(r=inset_rad,h=hull_height,$fn=hull_res); // main cutout
		
					for (i = [0:num_turrets-1]){
						rotate([0,0,(360/num_turrets)*i])
						translate([inset_rad,0,0])
						cylinder(r=turret_rad,h=hull_height);
					}
				}
			}
		
			// add the turrets
		
			for (i = [0:num_turrets-1]){
				rotate([0,0,(360/num_turrets)*i])
				translate([inset_rad+.1,0,6])
				rotate([0,17,0])
				dome(turret_rad,turret_height);
			}
		
			// add the legs
			translate([0,0,5])
			legs(num_legs,25);
		}
	cylinder(r=nozzle_rad+gap,h=hull_height,$fn=hull_res);
	}
}

// this is the top half of the saucer
// the cockpit pokes through the insert

module top_half() {
	cockpit_offset = sqrt(pow(hull_rad,2)-pow(cockpit_rad,2)) * (hull_height/hull_rad) ;	
	cockpit_depth = cockpit_offset - inset_offset;

	difference() {
		dome(hull_rad,hull_height, $fn=hull_res);
		top_cutout();
		registration_pins(num_turrets);
	}
	//#cylinder(r=cockpit_rad,h=cockpit_offset-cockpit_depth);
	translate([0,0,cockpit_offset-cockpit_depth])
	difference() {
		cylinder(r=cockpit_rad,h=cockpit_depth,$fn=hull_res);
		cylinder(r1=cockpit_rad-6,r2=cockpit_rad-4,h=cockpit_depth,$fn=hull_res);
	}
	translate([0,0,cockpit_offset])
	cockpit(cockpit_rad,cockpit_height);
}

// here is the bottom half
// the nozzle pokes through

module bottom_half() {
	nozzle_offset = sqrt(pow(hull_rad,2)-pow(nozzle_rad,2)) * (hull_height/hull_rad) ;
	difference() {
		dome(hull_rad,hull_height, $fn=hull_res);
		bottom_cutout();
		registration_pins(num_turrets);
	}
	cylinder(r=nozzle_rad,h=nozzle_offset,$fn=hull_res);
	translate([0,0,nozzle_offset])
	difference() {
		cylinder(r1=nozzle_rad,r2=nozzle_rad-3,h=5,$fn=hull_res) ;
		cylinder(r1=nozzle_rad-7,r2=nozzle_rad-5,h=6,$fn=hull_res);
	}
}

// this module assembles the complete saucer for previewing

module assembly() {
	top_half();
	translate([0,0,inset_offset]) top_insert();
	rotate([180,0,0]) bottom_half();
	rotate([180,0,0]) translate([0,0,inset_offset]) bottom_insert();
}

// enable and disable modules for render here

// 
assembly() ;

// top_half();
// top_insert();
// bottom_half();
// bottom_insert();


//%cube([100, 100, 1], center=true);