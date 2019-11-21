// Manual customizable clock
// Vilem Marsik, 2019
// CC BY-NC-SA 
// https://creativecommons.org/licenses/by-nc-sa/4.0/

label="Next feeding at:";
base_thickness=1;
text_height=3;
hole_diameter=5;

/* [Hidden] */

r1=60;
r2=80;
color("#f4f")
	linear_extrude(base_thickness+text_height)	{
			translate([0,r2,0])
				text(label,halign="center");
			for(i=[1:12])	{
				a=30*i;
				rotate(-a)
					translate([0,r1,0])
						text(str(i),halign="center");
			}
	}

difference()	{
translate([-r2,-r2,0])
	color("white") cube([2*r2,2*r2+20,base_thickness]);
	translate([0,0,-1])
		cylinder(d=10,h=10);
	for(x=[-r1,r1])
		translate([x,r2+18-hole_diameter,-1])
			cylinder(d=hole_diameter,h=10);
}

module hand()	{
	hull()	{
		cylinder(h=3,d=14);
		translate([r1,0,0,])
			cylinder(h=3,d=1);
	}
	cylinder(d=14,h=8);
	cylinder(d=9,h=9);
	translate([0,0,9])	{
		difference()	{
			cylinder(d=9,h=5);
			cylinder(d=7,h=6);
			for(a=[0,90])
				rotate(a)
					translate([-7,-1,0])
						cube([14,2,6]);
			
		}
	}
}

if($preview)	{
	color("#f4f")
		translate([0,0,base_thickness+8.5])
		mirror([0,0,1])
		hand();
}
else
	translate([100,0,0])	
		hand();