/*
 * bowden_e3_mount.scad
 * v1.0 11th December 2017
 * Written by landie @ Thingiverse (Dave White)
 *
 * This script is licensed under the Creative Commons - Attribution license.
 * https://www.thingiverse.com/thing:2707043
 *
 * Reworked from my direct mount extruder... mount
 * http://www.thingiverse.com/thing:1593485
 *
 * A mount for an e3d v6 hotend that, in conjunction with the modified rework x-carriage...
 * http://www.thingiverse.com/thing:1585254
 * Allows the use of a bowden extruder with the E3D V6 hot end
 *
 */

// Include the main mount assy.
includeMount = "yes"; // [yes,no]

// Include the hotend clamp 
includeClamp = "yes"; // [yes,no]

// Include the arm/bracket to mount the cooling fan on
includeCoolingFanMount = "yes"; // [yes,no]

// Include an 18mm sensor mount
includeSensorMount = "yes"; // [yes,no]

/* [Hidden] */
// Only edit lines below here if you know what you're doing ! :)

// Display as an assembly or component parts  
showAssembly = false;

 $fn = 100;
// constants
m3_bolt_dia = 3.5;
m3_nut_dia = 6.75;
m3_nut_depth = 3;

direct_mount = false; // set to false for a very simple Bowden mount

// Main dimensions of the mounting plate
carriage_width = 56; // from the x-carriage file
mounting_plate_width = 35;
mounting_plate_thickness = 3;

// Mounting hole diameters and spacing
bolt_hole_dia = 4.5;
screw_head_dia = 5.5;
bolt_y_centres = 23;
bolt_x_centres = 23;

// size and position of the head clamp and the
// rings on the head of the hotend
e3d_head_large_dia = 16.5;
e3d_small_dia = 12.5;
e3d_top_ring_height = 4;
e3d_small_ring_height = 5.5;
e3d_bottom_ring_height = 3;
e3d_collet_height = 3;
e3d_collet_dia = 16.5;
e3d_mount_y_offset = 18; // y distance from face of x-carriage to center of head
e3d_mount_z_offset = 18 + e3d_collet_height; // distance from center of bracket to top of clamp
mounting_plate_height = e3d_mount_z_offset * 2;

// Head clamp dimensions
clamp_height = e3d_top_ring_height + e3d_small_ring_height + e3d_bottom_ring_height + e3d_collet_height;
clamp_minimum_thickness = 4;
clamp_bolt_hole_dia = 3.5;
clamp_width = e3d_head_large_dia + clamp_minimum_thickness * 2 + screw_head_dia * 2 + clamp_minimum_thickness * 2;



// Dimensions for the Geetech extruder
extruder_centre_x_distance = 8;
extruder_centre_y_distance = 15;
extruder_mounting_hole_centres = 31;
extruder_mounting_hole_dia = 3.5;
extruder_mounting_cap_dia = 5.5;
extruder_mounting_hole_y_distance = 6;
extruder_mounting_hole_z_distance = 5.5;
extruder_bracket_additional_height = 16;
extruder_width = 20;
extruder_length = 43;
extruder_mount_width = 5;
extruder_depth = 60;

// dimensions for the cable attachment/supporting arm
cable_attachment_width = 10;
cable_mount_arm_width = 10;
cable_mount_offset = 42;

// dimensions for the levelling sensor
sensor_diameter = 18.5;
sensor_ring_drop = 20; // from top of clamp
sensor_drop_plate_thickness = 3;
sensor_ring_y_centre = 33;
sensor_ring_thickness = 7;
sensor_ring_depth = 5;
sensor_x_offset = -clamp_width / 2 - sensor_diameter / 2 - sensor_ring_thickness - 2; // offset from center of nozzle to sensor centre
sensor_y_offset = 15; // offset from center of nozzle to sensor centre
sensor_z_offset = e3d_mount_z_offset - sensor_ring_drop - sensor_ring_thickness;

// cooling duct bracket
bracket_angle = 48;
bracket_thickness = 5.2;
fan_mount_size = 40;
fan_mount_bolt_spacing = 32;
fan_mount_bolt_dia = m3_bolt_dia;
fan_mount_thickness = 10;
fan_mount_width = 9;
fan_mount_bolt_y_offset = 58.75;
fan_mount_bolt_z_offset = 0.5;
bracket_y_offset = 65;

if (showAssembly) {
    if (includeMount == "yes") {
        mountAssy();
    }

    if (includeClamp == "yes") {
        clampAssy();
    }
} else {
    if (includeMount == "yes") {
        rotate([90,0,0])
        mountAssy();
    }

    if (includeClamp == "yes") {
        translate([clamp_width + 5,e3d_mount_y_offset,-e3d_mount_z_offset + clamp_height])
        rotate([0,0,180])
        clampAssy();
    }
}

module mountAssy() {
    mounting_plate();
    clamp_base();
    if (direct_mount) {
        extruder_mount();
        levelling_sensor_mount();
    } else {
        if (includeSensorMount == "yes") {
            bowden_levelling_sensor_mount();
        }
        translate([-clamp_width / 2,cable_mount_arm_width / 2 + e3d_mount_y_offset - clamp_minimum_thickness,-sensor_ring_drop + e3d_mount_z_offset - sensor_ring_thickness])
        rotate([0,0,180])
        cable_mount();
    }
}

module clampAssy() {
    render()
    clamp_top();
}

module mounting_plate()
{
    difference () {
        union() {
            translate([0,mounting_plate_thickness/2, 0])
            cube(size = [mounting_plate_width, mounting_plate_thickness, mounting_plate_height], center = true);
            translate([-bolt_x_centres / 2, 0, bolt_y_centres / 2])
                mounting_bolt_rim();
            translate([-bolt_x_centres / 2, 0, -bolt_y_centres / 2])
                mounting_bolt_rim();
            translate([bolt_x_centres / 2, 0, bolt_y_centres / 2])
                mounting_bolt_rim();
            translate([bolt_x_centres / 2, 0, -bolt_y_centres / 2])
                mounting_bolt_rim();
            
        }
        union() {
            translate([-bolt_x_centres / 2, 0, bolt_y_centres / 2])
                mounting_bolt();
            translate([-bolt_x_centres / 2, 0, -bolt_y_centres / 2])
                mounting_bolt();
            translate([bolt_x_centres / 2, 0, bolt_y_centres / 2])
                mounting_bolt();
            translate([bolt_x_centres / 2, 0, -bolt_y_centres / 2])
                mounting_bolt();
        }
    }
}

module mounting_bolt_rim()
{
    translate([0,mounting_plate_thickness + 1,0])
    rotate([90,0,0])
    cylinder(d = 12, h = 2, center = true);
}

module mounting_bolt()
{
    translate([0,mounting_plate_thickness + 3,0])
    rotate([90,0,0]) {
        cylinder(d = bolt_hole_dia, h = mounting_plate_thickness + 5);
        cylinder(d=8.7,h=3,$fn=6);
    }
}

module clamp_base()
{
    clamp_dia = e3d_head_large_dia + clamp_minimum_thickness * 2;
    difference () {
        clamp(0);
        translate([0,e3d_mount_y_offset + clamp_dia / 2,e3d_mount_z_offset - clamp_height / 2])
            cube(size = [clamp_dia + screw_head_dia * 2 + clamp_minimum_thickness * 2, clamp_dia, clamp_height], center = true);
    }
}

module clamp_top()
{
    translate([0,0,0])
    difference() {
        union() {
            clamp(2);
            //bracket();
            if (includeCoolingFanMount == "yes") {
                new_bracket();
            }
        }
        e3d_head();
        clamp_base();
    }
}

module clamp(xinset)
{
    clamp_dia = e3d_head_large_dia + clamp_minimum_thickness * 2;
    clamp_support_y = e3d_mount_z_offset - e3d_head_large_dia / 2;
    clamp_y = e3d_mount_y_offset;
    
    difference() {
        union() {
            translate([0,clamp_y,e3d_mount_z_offset - clamp_height / 2])
            cylinder(d = clamp_dia, h = clamp_height, center = true);
            translate([0,clamp_support_y / 2,e3d_mount_z_offset - clamp_height / 2])
            cube(size = [bolt_x_centres - screw_head_dia * 2, clamp_support_y, clamp_height], center = true);
            translate([0,e3d_mount_y_offset,e3d_mount_z_offset - clamp_height / 2])
            cube(size = [clamp_dia + screw_head_dia * 2 + clamp_minimum_thickness * 2 - xinset, clamp_minimum_thickness * 2, clamp_height], center = true);
        }
        union() {
            e3d_head();
            translate([clamp_dia / 2 + clamp_minimum_thickness, 0, e3d_mount_z_offset - clamp_height / 2])
            clamp_bolt();
            translate([-clamp_dia / 2 - clamp_minimum_thickness, 0, e3d_mount_z_offset - clamp_height / 2])
            clamp_bolt();
        }
    }
}

module clamp_bolt()
{
    translate([0,e3d_mount_y_offset - clamp_minimum_thickness - 1, 0])
    rotate([-90,0,0]) {
        cylinder(d = clamp_bolt_hole_dia, h = clamp_minimum_thickness * 2 + 2);
        cylinder(d = 6.4, h = 3, $fn = 6);
    }
}

module e3d_head()
{
    translate([0,e3d_mount_y_offset,e3d_mount_z_offset - clamp_height]) {
        cylinder(d = e3d_head_large_dia, h = e3d_bottom_ring_height);
        translate([0,0,e3d_bottom_ring_height])
        cylinder(d = e3d_small_dia, h = e3d_small_ring_height);
        translate([0,0,e3d_bottom_ring_height + e3d_small_ring_height])
        cylinder(d = e3d_head_large_dia, h = e3d_top_ring_height);
        translate([0,0,e3d_bottom_ring_height + e3d_small_ring_height + e3d_top_ring_height])
        cylinder(d = e3d_collet_dia, h = e3d_collet_height);
        
    }
}

module extruder_mount()
{
    extruder_mount_thickness = e3d_mount_y_offset - extruder_centre_x_distance;
    extuder_x_offset = extruder_length / 2 - extruder_centre_y_distance;
    clamp_dia = e3d_head_large_dia + clamp_minimum_thickness * 2;
    support_width = extruder_length / 2 - (clamp_dia + screw_head_dia * 2 + clamp_minimum_thickness * 2) / 2 + extuder_x_offset;
    right_side_thickness = (clamp_dia + screw_head_dia * 2 + clamp_minimum_thickness * 2) / 2 - extruder_length / 2 + 0.25 + support_width;
    
    difference() {
    translate([extuder_x_offset,extruder_mount_thickness/2, mounting_plate_height / 2 + extruder_bracket_additional_height / 2])
                cube(size = [extruder_length, extruder_mount_thickness, extruder_bracket_additional_height], center = true);
    union() {
        translate([extruder_mounting_hole_centres / 2 + extuder_x_offset,0,extruder_mounting_hole_z_distance])
        extruder_mount_bolt();
        translate([-extruder_mounting_hole_centres / 2 + extuder_x_offset,0,extruder_mounting_hole_z_distance])
        extruder_mount_bolt();
    }
    
    }
    translate([extruder_length / 2 + 0.25,0,e3d_mount_z_offset - mounting_plate_thickness])
    cube(size = [support_width, extruder_depth, mounting_plate_thickness]);
    translate([extruder_length / 2 + 0.25 + support_width,0,e3d_mount_z_offset - mounting_plate_thickness])
    cube(size = [mounting_plate_thickness, extruder_depth, extruder_bracket_additional_height + mounting_plate_thickness]);
    //r/h support 
    translate([-extruder_length / 2 + 0.25 + support_width - right_side_thickness,0,e3d_mount_z_offset])
    cube(size = [right_side_thickness, extruder_depth, extruder_bracket_additional_height]);
    translate([extruder_length / 2 + 0.25 + support_width, cable_mount_offset,e3d_mount_z_offset - mounting_plate_thickness])
    cable_mount();
}


module extruder_mount_bolt()
{
    extruder_mount_thickness = e3d_mount_y_offset - extruder_centre_x_distance;
    translate([0, extruder_mount_thickness / 2, mounting_plate_height / 2])
    rotate([90,0,0])
    cylinder(d = extruder_mounting_hole_dia, h = extruder_mount_thickness + 2, center = true);
    translate([0, (extruder_mount_thickness - 5) / 2, mounting_plate_height / 2])
    rotate([90,0,0])
    cylinder(d = extruder_mounting_cap_dia, h = extruder_mount_thickness - 5, center = true);
}

module cable_mount() {
    rotate ([90,0,90]) {
    linear_extrude(height=3)
    mount();
    translate([0,0,3])
    linear_extrude(height=2)
    difference() {
        mount();
        offset(delta = -2)
        mount();
    }
}
}
module mount() {
    translate([-cable_mount_arm_width / 2, 0, 0])
    square(size = [cable_mount_arm_width, extruder_depth]);
    difference() {
        attachment();
        offset(delta = -3)
        attachment();
    }
}

module attachment()
{
    support_offset = extruder_depth;
    hull() {
            translate([-cable_attachment_width / 2, support_offset + cable_mount_arm_width / 2, 0])
            circle(d = cable_mount_arm_width, center = true);
            translate([cable_attachment_width / 2, support_offset + cable_mount_arm_width / 2, 0])
            circle(d = cable_mount_arm_width, center = true);
        }
}



module levelling_sensor_mount()
{
    extuder_x_offset = extruder_length / 2 - extruder_centre_y_distance;
    clamp_dia = e3d_head_large_dia + clamp_minimum_thickness * 2;
    ring_plate_width = sensor_diameter + sensor_ring_thickness * 2 + sensor_drop_plate_thickness;
    ring_plate_length = sensor_diameter + sensor_ring_thickness * 2;
    support_width = extruder_length / 2 - (clamp_dia + screw_head_dia * 2 + clamp_minimum_thickness * 2) / 2 + extuder_x_offset;
    
    translate([-extruder_length / 2 + 0.25,sensor_ring_y_centre - ring_plate_length / 2,e3d_mount_z_offset - sensor_ring_drop - sensor_ring_depth])
    levelling_sensor_plate();
    translate([-extruder_length / 2 + 0.25 - sensor_drop_plate_thickness,sensor_ring_y_centre - ring_plate_length / 2,e3d_mount_z_offset - sensor_ring_drop - sensor_ring_depth])
    cube([sensor_drop_plate_thickness, ring_plate_length, sensor_ring_depth + extruder_bracket_additional_height + sensor_ring_drop]);
}

module levelling_sensor_plate()
{
    ring_plate_width = sensor_diameter + sensor_ring_thickness * 2 + sensor_drop_plate_thickness;
    ring_plate_length = sensor_diameter + sensor_ring_thickness * 2;
    
    linear_extrude(sensor_ring_depth)
    difference() {
        hull() {
            translate()
            translate([-5, 0, 0])
            square([5, ring_plate_length]);
            translate([-ring_plate_width + sensor_ring_thickness + sensor_diameter / 2,ring_plate_length/2,0])
            circle(d = ring_plate_length);
        }
        translate([-ring_plate_width + sensor_ring_thickness + sensor_diameter / 2,sensor_diameter/2 + sensor_ring_thickness,0])
            circle(d = sensor_diameter);
    }
}

module bowden_levelling_sensor_mount()
{
    extuder_x_offset = extruder_length / 2 - extruder_centre_y_distance;
    clamp_dia = e3d_head_large_dia + clamp_minimum_thickness * 2;
    ring_plate_width = sensor_diameter + sensor_ring_thickness * 2 + sensor_drop_plate_thickness;
    ring_plate_length = sensor_diameter + sensor_ring_thickness * 2;
    support_width = extruder_length / 2 - (clamp_dia + screw_head_dia * 2 + clamp_minimum_thickness * 2) / 2 + extuder_x_offset;
    
    //translate([-extruder_length / 2 + 0.25,sensor_ring_y_centre - ring_plate_length / 2,e3d_mount_z_offset - sensor_ring_drop - sensor_ring_depth])
    bowden_levelling_sensor_plate();
    //translate([-extruder_length / 2 + 0.25 - sensor_drop_plate_thickness,sensor_ring_y_centre - ring_plate_length / 2,e3d_mount_z_offset - sensor_ring_drop - sensor_ring_depth])
    //cube([sensor_drop_plate_thickness, ring_plate_length, sensor_ring_depth + extruder_bracket_additional_height + sensor_ring_drop]);
}

module bowden_levelling_sensor_plate()
{
    ring_plate_width = sensor_diameter + sensor_ring_thickness * 2 + sensor_drop_plate_thickness;
    ring_plate_length = sensor_diameter + sensor_ring_thickness * 2;
    
    difference() {
        hull() {
            translate([sensor_x_offset,sensor_y_offset + e3d_mount_y_offset,sensor_z_offset])
            cylinder(d = ring_plate_length, h = sensor_ring_depth);
            translate([-clamp_width / 2 - 5,e3d_mount_y_offset - clamp_minimum_thickness,sensor_z_offset])
            cube([5, ring_plate_length / 2, sensor_ring_depth], center = false);
        }
        translate([sensor_x_offset,sensor_y_offset + e3d_mount_y_offset,sensor_z_offset])
        cylinder(d = sensor_diameter, h = sensor_ring_depth);
    }
    
}

module bracket()
{
    clamp_dia = e3d_head_large_dia + clamp_minimum_thickness * 2;
    translate([0,bracket_thickness / 2 + bracket_y_offset, mounting_plate_height / 2 + extruder_mounting_hole_z_distance])
    rotate([0,0,90]) {
//        difference() {
//            cube(size = [bracket_thickness, fan_mount_size, fan_mount_thickness], center = true);
//            union() {
//                translate([-4,fan_mount_bolt_spacing / 2, 0])
//                rotate([0,90,0])
//                cylinder(d = 3.5, h = 8);
//                translate([-4,-fan_mount_bolt_spacing / 2, 0])
//                rotate([0,90,0])
//                cylinder(d = 3.5, h = 8);
//            }
//        }
        translate([5,0,-8])
        rotate([0,-bracket_angle,0])
        difference() {
            translate([0,3,0]) {
                cube(size = [fan_mount_thickness * 2, 3, fan_mount_thickness], center = true);
                
                rotate([0,bracket_angle,0])
                translate([-(bracket_y_offset - e3d_head_large_dia) / 2, 0, 0])
                cube(size = [bracket_y_offset - e3d_head_large_dia, 3, 10], center = true);
                //rotate([0,bracket_angle,0])
                //translate([0,0,8])
                //cube(size = [fan_mount_thickness, 3, fan_mount_thickness], center = true);
            }
            union() {
                translate([5, 8, -1])
                rotate([90,0,0])
                cylinder( d = 3.5, h = fan_mount_thickness);
                translate([-5, 8, -1])
                rotate([90,0,0])
                cylinder( d = 3.5, h = fan_mount_thickness);
            }
        }
    }
}

module new_bracket()
{
    difference() {
        hull() {
            translate([0,e3d_mount_y_offset + e3d_head_large_dia / 2 + clamp_minimum_thickness / 2 + 5, e3d_mount_z_offset - clamp_height / 2])
            cube([fan_mount_width, 10, clamp_height], center = true);
            translate([0, e3d_mount_y_offset + fan_mount_bolt_y_offset, e3d_mount_z_offset + fan_mount_bolt_z_offset])
            rotate([0,90,0])
            cylinder(d = m3_nut_dia + 4, h = fan_mount_width, center = true);
        }
        translate([0, e3d_mount_y_offset + fan_mount_bolt_y_offset, e3d_mount_z_offset + fan_mount_bolt_z_offset]) {
            rotate([0,90,0])
            cylinder(d = m3_bolt_dia, h = fan_mount_width, center = true);
            translate([fan_mount_width / 2 - m3_nut_depth / 2,0,0])
            rotate([0,90,0])
            cylinder(d = m3_nut_dia, h = m3_nut_depth, center = true, $fn = 6);
        }
    }
}
