// Copyright (c) 2017 Matt Woodhead
//
// V1.0 - Original

echo(version=version());

/* [Dimensions] */
// Hose 1 Outer Diameter (mm)
DIA_1 = 10; //

// Hose 2 Outer Diameter (mm)
DIA_2 = 20; //

// Hose clamp depth (mm)
depth = 24; //

// Fastening screw diameter (mm)
screw_dia = 8; //

// Fastening screw clearance diameter increase (mm)
screw_clearance = 0.4;

// Maximum wall thickness either side of the hose hole (mm)
wall_t = 5; //

/* [Hidden] */
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Main ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

// Module to account for undersized holes produced by polygon estimation
 module cylinder_outer(radius, height, center_req=true, fn=100){
   fudge = 1/cos(180/fn);
   cylinder(h=height, r=radius*fudge, $fn=fn, center=center_req);
}


// Overall dimensions
WIDTH = (4*wall_t)+DIA_1+screw_dia+DIA_2;
echo("Width: ",WIDTH,"mm");
HEIGHT = 0.75*max(DIA_1, DIA_2);
echo("Height: ",HEIGHT,"mm");

// Hole positions
MAX_HOLE = max(DIA_1, DIA_2);
HOLE_1_POS = -1*((WIDTH/2) - (DIA_1/2) - wall_t);
HOLE_2_POS = (WIDTH/2) - (DIA_2/2) - wall_t;
BOLT_HOLE_POS = -1*((WIDTH/2) - DIA_1 - (2*wall_t) - (screw_dia/2));


// Create geometry
difference(){
    linear_extrude(height=HEIGHT, scale=0.9)
        square([WIDTH, depth], center=true);

    // Extrude first hose hole
    translate([HOLE_1_POS, 0, 0])
        rotate([-90,0,0])
            cylinder_outer(radius=DIA_1/2, height=depth+1);
    
    // Extrude second hose hole
    translate([HOLE_2_POS, 0, 0])
        rotate([-90,0,0])
            cylinder_outer(radius=DIA_2/2, height=depth+1);

    // Extrude mounting bolt hole
    translate([BOLT_HOLE_POS, 0, -1])
    rotate([0,0,0])
        cylinder_outer(radius=(screw_dia+screw_clearance)/2, height=HEIGHT+1+1, center_req=false);
    
    // Hollows to save plastic
    translate([HOLE_1_POS, depth/4, -1])
        linear_extrude(height=(MAX_HOLE/2)+2, scale=0.9)
            square([DIA_1+wall_t/2, depth/3], center=true);
    translate([HOLE_1_POS, -depth/4, -1])
        linear_extrude(height=(MAX_HOLE/2)+2, scale=0.9)
            square([DIA_1+wall_t/2, depth/3], center=true);
    translate([HOLE_2_POS, depth/4, -1])
        linear_extrude(height=(MAX_HOLE/2)+2, scale=0.9)
            square([DIA_2+wall_t/2, depth/3], center=true);
    translate([HOLE_2_POS, -depth/4, -1])
        linear_extrude(height=(MAX_HOLE/2)+2, scale=0.9)
            square([DIA_2+wall_t/2, depth/3], center=true);
}
    