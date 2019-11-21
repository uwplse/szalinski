//Parametric_RailLines_OSRailv0-Thingiverse.scad
//A script to generate 3D printable railway tracks
// that can be set for any gauge.
// This script also includes the special end sleepers
// that allow the track sections to clip together.

// Created by Hamish Trolove - Feb 2019
//www.techmonkeybusiness.com

//Licensed under a Creative Commons license - attribution
// share alike. CC-BY-SA

//No extra libraries are required and it works under 
//      OpenSCAD 2014 and OpenSCAD 2015.

//Length of Track (excluding clips)
TrakLength = 180;

//Height of the Rail
RailHt = 6;

//Number of Sleepers in Track Length
NoSlprs = 8;

//Track Gauge (OS Railway System is 32mm)
TrakGage = 32;

//Sleeper length (OS Railway System is 50mm)
SlprLn = 50;

//Sleeper Width (OS Railway System is 10mm)
SlprWd = 10;

//Sleeper height (OS Railway System is 3mm)
SlprHt = 3;

//OS Railways System Female Connector Diameter (Standard 8mm)
FemLockD = 8;

//OS Railways System Male Connector Diameter (Standard 7.8mm)
MalLockD = 7.6;



Railwidth = 0.5*RailHt; //OS railway Rail cap width is 2mm (but track
//profile used in this model is wider)

SLPRSpc = (TrakLength-SlprWd)/(NoSlprs-1); 	//Sleeper spacing
TrimCSidesLn = SlprLn*1.2; //End trimming cube length across tracks
TrimCSides = RailHt*1.5+SlprHt*2; //End trimming cube sides
ExtTrakLength = TrakLength+1.2*SlprWd;	//Extended length to allow
	//compatible connector cuts.


//Base Sleeper
module BaseSlpr(BSHt)
{
	cube([SlprLn,SlprWd,BSHt],center = true);
}

//Female connector cutter
module FemCttr(FCHt)
{
	difference()
	{
		translate([0.5*(TrakGage+Railwidth),-0.25*SlprWd,0])cylinder(h = FCHt, r=0.5*FemLockD, center = true, $fn = 50);
		translate([0.5*(TrakGage+Railwidth),0.25*FemLockD,0])cube([1.5*FemLockD,0.5*FemLockD,FCHt],center = true);
	}
}

//Male connector Adder
module MalAdder(MAHt)
{
	difference()
	{
		translate([-0.5*(TrakGage+Railwidth),-0.75*SlprWd,0])cylinder(h = MAHt, r=0.5*MalLockD, center = true, $fn = 50);
		translate([-0.5*(TrakGage+Railwidth),-(SlprWd+0.25*MalLockD),0])cube([1.5*MalLockD,0.5*MalLockD,MAHt],center = true);
	}
}

module EndSlpr(BlkHt)
{
	difference()
	{
		union()
		{
			MalAdder(BlkHt);
			BaseSlpr(BlkHt);
		}
		FemCttr(BlkHt);
	}
}





//Generate a reusable block for the sleeper ties
module SleeperPad(SLPrN)
{

	translate([0,-SLPrN*SLPRSpc-0.5*SlprWd,0])union()
	{
		translate([0,RailHt*0.175,0])rotate([90,0,0])linear_extrude(height = RailHt*0.35)
			{
			scale([RailHt,RailHt])polygon(points=[[-0.35,0.05],[-0.35,0.15],[-0.3,0.175],[0.3,0.175],[0.35,0.15],[0.35,0.05],[-0.35,0.05]]);
			}
		translate([0,0,RailHt*0.06])cube([RailHt*1.5,RailHt*0.8,RailHt*0.12],center = true);
		translate([RailHt*0.55,RailHt*0.25,RailHt*0.16])cylinder(r = RailHt*0.15, h = RailHt*0.08, center = true, $fn = 6);
		translate([RailHt*0.55,-RailHt*0.25,RailHt*0.16])cylinder(r = RailHt*0.15, h = RailHt*0.08, center = true, $fn = 6);
		translate([-RailHt*0.55,RailHt*0.25,RailHt*0.16])cylinder(r = RailHt*0.15, h = RailHt*0.08, center = true, $fn = 6);
		translate([-RailHt*0.55,-RailHt*0.25,RailHt*0.16])cylinder(r = RailHt*0.15, h = RailHt*0.08, center = true, $fn = 6);
	}
}


module StraightRail()
{
	translate([0,0.6*SlprWd,0])rotate([90,0,0])linear_extrude(height = ExtTrakLength)
	{
		scale([RailHt,RailHt])
		polygon(points=[[-0.5,0],[-0.5,0.05],[-0.2,0.1],[-0.125,0.15],[-0.125,0.65],[-0.2,0.7],[-0.25,0.75],[-0.25,0.95],[-0.2,1],[0.2,1],[0.25,0.95],[0.25,0.75],[0.2,0.7],[0.125,0.65],[0.125,0.15],[0.2,0.1],[0.5,0.05],[0.5,0],[-0.5,0]],center = true, convexity = 10);
	}
}

module EndTrimmer()
{
	union()
	{
	
		translate([0.25*TrimCSidesLn+0.5*RailHt,-0.5*TrakLength-0.15*SlprWd,0.20*TrimCSides])cube([TrimCSidesLn,TrakLength-1.5*SlprWd,TrimCSides],center = true);
		translate([0.5*(TrakGage+Railwidth),-0.5*SlprWd,0.20*TrimCSides])rotate([0,0,180])EndSlpr(TrimCSides);
		translate([0.5*(TrakGage+Railwidth),-TrakLength+0.5*SlprWd,0.20*TrimCSides])EndSlpr(TrimCSides);
	}
}





module CompStrtRails()
{
	union()
	{
		StraightRail();	
		for (SlprCount = [0:1:NoSlprs-1])
		{
			SleeperPad(SlprCount);
		}
	}
}



//Generating a complete Straight Rail
intersection(){
	union()
	{
		CompStrtRails();
		translate([TrakGage+0.5*RailHt,0,0])CompStrtRails();  //The adjustment
	// to the gauge is to account for the width of the rail.

		//Add sleepers
		for (SlprCount = [1:1:NoSlprs-2])
		{
			translate([0.5*(TrakGage+0.5*RailHt),-SlprCount*SLPRSpc-0.5*SlprWd,-SlprHt*0.5])cube([SlprLn,SlprWd,SlprHt],center = true);	
		}
		//Add end sleepers
		translate([0.5*(TrakGage+Railwidth),-0.5*SlprWd,-SlprHt*0.5])rotate([0,0,180])EndSlpr(SlprHt);
		translate([0.5*(TrakGage+Railwidth),-TrakLength+0.5*SlprWd,-SlprHt*0.5])EndSlpr(SlprHt);
	}
	EndTrimmer();
}

