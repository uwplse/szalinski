/*
Tripod leg clamp replacement
Jan 25, 2015
Corky Mork
*/
//Duiameter of larger leg (mm)
diameter1=27.5;//
//Duiameter of smaller leg (mm)
diameter2=23;//
//Diameter of screw holes (mm)
hole=5;//
//Size of nut or hex head (mm)
nut=8.5;//
/* [Hidden] */
height=26.5;
thick=5;
gap=2;
tab=12;


module tripodclamp()
{
	difference() {
		union() {			
//body
			cylinder(h = height, r = diameter1/2+thick, center = true);
//tab
		translate ([thick,diameter1/2+tab/2,0])
				 cube([thick*3+gap, tab+2*thick, height], center = true);
		}

		union() {
			translate ([0,0,height/4])
				cylinder(h = height/2+1, r = diameter1/2, center = true);
			cylinder(h = height+1, r = diameter2/2, center = true);
//screw holes
			rotate([0,90,0])
			translate([height/4,diameter1/2+tab/2+thick,gap])
				cylinder(h = thick*5, r = hole/2, center = true,$fn=12);
			rotate([0,90,0])
			translate([-height/4,diameter1/2+tab/2+thick,gap])
				cylinder(h = thick*5, r = hole/2, center = true,$fn=12);
//nut traps
			rotate([0,90,0])
			translate([height/4,diameter1/2+tab/2+thick,2*thick+gap])
				cylinder(h = thick+gap, r = nut*.577, center = true,$fn=6);
			rotate([0,90,0])
			translate([-height/4,diameter1/2+tab/2+thick,2*thick+gap])
				cylinder(h = thick+gap, r = nut*.577, center = true,$fn=6);
//slots
			translate ([gap/2,diameter1/2+1.5*thick,0])
				 cube([gap, diameter1/2+tab+thick, height+1], center = true);
			translate ([0,diameter1/4+thick/2+tab/2,0])
				 cube([diameter1+2*thick+1, diameter1/2+tab+thick, gap], center = true);
		}
	}
}

tripodclamp();
