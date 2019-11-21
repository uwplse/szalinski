//design and code by emanresu (http://www.thingiverse.com/Ema...
//generates a simple tray with standoffs for an arduino to sit in
// Tweaked a bit by Laird Popkin (http://www.thingiverse.com/laird

use <write/Write.scad>

//////////////////
// Parameters  //
//////////////////

// preview[view:south west, tilt:top diagonal]

/* [Stack] */

//Select Arduino type. Missing: Pro, Tre, Serial, Serial v2.0, Severino, Original, BT,
Arduino_Type = 0; //[0:Uno,1:USB v2.0,2:Extreme,3:Extreme v2,4:NG,5:NG Rev. C,6:Diecimila,7:Duemilanove,8:Leonardo,9:Mega 2560,10:Due,11:Mega,12:Mega ADK,13:Yún,14:Ethernet]

//Select shield closest to Arduino. Always place motor shield last for ease of access to screw terminals
Shield1 = 2; //[0:None, 1:GSM*, 2:Ethernet, 3:Wifi*, 4:WirelessSD*, 5:Motor*, 6:MotorR3*, 7:WirelessProto, 8:Proto, 9:Custom]
// Select second shield in stack. * means not verified. Please help!
Shield2 = 9; //[0:None, 1:GSM*, 2:Ethernet, 3:Wifi*, 4:WirelessSD*, 5:Motor*, 6:MotorR3*, 7:WirelessProto, 8:Proto, 9:Custom]
// Select third shield in stack. * means not verified. Please help!
Shield3 = 0; //[0:None, 1:GSM, 2:Ethernet, 3:Wifi, 4:WirelessSD, 5:Motor, 6:MotorR3, 7:WirelessProto, 8:Proto, 9:Custom]

//What Part to show?
part = 0; //[3:Preview, 0:Plated case to print, 1:Front test fit, 2:Back test fit]
// 10 = shapes
// 11 = front part
// 12 = back part
// 13 = bottom part


//Gap between hinge parts, etc.
gap = 0.6;

/* [Custom Shield] */

// Label
CustomLabel = "Steppers";
// Height (mm). Set to zero unless there is a custom shield.
CustomHeight = 20;
// Front hole center position, measured from labeled edge
FrontHolePos = 0;
// And height of center of front hole, measured from bottom of board
FrontHoleHeight = 0;
// And width of hole
FrontHoleWidth = 0;
// Front hole 2 center position, measured from labeled edge
FrontHolePos2 = 0;
// And height of center of front hole 2, measured from bottom of board
FrontHoleHeight2 = 0;
// And width of hole 2
FrontHoleWidth2 = 0;
// Back hole center position, measured from labeled edge
BackHolePos = 20;
// And height of center, measured from bottom of board
BackHoleHeight = 5;
// And width of back hole
BackHoleWidth = 30;

/* [Measurements] */

// (mm)
Thickness_Of_Side_Walls_And_Bottom  = 1.6;
// Height of power plug hole
Height_Of_Power_Plug_Hole=14;
// (mm)
Height_Of_USB_Plug_Hole=13;
// (mm)
Height_Of_Ethernet_Plug_Hole=16;
// (mm)
Width_Of_Ethernet_Plug_Hole=11.43+3;
// (mm)
Height_Of_Standoff = 7;
// (mm)
Standoff_Hole_Diameter = 2.9;
// (mm)
Standoff_Thickness = 1.6;
// (mm)
Clearance_Between_Arduino_And_Sidewalls = 1.5;

/* [Hidden] */

// Arduino types (matching param list above)

ard_label = ["Uno","USB v2.0","Extreme","Extreme v2","NG","NG Rev. C","Diecimila","Duemilanove","Leonardo","Mega 2560","Due","Mega","Mega ADK","Yún","Ethernet"];
ard_height= [21,19,19,19,19,19,19,19,19,19,19,19,19,19]; // height of each arduino model in mm, e.g. ard_height[Uno]=19.

Uno=0;
USBv2=1;
Extreme=2;
Extremev2=3;
NG=4;
NGRevC=5;
Diecimila=6;
Duemilanove=7;
Leonardo=8;
Mega2560=9;
Due=10;
Mega=11;
MegaADK=12;
Yun=13;
EthernetArduino=14;

// Shield types (matching param list above)

shield_label = ["None","GSM","Ethernet","Wifi","Wireless SD","Motor","MotorR3","WirelessProto","Proto","Custom"];
shield_height= [0,15,20,25,15,20,25,15,20,0]; // heights of shields (e.g. height[GSM] is height of GSM shield

None=0;
GSM=1;
Ethernet=2;
Wifi=3;
WirelessSD=4;
Motor=5;
MotorR3=6;
WirelessProto=7;
Proto=8;
Custom=9;

// Thickness of Arduino board (mm)
Board_Thickness=1.6;

// Hinge scaling
hingeScaleZ = 1;
hingeScaleX = 0.9;

hingeIn = 20;
hingeLen = 13;
hingeThick = 5;

//sets openSCAD resolution for nice, round holes
//$fa=1;
//$fs=0.5;
$fn=8;

//sets length for type of arduino specified, 101.6 mm for Mega, 68.58 mm for Uno
base_x = (Arduino_Type == Mega || Arduino_Type == Due || Arduino_Type == Mega2560 ? 101.6 : 68.58);
base_y = 53.34;

caseHeight = Thickness_Of_Side_Walls_And_Bottom//+Height_Of_Standoff
	+ard_height[Arduino_Type]
	+shield_height[Shield1]
	+shield_height[Shield2]
	+shield_height[Shield3]
	+(((Shield1==Custom)||(Shield2==Custom)||(Shield3==Custom))?CustomHeight:0);
caseLength = base_x+Thickness_Of_Side_Walls_And_Bottom*2+Clearance_Between_Arduino_And_Sidewalls*2;
caseWidth = base_y++Thickness_Of_Side_Walls_And_Bottom*2+Clearance_Between_Arduino_And_Sidewalls*2;

///////////////
// Modules //
///////////////

// LAP: modularized standoffs to make the Arduino_standoffs more compact/readable

module standoff(x, y) {
	translate([x, y, Height_Of_Standoff/2]) {
		difference() {
			cylinder(r=Standoff_Hole_Diameter/2+Standoff_Thickness, h=Height_Of_Standoff, center=true);
			cylinder(r=Standoff_Hole_Diameter/2, h=Height_Of_Standoff+1, center=true);
			}
		}
	}

module Arduino_standoffs() {
	// body...

	//arranging standoffs
	standoff(13.97, 2.54);
	standoff(15.24, 50.8);
	standoff(66.04, 7.62);
	standoff(66.04, 35.56);

	if (Arduino_Type == Mega || Arduino_Type == Due || Arduino_Type == Mega2560) {
		//adds extra standoffs for Mega, if specified
		standoff(90.17, 50.8);
		standoff(96.52, 2.54);
		}
	}

// Draw walls for a given height (e.g. for arduino or shield)

module walls(height) {
	echo("walls ",height);
	difference() {
		cube(
			size=[caseLength,
				caseWidth,
				height],
			center=false);
		translate([Thickness_Of_Side_Walls_And_Bottom,Thickness_Of_Side_Walls_And_Bottom,-1]) {
				//main compartment
				cube(
					size=[base_x+2*Clearance_Between_Arduino_And_Sidewalls,
						base_y+2*Clearance_Between_Arduino_And_Sidewalls,
						height+2],
					center=false);
				}
		}
	}

// no longer used
module Arduino_lid() {
	cube( // bottom
			size=[base_x+2*Thickness_Of_Side_Walls_And_Bottom+2*Clearance_Between_Arduino_And_Sidewalls,
				base_y+2*Thickness_Of_Side_Walls_And_Bottom+2*Clearance_Between_Arduino_And_Sidewalls,
				Thickness_Of_Side_Walls_And_Bottom],
			center=false);
	translate([Thickness_Of_Side_Walls_And_Bottom,Thickness_Of_Side_Walls_And_Bottom,0])
		cube( // bottom
			size=[base_x+2*Clearance_Between_Arduino_And_Sidewalls,
				base_y+2*Clearance_Between_Arduino_And_Sidewalls,
				2*Thickness_Of_Side_Walls_And_Bottom],
			center=false);
	}

// Base, walls around arduino, with holes for connectors

module Arduino_case_body() {

	cube( // bottom
			size=[base_x+2*Thickness_Of_Side_Walls_And_Bottom+2*Clearance_Between_Arduino_And_Sidewalls,
				base_y+2*Thickness_Of_Side_Walls_And_Bottom+2*Clearance_Between_Arduino_And_Sidewalls,
				Thickness_Of_Side_Walls_And_Bottom],
			center=false);

	// standoffs
	translate([Thickness_Of_Side_Walls_And_Bottom+Clearance_Between_Arduino_And_Sidewalls, Thickness_Of_Side_Walls_And_Bottom+Clearance_Between_Arduino_And_Sidewalls, Thickness_Of_Side_Walls_And_Bottom]) {
		Arduino_standoffs();
		}

	// body...

	difference() {
		color("green") translate([0,0,Thickness_Of_Side_Walls_And_Bottom])
			walls(ard_height[Arduino_Type]);

		///////////////
		//Plug Holes //
		///////////////

		// LAP: made bottom of plug holes below line up to the top of the board
		if (Arduino_Type == Uno || Arduino_Type == Due || Arduino_Type == MegaADK || Arduino_Type == Mega2560 || Arduino_Type == EthernetArduino || Arduino_Type == Leonardo) {
			//Barrel DC Plug
			translate([Thickness_Of_Side_Walls_And_Bottom/2, 7.62+Thickness_Of_Side_Walls_And_Bottom+Clearance_Between_Arduino_And_Sidewalls,Board_Thickness+Height_Of_Power_Plug_Hole/2+Thickness_Of_Side_Walls_And_Bottom+Height_Of_Standoff]) {
			//power plug gap
			cube(size=[Thickness_Of_Side_Walls_And_Bottom+1, 8.89+2*Clearance_Between_Arduino_And_Sidewalls, Height_Of_Power_Plug_Hole], center=true);
			}
		}

	//USB Type B
	if (Arduino_Type == Uno || Arduino_Type == MegaADK || Arduino_Type == Mega2560) {
		translate([Thickness_Of_Side_Walls_And_Bottom/2, 38.1+Thickness_Of_Side_Walls_And_Bottom+Clearance_Between_Arduino_And_Sidewalls, Height_Of_USB_Plug_Hole/2+Thickness_Of_Side_Walls_And_Bottom+Height_Of_Standoff+Board_Thickness]) {
		//USB plug gap
			cube(size=[Thickness_Of_Side_Walls_And_Bottom+1, 11.43+2*Clearance_Between_Arduino_And_Sidewalls, Height_Of_USB_Plug_Hole], center=true);
			}
		}

	//USB Type Micro B 2 and USB Type Micro B 1
	if (Arduino_Type == Due ) {
		translate([Thickness_Of_Side_Walls_And_Bottom/2, 38.1+Thickness_Of_Side_Walls_And_Bottom+Clearance_Between_Arduino_And_Sidewalls, 7/2+Thickness_Of_Side_Walls_And_Bottom+Height_Of_Standoff+Board_Thickness]) {
			//	USB plug gap
			cube(size=[Thickness_Of_Side_Walls_And_Bottom+1, 5+2*Clearance_Between_Arduino_And_Sidewalls, 7], center=true);
			}

		translate([Thickness_Of_Side_Walls_And_Bottom/2, 22.225+Thickness_Of_Side_Walls_And_Bottom+Clearance_Between_Arduino_And_Sidewalls, 7/2+Thickness_Of_Side_Walls_And_Bottom+Height_Of_Standoff+Board_Thickness]) {
			//USB plug gap
			cube(size=[Thickness_Of_Side_Walls_And_Bottom+1, 5+2*Clearance_Between_Arduino_And_Sidewalls, 7], center=true);
			}
		}

	//Ethernet and Ethernet plug gap
	if (Arduino_Type == EthernetArduino ) {
		translate([Thickness_Of_Side_Walls_And_Bottom/2, 38.1+Thickness_Of_Side_Walls_And_Bottom+Clearance_Between_Arduino_And_Sidewalls, Height_Of_USB_Plug_Hole/2+Thickness_Of_Side_Walls_And_Bottom+Height_Of_Standoff+Board_Thickness]) {
			cube(size=[Thickness_Of_Side_Walls_And_Bottom+1, 11.43+2*Clearance_Between_Arduino_And_Sidewalls, Height_Of_USB_Plug_Hole], center=true);
			}
		}

	//USB Type Micro B and USB plug gap
	if (Arduino_Type == Leonardo ) {
		translate([Thickness_Of_Side_Walls_And_Bottom/2, 38.1+Thickness_Of_Side_Walls_And_Bottom+Clearance_Between_Arduino_And_Sidewalls, 7/2+Thickness_Of_Side_Walls_And_Bottom+Height_Of_Standoff+Board_Thickness]) {
			cube(size=[Thickness_Of_Side_Walls_And_Bottom+1, 5+2*Clearance_Between_Arduino_And_Sidewalls, 7], center=true);
			}
		}
	}

	// Label Arduino
	translate([5,0,Thickness_Of_Side_Walls_And_Bottom+Height_Of_Standoff])
		rotate([90,0,0]) scale([2,2,1]) write(ard_label[Arduino_Type]);

	}

// Make a  shield with label, height, and holes given

module makeShield(Label, Height, FrontHolePos,FrontHoleWidth,FrontHoleHeight,FrontHolePos2,FrontHoleWidth2,FrontHoleHeight2,BackHolePos,BackHoleWidth,BackHoleHeight) {
	echo("SHIELD", Height,FrontHolePos,FrontHoleWidth,FrontHoleHeight,FrontHolePos2,FrontHoleWidth2,FrontHoleHeight2,BackHolePos,BackHoleWidth,BackHoleHeight);
	// add board #previews

	// make walls and subtract holes
	difference() {
		union() {
			walls(Height);
			translate([5,0,Board_Thickness]) rotate([90,0,0]) scale([2,2,1]) write(Label);
			}
		translate([Thickness_Of_Side_Walls_And_Bottom/2, FrontHolePos+Thickness_Of_Side_Walls_And_Bottom+Clearance_Between_Arduino_And_Sidewalls, Height/2])
			cube(size=[Thickness_Of_Side_Walls_And_Bottom+1, FrontHoleWidth+2*Clearance_Between_Arduino_And_Sidewalls, FrontHoleHeight], center=true);
		translate([Thickness_Of_Side_Walls_And_Bottom/2, FrontHolePos2+Thickness_Of_Side_Walls_And_Bottom+Clearance_Between_Arduino_And_Sidewalls, Height/2])
			cube(size=[Thickness_Of_Side_Walls_And_Bottom+1, FrontHoleWidth2+2*Clearance_Between_Arduino_And_Sidewalls, FrontHoleHeight2], center=true);

		// FINISH THIS

		translate([base_x+Thickness_Of_Side_Walls_And_Bottom*1.5+2*Clearance_Between_Arduino_And_Sidewalls, BackHolePos+Thickness_Of_Side_Walls_And_Bottom+Clearance_Between_Arduino_And_Sidewalls, Height/2])
			cube(size=[Thickness_Of_Side_Walls_And_Bottom+1, BackHoleWidth+2*Clearance_Between_Arduino_And_Sidewalls, BackHoleHeight], center=true);
		}
	}

// shield of given type (i.e. provide hole info for known shields

module shield(shield_type) {
	if (shield_type>0) { // 0 means no shield

// keep: shield_type==Custom? CustomLabel : shield_label[shield_type]

				if (shield_type == Ethernet) {
					makeShield(shield_label[shield_type],shield_height[shield_type],38.1,13.43,Height_Of_Ethernet_Plug_Hole,0,0,0,0,0,0);
						}
					}
				if (shield_type == Custom) {
					makeShield(CustomLabel,CustomHeight,FrontHolePos,FrontHoleWidth,FrontHoleHeight,FrontHolePos2,FrontHoleWidth2,FrontHoleHeight2,BackHolePos,BackHoleWidth,BackHoleHeight);
					}
				if ((shield_type != Custom) && (shield_type != Ethernet) && (shield_type != None)) {
					makeShield(shield_label[shield_type],shield_height[shield_type],0,0,0,0,0,0,0,0,0);
					}
				}


////////////////////
//  Control Code  //
////////////////////

module case() {
	union() {
		//Joins case body with standoffs
		color("blue") Arduino_case_body();
		color("purple") translate([0,0,Thickness_Of_Side_Walls_And_Bottom+ard_height[Arduino_Type]])
			shield(Shield1);
		color("red") translate([0,0,Thickness_Of_Side_Walls_And_Bottom+ard_height[Arduino_Type]+shield_height[Shield1]])
			shield(Shield2);
		color("orange") translate([0,0,Thickness_Of_Side_Walls_And_Bottom+ard_height[Arduino_Type]+shield_height[Shield1]+shield_height[Shield2]])
			shield(Shield3);
		color("yellow") translate([0,0,caseHeight]) cube([caseLength,caseWidth,Thickness_Of_Side_Walls_And_Bottom]);
		// guides for assembly
		color("white") {
			translate([Thickness_Of_Side_Walls_And_Bottom,Thickness_Of_Side_Walls_And_Bottom,caseHeight-Thickness_Of_Side_Walls_And_Bottom])
				cube(Thickness_Of_Side_Walls_And_Bottom);
			translate([Thickness_Of_Side_Walls_And_Bottom,Thickness_Of_Side_Walls_And_Bottom,caseHeight-2*Thickness_Of_Side_Walls_And_Bottom])
				cube([caseLength-2*Thickness_Of_Side_Walls_And_Bottom,2*Thickness_Of_Side_Walls_And_Bottom,2*Thickness_Of_Side_Walls_And_Bottom]);
			translate([Thickness_Of_Side_Walls_And_Bottom,caseWidth-2*Thickness_Of_Side_Walls_And_Bottom,Thickness_Of_Side_Walls_And_Bottom])
				cube([caseLength-2*Thickness_Of_Side_Walls_And_Bottom,Thickness_Of_Side_Walls_And_Bottom,Height_Of_Standoff]);
			translate([Thickness_Of_Side_Walls_And_Bottom,Thickness_Of_Side_Walls_And_Bottom,Thickness_Of_Side_Walls_And_Bottom])
				cube([caseLength-2*Thickness_Of_Side_Walls_And_Bottom,Thickness_Of_Side_Walls_And_Bottom,Height_Of_Standoff]);
			translate([caseLength-2*Thickness_Of_Side_Walls_And_Bottom,
					Thickness_Of_Side_Walls_And_Bottom,
					Thickness_Of_Side_Walls_And_Bottom])
				cube([Thickness_Of_Side_Walls_And_Bottom,caseWidth-2*Thickness_Of_Side_Walls_And_Bottom-gap,Height_Of_Standoff]);
			translate([Thickness_Of_Side_Walls_And_Bottom,
					Thickness_Of_Side_Walls_And_Bottom,
					Thickness_Of_Side_Walls_And_Bottom])
				cube([Thickness_Of_Side_Walls_And_Bottom,caseWidth-2*Thickness_Of_Side_Walls_And_Bottom-gap,Height_Of_Standoff]);
		}

		}
	}

// intersect this with case to get the base
module bottomShape() {
	difference() {
		translate([-gap,-1-gap,-gap]) cube([caseLength+2*gap,caseWidth+1+2*gap,caseHeight+2*gap]);
		frontShape();
		backShape();
	}
}

// intersect this with case to get the front half
module frontShape() {
	mirror([1,0,0]) translate([-caseLength,0,0]) backShape();
	}

// intersect this with case to get the back half
module backShape() {
	// top
	translate([caseLength/2,-gap,caseHeight-gap])
		cube([caseLength/2+2*gap,caseWidth+2*gap,Thickness_Of_Side_Walls_And_Bottom+2*gap]);
	// left side
	translate([caseLength/2,caseWidth-Thickness_Of_Side_Walls_And_Bottom-gap,Thickness_Of_Side_Walls_And_Bottom+gap+hingeThick/2])
		cube([caseLength/2+2*gap,Thickness_Of_Side_Walls_And_Bottom+2*gap,caseHeight+Thickness_Of_Side_Walls_And_Bottom+2*gap-(Thickness_Of_Side_Walls_And_Bottom+gap+hingeThick/2)]);
	// right side
	translate([caseLength/2,-gap-1,Thickness_Of_Side_Walls_And_Bottom+gap+hingeThick/2])
		cube([caseLength/2+2*gap,1+Thickness_Of_Side_Walls_And_Bottom+2*gap,caseHeight+Thickness_Of_Side_Walls_And_Bottom+2*gap-(Thickness_Of_Side_Walls_And_Bottom+gap+hingeThick/2)]);
	// back
	translate([caseLength-Thickness_Of_Side_Walls_And_Bottom-gap,-gap,
			Thickness_Of_Side_Walls_And_Bottom+gap+hingeThick])
		cube([2*gap+Thickness_Of_Side_Walls_And_Bottom,caseWidth+2*gap,caseHeight+gap-(Thickness_Of_Side_Walls_And_Bottom+gap+hingeThick)]);
	// guides
	translate([caseLength/2,Thickness_Of_Side_Walls_And_Bottom,caseHeight-2*Thickness_Of_Side_Walls_And_Bottom-gap])
		cube([caseLength/2,2*Thickness_Of_Side_Walls_And_Bottom+gap,2*Thickness_Of_Side_Walls_And_Bottom+gap]);

	// translate([caseLength-hingeThick/2,caseWidth/2,hingeThick/2]) rotate([90,0,0])
//		difference() {
			// cylinder(r=hingeThick/2,h=caseWidth+2*gap,center=true, $fn=32);
			// translate([0,0,0]) cylinder(r=hingeThick+2*gap+1,
			// 	h=caseWidth-2*(gap+Thickness_Of_Side_Walls_And_Bottom),center=true, $fn=32);
			// }
	}

module caseBottom() {
	intersection() {
		case();
		bottomShape();
	}
}

module caseFront() {
	intersection() {
		case();
		frontShape();
	}
}

module caseBack() {
	intersection() {
		case();
		backShape();
	}
}

module front() {
	intersection(){
		case();
		cube([Thickness_Of_Side_Walls_And_Bottom, caseWidth, caseHeight+Thickness_Of_Side_Walls_And_Bottom]);
	}
}

module back() {
	intersection(){
		case();
		translate([caseLength-Thickness_Of_Side_Walls_And_Bottom,0,0]) cube([Thickness_Of_Side_Walls_And_Bottom, caseWidth, caseHeight+Thickness_Of_Side_Walls_And_Bottom]);
	}
}

// place hinge between standoffs
hingePos = caseWidth*.42;
frontHingePos = caseWidth/2;

module platedCase() {
	// bottom
	difference() {
		caseBottom();
		// minus holes for the two hinges
		translate([caseLength-hingeThick/2,hingePos,-1]) rotate([0,0,90])
			scale([.9,1,1]) demoHole(hingeThick,.5,0);
		translate([hingeThick/2,frontHingePos,-1]) rotate([0,0,90])
			scale([.9,1,1]) demoHole(hingeThick,.5,0);
		}

	// back
	difference() {
		translate([caseLength-hingeThick,0,0])rotate([0,90,0]) translate([-caseLength,0,0]) caseBack();
		translate([caseLength-hingeThick/2,hingePos,-1]) {
			rotate([0,0,90])
				scale([.9,1,1]) demoHole(hingeThick,.5,gap);
			//translate([0,(caseWidth/2-hingePos),hingeThick/2]) rotate([90,0,0]) cylinder(r=hingeThick+2*gap,h=caseWidth,center=true, $fn=32);
			}
		// hinge gap
		translate([caseLength-hingeThick/2,caseWidth/2,hingeThick/2]) rotate([90,0,0])
			cylinder(r=hingeThick+gap,h=caseWidth+2*gap,center=true, $fn=32);
		}

	// back hinge
	color("yellow") translate([caseLength-hingeThick/2,hingePos,0]) rotate([0,0,-90])
		scale([hingeScaleX,1,hingeScaleZ]) demo(hingeThick,gap/hingeScaleZ);
	echo("HINGE GAP ",gap);

	// front
	difference() {
		translate([hingeThick,0,0]) rotate([0,-90,0]) caseFront();
		translate([caseLength-hingeThick/2,hingePos,-1]) {
			rotate([0,0,90])
				scale([.9,1,1]) demoHole(hingeThick,.5,gap);
			//translate([0,(caseWidth/2-hingePos),hingeThick/2]) rotate([90,0,0]) cylinder(r=hingeThick+2*gap,h=caseWidth,center=true, $fn=32);
			}
		translate([hingeThick/2,caseWidth/2,hingeThick/2]) rotate([90,0,0])
			cylinder(r=hingeThick+gap,h=caseWidth+2*gap,center=true, $fn=32);
			}

	// front hinge
	color("yellow") translate([hingeThick/2,frontHingePos-1.25,0]) rotate([0,0,90])
		scale([hingeScaleX,1,hingeScaleZ]) demo(hingeThick,gap/hingeScaleZ);
	echo("HINGE GAP ",gap);

	}

if (part==0) platedCase();
if (part==1) rotate([0,90,0]) front();
if (part==2) translate([0,0,caseLength]) rotate([0,90,0]) back();
if (part==3) case();
if (part==10) {
	color("blue") frontShape();
	color("red") backShape();
	color("green") bottomShape();
	}
if (part==11) caseFront();
if (part==12) caseBack();
if (part==13) caseBottom();

//case();
//halfShape();
//topHalf();
//bottomHalf();
//front();

////////////////////
//   Hinge Code   //
////////////////////

// What diameter or thickness should the hinge have (in 0.01 mm units)?
//hinge_dia = 500; // [1:5000]

// How much gap should be left between separate parts (in 0.01 mm units)?
//hinge_gap = 40; // [1:2000]

module hingepair() {
	union() {
		cylinder(h=0.25, r=0.5);
		translate([0,0,0.25]) cylinder(h=0.25, r1=0.5, r2=0.25);
		translate([0,0,1]) cylinder(h=0.25, r1=0.25, r2=0.5);
		translate([0,0,1.25]) cylinder(h=0.25, r=0.5);
	}
}

module hingecore(gap) {
	union() {
		difference() {
			union() {
				cylinder(h=1.5, r=0.5);
				translate([-0.5,0,0.25+gap])
					cube(size=[1,1,1-gap-gap]);
				// corner
				translate([0,-0.5,0.25+gap])
					cube(size=[0.5,0.5,1-gap-gap]);
			}
			translate([0,0,0.25+gap-0.5]) cylinder(h=0.75, r1=1, r2=0.25);
			translate([0,0,1-gap]) cylinder(h=0.75, r1=0.25, r2=1);
		}
		translate([-0.5,0.5+gap,0])
			cube(size=[1,0.5-gap,1.5]);
	}
}

module hingeedge(gap) {
	union() {
		hingepair();
		translate([-0.5,-1,0])
			cube(size=[1,0.5-gap,1.5]);
		translate([-0.5,-1,0])
			cube(size=[1,1,0.25]);
		translate([-0.5,-1,1.25])
			cube(size=[1,1,0.25]);
		translate([0,0,1.25])
			cube(size=[0.5,0.5,0.25]);
		translate([0,0,0])
			cube(size=[0.5,0.5,0.25]);
	}
}

module hinge(thick, realgap) {
	hingeedge(realgap / thick);
	hingecore(realgap / thick);
}

module demoHole(t, rg, outer) {
	scale([t,t,t+t])
	translate([0-0.125,0,0.5])
	rotate(a=[0,90,0]) {
		cube([1,2,1.25*4+.25], center=true);
		if (outer) cylinder(r=.7,h=1.25*4+.75,center=true);
		}
	}

module demo(t, rg) { // modified to make only two hinges
	//demoHole(t, rg);
	scale([t,t,t])
	translate([-2.5,0,0.5])
	rotate(a=[0,90,0])
	union() {
		for (z=[0:1.25:3.75]) {
			color("grey") translate([0,0,z]) hinge(t, rg);
		}
		translate([0,1,0]) cube(size=[.5,gap,5.25]);
		//translate([1,-2,1.25]) cube(size=[1,1,5.25]);
	}
}