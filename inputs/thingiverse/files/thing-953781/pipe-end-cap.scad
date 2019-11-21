// This thing is loosely based on my customizable
// dowel centers (http://www.thingiverse.com/thing:927256).
// The purpose is to create end caps for pipes.
//
// Recommended printing: 10% infill, 1 shell, 0.10 or smaller layer height (to get smoothest dome)
//
// This is licensed under creative commons, attribution, share-alike
// For the attribution requirement, please provide a link to:
//		http://www.thingiverse.com/thing:953781
//

/* [main] */

// inside diameter of pipe to fit inside.
inside_dia=16;

// outside_diameter of pipe
outside_dia=21;

// how high the dome is for the cap (od/2 = perfect hemisphere)
dome_h=5;

// to generate support structure (0 to turn off, recommended about 0.2)
rim_support_thick=0;

// how deep into the pipe the cap extends
inset=8;

// probably odd numbers are the best
num_gussets=5;

// set to 0 to disable gussets
gusset_depth=0.5;

// add a small twist to the support ribs (I don't know why you'd want to, but you can)
spiril_degrees=0;

// resolution ($fn)
resolution=64;

/* [hidden] */
pi=3.14159265358979323846264338327950;
$fn=resolution;
id=inside_dia;
od=outside_dia;

cylinder(r=id/2-gusset_depth,h=inset);
// post
for(a=[0:360/num_gussets:359.99]){
	rotate([0,0,a]) translate([id/2-gusset_depth,0,0]) rotate([0,1,0]) rotate([spiril_degrees,0,0]) union() {
		translate([0,0,gusset_depth]) cylinder(r=gusset_depth,h=inset-gusset_depth,$fn=16);
		cylinder(r2=gusset_depth,r1=0.1,h=gusset_depth,$fn=16);
	}
}
// dome
translate([0,0,inset-0.01]) scale([1,1,dome_h/(od/2)]) difference(){
	sphere(r=od/2);
	translate([-od/2,-od/2,-od]) cube([od,od,od]);
}
// support ring
if(rim_support_thick>0) difference(){
	qmin=0.1;
	nq=12;
	cylinder(r=od/2,h=inset);
	cylinder(r=od/2-rim_support_thick,h=inset);
	support_hole_w=qmin;
	for(a=[0:360/nq:359.99]){
		rotate([0,0,a]) translate([0,0,qmin*2]) cube([support_hole_w,od,inset-qmin]);
	}
}