//Author:       Andrew Keech
//name:         candleThing.scad
//description:  A candle stick holder, used to hold candles. Can also have a bit of text on the base, maybe initials or whatever is wanted up to 3 letters before things get a bit weird. Most of the sizes can be customized to fit any candle.


$fn = 25;
include <write/Write.scad>;//For thingiverse
include <write.scad>;//For home use

//
//custamizable Variables
//

baseRadius = 20; // [20:200]
holderHeight = 75; // [20:200]
candleWidth = 10; // [5:200]
candleDepth = 10;	// [5:200]
//Limited to 3 characters
baseText = "A K";
//Add Spike to hold candle?(0=no, 1=yes)
addSpike = 0; // [0,1]
//Size of the cylinders in the legs
spiralBlockHeight = 2; // [1,2]

//
//Other variables
//

baseHeight = 10;
numberOfSteps = (holderHeight/spiralBlockHeight);
degreesPerStep = 90/(holderHeight/spiralBlockHeight);

//
//Base
//	

//main base cylinder
cylinder(r=baseRadius,h=baseHeight);
//text on the base
translate([0,baseRadius/1.75,baseHeight])rotate([0,0,180])write(baseText, center = true, h=baseRadius/2,t=baseHeight/2.5);
//text platform
translate([0,baseRadius/1.75,baseHeight*0.9])cube([baseRadius,baseRadius/1.8,baseHeight/3], center=true);

//
//Center (the 4 legs)
//

//+x,+y starts at positive x, and increases y
for(x = [0:1:holderHeight/spiralBlockHeight-spiralBlockHeight])
{
	translate([cos(degreesPerStep*x)*(baseRadius/2),sin(degreesPerStep*x)*(baseRadius/2),x*spiralBlockHeight])cylinder(r=baseRadius/5,h=spiralBlockHeight);
}

//-x,+y starts at negative x, and increases y
for(x = [0:1:holderHeight/spiralBlockHeight-spiralBlockHeight])
{
	translate([-(cos(degreesPerStep*x)*(baseRadius/2)),sin(degreesPerStep*x)*(baseRadius/2),x*spiralBlockHeight])cylinder(r=baseRadius/5,h=spiralBlockHeight);
}

//-x,-y starts at negative x, and decreases y
for(x = [0:1:holderHeight/spiralBlockHeight-spiralBlockHeight])
{
	translate([-(cos(degreesPerStep*x)*(baseRadius/2)),-(sin(degreesPerStep*x)*(baseRadius/2)),x*spiralBlockHeight])cylinder(r=baseRadius/5,h=spiralBlockHeight);
}

//+x,-y starts at positive x, and decreases y
for(x = [0:1:holderHeight/spiralBlockHeight-spiralBlockHeight])
{
	translate([cos(degreesPerStep*x)*(baseRadius/2),-(sin(degreesPerStep*x)*(baseRadius/2)),x*spiralBlockHeight])cylinder(r=baseRadius/5,h=spiralBlockHeight);
}

//
//TOP
//

//base plate for the holder part
translate([0,0,holderHeight-3])cylinder(r=baseRadius*0.75,h=3);
//creates the hollow cylinder that holds the candle
difference()
{
	translate([0,0,holderHeight-2])cylinder(r=candleWidth+5,h=candleDepth+3);
	translate([0,0,holderHeight-2])cylinder(r=candleWidth,h=candleDepth+10);	
}
//adds a skpike to help hold bigger candles in place if needed
if (addSpike == 1)
{
	intersection()
	{
		translate([0,0,holderHeight-2])cylinder(r=candleWidth,h=candleDepth+10);
		translate([0,0,holderHeight-2])cylinder(r1=1,h=candleDepth,r2=0);
	}
}

