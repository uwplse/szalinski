//design and code by emanresu (http://www.thingiverse.com/Emanresu)
//generates a simple tray with standoffs for an arduino to sit in


//CUSTOMIZER VARIABLES

//arduino type
arduino_type = "Uno"; //[Uno,Mega]

//thickness of side walls and bottom (mm)
thick = 1.6;
//height of side walls (mm)
wall_height = 15;
//height of standoff (mm)
standoff_height = 7;
//standoff hole diameter (mm)
standoff_hole_diameter = 2.9;
//standoff thickness (mm)
standoff_thick = 1.6;
//clearance between arduino and sidewalls (mm)
clearance = 1.5;


/* [Hidden] */

//sets openSCAD resolution for nice, round holes
$fa=1;
$fs=0.5;


   ///////////////
  //  Modules  //
 ///////////////

module Arduino_standoffs() {
	// body...
	//arranging standoffs
	translate([13.97, 2.54, standoff_height/2]) {
		difference() {
			cylinder(r=standoff_hole_diameter/2+standoff_thick, h=standoff_height, center=true);
			cylinder(r=standoff_hole_diameter/2, h=standoff_height+1, center=true);
		}	
	}
	translate([15.24, 50.8, standoff_height/2]) {
		difference() {
			cylinder(r=standoff_hole_diameter/2+standoff_thick, h=standoff_height, center=true);
			cylinder(r=standoff_hole_diameter/2, h=standoff_height+1, center=true);
		}	
	}
	translate([66.04, 7.62, standoff_height/2]) {
		difference() {
			cylinder(r=standoff_hole_diameter/2+standoff_thick, h=standoff_height, center=true);
			cylinder(r=standoff_hole_diameter/2, h=standoff_height+1, center=true);
		}	
	}
	translate([66.04, 35.56, standoff_height/2]) {
		difference() {
			cylinder(r=standoff_hole_diameter/2+standoff_thick, h=standoff_height, center=true);
			cylinder(r=standoff_hole_diameter/2, h=standoff_height+1, center=true);
		}	
	}
	
	if (arduino_type == "Mega") {
		//adds extra standoffs for Mega, if specified
		translate([90.17, 50.8, standoff_height/2]) {
			difference() {
				cylinder(r=standoff_hole_diameter/2+standoff_thick, h=standoff_height, center=true);
				cylinder(r=standoff_hole_diameter/2, h=standoff_height+1, center=true);
			}	
		}
		translate([96.52, 2.54, standoff_height/2]) {
			difference() {
				cylinder(r=standoff_hole_diameter/2+standoff_thick, h=standoff_height, center=true);
				cylinder(r=standoff_hole_diameter/2, h=standoff_height+1, center=true);
			}	
		}	
	}
}

module Arduino_case_body() {
	// body...
	
	//sets length for type of arduino specified, 101.6 mm for Mega, 68.58 mm for Uno
	base_x = (arduino_type == "Mega" ? 101.6 : 68.58);
	
	difference() {
		cube(size=[base_x+2*thick+2*clearance, 53.34+2*thick+2*clearance, wall_height+thick], center=false);
		translate([thick, thick, thick]) {
			//main compartment
			cube(size=[base_x+2*clearance, 53.34+2*clearance, wall_height+1], center=false);
		}
		translate([thick/2, 7.62+thick+clearance, wall_height/2+thick+standoff_height]) {
			//power plug gap
			cube(size=[thick+1, 8.89+2*clearance, wall_height], center=true);
		}
		translate([thick/2, 38.1+thick+clearance, wall_height/2+thick+standoff_height]) {
			//USB plug gap
			cube(size=[thick+1, 11.43+2*clearance, wall_height], center=true);
		}
	}	
}


   ////////////////////
  //  Control Code  //
 ////////////////////

union() {
	//Joins case body with standoffs
	Arduino_case_body();
	translate([thick+clearance, thick+clearance, thick]) {
		Arduino_standoffs();
	}
}
