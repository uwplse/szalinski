// Name: BagBiner
// Creator: Cory Chapman (@cmchap)
// License: Creative Commons Attribution 
// Date Created: 2015 Nov 04
// About:
// This is a blatant ripoff of Tribe One's PackTach: 
// http://www.tribeoneoutdoors.com/packtach/
//
// It's used to attach carabiners to a sheet of cloth
// (e.g. on a bag) without puncturing
// a hole in the fabric. 

// preview[view:north east, tilt:top diagonal]

//Thinnest point of the carabiner's material
carabiner_thickness = 3.3;

//Maximum thickness of fabric to be used.
fabric_thickness = 2;

//Interior diameter of the end of the carabiner to be used. (The wider end probably works better.)
carabiner_ID = 22;

//Thickness of the final BagBiner. 
thickness = 6;

//Smoothness of the curves. Higher numbers take longer to render. It's printable without supports if this is set to 6 or 7 (depending or print orientation).
fn = 7;

hole_diameter = carabiner_thickness*2+fabric_thickness*4;
slot_width = fabric_thickness*2;


total_height = hole_diameter*1.5+thickness*2;
total_length = total_height;
total_width = total_height;

difference(){
	intersection() {
		union() {
			hull(){
				cylinder(
					h = total_width,
					d = total_length,
					center = true,
					$fn=fn
				);
				translate([0,-1*total_height/2,0]) cube([total_length,total_height,total_width], center=true);
			}
		}
		rotate([0,90,0])
			cylinder(
				h = total_length,
				d = total_height,
				center = true,
				$fn=fn
			);
	}
	color("red")
	union() {
			translate([0,carabiner_ID-thickness/2,0])
				rotate_extrude(convexity = 10, $fn = fn*2)
					translate([carabiner_ID, 0, 0])
						hull(){
							translate([-1*hole_diameter/4,0,0])
								circle(d = hole_diameter, $fn = fn);
							translate([hole_diameter/4,0,0])
								circle(d = hole_diameter, $fn = fn);
						}
		rotate([0,90,0]) 
			translate([0,total_height/4,0])
					cube(
						[slot_width,total_height/2,total_length],
						center = true
					);
   }
}