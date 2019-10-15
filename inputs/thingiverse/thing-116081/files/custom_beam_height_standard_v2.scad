//design and code by emanresu (http://www.thingiverse.com/Emanresu)



  ////////////////
 // Parameters //
////////////////

/* [Global] */

/* [Target] */

//beam height (mm)
beam_height = 100;
//diameter of the alignment hole(mm)
aperture_diameter = 2;
//width of crosshairs (mm)
crosshair_width = 0.8;
//depth of crosshairs (mm)
crosshair_depth = 0.8;
//thickness of beam target (mm)
thick=3;
//width of beam target (mm)
width=25;

/* [Base] */

//thickness of base (mm)
base_thick = 8;
//length of base (mm)
base_length = 30;
//Magnet holders?
magnet_hole = "yes"; //[yes,no]
//what is the diameter of your magnets? (mm)
magnet_hole_diameter = 6.9;
//thickness of material under magnet (mm)
magnet_hole_bottom = 0.8;


/* [Hidden] */

//Set openSCAD resolution
$fa=1;
$fs=0.5;



  /////////////
 // Modules //
/////////////

module beam_target() {
	// body...
	difference() {
		cylinder(r=width/2, h=thick+crosshair_depth, center=true);
		cylinder(r=width/2-1, h=thick+crosshair_depth+1, center=true);
	}
	difference() {
		union() {
			cylinder(r=width/2, h=thick, center=true);
			cube(size=[crosshair_width, width, thick+crosshair_depth], center=true);
			cube(size=[width, crosshair_width, thick+crosshair_depth], center=true);
		}
		cylinder(r=aperture_diameter/2, h=thick+2, center=true);
	}	
}

module beam_height_target() {
	// body...
	union() {
		translate([0, 0, beam_height-base_thick]) {
			rotate([0, 90, 0]) {
				beam_target();
			}
		}
		difference() {
			translate([0, 0, (beam_height-base_thick)/2]) {
				cube(size=[thick, width, beam_height-base_thick], center=true);	
			}
			translate([0, 0, beam_height-base_thick]) {
				rotate([0, 90, 0]) {
					cylinder(r=width/2, h=thick+1, center=true);
				}
			}
		}	
	}	
}

module base() {
	// body...
	difference() {
		cube(size=[base_length, width, base_thick], center=true);
		if (magnet_hole == "yes") {
			translate([base_length/4, 0, magnet_hole_bottom]) {
				cylinder(r=magnet_hole_diameter/2, h=base_thick, center=true);
			}
			translate([-base_length/4, 0, magnet_hole_bottom]) {
				cylinder(r=magnet_hole_diameter/2, h=base_thick, center=true);
			}
		}	
	}	
}

  //////////////////
 // Control Code //
//////////////////

translate([0, 0, base_thick]) {
	beam_height_target();
}
translate([0, 0, base_thick/2]) {
	base();
}





