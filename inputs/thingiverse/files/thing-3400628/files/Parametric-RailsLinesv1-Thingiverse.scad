//Parametric_RailLinesv1.scad
//A script to generate 3D printable railway tracks that can be set for any gauge.

// Created by Hamish Trolove - Feb 2019
//www.techmonkeybusiness.com

//Licensed under a Creative Commons license - attribution
// share alike. CC-BY-SA

//No extra libraries are required and it works under 
//      OpenSCAD 2014 and OpenSCAD 2015.

//Length of Track
TrakLength = 180; 

//Height of the Rail
RailHt = 6;

//Number of Sleepers in TrackLength
NoSlprs = 8;

//Track Gauge (OS Railway System is 32mm)
TrakGage = 32;

//Sleeper length (OS Railway System is 50mm)
SlprLn = 50;

//Sleeper Width (OS Railway System is 10mm)
SlprWd = 10;

//Sleeper height (OS Railway System is 3mm)
SlprHt = 3;

//Track end style. 1 = join between sleepers, 2 = Join on sleepers
TrkTyp = 1;

//To have Sleepers = 1.  No sleepers = 0
SleepersYN = 1;


SLPRSpc =	TrakLength/NoSlprs; 	//Sleeper spacing
TrimCSidesLn = SlprLn*1.2; //End trimming cube length across tracks
TrimCSides = RailHt*1.5+SlprHt*2; //End trimming cube sides

//Conditionals for the different types of track sleeper placements
ShiftSlp = (TrkTyp==1)? (-0.5*SLPRSpc):(0);
NoSlprsAct = (TrkTyp==1)? (NoSlprs):(NoSlprs+1);


//Generate a reusable block for the sleeper ties
module SleeperPad(SLPrN)
{

	translate([0,-(SLPrN-1)*SLPRSpc+ShiftSlp,0])union()
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
	rotate([90,0,0])linear_extrude(height = TrakLength)
	{
		scale([RailHt,RailHt])
		polygon(points=[[-0.5,0],[-0.5,0.05],[-0.2,0.1],[-0.125,0.15],[-0.125,0.65],[-0.2,0.7],[-0.25,0.75],[-0.25,0.95],[-0.2,1],[0.2,1],[0.25,0.95],[0.25,0.75],[0.2,0.7],[0.125,0.65],[0.125,0.15],[0.2,0.1],[0.5,0.05],[0.5,0],[-0.5,0]],center = true, convexity = 10);
	}
}

module EndTrimmers()
{
	translate([0.25*TrimCSidesLn+0.5*RailHt,0.5*TrimCSides,0.20*TrimCSides])cube([TrimCSidesLn,TrimCSides,TrimCSides],center = true);
	translate([0.25*TrimCSidesLn+0.5*RailHt,-TrakLength-0.5*TrimCSides,0.20*TrimCSides])cube([TrimCSidesLn,TrimCSides,TrimCSides],center = true);
}

module CompStrtRails()
{
	union()
	{
		StraightRail();	
		for (SlprCount = [1:1:NoSlprsAct])
		{
			SleeperPad(SlprCount);
		}
	}
}



//Generating a complete Straight Rail
difference(){
	union()
	{
		CompStrtRails();
		translate([TrakGage+0.5*RailHt,0,0])CompStrtRails();  //The adjustment
	// to the gauge is to account for the width of the rail.

		if(SleepersYN == 1)
		{
			//Add sleepers
			for (SlprCount = [1:1:NoSlprsAct])
			{
				translate([0.5*(TrakGage+0.5*RailHt),-(SlprCount-1)*SLPRSpc+ShiftSlp,-SlprHt*0.5])cube([SlprLn,SlprWd,SlprHt],center = true);	
			}
		}
	}
	EndTrimmers();
}
