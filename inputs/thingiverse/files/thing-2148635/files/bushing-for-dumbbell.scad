// This work is licensed under a Creative Commons Attribution-ShareAlike 3.0 Unported License.
// https://creativecommons.org/licenses/by-sa/3.0/

include <polyScrewThread.scad>

// how deep the bushing should go into the weight plate
plateBushingDepth = 20;
// diameter of hole in the weight plate
plateHoleDiameter = 29;
// diameter of the flange on your bar
flangeDiameter = 34;
// how thick the flange on this bushing should be
flangeThickness = 2;
// outer diameter of threads on bar
barThreadOuterDiameter = 25.4;
// inner diameter of threads on bar
barThreadInnerDiameter = 23;

difference() {
	$fn=36;
	union() {
		cylinder(d=plateHoleDiameter, h=flangeThickness + plateBushingDepth);
		cylinder(d=flangeDiameter, h=flangeThickness);
	}
	union() {
		intersection() {
			translate([0,0,0]) mirror([-1,0,0])
				screw_thread(30.6, 5.7, 36, 25, 1.5707963267948966, 0);
			cylinder(d=barThreadOuterDiameter, h=25);
		}
		cylinder(d=barThreadInnerDiameter, h=25);
	}
}
