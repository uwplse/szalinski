$fn=100;

/****************************************************/
// Vertical universal HDD bearing to spool holder by DrZoid
// Made for my FLSUN3D / Kossel Delta 3D printer
// You can adjust height, size and number of steps
// The HDD bearing is fitted with force in the base
// Can be printed without support with 20% infill without any problem
/****************************************************/

//Edit the step height
stepHeight = 8;

//Edit here the base height and width
baseHeight = 2;
baseWidth = 80;

//Add or remove steps if you want here
steps = [71, 51, 31];


module step(h, d) {
	union() {
		cylinder(h-2, d/2, d/2);
		translate([0, 0, h-2])
			cylinder(2, d/2, d/2-2);
	}
}

module tower() {
	union() {
		translate([0, 0, 0])
			cylinder(baseHeight, baseWidth/2, baseWidth/2);
		for(i=[0:len(steps)-1]) {
			translate([0, 0, baseHeight + (i*stepHeight)])
			step(stepHeight, steps[i]);
		}
	}
}

/* Represent a 3.5 HDD bearing */
module bearing() {
	union() {	
		translate([0,0,-.1])
			cylinder(4.7, 33.2/2, 33.2/2);
		translate([0,0,4.5])
			cylinder(1.3, 29.8/2,29.8/2);
		translate([0,0,4.6+1.2-.1])
			cylinder(12.1, 24.8/2,24.8/2);
	}
}

difference() {
	tower();
	bearing();	
}