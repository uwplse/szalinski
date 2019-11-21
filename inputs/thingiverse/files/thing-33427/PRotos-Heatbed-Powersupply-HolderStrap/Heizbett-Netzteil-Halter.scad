// Created by Simon Brüchner - public domain


// Inner dimensions
LENGTH        = 53.6;
WIDTH         = 22;
HEIGHT        = 37.4;


// Botton hole at the top
BUTTON_LENGTH = 21.0;
BUTTON_WIDTH  = 15.1;

// Screw diameter
SCREWHOLE     = 2;

WALL          = 2;
SPAN          = WIDTH / 4;



rotate([0,-90,0]) {
	difference() {
		union() {
	      color("yellow") translate([0,-WALL/2,0])  cube([WIDTH, LENGTH+(2*WALL), HEIGHT+WALL]);
			color("pink") translate([0,-SPAN-WALL/2,0]) cube([WIDTH, LENGTH+(2*(WALL+SPAN)), WALL]);
			color("green") translate([WIDTH/2,-WALL/2-SPAN,0]) cylinder(r=WIDTH/2, h=WALL);
			color("gray") translate([WIDTH/2,LENGTH+SPAN+WALL+WALL/2,0]) cylinder(r=WIDTH/2, h=WALL);
		}
		union() {
			color("red")  translate([-1,WALL/2,-1]) cube([WIDTH+2, LENGTH, HEIGHT+1]);
			color("blue") translate([(WIDTH / 2) - (BUTTON_WIDTH / 2), (LENGTH / 2) - (BUTTON_LENGTH / 2)+WALL/2, HEIGHT -1]) cube([BUTTON_WIDTH, BUTTON_LENGTH, WALL+2]);
	
			translate([WIDTH/2,-WALL/2-SPAN,-1]) cylinder(r=SCREWHOLE/2+0.2, h=WALL+2);	translate([WIDTH/2,LENGTH+SPAN+(1*WALL)+WALL/2,-1]) cylinder(r=SCREWHOLE/2+0.2, h=WALL+2);
		}
	}
}

$fn=100; 


