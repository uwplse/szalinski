//Author: Sometimes Cake
//Date: 5/11/2014
//Modified Date: 2/6/2016 - modified for customizer changes.

//All measurement are in mm.

/* [Dimensions] */
//in mm:
BeadDiameter = 14.5; //[4:50]
HoleDiameter = 6; //[1:50]
SkewFactor = 100; //[1:400]

/* [Hidden] */
//sets the smoothness of the bead.
$fn = 50; 

difference() {
	scale ([1,1,SkewFactor/100])
		sphere (BeadDiameter/2);
	
	translate([0,0,(BeadDiameter*3)*(-1)])
		cylinder (BeadDiameter*6,HoleDiameter/2, HoleDiameter/2);
}