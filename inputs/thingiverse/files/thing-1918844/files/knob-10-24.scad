/*

Parametric knob generator
by Gian Pablo Villamil
May 2011

Makes knurled knobs that accomodate a nut in the middle, useful for things
like camera mounts.

*/

knob_radius = 14.5;
dent_radius = 2;
knob_height = 5.35;
num_dents = 20;
dent_offset = 1;

nut_hole_radius = 2.6; // half of 1/4 inch in millimeters
nut_size_radius =5.6; // point to point size of nut

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
		translate([0,0,2.3]) cylinder(h = knob_height+10, r=nut_size_radius,$fa=60);
		}
	}
}

knob();
