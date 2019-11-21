// Designed by Glen Chung, 2014
// License: http://creativecommons.org/licenses/by-nc/3.0/

include <MCAD/boxes.scad>
include <MCAD/nuts_and_bolts.scad>

/* [Global] */

//knob length
length = 36; //[14:43]

//tolerance
tolerance = 0.4;



/* [Hidden] */
$fn=100;

knob(length);

module knob(total_length=14) {
	r=12.0;
	s1=0.95;
	s2=1.9;
	nut_r=4.5;
	length=total_length-9.8;


	difference() {
		union() {
			translate([0,0,length-3.2])
			intersection() {
				difference() {
					translate([0,0,r*s2-1.2])
					intersection() {
						scale([s1,s1,s2])
						sphere(r=r);

						scale([s1*0.93,s1*0.93,s2*1.25])
						sphere(r=r);

					}

					translate([-25,-25,13])
					cube([50,50,50]);

					for(a=[0,90,180,270])
					{
						rotate([0, 1.5, a])
						translate([r+0.35, 0, 0]) scale([1,1.4,1])
						cylinder(r=r/2, r*2);

						rotate([0, 0, a])
						translate([r, 0, 1.31*r]) scale([1,1.6,1])
						rotate([0,-45,0])
						cylinder(r=r/2, r*2);

					}
				}

				translate([0,0,r/3])
				scale([1.2,1.2,1])
				sphere(r=r);
			}

			cylinder(r1=6, r2=6.4, h=length);

		}

		translate([0,0, 20+4])
		rotate([0,0,45])
		cylinder(r1=(nut_r+tolerance/2), r2=r/2, h=40, $fn=6, center=true);

		translate([0,0,-1])
		boltHole(size=5, length=35, tolerance=0.2);
	}

	for(ang=[0, 60, 120, 180, 240, 300])
	rotate([0,0,ang+45-60/2])
	translate([nut_r-0.15,0,2+4+4])
	rotate([0,2.5,0])
	scale([0.4,0.4,2])
	sphere(r=2, h=1);

}


