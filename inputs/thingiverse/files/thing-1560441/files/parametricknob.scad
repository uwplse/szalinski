// by Hank Cowdog
// 2 Feb 2015
//
// based on FastRyan's
// Tension knob 
// Thingiverse Thing http://www.thingiverse.com/thing:27502/ 
// which was downloaded on 2 Feb 2015 
//
// GNU General Public License, version 2
// http://www.gnu.org/licenses/gpl-2.0.html
//
//This program is free software; you can redistribute it and/or
//modify it under the terms of the GNU General Public License
//as published by the Free Software Foundation; either version 2
//of the License, or (at your option) any later version.
//
//This program is distributed in the hope that it will be useful,
//but WITHOUT ANY WARRANTY; without even the implied warranty of
//MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//GNU General Public License for more details.
//
//
// 
//
//
//
// Finger points are the points on a star knob.
// Finger holes are the notches between each point.
// Larger values make for deeper holes.
// Too many/too deep and you may reduce knob size too much.
// If $TaperFingerPoints is true, the edges will be eased a little, making 
// for a nicer knob to hold/use. 
//

//Number of points on the knob
FingerPoints		= 5;   			//[3,4,5,6,7,8,9,10]

TaperFingerPoints	= true;			// true

//Diameter of the knob, in mm
KnobDiameter		= 22;			//[40:150]

//Thickness of knob, including the stem, in mm:
KnobTotalHeight 	= 8;			//[10:thin,20:normal,30:thick, 40:very thick]

//Ratio of stem to total height smaller makes for less of a stem under the knob:
StemHeightPercent =30.0/100.0;			// [0.3:0.8]

FingerHoleDiameter	=KnobDiameter/2.;

// The shaft is for a thru-hole.  Easing the shaft by a small percentage makes for
// easier insertion and makes allowance for ooze on 3D filament printers 

//Diameter of the shaft thru-bolt, in mm 
ShaftDiameter = 6;                   	//

ShaftEasingPercentage = 5/100.0;  // 10% is plenty


//
// Include Nut Captures at base of stem and/or on top of part
// If using a hex-head bolt for knob, include Top Nut Capture only.
// including both top and bottom captures allows creation of a knob 
// with nuts top and bottom for strength/stability when using all-thread rod
//

//Include a nut capture at the base (always has one on the top):
BaseNutCapture = 0;				// [1:Yes , 0:No]

TopNutCapture = 1;				//[1:Yes , 0:No]

NutFlatWidth = 1.75 * ShaftDiameter;
NutHeight =     0.87 * ShaftDiameter;
SineOfSixtyDegrees = 0.86602540378/1.0;

NutPointWidth = NutFlatWidth /SineOfSixtyDegrees;

StemDiameter= KnobDiameter/2.0;
StemHeight = KnobTotalHeight  * StemHeightPercent;

EasedShaftDiameter = ShaftDiameter * (1.0+ShaftEasingPercentage);

difference() {

// The whole knob
	cylinder(h=KnobTotalHeight, r=KnobDiameter/2, $fn=50);
	
// each finger point
	for ( i = [0 : FingerPoints-1] )
	{
    		rotate( i * 360 / FingerPoints, [0, 0, 1])
    		translate([0, (KnobDiameter *.6), -1])
		union() {

// remove the vertical part of the finger hole 
    			cylinder(h=KnobTotalHeight+2, r=FingerHoleDiameter/2, $fn=60);

// taper the sides of the finger points 
			if(TaperFingerPoints) {
				rotate_extrude(convexity = 10, $fn = 60)
					translate([FingerHoleDiameter/2.0, 0, 0])
					polygon( points=[[2,-3],[-1,6],[-1,-3]] );

			}
		}
	}


// Drill the shaft and nut captures
	translate([0, 0, KnobTotalHeight+1]) scale([1, 1, -1])
	union() {
//The thru-shaft
		cylinder(h=KnobTotalHeight+2, r=EasedShaftDiameter/2., $fn=50);
	
// Drill the nut capture
		if (1 == BaseNutCapture) {
			cylinder(h=NutHeight + 1, r=NutPointWidth/2.0, $fn=6);
		}
	}
	
// Drill the 2nd nut capture      
	if (1 == TopNutCapture) { 
		translate([0, 0, -1])
			cylinder(h=NutHeight + 1, r=NutPointWidth/2.0, $fn=6);
	}

// Torus removal to transition knob into stem
	translate([0, 0, KnobTotalHeight])
	rotate_extrude(convexity = 10, $fn = 50)
		translate([StemDiameter, 0, 0])
		circle(r = StemHeight, $fn = 50);

// taper the ends of the points
	if(TaperFingerPoints) {
		rotate_extrude(convexity = 10, $fn = 50)
		translate([KnobDiameter/2, 0, 0])
		polygon( points=[[-2,-3],[1,6],[1,-3]] );
	}
}	
