/**
 *
 * RotorPrint, customizable landing gear adapter
 * Made by Dave de Fijter - 2013
 *
**/

// preview[view:south east, tilt:side]

/* [Global] */

what_part = "adapter"; // [adapter, stopper]

// The length of the landing gear part, the longer the more rigid
shaft_length = 60;

// The inner diameter of the part, should be about the same as the outer diameter of your tubes.
inner_diameter = 12;

// The thickness of the walls, the thicker the stronger, but might look very bulky if you overdo this.
wall_thickness = 3;

// The diameter of the screw hole, use 0 for no holes
screw_diameter = 3;

/* [Hidden] */

$fn = 50;

choose_part();

module choose_part() {

	if(what_part == "adapter") {
		adapter();
	} else {
		landing();
	}
}

module landing() {
	difference() {
		union() {
			difference() {
				cube([shaft_length+inner_diameter*2, inner_diameter + 2*wall_thickness, inner_diameter + 2*wall_thickness]);
				
				translate([0-wall_thickness, wall_thickness, wall_thickness]) {
					cube([shaft_length+wall_thickness, inner_diameter, inner_diameter]);
				}
			}
			
			difference() {
			
				translate([shaft_length+inner_diameter*1.0, wall_thickness + (inner_diameter/2),  wall_thickness + (inner_diameter/2)]) {
					sphere(r=inner_diameter*1.5);
				}
	
				translate([shaft_length + inner_diameter*1.0, wall_thickness + (inner_diameter / 2),  wall_thickness + (inner_diameter / 2)]) {
					rotate([0, 45, 0]) {
						translate([-1.5*inner_diameter, 0, 0]) {
							cube(inner_diameter*3, center=true);
						}
					}
				}	
	
				
			}
	
		}
		
		if(screw_diameter > 0) {
			translate([shaft_length / 2, inner_diameter + (3*wall_thickness), wall_thickness+(inner_diameter/2)]) {
				rotate(90, [1, 0, 0]) {
					cylinder(r=screw_diameter/2, h=(inner_diameter + (4 * wall_thickness)));
				}
			}
		}
	}
}

module adapter() {
	difference() {
		difference() {
			
			union() {
				difference() {
				
					difference() {
						hull() {  outlines(false); }
						outlines(false);
					}
					translate([0, -1, 0]) {
						scale([0.9, 1.1, 0.95]) {
							difference() {
								hull() {  outlines(false); }
								outlines(false);
							}
						}
					}
				}
				
				
				
				difference() {
					outlines(false);
					outlines(true);
				}
			}
			
			
			union() {
		
				if(screw_diameter > 0) {
					translate([shaft_length / 2, inner_diameter + (3*wall_thickness), wall_thickness+(inner_diameter/2)]) {
						rotate(90, [1, 0, 0]) {
							cylinder(r=screw_diameter/2, h=(inner_diameter + (4 * wall_thickness)));
						}
					}
					
					rotate(45, [0, 1, 0]) {
						translate([shaft_length / 1.5, inner_diameter + (3*wall_thickness), wall_thickness+(inner_diameter/2)]) {
							rotate(90, [1, 0, 0]) {
								cylinder(r=screw_diameter/2, h=(inner_diameter + (4 * wall_thickness)));
							}
						}
				}
				}
		}
		}
		
		outlines(true);
	
	}
}

module outlines(render_inner) {

if(render_inner) {

		translate([-5, wall_thickness, wall_thickness]) {
			cube([shaft_length + 50, inner_diameter, inner_diameter]);
		}
	
	
		translate([0 + inner_diameter, wall_thickness, (wall_thickness + wall_thickness/2) - inner_diameter]) {
			rotate(45, [0, 1, 0]) {
				cube([shaft_length + 15, inner_diameter, inner_diameter]);			
			}
		}

} else {
	cube([shaft_length, inner_diameter + wall_thickness*2, inner_diameter + wall_thickness*2]);

	translate([0, 0, 0]) {
		rotate(45, [0, 1, 0]) {
			cube([shaft_length-wall_thickness*2, inner_diameter + wall_thickness*2, inner_diameter + wall_thickness*2]);
		}	
	}
}


}


//cube(inner_diameter + wall_thickness