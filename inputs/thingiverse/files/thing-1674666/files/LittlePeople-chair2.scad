// 
// LittlePeople chair, teeter totter
//

initial = "H"; // [A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z]
toy     = "Chair"; // [Chair, Teeter Totter]

module little_people_base() {
	nub_height = 6;
	nub_angle = 5;
	nub_width  = 1.2;
	
	union() {
		// for Little People Princess style
		difference() {
			cylinder(d1=34, d2=45, h=10);
		
			translate([0,0,2]) 
				cylinder(d=32.5, h=10);
		}
		// for standard Little People
		cylinder(d1=14.55, d2=13.25, h=8);

		rotate([nub_angle, 0, 0])
			translate([0,13.75/2, 0]) 
				union() {

					translate([0, .05, 5.2])
						rotate([90,0,90])
							cylinder(d=4.25, h=nub_width);
					cube([nub_width, 2, nub_height]);
				}
		rotate([nub_angle, 0, 120])
			translate([0,13.75/2, 0]) 
			union() {

					translate([0, .05, 5.2])
						rotate([90,0,90])
							cylinder(d=4.25, h=nub_width);
					cube([nub_width, 2, nub_height]);
				}
		rotate([nub_angle, 0, 240])
			translate([0,13.75/2, 0]) 
			union() {

					translate([0, .05, 5.2])
						rotate([90,0,90])
							cylinder(d=4.25, h=nub_width);
					cube([nub_width, 2, nub_height]);
				}
	}
}


module little_people_negative() {
	union() {
		translate([0,0,10]) 
			cylinder(d=45, h=50);
		
		translate([0,0,2]) 
			cylinder(d=32.5, h=9);
	}
}
/*
cylinder(d=40, h=5);
translate([0,0,3])
	linear_extrude(height = 11, center = true)
		text("A", 20, font="Arial", halign="center", valign="center"); /*, spacing,
     direction, language, script)
*/

if (toy == "Chair") { // [Chair, Teeter Totter]
	// Simple chair back
	union() {
		little_people_base();
		difference() {
			rotate([110,0,0]) 
				translate([0,32,13])
					scale([1,1.25,1])
						union () {
							cylinder(d=40, h=5);
							translate([0,0,4])
								linear_extrude(height = 6, center = true)
									text(initial, 25, font="Arial", halign="center", valign="center");
							 }
			little_people_negative();
		}
	}
}

// Cut away to ease designing
//difference() {
//	cube(30,1);
//	little_people_negative();
//}
//little_people_base();

if (toy == "Teeter Totter") {

	// teeter totter
	translate([-17,-17, 0])
		cube([150, 34, 5]);
	translate([0,0,5]) 
		little_people_base();
	translate([117,0,5])
		little_people_base();

	translate([0,64,0])
		rotate([90,0,0])
		difference() {
			cylinder(d=20, h=34);
			translate([-10,-20,-1])
				cube([20,20,36]);
		}
}
