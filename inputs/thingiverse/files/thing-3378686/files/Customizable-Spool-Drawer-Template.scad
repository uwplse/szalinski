///////////////////////////////////////////////////////////////////////////////
//
// SpoolDrawerTemplate.scad
//
// This file creates a template which may be used to determine the location of
// hinge holes for mounting filament spool drawers like Thingiverse #3110569
// (https://www.thingiverse.com/thing:3110569) or similar.
//
// The template can be used to determine the hinge holes for 8, 6, 4, and 3
// drawers per spool.  It also allows for aligning holes on the two opposite
// rims of the spool.  It is completely configurable.
//
// Features include:
// - Configurable hub dimensions.
// - Arms labeled with their associated angle.
// - Arms contain tick marks to assist in making consistent distance from spool
//   center.
// - Configurable nunber and angle of arms.  Initially set 5 arms at 0, 45, 60,
//   90, and 120 degrees to support 8, 6, 4, and 3 drawers per spool.
//   NOTE: I can't figure out how to use customizer to fill an array, so if there
//         is a need to modify the number of arms or the angles of any of their
//         arms, the "ArmAnglesDEG" vector will need to be manually modified.
// - Configurable length vertical arm to insure that the holes on both rims of
//   the spool align correctly.
//
// Author: J. M. Corbett
//
// History:
// 1.00 1/24/2019 Initial code.
//
///////////////////////////////////////////////////////////////////////////////

/* [Hub Dimensions] */

// (mm) Minimum diameter of the spool's hub hole.
HubMinDiameterMM   = 52;    // [10:100]

// (mm) Maximum diameter of the spool's hub hole.
HubMaxDiameterMM   = 55;    // [10:100]

// Height of the template hub that will mate with the spool.
HubHeightMM        = 8;     // [1:50]

// (mm) Diameter of hole in the center of the template.
HubHoleDiameterMM  = 45;    // [0:99]


/* [Spool Dimensiions] */

// (mm) Maximum outside diameter of the spool.
SpoolMaxDiameterMM = 202;   // [20:300]

// (mm) Height of the spool.
SpoolMaxHeightMM   = 70;    // [10:150]


/* [Arm Dimensions] */

// (mm) Width of an arm.
ArmWidthMM         = 10;    // [6:50]

// (mm) Height (thickness) of an arm.
ArmHeightMM        = 4;     // [2:20]


/* [Hidden] */

// (degrees) Angles at which the arms will be generated.  Don't know how to 
//           make Customizer handle vectors.
ArmAnglesDEG       = [0, 360 / 3, 360 / 4, 360 / 6, 360 / 8];



///////////////////////////////////////////////////////////////////////////////
// ArmEnd()
// Generate the round end of an arm.  Argument "height" is the height of the
// generated arm end.  If this argument is omitted, the height of the arm will
// be used.
///////////////////////////////////////////////////////////////////////////////
module ArmEnd(height = ArmHeightMM)
{
    // Generate one quadrant of a cylinder.
    intersection()
    {
        // Generate a cylinder of the requested height.
        cylinder(r = ArmWidthMM, h = height);
        // // Lop off all but the first quadrant.
        cube([ArmWidthMM, ArmWidthMM, height]);
    }
}

///////////////////////////////////////////////////////////////////////////////
// Arm()
// Generate an arm.  Argument "s" is a text string to be used as a label for the
// arm.  If this argument is omitted, no label will be generated.
///////////////////////////////////////////////////////////////////////////////
module Arm(s = "")
{
    difference()
    {
        // Start with a conplete arm with rounded end.
        union()
        {
            cube([ArmWidthMM, SpoolMaxDiameterMM / 2, ArmHeightMM]);
            translate([0, SpoolMaxDiameterMM / 2, 0]) ArmEnd();
        }
        // Add (remove) tick marks to the arm.
        for (i = [SpoolMaxDiameterMM / 2 - 20 : 2 : SpoolMaxDiameterMM / 2 + 2])
        {
            translate([-.01, i, -.01]) cube([ArmWidthMM / 2, .8, ArmHeightMM / 3]);
        }
        
        // Add (remove) the label if one was requested.
        translate([ArmWidthMM / 4, SpoolMaxDiameterMM / 4, ArmHeightMM / 3 - .01]) rotate([0, 0, 90]) rotate([180, 0, 0]) linear_extrude(height = ArmHeightMM / 3) 
            text(text = str(s), size = ArmWidthMM / 2);
    }
}

///////////////////////////////////////////////////////////////////////////////
// Arms()
// Generate all the arms that are specified by "ArmAnglesDEG".
///////////////////////////////////////////////////////////////////////////////
module Arms()
{
    // Loop through all the angles specified by "ArmAnglesDEG".
    for (deg = ArmAnglesDEG)
    {
        rotate([0, 0, deg]) Arm(deg);
    }
}

///////////////////////////////////////////////////////////////////////////////
// Hub()
// Generate the hub at the center of the template.  The generated hub will be 
// tapered based on the values of "HubMaxDiameterMM" and "HubMinDiameterMM".
// NOTE: "HubMaxDiameterMM" must be greater than or equal to "HubMinDiameterMM".
///////////////////////////////////////////////////////////////////////////////
module Hub()
{
    $fn = 100;
    cylinder(d = HubMaxDiameterMM, h = ArmHeightMM);
    translate([0, 0, ArmHeightMM]) cylinder(r1 = HubMaxDiameterMM / 2, r2 = HubMinDiameterMM / 2, h = HubHeightMM);
}

///////////////////////////////////////////////////////////////////////////////
// Template()
// Generate the entire template.
///////////////////////////////////////////////////////////////////////////////
module Template()
{
    $fn = 100;
    difference()
    {
        // Add the arms, hub, and the single extended arm end.
        union()
        {
            Arms();
            Hub();
            translate([0, SpoolMaxDiameterMM / 2, 0]) ArmEnd(SpoolMaxHeightMM + ArmHeightMM);
        }
        // Remove the hub hole.
        translate([0, 0, -1]) cylinder(d = HubHoleDiameterMM, h = HubHeightMM + ArmHeightMM + 2);
    }
}


///////////////////////////////////////////////////////////////////////////////
// GENERATE THE ENTIRE TEMPLATE.
///////////////////////////////////////////////////////////////////////////////
Template();