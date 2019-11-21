/*                                                 -*- c++ -*-
 * A Bahtinov mask generator.
 * Units in mm, default values are for
 * an 8 inch Newtonian
 *
 * Copyright 2013-2014, Brent Burton
 * License: CC-BY-SA
 *
 * Based on version updated: 2014-06-23
 *
 * Further modifications by Egil Kvaleberg
 * Latest update: 2014-01-26
 */

// Number of sections to split the mask in
sections = 0; // [1,2,4]

// Print which section, max is sections-1
section = 0; // [0,1,2,3]

// The overall diameter of the mask.
outerDiameter = 224.0; //

// The telescope light path diameter.
aperture = 212.0; // should be less than outerDiameter

// Diameter of secondary mirror holder. If no secondary, set to 0.
centerHoleDiameter = 0; // 

// Width of the bars.
gap = 3.3; // 3.3 is for 1000mm focal length; 4.0 for 1200mm; 6.0 for 2000mm

// Angle of bars
angle = 20; // 20 degrees is the standard value

// Maximum number of bars
maxBars = 10; // 

// Width of the strengthening bars.
bar = 10.0; 

// Height of gap mask
mHeight = 2.0;  // 

// Height of strengthening bars
bHeight = 6.0; // 

// Extra air needed between sections (times two) 
tol = 0.25; // Depends on the accuracy of your printer

d = 1 * 0.01;

/* create a series of bars covering roughly one half of the
 * scope aperture. Located in the +X side.
 */
module bars(gap, width, num=5) {
    num = round(num);
    for (i=[-num:num]) {
        translate([width/2,i*2*gap]) square([width,gap], center=true);
    }
}

module bahtinovBars(gap,width) {
    numBars = min(maxBars-1, aperture/2 / gap / 2 -1);
    // +X +Y bars
    intersection() {
        translate([0, outerDiameter*.08, 0]) rotate([0,0,angle]) bars(gap, width, numBars/2);
        square([outerDiameter/2, outerDiameter/2], center=false);
    }
    // +X -Y bars
    intersection() {
        translate([0, -outerDiameter*.08, 0]) rotate([0,0,-angle]) bars(gap, width, numBars/2);
        translate([0,-outerDiameter/2]) square([outerDiameter/2, outerDiameter/2], center=false);
    }
    // -X bars 
    rotate([0,0,180]) {
		if (sections<=2) bars(gap, width, numBars);
		else translate([0,gap,0]) bars(gap, width, numBars+1); 	 // offset so there is a solid bar in the middle
	}
}

$fn=72;
module bahtinov2D() {
    width = aperture/2;

    union() {
        difference() {                  // trims the mask to aperture size
            circle(r=aperture/2+1);
            bahtinovBars(gap,width);
        }
        difference() {                  // makes the outer margin
            circle(r=outerDiameter/2-1);
            circle(r=aperture/2);
        }
        // Add horizontal and vertical structural bars:
		  square([bar,2*(aperture/2+1)], center=true);

        if (sections==4) square([2*(aperture/2+1),bar], center=true);
		  else translate([aperture/4,0]) square([aperture/2+1,bar], center=true);
        // Add center hole margin if needed:
        if (centerHoleDiameter > 0 && centerHoleDiameter < outerDiameter) {
            circle(r=(centerHoleDiameter)/2+gap);
        }
    }
}

module bahtinov() {
   difference() {                          // overall plate minus center hole	
		union() {
	   		linear_extrude(height=mHeight) bahtinov2D();
			// Add strengthening bars
	       difference() {
	          cylinder(r=outerDiameter/2, h=bHeight);
	          translate([0,0,-d]) cylinder(r=aperture/2+1, h=bHeight+2*d);
	       }
	       // Add horizontal and vertical structural bars:
	       translate([0,0,bHeight/2]) 
				cube([bar*.75,2*(aperture/2+1),bHeight], center=true);
	       if (sections==4) translate([0,0,bHeight/2]) 
				cube([2*(aperture/2+1),bar*.75,bHeight], center=true);
			else translate([aperture/4,0,bHeight/2]) 
				cube([aperture/2+1,bar*.75,bHeight], center=true);
	
	  		// Add a little handle
	    	translate([outerDiameter/2-bar,0,0]) hull () {
				cylinder(r=bar*.4, h=12);
				translate([-12,0,0]) cylinder(r=bar*.4, h=12);
			}
		}
      // subtract center hole if needed
      if (centerHoleDiameter > 0 && centerHoleDiameter < outerDiameter) {
          translate([0,0,-0.1]) cylinder(r=centerHoleDiameter/2+1, h=bHeight+0.2);
      }
   }
}

// create the outline that defines the cut between sections 
module section() {
 	// the factor 20 can be tuned
	step = (outerDiameter-centerHoleDiameter-bar)/20;

	if (sections==2) translate([bar/4+tol, -outerDiameter/2, 0])
		cube([outerDiameter/2, outerDiameter, mHeight+12]);
	else translate([bar/4+tol, bar/4+tol, 0])
		cube([outerDiameter/2, outerDiameter/2, mHeight+12]);
	rotate ([0,0,(sections==2)?-90:0]) {
		for (x=[centerHoleDiameter/2+bar/2:2*step:outerDiameter/2-step]) {
			translate([x,-bar/8,0]) 
				hull () {
					cylinder(r=bar/8-tol, h=mHeight+12);
					translate([step,0,0]) cylinder(r=bar/8-tol, h=mHeight+12);
				}
			difference () {
				translate([x,-tol,0]) cube([step, bar/4+2*tol, mHeight+12]);
				translate([x,bar/8,-d]) { 
					cylinder(r=bar/8+tol, h=mHeight+12+2*d);
	 				translate([step,0,0]) cylinder(r=bar/8+tol, h=mHeight+12+2*d);
				}
			}
		}
		// filler at start
		translate([centerHoleDiameter/2+tol+((centerHoleDiameter>0 || sections==2 || section==0 || section==2)? 0: bar/4),-bar/4+tol,0]) cube([step, bar/2, mHeight+12]);
	}

	for (y=[centerHoleDiameter/2+bar/2+step:2*step:outerDiameter/2-step]) {
		translate([-bar/8,y,0]) 
			hull () {
				cylinder(r=bar/8-tol, h=mHeight+12);
				translate([0,step,0]) cylinder(r=bar/8-tol, h=mHeight+12);
			}
		difference () {
			translate([-tol,y,0]) cube([bar/4+2*tol, step, mHeight+12]);
			translate([bar/8,y,-d]) { 
				cylinder(r=bar/8+tol, h=mHeight+12+2*d);
 				translate([0,step,0]) cylinder(r=bar/8+tol, h=mHeight+12+2*d);
			}
		}
	}
	// filler at end
	translate([-bar/4+tol,outerDiameter/2-bar/2,0]) cube([bar/2, step, mHeight+12]);
}
	
px = (360 / sections) * section;
qx = (sections == 2) ? 90 + 45 : 0;

if (sections > 1) {
	rotate([0, 0, qx]) intersection () {
		bahtinov();	
		rotate([0, 0, px]) section();
	}
} else {
	bahtinov();	
}