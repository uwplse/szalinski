//Parametric_RailCurve_OSRailv0-Thingiverse.scad
// A script to generate 3D printable curved railway tracks that can be set for any
// gauge.  This script has been created to be compatible with relatively old
// OpenSCAD versions.  There are some efficiencies in the rotate_extrude
// function that have not been used.

// Created by Hamish Trolove - Feb 2019
//www.techmonkeybusiness.com

//Licensed under a Creative Commons license - attribution
// share alike. CC-BY-SA

//No extra libraries are required and it works under 
//      OpenSCAD 2014 and OpenSCAD 2015.


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

//Radius of railway centreline
CurveRad = 450;

//Segment angle
CurveSegAng = 20;

//OS Railways System Female Connector Diameter (Standard is 8mm)
FemLockD = 8;

//OS Railways System Male Connector Diameter (Standard is 8mm)
MalLockD = 7.6;


Railwidth = 0.5*RailHt; //OS railway Rail cap width is 2mm (but track
//profile used in this model is wider)

SLPRAngStp = (CurveSegAng-atan(SlprWd/CurveRad))/(NoSlprs-1); 	//Sleeper angle steps
TrimCSidesLn = SlprLn*1.2; //End trimming cube length across tracks
TrimCSides = RailHt*1.5+SlprHt*2; //End trimming cube sides


//Rail profile
module RailProfile()
{
	scale([RailHt,RailHt])polygon(points=[[-0.5,0],[-0.5,0.05],[-0.2,0.1],[-0.125,0.15],[-0.125,0.65],[-0.2,0.7],[-0.25,0.75],[-0.25,0.95],[-0.2,1],[0.2,1],[0.25,0.95],[0.25,0.75],[0.2,0.7],[0.125,0.65],[0.125,0.15],[0.2,0.1],[0.5,0.05],[0.5,0],[-0.5,0]],center = true, convexity = 10);
}

//Female connector cutter
module FemCttr()
{
	difference()
	{
		translate([0.5*(TrakGage+Railwidth),0.25*SlprWd,0])cylinder(h = (RailHt+SlprHt)*2, r=0.5*FemLockD, center = true, $fn = 50);
		translate([0.5*(TrakGage+Railwidth),0.5*SlprWd+0.25*FemLockD,0])cube([1.5*FemLockD,0.5*FemLockD,(RailHt+SlprHt)*2],center = true);
	}
}

//Male connector Adder
module MalAdder()
{
	difference()
	{
		translate([-0.5*(TrakGage+Railwidth),-0.25*SlprWd,0])cylinder(h = (RailHt+SlprHt)*2, r=0.5*MalLockD, center = true, $fn = 50);
		translate([-0.5*(TrakGage+Railwidth),-0.5*SlprWd-0.25*MalLockD,0])cube([1.5*MalLockD,0.5*MalLockD,(RailHt+SlprHt)*2],center = true);
	}
}

module EndSlpr()
{
	cube([SlprLn,SlprWd,SlprHt],center = true);
}


//Generate a reusable block for the sleeper ties
module SleeperPad()
{

	union()
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

//Create an object with two sleeper pads and sleepers correctly placed
module Slprs()
{
    union()
    {
        translate([-0.5*TrakGage-0.25*RailHt+CurveRad,0,0])SleeperPad();
        translate([0.5*TrakGage+0.25*RailHt+CurveRad,0,0])SleeperPad();
		translate([CurveRad,0,-0.5*SlprHt])cube([SlprLn,SlprWd,SlprHt],center = true);
    }
}


module Cutter()
{
	difference()
	{
		union()
		{
			translate([0,0,-(RailHt+SlprHt)*0.25])linear_extrude(height = (RailHt+SlprHt)*1.5)
			{
				polygon(points=[[0,0],[CurveRad+TrakGage+SlprLn,0],[CurveRad+TrakGage+SlprLn,(CurveRad+TrakGage+SlprLn)*tan(CurveSegAng)]]);
			}
		rotate([0,0,CurveSegAng])translate([CurveRad,0,RailHt*0.75])rotate([0,0,180])MalAdder();
		translate([CurveRad,0,RailHt*0.75])MalAdder();
		}
		union()
		{
			rotate([0,0,CurveSegAng])translate([CurveRad,0,RailHt*0.75])rotate([0,0,180])FemCttr();
			translate([CurveRad,0,RailHt*0.75])FemCttr();
		}
	}
}




module CurvedRail()
{
	rotate_extrude(angle = CurveSegAng, convexity = 10, $fn = 140 ) //Note: angle
   // does not work for pre 2016 versions of OpenSCAD.
	{
		translate([-0.5*TrakGage-0.25*RailHt+CurveRad,0,0])RailProfile();
		translate([0.5*TrakGage+0.25*RailHt+CurveRad,0,0])RailProfile();
	}
}

translate([-CurveRad,0,0])intersection()
{
	union()
	{
	    CurvedRail();
	    for (SlprCount = [1:1:NoSlprs+2])
	    {
	        rotate([0,0,SLPRAngStp*(SlprCount-1)+atan(0.5*SlprWd/CurveRad)])Slprs();
	    }
//Add the end pads
		rotate([0,0,-atan(0.5*SlprWd/CurveRad)])translate([CurveRad-0.25*RailHt,0,-0.5*SlprHt])cube([SlprLn-RailHt,SlprWd*1.4,SlprHt],center = true);
		rotate([0,0,CurveSegAng+atan(0.5*SlprWd/CurveRad)])translate([CurveRad-0.25*RailHt,0,-0.5*SlprHt])cube([SlprLn-RailHt,SlprWd*1.4,SlprHt],center = true);
	}
	Cutter();
}


