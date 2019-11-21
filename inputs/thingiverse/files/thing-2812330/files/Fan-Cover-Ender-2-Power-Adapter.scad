// Fan Cover Ender 2 Power Adapter
// Ralf Merschmann
// 02/03/2018

$fn=100;

module fan_cover_inside() {
	translate([0,0,10/2]) hull() {
		cube([65,65,10],center=true);
		translate([0,65/2-5,20]) cube([50,10,50/2],center=true);
	}	
}

module fan_cover() {
	difference() {
		minkowski () {
			fan_cover_inside();
			sphere(r=6);
		}
		fan_cover_inside();
		translate([0,0,-5]) cube([100,100,10],center=true);
		translate([0,42,32]) cube([50*2,10*2,50/2],center=true);
        //holes for the magnets
        translate([65/2+2,65/2+2,-0.8]) cylinder(r=2,h=5);
        translate([65/2+2,-65/2-2,-0.8]) cylinder(r=2,h=5);
        translate([-65/2-2,65/2+2,-0.8]) cylinder(r=2,h=5);
        translate([-65/2-2,-65/2-2,-0.8]) cylinder(r=2,h=5);
	}
}
render() fan_cover();
