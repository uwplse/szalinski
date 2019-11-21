// WALLY - Wall Plate Customizer v1.3
// by TheNewHobbyist 2013 (http://thenewhobbyist.com)
// http://www.thingiverse.com/thing:47956
//
// Most of the connectors used with this thing are panel mount connectors from
// www.DataPro.net I can't vouch for their quality but they did have easy to
// find dimensions for their products so I used them.
//
// This could be tightened up considerably but I thought I'd get it out there for people
// to experiment with before I lose my mind staring at it too long. Also this is my
// first OpenSCAD model so cut me some slack ;)
//
//   Notes:
//
// * The plug types "Duplex Outlet", "Long_Toggle Switch", "Toggle Switch", and "Rocker"
//   will all use the entire plate when selected in top or bottom configuration. The
//   other selection (if not "none" will be selected.
//
// * "None" and "Blank should not be considered equal. if "None" is selected for one of
//   the two holes on a plate the other selection will be centered on that plate. If
//   "Blank" is selected that plug location will remain blank but the other selection
//   will NOT move into a centered position.
//
//	Change Log:
//
//	v1.1
//	UPDATED: Screw hole locations for designer and toggle plate types.
//	UPDATED: Hole size for designer plate type.
//	UPDATED: Outlet hole spacing
//
//	v1.2
//	ADDED: Long Toggle Switch for laird
//
//	v1.3
//	ADDED: 3 new sizes for plate export: Standard, Junior-Jumbo, and Jumbo.
//

  //////////////////////////
 // Customizer Settings: //
//////////////////////////

//How big are we talkin' here?
plate_width = 1; //	[1:5]

// Bigger hole in your wall? Try this
plate_size = 0; // [0:Standard, 1:Junior-Jumbo, 2:Jumbo,]

//Pick a plug or full plate type
1st_plate = "none";  //	["none":None, "blank":Blank Port, "toggle":Full Plate - Toggle Switch, "long_toggle":Full Plate - Long Toggle Switch, "outlet":Full Plate - Duplex Outlet, "rocker":Full Plate - Rocker/Designer Plate, "keystone1":Keystone Jack, "vga":VGA Port, "hdmi":HDMI Port, "dvi":DVI-I Port, "displayport":Displayport, "cat5e":Cat5e/Cat6 Port, "usb-a":USB-A Port, "usb-b":USB-B Port, "firewire":Firewire IEEE 1394 Port, "db09":DB-09 Port, "ps2":PS2 Port, "f-type": F-Type/Coaxial Port,"svideo":S-Video Port, "stereo":Stereo Headphone Jack]
//Pick a bottom plug type or leave as none
1st_plate_bottom_hole = "none";  //	["none":None, "blank":Blank Port, "keystone1":Keystone Jack, "vga":VGA Port, "hdmi":HDMI Port, "dvi":DVI-I Port, "displayport":Displayport, "cat5e":Cat5e/Cat6 Port, "usb-a":USB-A Port, "usb-b":USB-B Port, "firewire":Firewire IEEE 1394 Port, "db09":DB-09 Port, "ps2":PS2 Port, "f-type": F-Type/Coaxial Port,"svideo":S-Video Port, "stereo":Stereo Headphone Jack]
//Pick a plug or full plate type
2nd_plate = "none";  //	["none":None, "blank":Blank Port, "toggle":Full Plate - Toggle Switch, "long_toggle":Full Plate - Long Toggle Switch, "outlet":Full Plate - Duplex Outlet, "rocker":Full Plate - Rocker/Designer Plate, "keystone1":Keystone Jack, "vga":VGA Port, "hdmi":HDMI Port, "dvi":DVI-I Port, "displayport":Displayport, "cat5e":Cat5e/Cat6 Port, "usb-a":USB-A Port, "usb-b":USB-B Port, "firewire":Firewire IEEE 1394 Port, "db09":DB-09 Port, "ps2":PS2 Port, "f-type": F-Type/Coaxial Port,"svideo":S-Video Port, "stereo":Stereo Headphone Jack]
//Pick a bottom plug type or leave as none
2nd_plate_bottom_hole = "none";  //	["none":None, "blank":Blank Port, "keystone1":Keystone Jack, "vga":VGA Port, "hdmi":HDMI Port, "dvi":DVI-I Port, "displayport":Displayport, "cat5e":Cat5e/Cat6 Port, "usb-a":USB-A Port, "usb-b":USB-B Port, "firewire":Firewire IEEE 1394 Port, "db09":DB-09 Port, "ps2":PS2 Port, "f-type": F-Type/Coaxial Port,"svideo":S-Video Port, "stereo":Stereo Headphone Jack]
//Pick a plug or full plate type
3rd_plate = "none";  //	["none":None, "blank":Blank Port, "toggle":Full Plate - Toggle Switch, "long_toggle":Full Plate - Long Toggle Switch, "outlet":Full Plate - Duplex Outlet, "rocker":Full Plate - Rocker/Designer Plate, "keystone1":Keystone Jack, "vga":VGA Port, "hdmi":HDMI Port, "dvi":DVI-I Port, "displayport":Displayport, "cat5e":Cat5e/Cat6 Port, "usb-a":USB-A Port, "usb-b":USB-B Port, "firewire":Firewire IEEE 1394 Port, "db09":DB-09 Port, "ps2":PS2 Port, "f-type": F-Type/Coaxial Port,"svideo":S-Video Port, "stereo":Stereo Headphone Jack]
//Pick a bottom plug type or leave as none
3rd_plate_bottom_hole = "none";  //	["none":None, "blank":Blank Port, "keystone1":Keystone Jack, "vga":VGA Port, "hdmi":HDMI Port, "dvi":DVI-I Port, "displayport":Displayport, "cat5e":Cat5e/Cat6 Port, "usb-a":USB-A Port, "usb-b":USB-B Port, "firewire":Firewire IEEE 1394 Port, "db09":DB-09 Port, "ps2":PS2 Port, "f-type": F-Type/Coaxial Port,"svideo":S-Video Port, "stereo":Stereo Headphone Jack]
//Pick a plug or full plate type
4th_plate = "none";  //["none":None, "blank":Blank Port, "toggle":Full Plate - Toggle Switch, "long_toggle":Full Plate - Long Toggle Switch, "outlet":Full Plate - Duplex Outlet, "rocker":Full Plate - Rocker/Designer Plate, "keystone1":Keystone Jack, "vga":VGA Port, "hdmi":HDMI Port, "dvi":DVI-I Port, "displayport":Displayport, "cat5e":Cat5e/Cat6 Port, "usb-a":USB-A Port, "usb-b":USB-B Port, "firewire":Firewire IEEE 1394 Port, "db09":DB-09 Port, "ps2":PS2 Port, "f-type": F-Type/Coaxial Port,"svideo":S-Video Port, "stereo":Stereo Headphone Jack]
//Pick a bottom plug type or leave as none
4th_plate_bottom_hole = "none";  //	["none":None, "blank":Blank Port, "keystone1":Keystone Jack, "vga":VGA Port, "hdmi":HDMI Port, "dvi":DVI-I Port, "displayport":Displayport, "cat5e":Cat5e/Cat6 Port, "usb-a":USB-A Port, "usb-b":USB-B Port, "firewire":Firewire IEEE 1394 Port, "db09":DB-09 Port, "ps2":PS2 Port, "f-type": F-Type/Coaxial Port,"svideo":S-Video Port, "stereo":Stereo Headphone Jack]
//Pick a plug or full plate type
5th_plate = "none";  //["none":None, "blank":Blank Port, "toggle":Full Plate - Toggle Switch, "long_toggle":Full Plate - Long Toggle Switch, "outlet":Full Plate - Duplex Outlet, "rocker":Full Plate - Rocker/Designer Plate, "keystone1":Keystone Jack, "vga":VGA Port, "hdmi":HDMI Port, "dvi":DVI-I Port, "displayport":Displayport, "cat5e":Cat5e/Cat6 Port, "usb-a":USB-A Port, "usb-b":USB-B Port, "firewire":Firewire IEEE 1394 Port, "db09":DB-09 Port, "ps2":PS2 Port, "f-type": F-Type/Coaxial Port,"svideo":S-Video Port, "stereo":Stereo Headphone Jack]
//Pick a bottom plug type or leave as none
5th_plate_bottom_hole = "none";  //	["none":None, "blank":Blank Port, "keystone1":Keystone Jack, "vga":VGA Port, "hdmi":HDMI Port, "dvi":DVI-I Port, "displayport":Displayport, "cat5e":Cat5e/Cat6 Port, "usb-a":USB-A Port, "usb-b":USB-B Port, "firewire":Firewire IEEE 1394 Port, "db09":DB-09 Port, "ps2":PS2 Port, "f-type": F-Type/Coaxial Port,"svideo":S-Video Port, "stereo":Stereo Headphone Jack]

  //////////////////////
 // Static Settings: //
//////////////////////

module GoAwayCustomizer() {
// This module is here to stop Customizer from picking up the variables below
}

l_offset = [55.2,39.6875,44.45];//34.925,39.6875
r_offset = [55.2,39.6875,44.45];
spacer = [0,0,46.0375,92.075,138.1125,184.15];
solid_plate_width = l_offset[plate_size] + spacer[plate_width] + r_offset[plate_size];//!!!!plate width squeaspacer[plate_width*2] r!!!!!

height_sizes = [114.3,123.825,133.35];

height =114.3 ; //plate height (static)114.3
gang_width=[0,69.86,115.824,161.925,206.375,254]; // Plate widths (standard)69.86

edgewidth = solid_plate_width + 10; // Bevel setting for top and bottom
rightbevel = solid_plate_width -4; // Bevel for right side (scales)

left_offset = 34.925; // Offset first hole position34.925
switch_offset = 46.0375; // Offset all additional holes
thinner_offset=[0,0.92,0.95,0.96,0.97,0.973]; // Manual fix for right side wackiness

positions=[height_sizes[plate_size]/2,height_sizes[plate_size]/2 - 14.25,height_sizes[plate_size]/2 + 14.25];

// preview[view:north, tilt:bottom]

  ///////////////////
 // Hole Control: //
///////////////////

module plate1(){
	if (1st_plate == "toggle" || 1st_plate_bottom_hole == "toggle"){
		translate([0,l_offset[plate_size],0]) toggle_screws();
		translate([0,l_offset[plate_size],0]) hole("toggle");
		}
	else if (1st_plate == "long_toggle" || 1st_plate_bottom_hole == "long_toggle"){
		translate([0,l_offset[plate_size],0]) toggle_screws();
		translate([0,l_offset[plate_size],0]) hole("long_toggle");
		}
	else if (1st_plate == "rocker" || 1st_plate_bottom_hole == "rocker"){
		translate([0,l_offset[plate_size],0]) rocker_screws();
		translate([0,l_offset[plate_size],0]) hole("rocker");
		}
	else if (1st_plate == "outlet" || 1st_plate_bottom_hole == "outlet") {
	translate([0,l_offset[plate_size],0]) hole("outlet");
	}
	else if (1st_plate_bottom_hole == "none") {
		translate([0,l_offset[plate_size],0]) box_screws();
		translate([positions[0],l_offset[plate_size],0]) hole(1st_plate);
			}
	else if (1st_plate == "none") {
		translate([0,l_offset[plate_size],0]) box_screws();
		translate([positions[0],l_offset[plate_size],0]) hole(1st_plate_bottom_hole);
			}
	else {
	translate([0,l_offset[plate_size],0]) box_screws();
	translate([positions[1],l_offset[plate_size],0]) hole(1st_plate);
	translate([positions[2],l_offset[plate_size],0]) hole(1st_plate_bottom_hole);
	}
}

module plate2(){
	if (2nd_plate == "toggle" || 2nd_plate_bottom_hole == "toggle"){
		translate([0,l_offset[plate_size] + switch_offset,0]) toggle_screws();
		translate([0,l_offset[plate_size] + switch_offset,0]) hole("toggle");
		}
	else if (2nd_plate == "long_toggle" || 2nd_plate_bottom_hole == "long_toggle"){
		translate([0,l_offset[plate_size] + switch_offset,0]) toggle_screws();
		translate([0,l_offset[plate_size] + switch_offset,0]) hole("long_toggle");
		}
	else if (2nd_plate == "rocker" || 2nd_plate_bottom_hole == "rocker"){
		translate([0,l_offset[plate_size] + switch_offset,0]) rocker_screws();
		translate([0,l_offset[plate_size] + switch_offset,0]) hole("rocker");
		}
	else if (2nd_plate == "outlet" || 2nd_plate_bottom_hole == "outlet") {
	translate([0,l_offset[plate_size] + switch_offset,0]) hole("outlet");
	}
	else if (2nd_plate_bottom_hole == "none") {
		translate([0,l_offset[plate_size] + switch_offset,0]) box_screws();
		translate([positions[0],l_offset[plate_size] + switch_offset,0]) hole(2nd_plate);
			}
	else if (2nd_plate == "none") {
		translate([0,l_offset[plate_size] + switch_offset,0]) box_screws();
		translate([positions[0],l_offset[plate_size] + switch_offset,0]) hole(2nd_plate_bottom_hole);
			}
	else {
	translate([0,l_offset[plate_size] + switch_offset,0]) box_screws();
	translate([positions[1],l_offset[plate_size] + switch_offset,0]) hole(2nd_plate);
	translate([positions[2],l_offset[plate_size] + switch_offset,0]) hole(2nd_plate_bottom_hole);
	}
}

module plate3(){
	if (3rd_plate == "toggle" || 3rd_plate_bottom_hole == "toggle"){
		translate([0,l_offset[plate_size] + switch_offset * 2,0]) toggle_screws();
		translate([0,l_offset[plate_size] + switch_offset * 2,0]) hole("toggle");
		}
	else if (3rd_plate == "long_toggle" || 3rd_plate_bottom_hole == "long_toggle"){
		translate([0,l_offset[plate_size] + switch_offset * 2,0]) toggle_screws();
		translate([0,l_offset[plate_size] + switch_offset * 2,0]) hole("long_toggle");
		}
	else if (3rd_plate == "rocker" || 3rd_plate_bottom_hole == "rocker"){
		translate([0,l_offset[plate_size] + switch_offset * 2,0]) rocker_screws();
		translate([0,l_offset[plate_size] + switch_offset * 2,0]) hole("rocker");
		}
	else if (3rd_plate == "outlet" || 3rd_plate_bottom_hole == "outlet") {
	translate([0,l_offset[plate_size] + switch_offset * 2,0]) hole("outlet");
	}
	else if (3rd_plate_bottom_hole == "none") {
		translate([0,l_offset[plate_size] + switch_offset * 2,0]) box_screws();
		translate([positions[0],l_offset[plate_size] + switch_offset * 2,0]) hole(3rd_plate);
			}
	else if (3rd_plate == "none") {
		translate([0,l_offset[plate_size] + switch_offset * 2,0]) box_screws();
		translate([positions[0],l_offset[plate_size] + switch_offset * 2,0]) hole(3rd_plate_bottom_hole);
			}
	else {
	translate([0,l_offset[plate_size] + switch_offset * 2,0]) box_screws();
	translate([positions[1],l_offset[plate_size] + switch_offset * 2,0]) hole(3rd_plate);
	translate([positions[2],l_offset[plate_size] + switch_offset * 2,0]) hole(3rd_plate_bottom_hole);
	}
}

module plate4(){
	if (4th_plate == "toggle" || 4th_plate_bottom_hole == "toggle"){
		translate([0,l_offset[plate_size] + switch_offset * 3,0]) toggle_screws();
		translate([0,l_offset[plate_size] + switch_offset * 3,0]) hole("toggle");
		}
	else if (4th_plate == "long_toggle" || 4th_plate_bottom_hole == "long_toggle"){
		translate([0,l_offset[plate_size] + switch_offset * 3,0]) toggle_screws();
		translate([0,l_offset[plate_size] + switch_offset * 3,0]) hole("long_toggle");
		}
	else if (4th_plate == "rocker" || 4th_plate_bottom_hole == "rocker"){
		translate([0,l_offset[plate_size] + switch_offset * 3,0]) rocker_screws();
		translate([0,l_offset[plate_size] + switch_offset * 3,0]) hole("rocker");
		}
	else if (4th_plate == "outlet" || 4th_plate_bottom_hole == "outlet") {
	translate([0,l_offset[plate_size] + switch_offset * 3,0]) hole("outlet");
	}
	else if (4th_plate_bottom_hole == "none") {
		translate([0,l_offset[plate_size] + switch_offset * 3,0]) box_screws();
		translate([positions[0],l_offset[plate_size] + switch_offset * 3,0]) hole(4th_plate);
			}
	else if (4th_plate == "none") {
		translate([0,l_offset[plate_size] + switch_offset * 3,0]) box_screws();
		translate([positions[0],l_offset[plate_size] + switch_offset * 3,0]) hole(4th_plate_bottom_hole);
			}
	else {
	translate([0,l_offset[plate_size] + switch_offset * 3,0]) box_screws();
	translate([positions[1],l_offset[plate_size] + switch_offset * 3,0]) hole(4th_plate);
	translate([positions[2],l_offset[plate_size] + switch_offset * 3,0]) hole(4th_plate_bottom_hole);
	}
}

module plate5(){
	if (5th_plate == "toggle" || 5th_plate_bottom_hole == "toggle"){
		translate([0,l_offset[plate_size] + switch_offset * 4,0]) toggle_screws();
		translate([0,l_offset[plate_size] + switch_offset * 4,0]) hole("toggle");
		}
	else if (5th_plate == "long_toggle" || 5th_plate_bottom_hole == "long_toggle"){
		translate([0,l_offset[plate_size] + switch_offset * 4,0]) toggle_screws();
		translate([0,l_offset[plate_size] + switch_offset * 4,0]) hole("long_toggle");
		}
	else if (5th_plate == "rocker" || 5th_plate_bottom_hole == "rocker"){
		translate([0,l_offset[plate_size] + switch_offset * 4,0]) rocker_screws();
		translate([0,l_offset[plate_size] + switch_offset * 4,0]) hole("rocker");
		}
	else if (5th_plate == "outlet" || 5th_plate_bottom_hole == "outlet") {
	translate([0,l_offset[plate_size] + switch_offset * 4,0]) hole("outlet");
	}
	else if (5th_plate_bottom_hole == "none") {
		translate([0,l_offset[plate_size] + switch_offset * 4,0]) box_screws();
		translate([positions[0],l_offset[plate_size] + switch_offset * 4,0]) hole(5th_plate);
			}
	else if (5th_plate == "none") {
		translate([0,l_offset[plate_size] + switch_offset * 4,0]) box_screws();
		translate([positions[0],l_offset[plate_size] + switch_offset * 4,0]) hole(5th_plate_bottom_hole);
			}
	else {
	translate([0,l_offset[plate_size] + switch_offset * 4,0]) box_screws();
	translate([positions[1],l_offset[plate_size] + switch_offset * 4,0]) hole(5th_plate);
	translate([positions[2],l_offset[plate_size] + switch_offset * 4,0]) hole(5th_plate_bottom_hole);
	}
}

  /////////////////
 // SolidWorks: //
/////////////////

module plate1_solid(){
if (1st_plate == "keystone1" && 1st_plate_bottom_hole == "none") {
	translate([height_sizes[plate_size]/2 + 14.3,l_offset[plate_size] - 11.5,-3.9]) hole("keystone_solid");
	}
else if (1st_plate == "keystone1" && 1st_plate_bottom_hole != "outlet" && 1st_plate_bottom_hole != "toggle" && 1st_plate_bottom_hole != "rocker") {
	translate([height_sizes[plate_size]/2,l_offset[plate_size] - 11.5,-3.9]) hole("keystone_solid");
	}
if (1st_plate_bottom_hole == "keystone1" && 1st_plate == "none") {
	translate([height_sizes[plate_size]/2 + 14.3,l_offset[plate_size] - 11.5,-3.9]) hole("keystone_solid");
	}
else if (1st_plate_bottom_hole == "keystone1" && 1st_plate != "outlet" && 1st_plate != "toggle" && 1st_plate != "rocker") {
	translate([height_sizes[plate_size]/2 + 28.5,l_offset[plate_size] - 11.5,-3.9]) hole("keystone_solid");
	}

}

module plate2_solid(){
if (2nd_plate == "keystone1" && 2nd_plate_bottom_hole == "none") {
	translate([height_sizes[plate_size]/2 + 14.3,l_offset[plate_size] - 11.5 + switch_offset,-3.9]) hole("keystone_solid");
	}
else if (2nd_plate == "keystone1" && 2nd_plate_bottom_hole != "outlet" && 2nd_plate_bottom_hole != "toggle" && 2nd_plate_bottom_hole != "rocker") {
	translate([height_sizes[plate_size]/2,l_offset[plate_size] - 11.5 + switch_offset,-3.9]) hole("keystone_solid");
	}
if (2nd_plate_bottom_hole == "keystone1" && 2nd_plate == "none") {
	translate([height_sizes[plate_size]/2 + 14.3,l_offset[plate_size] - 11.5 + switch_offset,-3.9]) hole("keystone_solid");
	}
else if (2nd_plate_bottom_hole == "keystone1" && 2nd_plate != "outlet" && 2nd_plate != "toggle" && 2nd_plate != "rocker") {
	translate([height_sizes[plate_size]/2 + 28.5,l_offset[plate_size] - 11.5 + switch_offset,-3.9]) hole("keystone_solid");
	}

}

module plate3_solid(){
if (3rd_plate == "keystone1" && 3rd_plate_bottom_hole == "none") {
	translate([height_sizes[plate_size]/2 + 14.3,l_offset[plate_size] - 11.5 + switch_offset * 2,-3.9]) hole("keystone_solid");
	}
else if (3rd_plate == "keystone1" && 3rd_plate_bottom_hole != "outlet" && 3rd_plate_bottom_hole != "toggle" && 3rd_plate_bottom_hole != "rocker") {
	translate([height_sizes[plate_size]/2,l_offset[plate_size] - 11.5 + switch_offset * 2,-3.9]) hole("keystone_solid");
	}
if (3rd_plate_bottom_hole == "keystone1" && 3rd_plate == "none") {
	translate([height_sizes[plate_size]/2 + 14.3,l_offset[plate_size] - 11.5 + switch_offset * 2,-3.9]) hole("keystone_solid");
	}
else if (3rd_plate_bottom_hole == "keystone1" && 3rd_plate != "outlet" && 3rd_plate != "toggle" && 3rd_plate != "rocker") {
	translate([height_sizes[plate_size]/2 + 28.5,l_offset[plate_size] - 11.5 + switch_offset * 2,-3.9]) hole("keystone_solid");
	}

}

module plate4_solid(){
if (4th_plate == "keystone1" && 4th_plate_bottom_hole == "none") {
	translate([height_sizes[plate_size]/2 + 14.3,l_offset[plate_size] - 11.5 + switch_offset * 3,-3.9]) hole("keystone_solid");
	}
else if (4th_plate == "keystone1" && 4th_plate_bottom_hole != "outlet" && 4th_plate_bottom_hole != "toggle" && 4th_plate_bottom_hole != "rocker") {
	translate([height_sizes[plate_size]/2,l_offset[plate_size] - 11.5 + switch_offset * 3,-3.9]) hole("keystone_solid");
	}
if (4th_plate_bottom_hole == "keystone1" && 4th_plate == "none") {
	translate([height_sizes[plate_size]/2 + 14.3,l_offset[plate_size] - 11.5 + switch_offset * 3,-3.9]) hole("keystone_solid");
	}
else if (4th_plate_bottom_hole == "keystone1" && 4th_plate != "outlet" && 4th_plate != "toggle" && 4th_plate != "rocker") {
	translate([height_sizes[plate_size]/2 + 28.5,l_offset[plate_size] - 11.5 + switch_offset * 3,-3.9]) hole("keystone_solid");
	}

}

module plate5_solid(){
if (5th_plate == "keystone1" && 5th_plate_bottom_hole == "none") {
	translate([height_sizes[plate_size]/2 + 14.3,l_offset[plate_size] - 11.5 + switch_offset * 4,-3.9]) hole("keystone_solid");
	}
else if (5th_plate == "keystone1" && 5th_plate_bottom_hole != "outlet" && 5th_plate_bottom_hole != "toggle" && 5th_plate_bottom_hole != "rocker") {
	translate([height_sizes[plate_size]/2,l_offset[plate_size] - 11.5 + switch_offset * 4,-3.9]) hole("keystone_solid");
	}
if (5th_plate_bottom_hole == "keystone1" && 5th_plate == "none") {
	translate([height_sizes[plate_size]/2 + 14.3,l_offset[plate_size] - 11.5 + switch_offset * 4,-3.9]) hole("keystone_solid");
	}
else if (5th_plate_bottom_hole == "keystone1" && 5th_plate != "outlet" && 5th_plate != "toggle" && 5th_plate != "rocker") {
	translate([height_sizes[plate_size]/2 + 28.5,l_offset[plate_size] - 11.5 + switch_offset * 4,-3.9]) hole("keystone_solid");
	}

}

  ///////////////////
 // PlateStation: //
///////////////////

//Plate size and bevel
module plate() {
	difference() {
		cube([height_sizes[plate_size],solid_plate_width,6]);//solid_plate_width
		translate([-4.3,-5,6.2]) rotate([0,45,0]) cube([6,edgewidth,6]); //Top Bevel
		translate([height_sizes[plate_size]-4.2,-5,6.25]) rotate([0,45,0]) cube([6,edgewidth,6]); //Bottom Bevel
		translate([height_sizes[plate_size]+10,-4.4,6.1]) rotate([0,45,90]) cube([6,height_sizes[plate_size]+20,6]); //Left Bevel (doesn't change)
		translate([height_sizes[plate_size]+10,rightbevel,6]) rotate([0,45,90]) cube([6,height_sizes[plate_size]+10,6]); //Right Bevel (scales right)
				}
			}


// Thinning Plate
module plate_inner() {
	scale([0.95,thinner_offset[plate_width],1]){
	translate([3,3,0]){
	difference() {
		cube([height_sizes[plate_size],solid_plate_width,6]);
		translate([-4.3,-5,6.2]) rotate([0,45,0]) cube([6,edgewidth,6]); //Top Bevel
		translate([height_sizes[plate_size]-4.2,-5,6.25]) rotate([0,45,0]) cube([6,edgewidth,6]); //Bottom Bevel
		translate([height_sizes[plate_size]+10,-4.4,6.1]) rotate([0,45,90]) cube([6,height_sizes[plate_size]+20,6]); //Left Bevel (doesn't change)
		translate([height_sizes[plate_size]+10,rightbevel,6]) rotate([0,45,90]) cube([6,height_sizes[plate_size]+10,6]); //Right Bevel (scales right)
				}
			}
		}
	}

// Box screw holes
module box_screws(){
	 translate([height_sizes[plate_size]/2 + 41.67125,0,-1]) cylinder(r=2, h=10, $fn=12);//23 position of holes
	 translate([height_sizes[plate_size]/2 + 41.67125,0,3.5]) cylinder(r1=2, r2=3.3, h=3);
	 translate([height_sizes[plate_size]/2 - 41.67125,0,-1]) cylinder(r=2, h=10, $fn=12);
	 translate([height_sizes[plate_size]/2 - 41.67125,0,3.5]) cylinder(r1=2, r2=3.3, h=3);
}

// Rocker/Designer screw holes
module rocker_screws(){
	 translate([height_sizes[plate_size]/2 + 48.41875,0,-1]) cylinder(r=2, h=10, $fn=12);
	 translate([height_sizes[plate_size]/2 + 48.41875,0,3.5]) cylinder(r1=2, r2=3.3, h=3);
	 translate([height_sizes[plate_size]/2 - 48.41875,0,-1]) cylinder(r=2, h=10, $fn=12);
	 translate([height_sizes[plate_size]/2 - 48.41875,0,3.5]) cylinder(r1=2, r2=3.3, h=3);
}

// Toggle screw holes
module toggle_screws(){
	 translate([height_sizes[plate_size]/2 + 30.1625,0,-1]) cylinder(r=2, h=10, $fn=12);
	 translate([height_sizes[plate_size]/2 + 30.1625,0,3.5]) cylinder(r1=2, r2=3.3, h=3);
	 translate([height_sizes[plate_size]/2 - 30.1625,0,-1]) cylinder(r=2, h=10, $fn=12);
	 translate([height_sizes[plate_size]/2 - 30.1625,0,3.5]) cylinder(r1=2, r2=3.3, h=3);
}

  ///////////////
 // Portland: //
///////////////

// Hole Cutout definitions
module hole(hole_type) {


// Toggle switch hole
	if (hole_type == "toggle") {
		translate([height_sizes[plate_size]/2,0,0]) cube([23.8125,10.3188,15], center = true);
		 						}

// Toggle switch hole and screw holes
	if (hole_type == "long_toggle") {
		translate([height_sizes[plate_size]/2,0,0]) cube([43.6563,11.9063,15], center = true);
		 						}

// Rocker switch plate
	if (hole_type == "rocker") {
		translate([height_sizes[plate_size]/2,0,0]) cube([67.1,33.3,15], center = true);

		 						}

// Duplex power outlet plate or dual side toggles
	if (hole_type == "outlet" || hole_type == "dualsidetoggle") {
		translate([height_sizes[plate_size]/2 + 19.3915,0,0]) {
			difference() {
				cylinder(r=17.4625, h=15, center = true);
				translate([-24.2875,-15,-2]) cube([10,37,15], center = false);
				translate([14.2875,-15,-2]) cube([10,37,15], center = false);
								}
							}
		translate([height_sizes[plate_size]/2 - 19.3915,0,0]){
			difference(){
				cylinder(r=17.4625, h=15, center = true);
				translate([-24.2875,-15,-2]) cube([10,37,15], center = false);
				translate([14.2875,-15,-2]) cube([10,37,15], center = false);
								}
							}
		translate([height_sizes[plate_size]/2,0,-1]) cylinder(r=2, h=10);
		translate([height_sizes[plate_size]/2,0,3.5]) cylinder(r1=2, r2=3.3, h=3);
							}

// Blank plate
	if (hole_type == "blank") { }

// VGA & DB09 plate
// VGA Fits http://www.datapro.net/products/vga-dual-panel-mount-f-f-cable.html
// DB09 Fits http://www.datapro.net/products/db9-serial-panel-mount-male-extension.html
	if (hole_type == "vga" || hole_type == "db09") {

			translate([0,-12.5,3]) cylinder(r=1.75, h=10, center = true);
			translate([0,12.5,3]) cylinder(r=1.75, h=10, center = true);
				difference(){
					cube([10,19,13], center=true);
					translate([-5,-9.2,1]) rotate([0,0,-35.6]) cube([4.4,2.4,15], center=true);
					translate([.9,-11.2,0]) rotate([0,0,9.6]) cube([10,4.8,15], center=true);
					translate([4.6,-8.5,0]) rotate([0,0,37.2]) cube([4.4,2.4,15], center=true);
					translate([-5,9.2,1]) rotate([0,0,35.6]) cube([4.4,2.4,15], center=true);
					translate([0.9,11.2,0]) rotate([0,0,-9.6]) cube([10,4.8,15], center=true);
					translate([4.6,8.5,0]) rotate([0,0,-37.2]) cube([4.4,2.4,15], center=true);
								}
						}

// HDMI plate
// Fits http://www.datapro.net/products/hdmi-panel-mount-extension-cable.html
	if (hole_type == "hdmi") {
		translate([0,-13,3]) cylinder(r=1.75, h=10, center = true);
		translate([0,13,3]) cylinder(r=1.75, h=10, center = true);
		translate([0,0,3]) cube([6,16,10], center=true);
							}

// DVI-I plate
// Fits http://www.datapro.net/products/dvi-i-panel-mount-extension-cable.html
	if (hole_type == "dvi") {
		translate([0,-16,3]) cylinder(r=1.75, h=10, center = true);
		translate([0,16,3]) cylinder(r=1.75, h=10, center = true);
		translate([0,0,3]) cube([10,26,10], center=true);
							}

// DisplayPort plate
// Fits http://www.datapro.net/products/dvi-i-panel-mount-extension-cable.html
	if (hole_type == "displayport") {
		translate([0,-13.5,3]) cylinder(r=1.75, h=10, center = true);
		translate([0,13.5,3]) cylinder(r=1.75, h=10, center = true);
		translate([0,0,0]){
			difference(){
				translate([0,0,3]) cube([7,19,10], center=true);
				translate([2.47,-9.37,3]) rotate([0,0,-54.6]) cube([3,5,14], center=true);
						}
								}
									}

// USB-A Plate
// Fits http://www.datapro.net/products/usb-panel-mount-type-a-cable.html
	if (hole_type == "usb-a") {
		translate([0,-15,3]) cylinder(r=1.75, h=10, center = true);
		translate([0,15,3]) cylinder(r=1.75, h=10, center = true);
		translate([0,0,3]) cube([8,16,10], center=true);
							}

// USB-B Plate
// Fits http://www.datapro.net/products/usb-panel-mount-type-b-cable.html
	if (hole_type == "usb-b") {
		translate([0,-13,3]) cylinder(r=1.75, h=10, center = true);
		translate([0,13,3]) cylinder(r=1.75, h=10, center = true);
		translate([0,0,3]) cube([11,12,10], center=true);
							}

// 1394 Firewire Plate
// Fits http://www.datapro.net/products/firewire-panel-mount-extension.html
	if (hole_type == "firewire") {
		translate([0,-13.5,3]) cylinder(r=1.75, h=10, center = true);
		translate([0,13.5,3]) cylinder(r=1.75, h=10, center = true);
		translate([0,0,3]) cube([7,12,10], center=true);
							}

// F-Type / Cable TV Plate
// Fits http://www.datapro.net/products/f-type-panel-mounting-coupler.html
	if (hole_type == "f-type") {
		translate([0,0,3]) cylinder(r=4.7625, h=10, center=true);
							}

// Cat5e & Gat6 plate
// Cat5e Fits http://www.datapro.net/products/cat-5e-panel-mount-ethernet.html
// Cat6 Fits hhttp://www.datapro.net/products/cat-6-panel-mount-ethernet.html
	if (hole_type == "cat5e" || hole_type == "cat6") {
		translate([0,-12.5,3]) cylinder(r=1.75, h=10, center = true);
		translate([0,12.5,3]) cylinder(r=1.75, h=10, center = true);
		translate([0,0,3]) cube([15,15,10], center=true);
		}

// S-Video & PS2 plate
// S-Video Fits hhttp://www.datapro.net/products/cat-6-panel-mount-ethernet.html
// PS2 http://www.datapro.net/products/ps2-panel-mount-extension-cable.html
	if (hole_type == "svideo" || hole_type == "ps2") {
		translate([0,-10,3]) cylinder(r=1.75, h=10, center = true);
		translate([0,10,3]) cylinder(r=1.75, h=10, center = true);
		translate([0,0,3]) cylinder(r=5, h=10, center=true);
		}


// Stereo / 1/4" headphone jack coupler
// Stereo coupler Fits http://www.datapro.net/products/stereo-panel-mount-coupler.html
	if (hole_type == "stereo") {
		translate([0,0,3]) cylinder(r=2.985, h=10, center=true);
		}

//Keystone1 hole
//Hole for 1 Keystone Jack
	if (hole_type == "keystone1") {
		translate([0,0,5]) cube([16.5,15,10], center = true);
	}

//Keystone Solid
	if (hole_type == "keystone_solid") {
		rotate([0,0,90]) {
			difference(){
				translate([0,0,.1]) cube([23,30.5,9.8]);
					translate([4,4,0]){
						difference(){
							cube([15,22.5,10]);
							translate([-1,-0.001,3.501]) cube([17,2,6.5]);
							translate([-1,2.5,-3.40970]) rotate([45,0,0]) cube([17,2,6.5]);
							translate([-1,18.501,6.001]) cube([17,4,4]);
							translate([-1,20.5,0]) rotate([-45,0,0]) cube([17,2,6.5]);
						}
					}
				}
			}
		}

//End of module "hole"
}

  ////////////////////////
 // Number One ENGAGE: //
////////////////////////

// Rotate so it sits correctly on plate (whoops) and make upside down
rotate([0,180,90]){
// put plate at 0,0,0 for easier printing
translate([-height_sizes[plate_size]/2,-solid_plate_width/2,-6]){

if (plate_width == 1) {
	difference() {
		plate();
		translate([0,0,-3]) plate_inner();
		plate1();
			}
		union() {
		plate1_solid();
		}
			}

else if (plate_width == 2) {
difference()
{
plate();
translate([0,0,-3]) plate_inner();
plate1();
plate2();
}
union() {
		plate1_solid();
		plate2_solid();
		}
}

else if (plate_width == 3) {
difference()
{
plate();
translate([0,0,-3]) plate_inner();
plate1();
plate2();
plate3();
}
union() {
		plate1_solid();
		plate2_solid();
		plate3_solid();
		}
}

else if (plate_width == 4) {
difference()
{
plate();
translate([0,0,-3]) plate_inner();
plate1();
plate2();
plate3();
plate4();
}
union() {
		plate1_solid();
		plate2_solid();
		plate3_solid();
		plate4_solid();
		}
}

else if (plate_width == 5) {
difference()
{
plate();
translate([0,0,-3]) plate_inner();
plate1();
plate2();
plate3();
plate4();
plate5();
}
union() {
		plate1_solid();
		plate2_solid();
		plate3_solid();
		plate4_solid();
		plate5_solid();
		}
}

//End Rotate
}
//End Translate
}