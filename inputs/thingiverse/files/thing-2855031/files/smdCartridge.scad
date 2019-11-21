// SMT drag strip feeder box for V4 cartridge for OpenPnP
// Copyright (c) R. Linder
// This work is licensed under a Creative Commons Attribution 4.0 International License.

// Width of the SMD tape
tape_width = 8;
// A small amount of clearance to add to tape size (Eg. 1.5)
slackness = 1.5;
// wall thickness
thickness=0.75;
// Cartridge Height
cheight = 100;

$fn=180;

//=================== I use these to gen stls in turn ===================
//LHS (); translate ([190,120,0]) rotate ([0,0,90]) motor_plate ();

//RHS();

//inserts ();

//spool (); translate ([30,0,0]) spool_cover ();

// A Cover that slots into the casset back
//cube ([tape_width-1, cheight-4, 1.5]);
//=========================================================================

//====================== Render a cartridge plate =========================
/*
color ("green") linear_extrude (height=4, convexity = 10) import (file = "smdCartridge_laser.dxf", layer = "0");

// Maybe add the inserts 
translate ([98,0,tape_width+6]) rotate ([0,180,00]) inserts ();
*/

//===================== A combined plate for TV ============================
/**/
LHS (); translate ([190,120,0]) rotate ([0,0,90]) motor_plate ();
RHS ();
inserts ();
translate ([20,130,0]) spool ();
translate ([50,130,0]) spool_cover ();
/**/
//==========================================================================

module inserts ()
{
	difference ()
	{
	union ()
	{
		linear_extrude (height=4+tape_width+slackness+thickness, convexity = 10)
			import (file = "smdCartridgeInsert.dxf", layer = "0");
	}
	translate ([cheight-4, 8, 2]) cube ([2, cheight-4, tape_width+0.5]);
		
	rotate ([90,0,0])  translate ([-3,1+tape_width+slackness+thickness,-cheight-1]) cylinder (d=2.5,h=7);
	rotate ([90,0,0]) translate ([-7,1+tape_width+slackness+thickness,-cheight-1])  cylinder (d=2.5,h=7);

	translate ([0,-5,tape_width+slackness+thickness]) cube ([cheight+1, cheight+5.1, 4.1]);
	}
}


module RHS ()
{
	difference ()
	{
		linear_extrude (height=4, convexity = 10)
			import (file = "smdCartridgeInsert2.dxf", layer = "LHS");
		
		translate ([0,0,1]) linear_extrude (height=4, convexity = 10)
			import (file = "smdCartridgeInsert2.dxf", layer = "LHB");
	}
}

module LHS ()
{
	difference ()
	{
		union ()
		{
			linear_extrude (height=4, convexity = 10)
				import (file = "smdCartridgeInsert2.dxf", layer = "RHS");
			linear_extrude (height=19, convexity = 10)
				import (file = "smdCartridgeInsert2.dxf", layer = "RH_STANDOFFS");
		}
		
		translate ([0,0,1]) linear_extrude (height=4, convexity = 10)
			import (file = "smdCartridgeInsert2.dxf", layer = "RHB");
	}
}

module motor_plate ()
{
	linear_extrude (height=3, convexity = 10)
		import (file = "smdCartridgeInsert2.dxf", layer = "Motor_Plate_3mm");
}

module spool_cover ()
{
	difference ()
	{
		cylinder (d=28, h=1.25);
		translate ([0,0,-1]) cylinder (d=5, h=4);
		translate ([-5,0,-1]) cylinder (d=2, h=4);
		translate ([5,0,-1]) cylinder (d=2, h=4);
	}
}

module spool ()
{
	difference ()
	{
		union ()
		{
			cylinder (d=28, h=1.25);
			cylinder (d=16, h=tape_width+2);
		}
		
		translate ([0,0,-1]) cylinder (d=5, h=tape_width+4);
		translate ([-5,0,-1]) cylinder (d=2, h=tape_width+4);
		translate ([5,0,-1]) cylinder (d=2, h=tape_width+4);
		
		translate ([-5,1.6,tape_width-3]) cube ([10,1,6]);
		translate ([-2.5,1.5,tape_width-3]) cube ([5,2,6]);
	}
}

