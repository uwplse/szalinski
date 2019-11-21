/*******************************************************************************
 *                Battery Dispenser for Cylindrical Batteries                  *
 *                      By Blair Thompson    (AKA Justblair)                   *
 *                                        29/12/11                             *
 *                                www.justblair.co.uk                          *
 *                                      Version 1.0                            *
 *******************************************************************************/


// modified Aug2016, ls (AKA Bushmills):
// - anti-warping "ears":  for a reason, possibly cheap material with poor thermal expansion coefficient,
//   nothing else I tried eliminated warping, so I used massive "ears"
// - retainment improving snout: keeps battery at buttom from pushed out by weight of added batteries
// - slotted mount holes
// - relevant parameters customised higher level:
//    strength, wall
//    sizes specified in terms of capacity (battery count)
// - made fit for customiser
// - dropped back plate, extension

// ******************** For customiser *********************

// $fn number of facettes
detail = 90;                            // [8:180]

// AAA: 10, AA: 14, 18650: 18. Give accurate size, slack is calculated.
cell_diameter = 14;			// [6:0.1:40]

// AAA:44, AA: 50, 18650: 65. Give accurate size, slack is calculated.
cell_length = 50;			// [30:1:100]

// battery count upper part
capacity_upper_section = 6; 		// [2:16]

// battery count lower part
capacity_lower_section = 2;		// [2:8]

// "knee" angle between upper and lower sections
angle = 120;				// [100:180]

// base layer becomes outer walls when mounted)
thickness_of_outer_walls = 1.2;		// [0.4:0.2:16]

// "rails" walls, overall stability determined by this value mostly
thickness_of_channel_walls = 1.2;				// [0.4:0.2:16]

// How deep are the channels, in percent of cell length.
channel_depth_percent = 20;		// [5:40]

// How high above the Channels to do you want the tab to extend
mount_tab_height = 8;			// [0:1:32]

// Holes distance from upper/lower edges as percentage of upper channel length
hole_position = 12.5;			// [2:0.5:50]

// Hole diameters. Set to 0 for no mount holes.
mount_hole_diameter = 3.2;		// [0:0.1:8]

// Diameter of recess
holes_pan_diameter = 6.6; 		// [2:0.1:20]

// Recess depth. Set to 0 for no recesses. Affects thickness of mount tabs
holes_pan_depth = 3;	 		// [0:0.1:8]

// Slotted holes allow position adjustment after mounting. Slot length in mm.
holes_slotted = 4;			// [0:0.1:24]

// percentage of cell diameter
ear_size = 100;		// [0:400]

// If 1, a calibration piece will be generated, which is a single (left) knee
calibrate = 0;				// [0:1]


// ****************** end of customiser section **********************


ear_radius = cell_diameter*ear_size/100; // anti warp mice ears radius. 0 disables ears.

module ear(x, y, r)  {			// radius of 0 disables ears.  a circle with radius 0 should have
	if(r) {				// same effect, but I didn't test. Conditionally makes certain that
		linear_extrude(0.2)  {	// radius 0 means no ears and no artefacts.
			translate([x, y])
			circle(r);
		}
	}
}

battery_diameter = cell_diameter+2;	// Needs to be set wider than your intended battery
battery_length = cell_length+2;		// Set slightly longer than your actual battery size
channel_depth = cell_length*channel_depth_percent/100;
$fn=detail;								// Set the resolution of the curves

channel_width = battery_diameter+2*thickness_of_channel_walls;				// channel width
lower_channel_length = battery_diameter*capacity_lower_section;		// lower section size
upper_channel_length = battery_diameter*capacity_upper_section;		// upper section size

mount_tab_thickness = thickness_of_channel_walls+holes_pan_depth; 			// Set thicknes for the mount tab.
parts_spacing = mount_tab_thickness+4;



// ****************** Here Comes the Code! ************************

if (calibrate)
{
	translate ([channel_width/2,-10+lower_channel_length/2,0])  battery_holder_left(20);
} else {
	translate ([-channel_width/2-1-parts_spacing,-upper_channel_length/2+lower_channel_length/2,0]) 
		battery_holder_left(upper_channel_length);
	translate ([channel_width/2+1+parts_spacing,-upper_channel_length/2+lower_channel_length/2,0]) 
		mirror ([1,0,0]) battery_holder_left(upper_channel_length);
} // end if
	
// ************************ Modules ******************************

module battery_holder_left(tab){
	difference(){
		outer_shape(tab);
		inner_shape();
	} // end difference
} // end module


module outer_shape(outer_tab){
	cylinder (h=channel_depth, r=channel_width/2);

	if (calibrate){
		translate ([-channel_width/2,0,0])
		cube ([channel_width, 20, channel_depth]);	
	} else {
// vertikaler Kanal
		translate ([-channel_width/2,0,0])  {		
			cube ([channel_width, upper_channel_length, channel_depth]);
			if(ear_radius) {
				ear(0, upper_channel_length, ear_radius);
				ear(channel_width+ear_radius, upper_channel_length, ear_radius);
				ear(0, 0, ear_radius);
			}
		}
	} // end if
	if (mount_tab_height) mount_tabs(outer_tab);

// unterer Kanal
	rotate (angle,0,0) {
		translate([-channel_width/2,0,0]) cube ([channel_width,lower_channel_length-channel_width/2,channel_depth]);
		translate([0,0,0])  {
			if(ear_radius) {
				ear(channel_width/2, lower_channel_length, ear_radius);
				ear(-channel_width/2, -ear_radius, ear_radius);
				ear(-channel_width/2+channel_width/16, lower_channel_length-channel_width/16, ear_radius);
			}
			cube ([channel_width/2, lower_channel_length-channel_width, channel_depth]);
		}
		translate([0,lower_channel_length-channel_width/2,0]) cylinder (h=channel_depth, r=channel_width/2);	
	} // end rotate
} // end module

module inner_shape(){
	translate ([0,0, thickness_of_outer_walls]) 
		cylinder (h=channel_depth, r=battery_diameter/2);
	translate ([-battery_diameter/2, 0, thickness_of_outer_walls]) 
		cube ([battery_diameter,upper_channel_length+5,channel_depth]);
	rotate (angle,0,0) {
		translate ([-battery_diameter/2,0, thickness_of_outer_walls]) 
			cube ([battery_diameter,lower_channel_length-channel_width/2,channel_depth]);
		translate ([0,lower_channel_length-channel_width/2, thickness_of_outer_walls]) 
			cylinder (h=channel_depth, r=battery_diameter/2);
		translate ([0,lower_channel_length-channel_width/2-battery_diameter*3/4-thickness_of_channel_walls, thickness_of_outer_walls]) 
			cube ([channel_width, battery_diameter*1.1, channel_depth]);
	} // end rotate
} // end 

module mount_hole_circular(){
	cylinder (r=mount_hole_diameter/2, h=parts_spacing+2);
	if (holes_pan_depth) cylinder(r=holes_pan_diameter/2, h=holes_pan_depth);
} // end module

module mount_hole()  {
	if(holes_slotted)  {
		translate ([holes_slotted/2, 0, 0]) mount_hole_circular();
		translate ([-holes_slotted/2, 0, 0]) mount_hole_circular();
		cube([holes_slotted, mount_hole_diameter, parts_spacing*2], center=true);
		if (holes_pan_depth){
			cube([holes_slotted, holes_pan_diameter, holes_pan_depth*2], center=true);
		}
	} else {
		mount_hole_circular();
	}
}

module mount_tabs(tab_length){
	difference(){
		translate ([channel_width/2-(channel_width-battery_diameter)/2+1, 0,0])
		rotate([0,90,0]) { 
			hull() {
   				translate([-mount_tab_height-channel_depth,tab_length-4,0]) cylinder(r=4, h=mount_tab_thickness);
   				translate([-mount_tab_height-channel_depth,4,0])cylinder(r=4, h=mount_tab_thickness);
   				translate([-4,tab_length-4,0])cube ([4,4,mount_tab_thickness] );
   				translate([-4,0,0])cube ([4,4,mount_tab_thickness] );
			 } // end hull
		} // end translate

		if (mount_hole_diameter){
			for(y = [hole_position, 100-hole_position])  {
				hole_x = channel_width/2-(channel_width-battery_diameter)/2;
				hole_y = upper_channel_length*y/100;
				hole_z = mount_tab_height/2+channel_depth+2;
				translate ([hole_x, hole_y, hole_z])
				rotate ([0,90,0]) 
				mount_hole();
			} // end for
		} // end if
	} // end translate
} // end module
