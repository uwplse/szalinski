//#############################################################################
//
// Customizable magnetic squares
// =============================
//
// These little tools are very useful for paper, card or plastic modelling
// where pieces need to be attached upright or at ninety degree angles.
//
// Two shapes can be printed: an L-shaped square, and a rectangle shaped one.
// Given the same input dimensions, the rectangle shaped part fits precisely
// into the corner of the L-shaped square.
//
// The magnetic squares can be printed in different sizes, depending
// on your particular need. Both disc and rectangle shaped magnets of
// configurable dimensions are supported.
//
// It is important to alternate the polarity of the magnet between the x and
// y direction of the magnetic square so that any combination of squares 
// can be used together.
// Use the small recess dots modelled into the magnetic square to indicate
// polarity with a drop of paint.
//
// The magnets are best secured with epoxy. 
//
//
// Author: LANEBoysRC <laneboysrc@gmail.com>
// Licensed under the Creative Commons - Attribution license. 
// http://creativecommons.org/licenses/by/3.0/
//
//#############################################################################

/* [Part shape] */

// dimension of the magnetic square:
x = 20;     // [20:20:200]

// dimension of the magnetic square:
y = 20;     // [20:20:200]

// of the magnetic square:
thickness = 15; 

// of the "arm" of the magnetic square. 
width = 10;

// of the magnetic square (square: L-shaped, clamp: rectangle with chamfered back)
type = "both"; // [square, clamp, both]

/* [Magnet] */

magnet_shape = "rectangle"; // [disc, rectangle]

// Magnet dimensions
magnet_x = 10;

// (ignored for disc shaped magnets)
magnet_y = 5;

magnet_z = 3;

/* [Advanced options] */

// Distance between two magnets
magnet_spacing = 20;

// If set to yes, magnets are also placed on the outside of the L-shaped part
magnets_on_the_outside = "no"; // [yes, no]

// Diameter of the corner relief. Set to zero for no relief.
relief_d = 5.5;

// Determines how much the center of the relief cylinder is shifted in x and y
relief_offset = 0.5;


/* [Hidden] */
dim = [x, y, thickness, width];

magnet_dim = [magnet_x, magnet_y, magnet_z];
magnet_offset = magnet_spacing / 2;

// Clearance around the magnet in x, y, z dimensions
magnet_clearance = [0.75, 0.75, 0.75];   

marker_d = 3;           // Dots that allow marking north/south of the magnets with paint
marker_h = 1;
marker_inset = 5;

// Clamp width to a sensible value
sensible_width = min(dim.x, dim.y, max(dim[3], relief_d));

$fa = 1;
$fs = 0.5;

eps = 0.05;
eps2 = 2 * eps;

if (type == "both") {
    translate([-2, -2, 0]) part(dim=dim, type="square", width=sensible_width);
    translate([2, 2, 0])part(dim=dim, type="clamp", width=sensible_width);
}
else {
    part(dim=dim, type=type, width=sensible_width);
}


//#############################################################################
// Rotates the children onto the xz plane.
module xz(dim)
{
    rotate([90, 0, 0]) translate([0, 0, -dim.z]) children();
}

//#############################################################################
// Rotates the children onto the yz plane.
module yz(dim)
{
    rotate([90, 0, 90]) translate([0, 0, 0]) children();
}

//#############################################################################
module part(type="square", dim=[30, 30, 10], width=10) 
{
    if (type == "square") {
        magnetic_square(dim, width);
    }
    else if (type == "clamp") {
        magnetic_clamp(dim, width);
    }
    else {
        %color("red") text("error: type must be 'square' or 'clamp'");
    }
}

//#############################################################################
module magnet_recess()
{
    if (magnet_shape == "disc") {
        r_d = magnet_recessDim().x;
        r_h = magnet_recessDim().z;
        cylinder(d=r_d, h=r_h);
    }
    else if (magnet_shape == "rectangle") {
        m = magnet_recessDim();
        translate([-m.x/2, -m.y/2, 0])
            cube(m);
    }
    else {
        %color("red") text("error: magnet_shape must be 'disc' or 'rectangle'");
    }
}

function magnet_recessDim(location="") =
    location == "" ? magnet_dim + magnet_clearance + [0, eps, 0] :
    "Error";

//#############################################################################
module marker_recess()
{
    r_d = marker_recessDim().x;
    r_h = marker_recessDim().z;
    cylinder(d=r_d, h=r_h);
}

function marker_recessDim(location="") =
    location == "" ? [marker_d, marker_d, marker_h] :
    "Error";

//#############################################################################
module magnetic_square(dim, width) 
{
    // Define the outside shape 
    // Note that the dimensions refer to the inner side of the square
    // so we position the inner side at 0/0
    points = [
        [-width, -width],
        [dim.x, -width],
        [dim.x, 0],
        [0, 0],
        [0,  dim.y],
        [-width, dim.y]
    ];
    
    difference() {
        // Basic outside shape
        linear_extrude(dim.z) polygon(points);
        
        // Relief at the origin
        ro = [relief_offset, relief_offset, -eps];
        translate(ro)
            cylinder(d=relief_d, h=dim.z+eps2);
        
        // Relief in the outer corner
        translate(ro + [-width, -width, 0])
            cylinder(d=relief_d, h=dim.z+eps2);
        
        // Magnets
        mr = magnet_recessDim();
        posX = [magnet_offset, -mr.z + eps, dim.z/2];
        n_magnets_x = (dim.x - magnet_offset - mr.x/2 - 1) / magnet_spacing;
        for (i = [0:n_magnets_x]) {
            translate(posX + [i * magnet_spacing, 0, 0])
                xz(mr) magnet_recess();
        }

        posY = [-mr.z + eps, magnet_offset, dim.z/2];
        n_magnets_y = (dim.y - magnet_offset - mr.x/2 - 1) / magnet_spacing;
        for (i = [0:n_magnets_y]) {
            translate(posY + [0, i * magnet_spacing, 0])
                yz(mr) magnet_recess();
        }

        if (magnets_on_the_outside == "yes") {
            posX = [-width + magnet_offset, -width - eps, dim.z/2];
            n_magnets_x = (dim.x + width - magnet_offset - mr.x/2 - 1) / magnet_spacing;
            for (i = [0:n_magnets_x]) {
                translate(posX + [i * magnet_spacing, 0, 0])
                    xz(mr) magnet_recess();
            }

            posY = [-width - eps, -width + magnet_offset, dim.z/2];
            n_magnets_y = (dim.y + width - magnet_offset - mr.x/2 - 1) / magnet_spacing;
            for (i = [0:n_magnets_y]) {
                translate(posY + [0, i * magnet_spacing, 0])
                    yz(mr) magnet_recess();
            }
        }

        // Magnet polarity markers
        mox_x = dim.x - marker_inset;
        mox_y = -marker_recessDim().y;
        translate([mox_x, mox_y, -eps])
            marker_recess();
        translate([mox_x, mox_y, dim.z-marker_recessDim().z+eps])
            marker_recess();

        moy_x = -marker_recessDim().x;
        moy_y = dim.y - marker_inset;
        translate([moy_x, moy_y, -eps])
            marker_recess();
        translate([moy_x, moy_y, dim.z-marker_recessDim().z+eps])
            marker_recess();
    }
}

//#############################################################################
module magnetic_clamp(dim, width) 
{
    points = [
        [0, 0],
        [dim.x, 0],
        [dim.x, width],
        [width, dim.y],
        [0, dim.y]
    ];

    difference() {
        // Basic outside shape
        linear_extrude(dim.z) polygon(points);
        
        // Relief at the origin
        translate([relief_offset, relief_offset, -eps])
            cylinder(d=relief_d, h=dim.z+eps2);
        
        // Magnets
        mr = magnet_recessDim();
        posX = [magnet_offset, -eps, dim.z/2];
        n_magnets_x = (dim.x - magnet_offset - mr.x/2 - 1) / magnet_spacing;
        for (i = [0:n_magnets_x]) {
            translate(posX + [i * magnet_spacing, 0, 0])
                xz(mr) magnet_recess();
        }

        posY = [-eps, magnet_offset, dim.z/2];
        n_magnets_y = (dim.y - magnet_offset - mr.x/2 - 1) / magnet_spacing;
        for (i = [0:n_magnets_y]) {
            translate(posY + [0, i * magnet_spacing, 0])
                yz(mr) magnet_recess();
        }

        // Magnet polarity markers
        mox_x = dim.x - marker_inset;
        mox_y = marker_recessDim().y;
        translate([mox_x, mox_y, -eps])
            marker_recess();
        translate([mox_x, mox_y, dim.z-marker_recessDim().z+eps])
            marker_recess();

        moy_x = marker_recessDim().x;
        moy_y = dim.y - marker_inset;
        translate([moy_x, moy_y, -eps])
            marker_recess();
        translate([moy_x, moy_y, dim.z-marker_recessDim().z+eps])
            marker_recess();
   }    
}