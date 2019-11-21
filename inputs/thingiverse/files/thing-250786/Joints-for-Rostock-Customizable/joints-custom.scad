// Joints for Rostock (Customizable) - V0.1

////////////////////////////////////////////////////////////////////////////////
// Fixed values

// This value is used in various places to prevent coincident faces.
extra = 0.1*1;

// The spacing between joints.
spacing = 4*1;

////////////////////////////////////////////////////////////////////////////////
// User Defined Values

// The number of rows of joints.
rows = 3;

// The number of columns of joints.
columns = 4;

// The height of the joint.
height = 6;

// The distance between the arms of the jaws.
jaws_length = 8.5;

// The distance between the arms of the carriage/platform.
platform_carriage_length = 13.0;

// The length of the taper from each end of the joint.
taper_length = 1.25;

// The radius of the taper at each end of the joint.
taper_end_radius = 2.5;

// The radius of the hole for the jaws bolt.
m3_jaws_radius = 1.45;

// The radius of the hole for the carriage/platform bolts.
m3_platform_carriage_radius = 1.55;

////////////////////////////////////////////////////////////////////////////////
// Calculated Values
taper_start_radius = (height/2)/cos(30);

////////////////////////////////////////////////////////////////////////////////
// Modules

module joint_part(len) {
	hull() {
		translate([0,0,(len/2)-taper_length]) cylinder(r1=taper_start_radius,r2=taper_end_radius,h=taper_length,$fn=6);
		translate([0,0,-((len/2)-taper_length)]) rotate([180,0,0]) cylinder(r1=taper_start_radius,r2=taper_end_radius,h=taper_length,$fn=6);
	}
}

module joint() {
	difference() {
		union() {
			rotate([90,0,0]) joint_part(jaws_length);
			rotate([90,0,90]) joint_part(platform_carriage_length);
		}
    	rotate([90, 0, 0]) cylinder(r=m3_jaws_radius, h=jaws_length+(2*extra), center=true, $fn=12);
    	rotate([0, 90, 0]) cylinder(r=m3_platform_carriage_radius, h=platform_carriage_length+(2*extra), center=true, $fn=12); 
	}
}

////////////////////////////////////////////////////////////////////////////////
// Main

for(i=[0:(rows-1)]) {
	for(j=[0:(columns-1)]) {
		translate([i*(platform_carriage_length+spacing),j*(jaws_length+spacing),0]) joint();
	}
}