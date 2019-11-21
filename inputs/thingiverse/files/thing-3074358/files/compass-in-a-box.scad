/**
 * Batteries Case
 * 
 * @Author  Wilfried Loche
 * @Created Aug 29th, 2018
 */

$fn = 50;

/* [Box] */
// Width/length (mm)
box_width = 173;
// Depth (mm)
box_depth = 69;
// Height (mm)
box_height = 16;
// Corner/radius (mm)
box_corner = 13;

// Holes diameter to put your finger in (mm)
fingers_hole_diameter = 20;

/* [Compass] */
// Compass total length (mm)
compass_length = 160;

// Pin length (mm)
compass_pin_length   = 24;
// Pin diameter (mm)
compass_pin_diameter = 9;

// Head length (mm)
compass_head_length = 30;
// Head width (mm)
compass_head_width  = 20;
// Head depth (mm)
compass_head_depth  = 15;

// Legs width (mm)
compass_legs_width = 22;
// Legs depth (mm)
compass_legs_depth = 10;

// Screw length (mm)
compass_screw_length        = 60;
// Screw diameter (mm)
compass_screw_diameter      = 2;
// Screw position from head/top of the pin (mm)
compass_screw_pos_from_head = 69;

// Wheel on the screw diameter (be generous!) (mm)
compass_screw_dial_diameter = 15;
// Wheel on the screw width (be generous!) (mm)
compass_screw_dial_width    = 3;

/* [Case (small case to put in pencil leads and so on)] */
// Length (mm)
case_length   = 35;
// Diameter (mm)
case_diameter = 10;


difference() {
    translate([0, 0, -box_height/2 - (box_height-compass_head_depth)/2]) box();
    compass_hole();
    compass_fingers_holes();

    case();
    case_finger_hole();
}

module case_finger_hole()
{
    translate([
        -compass_length/2 + case_length + fingers_hole_diameter * .2,
        box_depth/3,
        box_height/2 + (box_height-compass_head_depth)/2
    ])
    cylinder(h = box_height*2, d = fingers_hole_diameter, center = true);
}

module case()
{
    translate([
        -compass_length/2 + case_length/2,
        box_depth/3,
        box_height/2 +- (box_height-compass_head_depth)/2 -case_diameter/2
    ])
    cube([case_length, case_diameter, case_diameter], center = true);
}

module compass_hole()
{
    //### Might not work with any parameters: quick and dirty here!!
    for (a = [0:10])
        translate([0, 0, a])
        compass();
}

module compass_fingers_holes()
{
    for (i = [-1, 1]) {
        translate([
            compass_length/2 - compass_head_length/2 - compass_pin_length,
            i * max(compass_head_width, compass_legs_width)/2,
            box_height/2 + (box_height-compass_head_depth)/2
        ])
        cylinder(h = box_height*2, d = fingers_hole_diameter, center = true);
    }
}

module compass()
{
    compass_pin();
    compass_head();
    compass_legs();
    compass_screw();
}

module compass_pin()
{
    translate([compass_length/2 - compass_pin_length/2, 0, 0])
    cube([compass_pin_length, compass_pin_diameter, compass_pin_diameter], center = true);    
}

module compass_head()
{
    translate([compass_length/2 - compass_head_length/2 - compass_pin_length, 0, 0])
    cube([compass_head_length, compass_head_width, compass_head_depth], center = true);    
}

module compass_legs()
{
    translate([- compass_pin_length/2, 0, 0])
    cube([compass_length - compass_pin_length, compass_legs_width, compass_legs_depth], center = true);    
}

module compass_screw()
{
    translate([compass_length/2 - compass_screw_pos_from_head, 0, 0]) {
        cube([compass_screw_diameter*3, compass_screw_length, compass_screw_diameter*3], center = true); 
    
        rotate([90, 0, 0])
        cylinder(h = compass_screw_dial_width, d = compass_screw_dial_diameter*1.1, center = true);
    }
}

module box()
{
    linear_extrude(height = box_height)
    offset(r = box_corner)
    square([box_width - box_corner*2, box_depth - box_corner*2], center = true);
}

