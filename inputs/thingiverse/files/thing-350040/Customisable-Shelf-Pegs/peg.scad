// Diameter of hole in side board of bookcase or wardrobe
hole_diameter = 7; 

// Deep of hole
hole_deep = 10;

// Length of outer part of peg
length = 12;

intersection() {
	union() {
		translate([-hole_deep+1,0,0]) rotate([0,-90,0]) cylinder(r1=hole_diameter/2, r2=hole_diameter/2-1, h=1);
		rotate([0,-90,0]) cylinder(r=hole_diameter/2, h=hole_deep-1);
		difference() {
			translate([0,-hole_diameter/2,-hole_diameter/2]) cube([length,length,hole_diameter]);
			translate([length*0.7+0.5,0,0]) rotate([0,0,45]) translate([0,-50,-50]) cube([100,100,100]);
		}
		translate([0,-hole_diameter/2-2,-hole_diameter/2]) cube([1,length,hole_diameter]);
	}
	cube([100,100,hole_diameter-0.2], center=true);
}

