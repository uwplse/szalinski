// Wire clamp for electronics
// https://www.thingiverse.com/thing:3765512
// Vilem Marsik, 2019
// License: CC BY-NC-SA 
// https://creativecommons.org/licenses/by-nc-sa/4.0/

width=5.5;
hole2hole=14;
hole_diameter=3;
thickness=2.75;
bridge_radius=8;
bridge_height=2;

/* [Hidden] */
$fs=.5;
$fa=.5;
zb=bridge_height-bridge_radius+thickness;

difference()	{
	union()	{
		hull()
			for(i=[-1,1])
				translate([hole2hole*i/2,0,0])
					cylinder(d=width,h=thickness);
		translate([0,-width/2,zb])
			rotate([-90,0,0])
				cylinder(r=bridge_radius,h=width);
	}
	for(i=[-1,1])
		translate([hole2hole*i/2,0,-1])
			cylinder(d=hole_diameter,h=thickness+2);
	translate([0,-width/2-1,zb])
		rotate([-90,0,0])
			cylinder(r=bridge_radius-thickness,h=width+2);
	translate([-hole2hole/2-width/2-1,-width/2-1,-2*bridge_radius])
		cube([hole2hole+width+2,width+2,2*bridge_radius]);
}