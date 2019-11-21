//------------------------------[ RHM Star Box ]------------------------------
//
//	Author:		    Robert H. Morrison
//	Date:			Sunday, 19 August 2012
//
//	Description:	This is my version of a parametric 8 point star box.
//
//					There are three primary variables: the inner radius (i.e. the
//					size of the hole, the wall Thickness (used for top, bottom
//					and lip) and the star box Height (the height of the box w/o
//					the lip/top.
//
//----------------------------------------------------------------------------

//---[ USER definable Parameters ]--------------------------------------------

part = "both";          // [both:Top and Bottom,top:Top Only,bottom:Bottom Only] 

$fn = 100;				//	I found that 100 is a good value for this object

iRadius    =   20;		//	inner Radius
wThickness =    3;		//	wall Thickness
sbHeight   =   93;		//	star box Height

sbLip      =   10;		//	star box Lip height
tFactor    = -100;		//	twist Factor (how twisty)

tGap       =    0.3;	//	the Gap (fudge factor):
						// This is how much of a gap we want to have between
						//	the inside of the top (cap) and the outside of the
						//	bottom lip.  Depends on your printer, but no matter
						//	how well you calibrate your printer it still should
						//	not be zero!

//---[ Automatically calculated Parameters ]----------------------------------

tTwist = (sbHeight * tFactor)/100;	//	true Twist
oRadius = iRadius + wThickness;		//	outer Radius
lSide = 2 * oRadius;				//	length of Side (of a square)

//---[ M O D U L E S ]--------------------------------------------------------

//---[ lip ]------------------------------------------------------------------

module lip() {
	rotate_extrude($fn=200)
		polygon(points=[[oRadius,0],[oRadius,wThickness],[iRadius,wThickness]]);
}

//---[ box ]------------------------------------------------------------------

module box() {
	difference() {
		union() {
			linear_extrude(height = sbHeight, center = false, convexity = 10, twist = tTwist)
				union() {
					rotate([0,0,45])
						square([lSide,lSide], true);
					square([lSide,lSide], true);
				}
	
			translate([0,0,wThickness])
				cylinder(r=oRadius,h=sbHeight+sbLip);
		}

		translate([0,0,sbHeight+sbLip])
			lip();
	
		translate([0,0,wThickness])
			cylinder(r=iRadius,h=sbHeight+sbLip+1);
	}
}

//---[ top ]------------------------------------------------------------------

module top() {
	difference() {
		union() {
			linear_extrude(height = sbLip+wThickness+wThickness, center = false, convexity = 10, twist = tTwist*(sbLip+wThickness)/sbHeight)
				union() {
					rotate([0,0,45])
						square([lSide,lSide], true);
					square([lSide,lSide], true);
				}
	
			translate([0,0,wThickness])
				cylinder(r=oRadius,h=sbLip);
		}

		translate([0,0,wThickness])
			cylinder(r=oRadius+tGap,h=sbLip+wThickness+1);
	}
}

//---[ B E D ]----------------------------------------------------------------

if (part == "bottom")
{
    box();
}
else if (part == "top")
{
    translate([3*lSide/2,0,0])
        top();
}
else if (part == "both")
{
    box();
    translate([3*lSide/2,0,0])
        top();
}
