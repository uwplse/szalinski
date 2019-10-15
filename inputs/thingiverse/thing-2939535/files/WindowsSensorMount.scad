// Title:        Parametric Homematic magnet mount
// Version:      1.0.0
// Release Date: 2018-05-31
// Author:       Klaus Moser


// Variables
/////////////

/* [General] */

// mounting type
mounting_type = 1; // [0:none, 0:magnets, 1: screws]

// Wall width
wall_width = .8;


/* [Sensor] */

// Sensor width
sensor_width = 48;

// Sensor width
sensor_depth = 11.5;

// Mounting hole distance for sensor
sensor_screw_distance = 39;


/* [Mounting base] */

// Base mounting plate depth
base_width = 60;

// Corner radius
corner_radius = 5;

// Distance of the magnets/screws to the border
border_distance = 2;

// Magnets/screws x - distance divider, (total_width / this value)
distance_divider = 3;


/* [Magnets] */

// Diameter of the magnet
magnet_dimeter = 8.1; // 7.89

// Height of the magnet
magnet_height = 2; // 1.94


/* [Sensor screws] */

// Sensor screw hole diameter
sensor_screw_hole_diameter = 3;

// Nut diameter
sensor_nut_hole_diameter = 6; // 5.6

// Nut height
sensor_nut_hole_height = 2; // 1.93


/* [Mounting screws] */

// Mounting screw hole diameter
mounting_screw_hole_diameter = 3;

// Mounting screw head diameter
mounting_screw_head_diameter = 6;

// Mounting screw head height
mounting_screw_head_height = 3;


/* [Misc] */

// Resolution
$fn = 96;

// Avoid artifacts
clearance = .001;


// Calculated values
//////////////////////
total_base_height = magnet_height + wall_width;
magnet_offset = corner_radius+border_distance;
magnet_distance = base_width - base_width/distance_divider;
screw_hole_offset = (sensor_width-sensor_screw_distance) / 2;


// Build
/////////
difference() {

    // Base
    baseMount();

    // Holes for magnets
    if (mounting_type == 1) {
        translate([
            magnet_offset,
            magnet_offset,
            total_base_height-magnet_height
        ]) {
            cylinder(d=magnet_dimeter,h=magnet_height+clearance);
        }
        translate([
            magnet_offset,
            sensor_width-magnet_offset,
            total_base_height-magnet_height
        ]) {
            cylinder(d=magnet_dimeter,h=magnet_height+clearance);
        }
        translate([
            magnet_offset+magnet_distance,
            sensor_width-magnet_offset,
            total_base_height-magnet_height
        ]) {
            cylinder(d=magnet_dimeter,h=magnet_height+clearance);
        }
        translate([
            magnet_offset+magnet_distance,
            magnet_offset,
            total_base_height-magnet_height
        ]) {
            cylinder(d=magnet_dimeter,h=magnet_height+clearance);
        }
    }
    
    // Holes for screws
    if (mounting_type == 2) {

        translate_z = total_base_height-mounting_screw_head_height+clearance;

        translate([
            magnet_offset,
            magnet_offset,
            translate_z
        ]) {
            sunkScrewHole();
        }
        translate([
            magnet_offset,
            sensor_width-magnet_offset,
            translate_z
        ]) {
            sunkScrewHole();
        }
        translate([
            magnet_offset+magnet_distance,
            sensor_width-magnet_offset,
            translate_z
        ]) {
            sunkScrewHole();
        }
        translate([
            magnet_offset+magnet_distance,
            magnet_offset,
            translate_z
        ]) {
            sunkScrewHole();
        }
    }
    
    // Screw holes for sensor
    translate([base_width-wall_width-clearance,screw_hole_offset,sensor_depth/2]) {
        rotate(90, [0,1,0]) {
            screwHole();
            translate([0,sensor_screw_distance,0]) {
                screwHole();
            }
        }
    }
}


// Modules
////////////
module baseMount() {
    union() {
        roundedRectangle(base_width, sensor_width, total_base_height, corner_radius);
        translate([base_width-wall_width,0,sensor_depth]) {
            rotate(90, [0,1,0]) {
                cube([sensor_depth, sensor_width, total_base_height]);
            }
        }
    }
}
module roundedRectangle(width, depth, height, radius) {
    hull () {    
        translate([radius,radius,0]) {
            cylinder(h=height, r=radius, $fn=90);
        }
        translate([radius,depth-radius,0]) {
            cylinder(h=height, r=radius, $fn=90);
        }
        translate([width-radius,depth-radius,0]) {
            cube([radius,radius,height]);
        }
        translate([width-radius,0,0]) {
            cube([radius,radius,height]);
        }
    }
}
module screwHole() {
    rotate(90, [0,0,1]) {
        cylinder(d=sensor_screw_hole_diameter,h=total_base_height+2*clearance);
        cylinder(d=sensor_nut_hole_diameter,h=sensor_nut_hole_height+clearance, $fn=6);
    }
}

module sunkScrewHole() {
    cylinder(
        d1=mounting_screw_hole_diameter,
        d2=mounting_screw_head_diameter,
        h=mounting_screw_head_height+2*clearance
    );
    cylinder(
        d=mounting_screw_hole_diameter,
        h=mounting_screw_head_height+2*clearance
    );
}
