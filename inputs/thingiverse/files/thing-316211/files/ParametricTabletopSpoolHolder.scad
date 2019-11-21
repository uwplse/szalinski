/**
 * PARAMETRIC TABLETOP SPOOL HOLDER
 * 
 * @author	Pacien TRAN-GIRARD
 * @version	1.1
 * @license	CC BY-NC-SA 3.0
 */


/***** PARAMETERS *****/

material_thickness = 1.5;
material_space = 0.35;
material_eco = true;

rod_length = 150;
rod_radius = 8;

pillar_height = 120;

base_height = 25;
base_length = 150;


/***** TO PRINT *****/

// preview_all();

print_all();

// print_base();
// print_coupler();
// print_rod();
// print_pillar();



/********** This is where it gets complicated **********/



/***** MODELS *****/


module print_all() {
	
	space=5;

		print_pillar();

		translate([0, 2*rod_radius+2*(material_thickness+material_space)+space, 0]) {

			print_pillar();

			translate([0, 2*rod_radius+2*(material_thickness+material_space)+space, 0]) {

				print_base();

				translate([0, 2*rod_radius+2*(material_thickness+material_space)+space, 0]) {

					print_base();

					translate([0, 2*rod_radius+2*(material_thickness+material_space)+space, 0]) {

						print_rod();

						translate([0, rod_radius*2+space, 0]) {

							print_coupler();

						}
					}
				}
			}
		}

}

module preview_all() {

	translate([	-(rod_radius+material_thickness+material_space),
					material_thickness+material_space,
					material_thickness+material_space]) {

		sized_pillar();

		translate([0, rod_length+2*(material_thickness+material_space), 0]) {
			mirror([0, 1, 0]) {
				sized_pillar();
			}
		}

		translate([	rod_radius+material_thickness+material_space,
						material_thickness+material_space,
						pillar_height]) {
			rotate([0, 0, 90]) {
				sized_rod();
			}
		}
	
	}
	
	sized_base();

	translate([0, rod_length+4*(material_thickness+material_space), 0]) {
		mirror([0, 1, 0]) {
			sized_base();
		}
	}

	translate([-rod_radius, 2*(material_thickness+material_space), 0]) {
		sized_coupler();
	}

}


/***** MODULE TRANSLATING *****/

module print_base() {
	translate([base_length/2, 0, 0]) {
		sized_base();
	}
}

module print_coupler() {
	translate([rod_length, 0, 4*(material_thickness+material_space)]) {
		rotate([0, 0, 90]) {
			mirror([0, 0, 1]) {
				sized_coupler();
			}
		}
	}
}

module print_rod() {
	translate([0, rod_radius, rod_radius]) {
		sized_rod();
	}
}

module print_pillar() {
	rotate([90, 0, 90]) {
		sized_pillar();
	}
}


/***** MODULE SIZING *****/

module sized_base() {
	base(	base_length,
				2*rod_radius+2*(material_thickness+material_space),
				base_height,
				material_thickness,
				material_space,
				material_eco
	);
}

module sized_coupler() {
	coupler(rod_length, 2*rod_radius, material_thickness, material_space, material_eco);
}

module sized_rod() {
	rod(rod_length, rod_radius);
}

module sized_pillar() {
	pillar(	2*rod_radius+2*(material_thickness+material_space),
				2*rod_radius,
				pillar_height,
				material_thickness,
				rod_radius+material_space,
				material_eco);
}


/***** MODULES *****/

module base(length, width, height, material_thickness, material_space, material_eco) {
	
	half_base(length/2, width, height, material_thickness, material_space, material_eco);
	
	mirror([1, 0, 0]) {
		half_base(length/2, width, height, material_thickness, material_space, material_eco);
	}
	
}

module half_base(length, width, height, material_thickness, material_space, material_eco) {
	
	difference() {
		
		prism(width, length, height);
		
		translate([0, material_thickness, material_thickness]) {
			cube([width/8+material_space, width, height]);
			
			cube([width/2+material_space, width-2*material_thickness, height]);

			if (material_eco == true) {
				translate([width/2+material_thickness+material_space, 0, 0]) {
					cube([length, width-2*material_thickness, height]);
				}
			}

		}

	}
	
}

module pillar(length, width, height, material_thickness, rod_slot, material_eco) {
	
	coupler_slot_height = 2*(material_thickness+material_space)+2*material_space;
	length_inside = length-2*material_thickness;
	width_inside = width-material_thickness;

	difference() {
		
		cube([length, width, height]);

		translate([material_thickness, material_thickness, material_thickness]) {
			cube([length_inside, width_inside, coupler_slot_height]);
		}
		
		translate([material_thickness, material_thickness, height-rod_slot]) {
			cube([length_inside, width_inside, rod_slot]);
		}
		
		if (material_eco == true) {
			translate([material_thickness, material_thickness, coupler_slot_height+2*material_thickness]) {
				cube([length_inside, width_inside, height-coupler_slot_height-(3*material_thickness+rod_slot)]);
			}
		}
		
	}
	
}

module coupler(length, width, material_thickness, material_space, material_eco) {

	half_coupler(length/2, width, material_thickness, material_space, material_eco);

	translate([0, length, 0]) {
		mirror([0, 1, 0]) {
			half_coupler(length/2, width, material_thickness, material_space, material_eco);
		}
	}

}

module half_coupler(length, width, material_thickness, material_space, material_eco) {

	height = 4*(material_thickness+material_space);
	width_inside = width-2*material_thickness;

	difference() {

		cube([width, length, height]);

		cube([width, width-material_thickness, 2*(material_thickness+material_space)]);

		translate([0, width-(material_thickness+material_space), 0]) {

			cube([width, material_thickness+2*material_space, material_thickness+material_space]);

			cube([width/2-(width/8+material_space), material_thickness+2*material_space, height]);

			translate([width/2+(width/8+material_space), 0, 0]) {
				cube([width/2-(width/8+material_space), material_thickness+2*material_space, height]);
			}
				
		}

		if (material_eco == true) {

			translate([material_thickness, material_thickness, 0]) {
				cube([width_inside, width-(3*material_thickness+material_space), height-material_thickness]);
			}
		
			translate([material_thickness, width+material_thickness+material_space, 0]) {
				cube([width_inside, length-(width+material_thickness+material_space), height-material_thickness]);
			}
		
		}
		
	}
}

module rod(length, radius) {
	
	rotate([0, 90, 0]) {
		cylinder(h=length, r=radius, $fn=5*radius);
	}
	
	translate([0, -radius, -radius]) {
		cube([length, 2*radius, radius]);
	}

}


/***** THIRD PARTY *****/

//https://github.com/dannystaple/OpenSCAD-Parts-Library/blob/master/prism.scad
//Draw a prism based on a 
//right angled triangle
//l - length of prism
//w - width of triangle
//h - height of triangle
module prism(l, w, h) {
	translate([0, l, 0]) rotate( a= [90, 0, 0]) 
	linear_extrude(height = l) polygon(points = [
		[0, 0],
		[w, 0],
		[0, h]
	], paths=[[0,1,2,0]]);
}
