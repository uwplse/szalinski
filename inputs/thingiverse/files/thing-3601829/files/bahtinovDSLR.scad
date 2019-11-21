/*                                                 -*- c++ -*-
 * A Bahtinov mask generator fo DSLR lenses.
 * Units in mm,
 *
 * Copyright 2013-2018, Brent Burton, Eric Lofgren, Robert Rath
 * License: CC-BY-SA
 *
 * Updated: Brent Burton 2014-06-23
 */
 
/* 
 * Modified by Eric Lofgren 2016-07-18 to add external tabs.
 *
 * This is a modification of brentb's Bahtinov mask generator.
 * See his post for details. I added a way to have tabs extend on the outside
 * of my telescope. The number and size of tabs are parametrized in the scad
 * file. Be sure to specify the outer diameter of your telescope to make it
 * fit--the tabs are added beyond the specified diameter.
 * A pull-handle is not necessary and would make printing very difficult,
 * so I just commented it out.
 */
 
/*
 * Modified by Robert Rath 2018-03-12 to
 * 
 * a) Tabulated dimensions to suit a variety of DSLR Lenses.
 * b) Added chamfers to tabs.
 * c) Corrected the maths to allow arbitrary tab thickness.
 *
 * This modification extends Eric Lofgren's modifications to Brent Burton's
 * original Bahtinov mask generator specifically targeting a collection of
 * DSLR lenses rather than a single lens.
 * 
 * A table of lenses and their attributes is the source for mask creation.
 * Simply uncomment the lens you wish to create a mask for or add new
 * lenses to the table as per the layout in the SCAD file.
 *
 * Updated : Robert Rath 2018-03-12 : Added Sigma Sport 150-600mm
 *
 * Please let me know if you add new lenses and I will update this file.
 */

// List of Available Lenses
sigmaArt50mm                = 0;
canon100mmF28L              = 1;
canon70to20mmF28L2          = 2;
sigmaSport150to600mm        = 3;
PL100to400mm                = 4;

// Uncomment One Lens To Render 
//Lens = sigmaArt50mm;
//Lens = canon100mmF28L;
//Lens = canon70to20mmF28L2;
//Lens = sigmaSport150to600mm;
Lens = PL100to400mm;

// Attributes Index 
outerDiameterIndex          = 0; // The physical diameter of the lens.
apertureIndex               = 1; // The aperture diameter at the lens extremity.
gapIndex                    = 2; // The width of the gaps and the bars.
ringHeightIndex             = 3; // The height of the retaining ring. 

// Lens Details               [diameter, aperture, slot, height]
sigmaArt50mmDetails         = [ 85.3,     74.0,     0.50,  15.0  ];
canon100mmF28LDetails       = [ 76.7,     50.0,     0.50,  15.0  ];
canon70to20mmF28L2Details   = [ 87.9,     76.0,     1.00,  15.0  ];
sigmaSport150to600mmDetails = [117.9,     96.0,     1.50,  15.0  ];
PL100to400mmDetails         = [ 88.5,     75.0,     1.33,  15.0  ];

// Collection Of All Lenses 
Lenses = [sigmaArt50mmDetails, canon100mmF28LDetails, canon70to20mmF28L2Details, sigmaSport150to600mmDetails, PL100to400mmDetails];

// Interfere with the lens diameter in order to grip the lens.
ringTabInterference = -1.2;     // oversize and use 1mm felt pads

// The diameter of the secondary mirror holder. If no secondary then set to 0.
centerHoleDiameter = 0;

// The thickness of the retaining ring in mm.
ringThickness = 1.6;

// The number of ring pieces.
ringPieces = 3; 

// The angle of the three pieces in the retaining ring. Use (360/ringPieces) for a solid ring.
ringPiece = 30;

// The Rotation of he retaining ring pieces with respect to the mask (in degrees).
ringRotation = 0;

// Assign lens attributes
outerDiameter = Lenses[Lens][outerDiameterIndex]-ringTabInterference;
aperture      = Lenses[Lens][apertureIndex];
gap           = Lenses[Lens][gapIndex];
ringHeight    = Lenses[Lens][ringHeightIndex];

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

$fn=200;
module bahtinov2D() {
    width = aperture/2;
    difference() {                          // overall plate minus center hole
        union() {
            difference() {                  // trims the mask to aperture size
                circle(r=aperture/2+1);
                bahtinovBars(gap,width);
            }
            difference() {                  // makes the outer margin
                circle(r=outerDiameter/2+ringThickness);  // Re-written to make the ringThickness independent.
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
    difference()
    {
        cylinder(h=ringHeight+2,d=outerDiameter+2*ringThickness);
        translate([0,0,-1])cylinder(h=ringHeight+4,d=outerDiameter);
        for(angle=[0:360/ringPieces:359])
        {
            rotate([0,0,angle])
            linear_extrude(height=ringHeight+4)
            pie_slice(r=outerDiameter/2+2*ringThickness,deg=360/ringPieces-ringPiece);    
        }

        // chamfer the leading edges of the clips 
        translate([0,0,ringHeight+(ringThickness/2)+(outerDiameter-sqrt(10*sqrt(2)))/2])
        {
            sphere(sqrt(2*((ringThickness/2)+(outerDiameter-sqrt(10*sqrt(2)))/2)*((ringThickness/2)+(outerDiameter-sqrt(10*sqrt(2)))/2)));
        }    
    }
}

union() {
    linear_extrude(height=2) bahtinov2D();
    // add a little handle //Eric removed so it would print easier
    // translate([outerDiameter/2-gap,0,0]) cylinder(r=gap/2, h=12);
    
    //add a retaining ring
    rotate([0,0,ringRotation]) retainingring();
}
