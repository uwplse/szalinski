// by Les Hall
// started Fri May 30 2014
// 
// 
// This structure is an antenna.  It is a space filling 3D H-Tree design
// that has a 2^n periodic bandwidth.  It contains electronics which 
// enable it to receive and transmit at any desired frequency or band of
// frequencies.  This object is printed in conductive material with embedded
// integrated circuits.  
// 
// Each sphere and each rod is printed separately and the final structure 
// gets coated with a conductive polymer.  Circuitry placed in each sphere
// has three contacts:  base, - and +.  Reception and transmission of 
// signals occurs by monitoring and / or driving these pins.  
// 
// the antenna is held by the central bar grip or by gently holding the 
// outside of it.  It generates it's own power from received radio signals
// and transmits to and from local devices via bluetooth and wifi.  
// 
// This structure is also used as a gripper building material.  As such it 
// has properties of efficient space filling and the ability to adhere the
// material to other material blocks by simply pressing them together.  
// 



/* [Base Geometry] */

// number of levels to fabricate (levels)
levels = 8;

/* [Details] */

// curvature smoothness (faces)
$fn = 8;

/* [Hidden] */


// by Oskar
// emailed to me on Tue May 6, 2014
// i changed it a little...  

// a branch, 16 long, 1 wide
module branch() {
	color([0.25, 0.75, 0.75])
	cylinder(h=16,r=1, center=true);
}

module tree(level) {
	branch();

	if (level > 0)
	for (side = [-1:2:1])       	// generate 2 children
	translate([0, 0, side * 8])   // translate up to the tip of the branch
	rotate(180 + side * 90)       // rotated at different angles 
	rotate(90, [1, 0, 0])      	// branching angle
	scale(0.8)
	tree(level-1);
}

rotate(360*$t, [0.25, 0.5, 1])	// animate!  
tree(levels);