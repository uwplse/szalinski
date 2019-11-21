//design and code by emanresu (http://www.thingiverse.com/Emanresu)
//generates clampable mounts for a NEMA 17 syle stepper motor



//CUSTOMIZER VARIABLES

//Clamp Type
type = "90 degree";//[90 degree, 180 degree, 45 degree, Multi]
//Clamp Thickness (mm)
thick = 1.6;
//Shaft height (mm)
shaft_height = 21;// 21:10000000
//width of clamp base (mm);
width=42; //42:10000000
//do you want the motor plate the same width as the clamp?
mount_flush="yes";//[yes,no]
//how do you want the motor mount justified with respect to the clamp?
//length of 90º base of clamp (mm)
base_1 = 50;
//length of 180º or 45º base of clamp (mm)
base_2 = 30;
//length of 180º base in multi-clamp (mm)
base_3 = 30;


/* [Hidden] */

//Sets openSCAD resolution for nice round holes
$fa=1;
$fs=0.5;

//NEMA 17 Parameters
Nema_square = 42;
Nema_hole_offset = 31;
Nema_mount_hole_diameter = 3.6;//clearance for M3 screws
Nema_center_hole_diameter = 23;

Nema_mount_hole_radius = Nema_mount_hole_diameter/2;
Nema_center_hole_radius = Nema_center_hole_diameter/2;


   ///////////////
  //  Modules  //
 ///////////////

module NEMA17_plate() {
	// Generates mounting plate  with the necessary clearance holes for a NEMA 17 style motor
	
	difference() {
		//plate body
		cube(size=[Nema_square, Nema_square, thick], center=true);
		
		//center hole
		cylinder(r=Nema_center_hole_radius, h=thick+2, center=true);
		
		//clearance holes for M3 screws
		translate([Nema_hole_offset/2, Nema_hole_offset/2, 0]) {
			cylinder(r=Nema_mount_hole_radius, h=thick+1, center=true);
		} 
		translate([-Nema_hole_offset/2, Nema_hole_offset/2, 0]) {
			cylinder(r=Nema_mount_hole_radius, h=thick+1, center=true);
		}
		translate([-Nema_hole_offset/2, -Nema_hole_offset/2, 0]) {
			cylinder(r=Nema_mount_hole_radius, h=thick+1, center=true);
		}
		translate([Nema_hole_offset/2, -Nema_hole_offset/2, 0]) {
			cylinder(r=Nema_mount_hole_radius, h=thick+1, center=true);
		}
	}
}


module 90deg_clamp() {
	// makes a simple 90º clamp for a NEMA 17 style motor
	
	//defines spacer for shaft_height parameter
	//sets minimum value allowed for shaft height
	delta = (shaft_height >= 21 ? abs(shaft_height-Nema_square/2) : 0);
	
	//sets minimum value allowed for the base width
	base_width = (width - Nema_square > 0 ? width : Nema_square);
	
	//determines if mount plate is flush with the rest of the clamp
	test_width = (mount_flush == "yes" ? (abs(width-Nema_square)/2) : 0);
	ex_width = (width-Nema_square > 0 ? test_width : 0);

	union() {
		//joining the parts of the clamp together
		translate([-21-delta, 0, thick/2]) {
			//positions motor mount
			NEMA17_plate();
		}
		translate([-delta/2, 0, thick/2]) {
			//spacer for motor height
			cube(size=[delta, 42, thick], center=true);
		}
		translate([-(42+delta)/2, 21+ex_width/2, thick/2]) {
			//wings for making plate flush
			cube(size=[42+delta, ex_width, thick], center=true);
		}
		translate([-(42+delta)/2, -21-ex_width/2, thick/2]) {
			//wings for making plate flush
			cube(size=[42+delta, ex_width, thick], center=true);
		}
		translate([0, 0, base_1/2]) {
			//90º clamp base
			cube(size=[thick, base_width, base_1], center=true);
		}
	}
}


module 180deg_clamp() {
	// makes a simple 180º clamp for a NEMA 17 style motor
	
	union() {
		//joins 90º clamp with an additional base to make the 180º clamp
		translate([-base_1-thick/2, 0, thick/2]) {
			rotate([0, 90, 0]) {
				//reorients the 90º clamp so the 180º clamp is printable
				90deg_clamp();
			}
		}
		translate([0, 0, base_2/2]) {
			//adding the 180º base to the clamp
			cube(size=[thick, width, base_2], center=true);
		}
	}	
}


module 45deg_clamp() {
	// makes a simple 45º clamp for a NEMA 17 style motor
	
	translate([0, 0, width/2]) rotate([-90, 0, 0]) {
		//Positions clamp for printing
		union() {
			//joins 90º clamp with an additional base to make the 45º clamp
			translate([-base_1, 0, thick/2]) {
				rotate([0, 90, 0]) {
					90deg_clamp();
				}
			}
			rotate([0, -45, 0]) {
				//adding the 45º base to the clamp
				translate([base_2/2, 0, thick/2]) {
					cube(size=[base_2, width, thick], center=true);
				}
			}	
		}
	}	
}


module Multi_clamp() {
	// makes a multi clamp (one with 45º, 90º and 180º clamping surfaces) for a NEMA 17 style motor
	
	beta = base_2*sin(45);
	
	union() {
		//joins a 45º clamp with an additional base to make the multi clamp
		45deg_clamp();

		translate([beta-thick, beta, 0]) {
			//adding the 180º base to the multi-clamp
			cube(size=[thick, base_3, width], center=false);
		}
	}	
}


   ////////////////////
  //  Control Code  //
 ////////////////////



if (type == "90 degree") {
	90deg_clamp();
}
if (type == "45 degree") {
	45deg_clamp();
}
if (type == "180 degree") {
	180deg_clamp();
}
if (type == "Multi") {
	Multi_clamp();
}
 