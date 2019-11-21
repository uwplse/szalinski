////////////////////////
// Hair drier holder
//
// By: assin
////////////////////////

// Variables
/////////////

/* [Dryer] */

// Wall thickness on the left and right side of the hole
wall_width = 5;

// Smoth edges
corner_radius = 3;

// Height of the holder
height = 35;

// Large diameter of the dryer hole
large_diameter = 75;

// Small diameter of the dryer hole
small_diameter = 62;

// Add some material to the wall side
holder_length = 8;

// Move hole so there will be a gap in front. Can also be negative of no gap is needed
hole_offset_y = 10;

// Move hole upwards to avoid to thin first layers
hole_offset_z = 5;

/* [Mounting screws] */

// Screw diameter
screw_hole_diameter = 4;

// Screw head diameter
screw_head_diameter = 8;

// Screw offset from the middle
screw_hole_offset_x = 22;

// Wall thickness for the screw
screw_hole_offset_y = 5;


/* [Misc] */

// Precision
$fn=96;

// Avoid artifacts
clearance = 0.01;


// Calculated
//////////////

total_width = large_diameter+2*wall_width;
total_length = large_diameter+holder_length-hole_offset_y;

// Build
/////////

difference() {
    //cube([total_width, total_length,height]);
    roundedCube(
        total_width,
        total_length,
        height,
        corner_radius
    );
    // Dryer hole
    translate([
        total_width/2,
        holder_length+large_diameter/2+wall_width,
        -clearance
    ]) {
        cylinder(d=small_diameter, height+10);
        
        translate([0,0,hole_offset_z]) {
            cylinder(
                d1=small_diameter,
                d2=large_diameter,
                height-hole_offset_z+2*clearance);
        }
    }
    
    // Screw holes
    translate([
        total_width/2-screw_hole_offset_x,
        -clearance,
        height/2
    ]) {
        screwHole();
    }
    translate([
        total_width/2+screw_hole_offset_x,
        -clearance,
        height/2
    ]) {
        screwHole();
    }
}

module roundedCube(width, length, height, radius) {
    translate([radius,radius,radius]) {
        hull() {
        
            cornerCylinder(r=radius, h=radius);
            translate([0,0,height-2*radius]) {
                cornerCylinder(r=radius, h=radius);
            }

            translate([width-2*radius,0,0]) {
                cornerCylinder(r=radius, h=radius);
            }
            translate([width-2*radius,0,height-2*radius]) {
                cornerCylinder(r=radius, h=radius);
            }
        
            translate([width-2*radius,length-2*radius,0]) {
                sphere(r=radius);
            }
            translate([width-2*radius,length-2*radius,height-2*radius]) {
                sphere(r=radius);
            }

            translate([0,length-2*radius,0]) {
                sphere(r=radius);
            }
            translate([0,length-2*radius,height-2*radius]) {
                sphere(r=radius);
            }
        }
    }
}

module cornerCylinder(r,h) {
    rotate(90, [1,0,0]) {
        translate([0,0,0]) {
            cylinder(r=r, h=h);
        }
    }
}
module screwHole() {
    rotate(270, [1,0,0]) {
        cylinder(d=screw_hole_diameter, h=screw_hole_offset_y+clearance);
        translate([0,0,screw_hole_offset_y]) {
            cylinder(d=screw_head_diameter, h=total_width/2);
        }
    }
}
