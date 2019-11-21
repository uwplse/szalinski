// The Whirly One
//  by seedwire
//
//  A whirly copter-like thing inspired by the venerable wooden namesake.
//  N.B. requires good first and second layer bed adhesion.
//
//  Also doubles as a simple pin-wheel, or fan rotor...
//
//  Best sliced with 2 shells at 10% infill

blade_radius = 70;
blade_width = 10;
blade_thickness = 0.9;
blade_pitch = 30;
handle_length = 8; // 8mm for hand block, 90mm for handle

handblock = 0;
outer_ring = 1;
rotors = 1;

$fn=100;

translate([0,0,-0.3]) if(rotors == 1) { 
	// a handle
		union() { 
			cylinder(r=2, h=handle_length-4.75/2.1);
			cylinder(r1=blade_width, r2=2, h=blade_width*0.707);
			translate([0,0,handle_length]) cube([4.75,4.75,5.75], center=true); // key to fit into string spinner thingy...
	
			//sphere(r=2); // alternate end-stop
			cylinder(r=blade_width/2, h=0.6);
		}
		//translate([0,0,2]) cylinder(r=1, h=handle_length-1);

	// some rotors
	translate([0,0,0]) rotate([0,0,45]) union() {

	for(i=[0:3]){
		rotate([0,0,90*i]) rotor();
	}
}

// optional outer ring
if(outer_ring == 1) 
	difference() {
		cylinder(r=blade_radius, h=(blade_width+blade_thickness)*sin(blade_pitch));
		translate([0,0,-0.035]) cylinder(r=blade_radius-blade_thickness, h=(blade_width+blade_thickness)*1.2*sin(blade_pitch));
	}


}


// The string spinner thingy
if(handblock == 1) {
	translate([blade_radius + 30,-25,-0.3]) union() { 

	rotate([0,0,0]) spinner_thingy();

	// The hand block
	translate([0,35,14]) rotate([180,0,180]) difference() {
		minkowski() { minkowski() { minkowski() { 
			hull() { 
				cube([30,30,15], center=true);
				translate([0,20,0]) cube([15,30,15], center=true);
			}
			translate([0,0,0]) cylinder(r=3, h=1, center=true);
		}
			rotate([90,0,0]) cylinder(r=3, h=1, center=true);
		}
			rotate([0,90,0]) cylinder(r=3, h=1, center=true);
		}
		translate([0,0,-14.01]) scale([1.15,1.15,1.15]) spinner_thingy(0);
	 } 
	}
}

//////
// Tear-away printing support
//
if(handblock == 1) { 
	translate([112.5,-20,0]) cube([10,80,0.6], center=true);
	translate([87,-20,0]) cube([10,80,0.6], center=true);
	translate([110,-35,0]) cube([80,10,0.6], center=true);
	translate([110,-17,0]) cube([80,5,0.6], center=true);
	translate([110,35,0]) cube([80,10,0.6], center=true);
}

module rotor()
{
	translate([-blade_radius,-blade_width/2+blade_width*sin(blade_pitch)/2,0]) rotate([blade_pitch,0,0]) union() {

		cube([blade_radius,blade_width,blade_thickness]);
		translate([-blade_width/16, blade_width/2,0]) cylinder(r=blade_width/2,h=blade_thickness);
	}
}

module spinner_thingy(final = 1)
{
 union() { 
	difference() {
		cylinder(r=7, h=15);
		if(final) union() {
			cube([6,6,6], center=true);	// slot for rotor
			translate([0,12,8]) rotate([90,0,0]) cylinder(r=2, h=25); // hole for string
		}
	}
	difference() { 
		translate([0,0,15]) sphere(r=7);
		if(final) translate([0,12,8]) rotate([90,0,0]) cylinder(r=2, h=25); // hole for string
	}
 }

 if(final == 0) {
	translate([0,0,4]) cylinder(r=14, h=11);
	translate([14-4,-12.5,9.5]) cube([8,25,11], center=true);
 }
}