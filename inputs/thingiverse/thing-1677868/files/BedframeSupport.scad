/*--------------------------------------------*/
/*  Castor Replacement Generator v1           */
/*  Created by Alex Keeling                   */
/*  thingiverse@keeling.me                    */
/*  License: Creative Commons - Public Domain */
/*  2016-7-17 First version on Thingiverse    */
/*--------------------------------------------*/

// preview[view:south west, tilt:top diagonal]

// How long should it be? (mm)
box_Length = 80; // [6:250]

// How wide should it be? (mm)
box_Width = 50; // [25:250]

// How tall should it be? (mm)
box_Height = 30; // [15:250]

//How deep should the groove be? (mm)
groove_Radius = 5; // [1:10]


/* [Hidden] */

grooveR = groove_Radius;
cylR = 5;
cylH = box_Height;
cylFN = 100;


boxW = box_Length - cylR * 2;
boxD = box_Width - cylR * 2;



difference(){
hull() {
translate([cylR, cylR, 0])
	cylinder(r=cylR, h=cylH, center=false, $fn=cylFN);

translate([cylR + boxD, cylR, 0])
	cylinder(r=cylR, h=cylH, center=false, $fn=cylFN);

translate([cylR, cylR + boxW, 0])
	cylinder(r=cylR, h=cylH, center=false, $fn=cylFN);

translate([cylR + boxD, cylR + boxW, 0])
	cylinder(r=cylR, h=cylH, center=false, $fn=cylFN);
}

translate([cylR + boxD / 2, -5, cylH])
	rotate([-90, 0, 0])
		cylinder(r=grooveR, h=boxW + cylR * 2 + 10, center=false, $fn=cylFN);
}

// Written by Alex Keeling 2016