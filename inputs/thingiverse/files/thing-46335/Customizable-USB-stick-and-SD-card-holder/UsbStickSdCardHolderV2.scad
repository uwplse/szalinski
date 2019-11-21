//----------------------------------------------------------------------------
//	Filename:	UsbStickSdCardHolderV2.scad
//	Author:		Robert H. Morrison
//	Date:		Saturday, 02 Feb 2013
//
//	A parametric holder for USB Sticks, SD cards and an EXTRA
//	where the EXTRA can be any number of things such as TEXT,
//	Micro SD card slots, a small Tray, Pencil holes or nothing.
//----------------------------------------------------------------------------

use <MCAD/boxes.scad>
use <utils/build_plate.scad>
use <write/Write.scad>

//---[ USER Customizable Parameters ]-----------------------------------------

Device_Type = 3; //[1:USB sticks,2:SD cards,3:USB sticks & SD cards ]
Device_Order = 1; //[1:SD - USB,-1:USB - SD]
USB_Extra = 1; //[0:NONE,1:Micro SD slots,2:Pencil holes,4:Tray,8:Sign]
Sign_FONT = "orbitron"; //["Letters":Basic,"BlackRose":BlackRose,"orbitron":Orbitron,"knewave":Knewave,"braille":Braille]
Sign_TEXT = "USB sticks";
Sign_HEIGHT = 6; //[4:12]
Sign_TYPE = 1; //[-1:Embossed,1:Raised]
Connector_Type = 3; //[0:NONE,1:Tabs right,2:Slots left,3:Slots left and Tabs right,4:Tabs back,8:Slots back]

//: Number of USB sticks
USB_sticks = 5; //[2:20]

//: Gap between USB sticks
USB_gap = 4; //[4,4.25,4.5,4.75,5,5.25,5.5,5.75,6]

//: Number of SD cards
SD_cards = 8; //[3:20]

//: Gap between SD cards
SD_gap = 2; //[2,2.1,2.2,2.3,2.4,2.5,2.6,2.7,2.8,2.9,3,3.1,3.2,3.3,3.4,3.5,3.6,3.7,3.8,3.9,4]

//: Gap between Micro SD cards
MicroSD_gap = 3; //[2,2.1,2.2,2.3,2.4,2.5,2.6,2.7,2.8,2.9,3,3.1,3.2,3.3,3.4,3.5,3.6,3.7,3.8,3.9,4,4.5,5,5.5,6,7,8]

//: Radius of the holes
Pencil_radius = 4;

//: Gap between the holes
Pencil_gap = 3;

//---[ Build Plate ]----------------------------------------------------------

//: for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]
//: when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]
//: when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

//---[ HOLDER ]---------------------------------------------------------------

module HOLDER() {

	difference() {
		union() {
			if ((Device_Type == 1) || (Device_Type == 3))
				translate([Device_Order*(USB_Holder_Length-.001)/2,0,0]) USB_MicroSD();
			if ((Device_Type == 2) || (Device_Type == 3))
				translate([-Device_Order*(SD_Holder_Length-.001)/2,0,0]) SD();
			CONNECTORS(1);	// Add the TABS (if required)
		}
		
		CONNECTORS(-1);		// Remove the SLOTS (if required)
		
		// Remove everything below the Z plane
		translate([0,0,-50])
			cube([300,300,100],true);
	}
}

//---[ Fixed and Calculated Parameters ]--------------------------------------

USB_width = 5;
USB_length = 13;
USB_depth = 13;

USB_Holder_Height = 18;
USB_Holder_Width = 32;
USB_Holder_Length = USB_sticks*(USB_width + USB_gap)+6-USB_gap;

MicroSD_width = 1;
MicroSD_length = 9;
MicroSD_depth = 15;

MicroSD_cards = (USB_Holder_Length-3)/(MicroSD_width+MicroSD_gap);

Pencil_holes = (USB_Holder_Length-3)/(2*Pencil_radius+Pencil_gap);
Pencil_depth = 18;

Sign_FONT_dxf = str("write/",Sign_FONT,".dxf");

//---[ USB sticks & Micro SD cards ]------------------------------------------

module USB_MicroSD() {

	difference() {
		rotate([0,90,0])
			roundedBox([USB_Holder_Height*2,USB_Holder_Width,USB_Holder_Length],3,true,$fn=60);
			
		for (i=[1:USB_sticks])
			translate([5-USB_Holder_Length/2+(i-1)*(USB_width+USB_gap),6,USB_Holder_Height-USB_depth/2])
				cube([USB_width,USB_length,USB_depth+1], true);
		
		translate([0,-USB_Holder_Width/2,2*USB_Holder_Height/3+USB_Holder_Width/2])
			rotate([45,0,0])
				cube([USB_Holder_Length+1,USB_Holder_Width,USB_Holder_Width],true);
				
		if (USB_Extra == 1)
		{
			for (i=[1:MicroSD_cards])
				translate([3-USB_Holder_Length/2+(i-1)*(MicroSD_width+MicroSD_gap),-11,USB_Holder_Height-MicroSD_depth/2])
					cube([MicroSD_width,MicroSD_length,MicroSD_depth], true);
		}
				
		if (USB_Extra == 2)
		{
			for (i=[1:Pencil_holes])
				translate([3*Pencil_radius/2-USB_Holder_Length/2+(i-1)*(2*Pencil_radius+MicroSD_gap),-11.4,USB_Holder_Height-MicroSD_depth/2])
					rotate([30,0,0])
						cylinder(h=Pencil_depth, r=Pencil_radius, center=true, $fn=40);
		}
		
		if (USB_Extra == 4)
		{
			translate([0,-8.5,8])
				rotate([0,90,0])
					cylinder(h=USB_Holder_Length-USB_gap, r=6.5, center=true, $fn=60);
		}
	
		if ((USB_Extra == 8)  && (Sign_TYPE == -1))
		{
			translate([0,-11,10])
				rotate([45,0,0])
					write(Sign_TEXT,t=2,h=Sign_HEIGHT,center=true,font=Sign_FONT_dxf);
		}
	}
	
	if ((USB_Extra == 8)  && (Sign_TYPE == 1))
	{
		translate([0,-11,10])
			rotate([45,0,0])
				write(Sign_TEXT,t=2,h=Sign_HEIGHT,center=true,font=Sign_FONT_dxf);
	}

	translate([0,-3.2,14.21]) {
		rotate([0,90,0]) {
			difference() {
				cylinder(h=USB_Holder_Length, r=3.8, center=true, $fn=60);
				translate([0,5/2,0])
					cube([10,5,USB_Holder_Length+1], true);
			}
		}
	}
}

SD_width = 2.64;
SD_length = 26.15;
SD_depth = 15;

SD_Holder_Height = 18;
SD_Holder_Width = 32;
SD_Holder_Length = SD_gap+SD_cards*(SD_width + SD_gap)+SD_gap/2;

//---[ SD cards ]-------------------------------------------------------------

module SD() {

	difference() {
		rotate([0,90,0]) {
			roundedBox([SD_Holder_Height*2,SD_Holder_Width,SD_Holder_Length],3,true,$fn=60);
		}
		
		for (i=[1:SD_cards])
			translate([SD_gap+1.5-SD_Holder_Length/2+(i-1)*(SD_width+SD_gap),0,SD_Holder_Height-SD_depth/2])
				cube([SD_width,SD_length,SD_depth+1], true);
	}
}

tabHeight = 8;
tabSeperation = 16;

tabLeft = 2.44; //2.84 is too much!
tabRight = 4.44; //4.84 is too much!
tabWidth = 2;

tabX = tabWidth/2;
tabYa = tabLeft/2;
tabYb = tabRight/2;

pos_OK = (Device_Type == 3) || ((Device_Type == 2) && (Device_Order ==  1)) || ((Device_Type == 1) && (Device_Order == -1));
neg_OK = (Device_Type == 3) || ((Device_Type == 2) && (Device_Order == -1)) || ((Device_Type == 1) && (Device_Order ==  1));

//---[ TAB ]------------------------------------------------------------------

module TAB(x,y) {

	translate([x,y,slotHeight/2])
		linear_extrude(height = tabHeight, center = true, convexity = 10, twist = 0)
			polygon(points=[[-tabX,-tabYa],[-tabX,tabYa],[tabX,tabYb],[tabX,-tabYb]], paths=[[0,1,2,3]]);
}

//---[ TABS ]-----------------------------------------------------------------

module TABS(d) {

	if (Connector_Type == 4)
	{
		if (pos_OK)
		{
			translate([0,SD_Holder_Width/2+slotX-.001,0])
				rotate([0,0,90])
					TAB(0,tabSeperation/2);
		}
		
		if (neg_OK)
		{
			translate([0,SD_Holder_Width/2+slotX-.001,0])
				rotate([0,0,90])
					TAB(0,-tabSeperation/2);
		}
	}
	else if ((Connector_Type == 1) || (Connector_Type == 3))
	{
		if (!neg_OK)
		{
			TAB(slotX-.001,tabSeperation/2);
			TAB(slotX-.001,-tabSeperation/2);
		}
		else
		{
			TAB(d+slotX-.001,tabSeperation/2);
			TAB(d+slotX-.001,-tabSeperation/2);
		}
	}
}

slotHeight = tabHeight;
slotSeperation = tabSeperation;

slotLeft = 3;
slotRight = 5;
slotWidth = 2;

slotX = slotWidth/2;
slotYa = slotLeft/2;
slotYb = slotRight/2;

//---[ SLOT ]------------------------------------------------------------------

module SLOT(x,y) {

	translate([x,y,slotHeight/2])
		linear_extrude(height = slotHeight, center = true, convexity = 10, twist = 0)
			polygon(points=[[-slotX,-slotYa],[-slotX,slotYa],[slotX,slotYb],[slotX,-slotYb]], paths=[[0,1,2,3]]);
}

//---[ SLOTS ]----------------------------------------------------------------

module SLOTS(d) {

	if (Connector_Type == 8)
	{
		if (neg_OK)
		{
			translate([0,SD_Holder_Width/2-slotX+.001,0])
				rotate([0,0,-90])
					SLOT(0,tabSeperation/2);
		}
				
		if (pos_OK)
		{
			translate([0,SD_Holder_Width/2-slotX+.001,0])
				rotate([0,0,-90])
					SLOT(0,-tabSeperation/2);
		}
	}
	else if ((Connector_Type == 2) || (Connector_Type == 3))
	{
		if (pos_OK)
		{
			SLOT(d+slotX-.001,tabSeperation/2);
			SLOT(d+slotX-.001,-tabSeperation/2);
		}
		else
		{
			SLOT(slotX-.001,tabSeperation/2);
			SLOT(slotX-.001,-tabSeperation/2);
		}
	}
}

//---[ CONNECTORS: Tabs (+1) & Slots (-1) ]-----------------------------------
//
//	Connector_Type:
//	==============
//	 0 : NONE
//	 1 : Tabs right
//	 2 : Slots left
//	 3 : Slots left & Tabs right
//	 4 : Tabs back
//	 8 : Slots back
//
//----------------------------------------------------------------------------

module CONNECTORS(cType) {

	if (cType > 0)
	{
		if (Connector_Type == 4)
			TABS(USB_Holder_Width);
		else if (Device_Order > 0)
			TABS(USB_Holder_Length);
		else
			TABS(SD_Holder_Length);
	}
	else
	{
		if (Connector_Type == 5)
			SLOTS(USB_Holder_Width);
		else if (Device_Order > 0)
			SLOTS(-SD_Holder_Length);
		else
			SLOTS(-USB_Holder_Length);
	}
}

//---[ USB stick / SD card / Micro SD card Holder ]---------------------------

HOLDER();
