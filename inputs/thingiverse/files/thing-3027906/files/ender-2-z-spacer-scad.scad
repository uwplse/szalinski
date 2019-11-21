bolt_hole_diameter = 4.6; // [4.0:0.1:5]
z_spacer_thickness = 1.0; // [1:0.1:10]

/* [Hidden] */

$fn = 100;

x1 = 40;
y1 = 16;

d2 = bolt_hole_diameter;

h1 = z_spacer_thickness; 



difference() {
	linear_extrude(height=h1) square([x1,y1]);
	
	translate([x1/4,y1/2,-0.1]) cylinder(h=h1+1,d=d2);
	translate([x1/4*3,y1/2,-0.1]) cylinder(h=h1+1,d=d2);

}



