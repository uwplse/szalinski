// Designed by Glen Chung, 2014
// License: http://creativecommons.org/licenses/by-nc/3.0/

include <MCAD/boxes.scad>
include <MCAD/nuts_and_bolts.scad>

/* [Global] */

//handle bar diameter
diameter = 15; //[8:35]

//mount angle
angle = 0; //[-65:70]

//mount length
length = 1.5; //[1.5:200]


/* [Hidden] */
handle_bar(bar_dia=diameter, length=length, angle=angle);

$fn=100;
tolerance=0.4;

module handle_bar(bar_dia=15, length=1.5, angle=0, bar_dia_extra=0.6) {
	outter_dia=bar_dia+10;
	thick=15;

	difference() {
		union() {
			cylinder(r=(outter_dia+bar_dia_extra)/2, h=thick);


			translate([-(outter_dia)/2,0,0])
			translate([(bar_dia+10)/2,(outter_dia/2+6)/2,thick/2])
			rotate([90,0,90])
			roundedBox([outter_dia/2+6, thick, outter_dia], 2, true);
			translate([-outter_dia/2,0,0])
			cube([outter_dia,5,thick]);

			if(1) 
			rotate([0,0,angle]) difference() {
				union() {
					if(1) translate([0,-(outter_dia+bar_dia_extra)/2-thick/2-length,15/2])
					rotate([0,90,0])
					cylinder(r=thick/2, h=14.6, center=true);

					if(1) translate([-14.6/2, -(outter_dia+bar_dia_extra)/2-thick/2-length, 0])
					cube([14.6, -(-(outter_dia+bar_dia_extra)/2-thick/2-length), 15]);


					if(1)translate([-14.6/2, -(outter_dia+bar_dia_extra)/2-thick/2-length, 15/2])
					rotate([0,0,180])
					difference() {
						scale([2,1,1])
						sphere(r=15/2);
						translate([-20, -10, -10])
						cube([20,20,20]);
						translate([4, -10, -10])
						cube([20,20,20]);
					}
				}

				for(disp=[3.1, -3.1])
				translate([-3.5/2+disp, -18-3-(outter_dia+bar_dia_extra)/2-thick/2-length, -10])
				cube([3.5, 30, 40]);

				if(1) translate([-12.5, -(outter_dia+bar_dia_extra)/2-thick/2-length, 15/2])
				rotate([0,90,0])
				boltHole(size=5, length=35, tolerance=0.3);

				translate([-(14.6/2+10/2), -(outter_dia+bar_dia_extra)/2-thick/2-length, 15/2])
				rotate([0,90,0])
				cylinder(r=4.8, h=10, $fn=6, center=true);

			}

			if(1)translate([(outter_dia-1)/2, outter_dia/2-2, 15/2])
			difference() {
				scale([2,1,1])
				sphere(r=15/2);
				translate([-20, -10, -10])
				cube([20,20,20]);
				translate([4, -10, -10])
				cube([20,20,20]);
			}
		}

		translate([0,0,-7.5])
		cylinder(r=(bar_dia+bar_dia_extra)/2, h=7.5*2*2);

		translate([-(bar_dia-0.5)/2,0,-7.5])
		cube([(bar_dia-0.5), 30,7.35*2*2]);

		translate([30, outter_dia/2-2,7.5])
		rotate([180,90,0])
		boltHole(size=5, length=100, tolerance=tolerance);


		translate([outter_dia/2+10/2, outter_dia/2-2, thick/2])
		rotate([0,90,0])
		cylinder(r=5, h=10, $fn=6, center=true);

		translate([outter_dia/2, outter_dia/2-2, thick/2])
		translate([-10, 0, -5.2/2])
		cube([20, 20, 5.2]);


		if(0) translate([-100, -100, 8])
		cube([200, 200, 200]);

	}

	//supports
	{

		translate([(bar_dia-0.5)/2, outter_dia/2+5.8, 15/2-(5.2+1)/2])
		cube([(outter_dia-(bar_dia-0.5))/2, 0.2, 5.2+1]);

		translate([(bar_dia-0.5)/2, outter_dia/2-0.7, 15/2-(5.2+1)/2])
		cube([(outter_dia-(bar_dia-0.5))/2, 0.2, 5.2+1]);

		translate([(bar_dia-0.5)/2, outter_dia/2+2.1, 15/2-(5.2+1)/2])
		cube([8.75, 0.2, 5.2+1]);

		translate([outter_dia/2, outter_dia/2+4.5, 4.8])
		cube([3.45, 0.2, 5.4]);
	}

}


