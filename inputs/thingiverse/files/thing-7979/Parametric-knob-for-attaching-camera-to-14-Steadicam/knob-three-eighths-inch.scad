/*

Parametric knob generator
by Gian Pablo Villamil
May 2011

Makes knurled knobs that accomodate a nut in the middle, useful for things
like camera mounts.

version for 3/8 inch nut

*/

knob_radius = 19.05;
dent_radius = 5;
knob_height = 9.29;
num_dents = 6;
dent_offset = 2;

nut_hole_radius = 4.8; // half of 1/4 inch in millimeters
nut_size_radius = 8.255; // point to point size of nut

module knob()
{
	translate([0, 0, 0]) {
		difference() {
		cylinder(h = knob_height, r = knob_radius);
		for (i = [0:(num_dents - 1)]) {
			translate([sin(360*i/num_dents)*(knob_radius+dent_offset), cos(360*i/num_dents)*(knob_radius+dent_offset), -5 ])
			cylinder(h = knob_height+10, r=dent_radius);
			}
		translate([0,0,-5]) cylinder(h = knob_height+10, r=nut_hole_radius,$fa=10);
		translate([0,0,1.2]) cylinder(h = knob_height+10, r=nut_size_radius,$fa=60);
		}
	}
}

knob();
