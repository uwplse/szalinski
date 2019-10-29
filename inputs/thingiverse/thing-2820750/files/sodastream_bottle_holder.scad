// Customizable Sodastream bottle holder for Cornelius kegs
// Copyright: Olle Wreede 2019
// License: CC BY-SA

//CUSTOMIZER VARIABLES

/* [Holder] */

// Thickness in mm of the holder connecting the collars
thickness_of_holder = 8; // [5:10]

// Width in mm of the holder connecting the collars
width_of_holder = 30; // [10:50]

// This is the total height in mm of the holder
height_of_holder = 325; // [175:350]

/* [Collars] */

// Position in mm of upper collar
upper_collar_position = 267; // [150:300]

// The height in mm of each collar around the Sodastream bottle
height_of_collars = 20; // [10:50]

// Thickness in mm of collar walls
thickness_of_collars = 5; // [3:10]

// Thickness in mm of the cross at the bottom of the base collar
thickness_of_bottom = 5; // [3:10]

// Width in mm of the Sodastream bottle
inner_width_of_collars = 60; // [60:70]

// Width in mm of support struts in base collar
base_support_width = 10; // [5:0.5:15]

/* [Hook] */

// Depth in mm of the hook at the top
depth_of_hook = 25; // [10:40]

// Height in mm of the hook from the top
height_of_hook = 20; // [5:30]

/* [Buckles] */

// Height in mm of the strap buckles
height_of_buckle = 30; // [20:50]

// Position in mm of lower buckle
lower_buckle_position = 50; // [25:150]

// Position in mm of upper buckle
upper_buckle_position = 242; // [150:250]

//CUSTOMIZER VARIABLES END

/* [Hidden] */

$fn=50;

BASE_WIDTH = inner_width_of_collars + 1; // Adding some tolerance
OUTER_DIAMETER = BASE_WIDTH + thickness_of_collars * 2;
HOLDER_POSITION = BASE_WIDTH / 2 + thickness_of_holder / 2;

KEG_RADIUS = 110;
// Todo select between different keg radius versions

STRAP_BUCKLE_WALL = 3;
STRAP_THICKNESS = 3;
STRAP_WIDTH = height_of_buckle - STRAP_BUCKLE_WALL * 2;
STRAP_BUCKLE_WIDTH = width_of_holder + STRAP_THICKNESS * 2 + STRAP_BUCKLE_WALL * 2;

// Hanger
module hanger() {
    translate([0, HOLDER_POSITION, height_of_holder / 2]) {
        cube(size = [width_of_holder, thickness_of_holder, height_of_holder], center = true);
    }
    
    // Lower strap buckle
    translate([0, HOLDER_POSITION, lower_buckle_position]) {
        strap_buckle();
    }

    // Upper strap buckle
    translate([0, HOLDER_POSITION, upper_buckle_position]) {
        strap_buckle();
    }
}

module base_collar() {
     difference() {
        cylinder(h=thickness_of_bottom + height_of_collars, d=OUTER_DIAMETER);
        cylinder(h=height_of_collars * 2, d=BASE_WIDTH);
     }

 }
module base() {
    base_collar();
    
    // Base supports
    translate([0, 0, thickness_of_bottom / 2]) {
        cube([base_support_width, BASE_WIDTH + thickness_of_collars, thickness_of_bottom], center=true);
        rotate([0, 0, 90])
            cube([base_support_width, BASE_WIDTH + thickness_of_collars, thickness_of_bottom], center=true);
    }
}

module upper_collar() {
    translate([0, 0, upper_collar_position]) {
        difference() {
            cylinder(h=height_of_collars, d=OUTER_DIAMETER);
            cylinder(h=height_of_collars, d=BASE_WIDTH);
        }
    }    
}

module strap_buckle() {
    difference() {
        cube([STRAP_BUCKLE_WIDTH, thickness_of_holder, height_of_buckle], center=true);

        // Strap holes
        translate([width_of_holder / 2 + STRAP_THICKNESS / 2, 0, 0]) {
            cube([STRAP_THICKNESS, thickness_of_holder, STRAP_WIDTH], center = true);
        }
        translate([0 - (width_of_holder / 2 + STRAP_THICKNESS / 2), 0, 0 ]) {
            cube([STRAP_THICKNESS, thickness_of_holder, STRAP_WIDTH], center = true);
        }
        
        // Make room for straps behind buckle
        strap_hole_pos = thickness_of_holder / 2 - STRAP_THICKNESS / 2 + 1;
        translate([width_of_holder / 2 + STRAP_THICKNESS, strap_hole_pos, 0]) {
            cube([STRAP_BUCKLE_WALL * 2, 2, STRAP_WIDTH], center = true);
        }
        translate([0 - (width_of_holder / 2 + STRAP_THICKNESS), strap_hole_pos, 0]) {
            cube([STRAP_BUCKLE_WALL * 2, 2, STRAP_WIDTH], center = true);
        }
    }
}

module hook() {
    // Horizontal lip
    translate([0, (BASE_WIDTH + depth_of_hook) / 2 + thickness_of_holder, height_of_holder - thickness_of_holder / 2]) {
        cube([width_of_holder, depth_of_hook, thickness_of_holder], center = true);
    }
    
    // Vertical hook
    translate([0, BASE_WIDTH / 2 + depth_of_hook + thickness_of_holder * 1.5, height_of_holder - height_of_hook / 2 - thickness_of_holder / 2]) {
        cube([width_of_holder, thickness_of_holder, height_of_hook + thickness_of_holder], true);
    } 
}

module holder() {
    hanger();
    translate([0, -1, 0]) base();
    translate([0, -1, 0]) upper_collar();
}

module drawHolder() {
    // Curved back of holder
    difference() {
        holder();
        
        // Make back rounded to fit keg
        translate([0, BASE_WIDTH / 2 + thickness_of_holder + KEG_RADIUS - 0.5, 0]) {
            cylinder(h=height_of_holder - thickness_of_holder, r=KEG_RADIUS, center=false);
        }
    }

    // Add hook (outside of holder, to not be in the way for the curved back)
    hook();
}

module rotatedHolder() {
    //translate([0, 0, - OUTER_DIAMETER / 2])
        rotate([-90, 0, 0])
            drawHolder();
}

rotatedHolder();
//drawHolder();
