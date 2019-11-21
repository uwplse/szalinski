// Filamentführung
// filament-guide.scad
// djgan, 2019-01-31

$fn=100;
use <MCAD/regular_shapes.scad>
	
difference () {
union() {
	color("red")
	translate([75.4,0,0]) rotate([90,0,0])
	torus(12,2);
	cube(size = [140,10,4], center = true); // Teil2
	
	color("green") // Teil1
	translate([-29,-1.5,0])
	minkowski() {
		cube(size = [80,11,4], center = true);
		cylinder(r=1,h=0.4);
		}
	color("black")
	translate([-5,0,0])
	cylinder(r=2,h=7.7);} //Stift
	translate([-59,0,-4])
	cylinder(r=2.2,h=10); //Bohrung	
	}