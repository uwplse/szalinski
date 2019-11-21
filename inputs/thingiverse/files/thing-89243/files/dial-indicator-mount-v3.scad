//design and code by emanresu (http://www.thingiverse.com/Emanresu)
//dial indicator mount for a makerbot step-struder mk7

use <./MCAD/3d_triangle.scad>

// preview[view:east, tilt:top]


//CUSTOMIZER VARIABLES

//diameter of the sensor arm of the dial indicator (mm)
indicator_sensor_diameter=6.5;
//diameter of the mounting shaft of the dial indicator (mm)
indicator_mount_diameter = 9.9;
//length of the mounting shaft of the dial indicator (mm)
mount_depth = 18;
//diameter of clamping bolt (mm)
bolt_diameter=3.65;
//width of mounting block (mm)
block_width = 25; 
//offset of clamp along the center of the mounting block (mm)
offset = 3;  


/* [Hidden] */

//sets openSCAD resolution
$fa=1;
$fs=0.5;

//Clamp parameters
thick = 1.6;//thickness of clamp, bottom of clamp
gap = 1;//gap between tightening tabs on clamp

indicator_sensor_radius=indicator_sensor_diameter/2; //radius of the dial indicator's sensor shaft
indicator_mount_radius = indicator_mount_diameter/2;//radius of dial indicator's mounting shaft

//mounting block dimentions
//y dimention controled by block_with above
bm_x = 40; //width of stepstruder bar mount
bm_z = 9; //thickness of stepstruder bar mount

//mounting block holes (to line up with the stepstruder bar mount)
bm_hole_offset = 31.01/2; //how far the holes are from the center of the mounting block NEMA 17
bm_hole_diameter = 3.6;  //M3 bolt clearance hole diameter
bm_hole_radius = bm_hole_diameter/2;  //M3 bolt clearance hole radius

bolt_radius=bolt_diameter/2;//radius of tightening bolt


  /////////////
 // Modules //
/////////////

module DI_clamp() {
	//generates the dial indicator clamp, puts everything together
	union() {
		translate([0, offset, thick]) {
			clamp_cyl();
		}
		translate([0, 0, bm_z/2]) {
			difference() {
				mounting_block();
				translate([0, offset, thick]) {
					cylinder(r=indicator_mount_radius, h=bm_z, center=true);
				}
				translate([0, offset, 0]) {
					cylinder(r=indicator_sensor_radius, h=bm_z+1, center=true);
				}
			}	
		}	
	}
}

module mounting_block() {
	// generates the mounting block with holes to mount to a mk7 stepstruder
	difference() {
		cube(size=[bm_x, block_width, bm_z], center=true);
		translate([bm_hole_offset, 0, 0]) {
			rotate([90, 0, 0]) {
				cylinder(r=bm_hole_radius, h=block_width+1, center=true);
			}
		}
		translate([-bm_hole_offset, 0, 0]) {
			rotate([90, 0, 0]) {
				cylinder(r=bm_hole_radius, h=block_width+1, center=true);
			}
		}
	}
}

module clamp_cyl() {
	//makes a cylindric clamp with screw tabs to tighten it
	//radius determines the internal radius
	//depth determines the height
	//thick determines how thick it is, difference between external and internal radius
	//gap determines how large the gap in the clamp is
	union() {
		difference() {
			cylinder(r=indicator_mount_radius+thick, h=mount_depth, center=false);
			translate([0, 0, -0.5]) {
				cylinder(r=indicator_mount_radius, h=mount_depth+1, center=false);
			}
			translate([-gap/2, 0, -0.5]) {
				cube(size=[gap, indicator_mount_radius+thick, mount_depth+1], center=false);
			}
		}
		translate([gap/2, indicator_mount_radius+thick/2, mount_depth-(2*bolt_radius+2*thick)]) {
			screw_tab();
		}

		translate([-gap/2-thick, indicator_mount_radius+thick/2, mount_depth-(2*bolt_radius+2*thick)]) {
			screw_tab();
		}	
	}	
}

module screw_tab() {
	//makes the screw tabs on the clamp
	//square tabs with triangular bottoms
	//rad determines the radius of the screw holes
	//thick determines how thick the tabs are
	difference() {
		union() {
			cube(size=[thick, 2*bolt_radius+2*thick, 2*bolt_radius+2*thick], center=false);
			rotate([0, 90, 0]) {
				3dtri_draw([0,0,0],[0,2*bolt_radius+2*thick,0],[2*bolt_radius+2*thick,0,0],thick);
			}
		}
		translate([-0.5, (2*bolt_radius+2*thick)/2, (2*bolt_radius+2*thick)/2]) {
			rotate([0, 90, 0]) {
				cylinder(r=bolt_radius, h=thick+1, center=false);
			}
		}
	}	
}


  //////////////////
 // Control Code //
//////////////////

DI_clamp();



