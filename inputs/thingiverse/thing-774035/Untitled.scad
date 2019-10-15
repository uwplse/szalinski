// include <MCAD/filename.scad>
// include <pins/pins.scad>
include <write/Write.scad>
include <write.scad>

name_text = "Will";

difference(){
	translate([-25,-10,-2]){
		cube([50, 20, 4]);
	}
	write(name_text, t = 4, h = 12, center = true, bold = 1);
	translate([20, 0, -2]){
		cylinder(r = 3, h = 6);
	}
}
