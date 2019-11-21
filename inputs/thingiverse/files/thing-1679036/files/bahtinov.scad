/*                                                 -*- c++ -*-
 * A Bahtinov mask generator.
 * Units in mm, default values are for
 * a Celestron NexStar GPS 8.
 *
 * Copyright 2013-2014, Brent Burton
 * License: CC-BY-SA
 *
 * Updated: 2014-06-23
 */
 
/*
 Modified by Eric 2016:
 For installation over the outside of the end of a telescope instead of inside
 Default values are for an Orion XT4.5
*/ 


// This is the diameter of the mask. For this version use the OD of your scope.
outerDiameter = 146; // [80:400]

// The telescope light's path diameter.
aperture = 114; // [80:400]

// Diameter of secondary mirror holder. If no secondary, set to 0.
centerHoleDiameter = 0; // [0:90]

// Width of the gaps and the bars.
gap = 5; // [4:10]

//height of the retaining ring in mm
ringHeight=20;

//thickness of the retaining ring in mm
ringThickness=5;

//number of ring pieces
ringPieces=3; 

//angle of the three pieces in the retaining ring. Use (360/ringPieces) for a solid ring.
ringPiece=30;

//rotate the retaining ring pieces with respect to the mask (in degrees)
ringRotation=0;


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
    numBars = aperture/2 / gap / 2 -1;
    // +X +Y bars
    intersection() {
        rotate([0,0,30]) bars(gap, width, numBars);
        square([outerDiameter/2, outerDiameter/2], center=false);
    }
    // +X -Y bars
    intersection() {
        rotate([0,0,-30]) bars(gap, width, numBars);
        translate([0,-outerDiameter/2]) square([outerDiameter/2, outerDiameter/2], center=false);
    }
    // -X bars
    rotate([0,0,180]) bars(gap, width, numBars);
}

$fn=72;
module bahtinov2D() {
    width = aperture/2;
    difference() {                          // overall plate minus center hole
        union() {
            difference() {                  // trims the mask to aperture size
                circle(r=aperture/2+1);
                bahtinovBars(gap,width);
            }
            difference() {                  // makes the outer margin
                circle(r=outerDiameter/2+ringThickness/2+1);  //Eric removed the -1 and replaced with +ringThickness/2+1
                circle(r=aperture/2);
            }
            // Add horizontal and vertical structural bars:
            square([gap,2*(aperture/2+1)], center=true);
            translate([aperture/4,0]) square([aperture/2+1,gap], center=true);
            // Add center hole margin if needed:
            if (centerHoleDiameter > 0 && centerHoleDiameter < outerDiameter) {
                circle(r=(centerHoleDiameter+gap)/2);
            }
        }
        // subtract center hole if needed
        if (centerHoleDiameter > 0 && centerHoleDiameter < outerDiameter) {
            circle(r=centerHoleDiameter/2+1);
        }
    }
}

module pie_slice(r = 10, deg = 30) {
    degn = (deg % 360 > 0) ? deg % 360 : deg % 360;
    echo(degn);
    difference() {
        circle(r);
        if (degn > 180) intersection_for(a = [0, 180 - degn]) rotate(a) translate([-r, 0, 0]) #square(r * 2);
        else union() for(a = [0, 180 - degn]) rotate(a) translate([-r, 0, 0]) square(r * 2);
    }
}


module retainingring(){
    difference(){
    cylinder(h=ringHeight+2,d=outerDiameter+ringThickness+2);
    translate([0,0,-1])cylinder(h=ringHeight+4,d=outerDiameter+2);
    for(angle=[0:360/ringPieces:359]){
        rotate([0,0,angle])
            linear_extrude(height=ringHeight+4)
                pie_slice(r=outerDiameter/2+ringThickness,deg=360/ringPieces-ringPiece);    
        }
    }
}





union() {
    linear_extrude(height=2) bahtinov2D();
    // add a little handle //Eric removed so it would print easier
    //translate([outerDiameter/2-gap,0,0]) cylinder(r=gap/2, h=12);
    
    //add a retaining ring
    rotate([0,0,ringRotation]) retainingring();
    
    
}
