// Copyright (C) Peter Ivanov <ivanovp@gmail.com>, 2015, 2016
// License: Creative Commons - Attribution - Non-commercial (CC BY-NC)
// Version: 3 

part = "print"; // [print:Print,base:Base Only,jaw:Jaw Only,jaw_rot:Jaw Only Rotated,both:Base and Jaw]

// Height of support and jaw
height = 20; // [10:50]
// Thickness of base
base_thickness = 6; // [5:12]
// Thickness of support
support_thickness = 8; // [5:15]
// Width of support and jaw
width = 75; // [40:200]
// Base's edges
edge_round = 5; // [1:10]

// M6 = 10 mm, M5 = 8 mm
nut_width = 10; // [5:0.1:15]
// 6.5 mm for M6, 5.5 mm for M5
nut_diameter = 6.5; // [3:0.1:10]

// Length of slots
slot_length = 25; // [15:100]
slot_width = 4; // [3:10]
// Must be less than base_thickness!
slot_sink = 3; // [1:12]
// Must be less than width!
major_slot_distance = 50; // [20:200]
// Must be less than width!
minor_slot_distance = 25; // [0:150]
// Depth of slot
holder_slot_depth = 1.5; // [0.2:0.1:2]
// Horizontal distance from perimeter of jaw
holder_slot_pos_horiz = 3; // [2:20]
// Vertical distance from perimeter of jaw
holder_slot_pos_vert = 20; // [2:20]

jaw_thickness = 12; // [4:20]
// Depth of jaw's rail
rail_depth = 4; // [1:10]
// Width of jaw's rail
rail_width = 15; // [5:60]
// Length of jaw' rail
rail_length = 25; // [10:150]
// Distance from perimeter of base
rail_distance = 10; // [5:25]
rail_shape = -0.05; // [-0.4:0.05:0.4]

// Diameter of washer
washer_diameter = 18; /* 18 for M5 */
// Thickness of washer
washer_thickness = 2.5; // [1:0.1:4]

/* [Hidden] */
// Internal variables
drill_h = base_thickness + 0.5 * height;
epsilon = 0.1;
gamma = 0.5;
fn = 20;
$fn = 20;
holder_slot_w = 5;
x = sqrt(2) * holder_slot_w / 2;

/* Vice */
if (part == "both" || part == "base" || part == "print")
union()
{
    difference()
    {
        /* Support */
        translate([0, 0, base_thickness]) cube([support_thickness, width, height]);
        /* Drill for nut */
        translate([0.5 * support_thickness, width / 2, drill_h]) rotate([0, 90, 0])
        {
            union()
            {
                translate([0, 0, support_thickness / 2]) hexagon(nut_width, support_thickness, 90);
                cylinder(d = nut_diameter, h = support_thickness * 2, center=true, $fn=fn);
            }
        }
        /* Horizontal holder slot */
        translate([support_thickness + x - holder_slot_depth, width / 2, drill_h]) rotate([0, 45, 0]) cube([holder_slot_w, width, holder_slot_w], true);
        translate([support_thickness + x - holder_slot_depth, width / 2, base_thickness + height - holder_slot_pos_horiz]) rotate([0, 45, 0]) cube([holder_slot_w, width, holder_slot_w], true);
        translate([support_thickness + x - holder_slot_depth, width / 2, base_thickness + holder_slot_pos_horiz]) rotate([0, 45, 0]) cube([holder_slot_w, width, holder_slot_w], true);

        /* Vertical holder slot */
        translate([support_thickness + x - holder_slot_depth, width / 2, base_thickness + height / 2]) rotate([0, 0, 45]) cube([holder_slot_w, holder_slot_w, height], true);
        translate([support_thickness + x - holder_slot_depth, holder_slot_pos_vert, base_thickness + height / 2]) rotate([0, 0, 45]) cube([holder_slot_w, holder_slot_w, height], true);
        translate([support_thickness + x - holder_slot_depth, width - holder_slot_pos_vert, base_thickness + height / 2]) rotate([0, 0, 45]) cube([holder_slot_w, holder_slot_w, height], true);
    }
    translate([-slot_length, 0, 0])
    {
        difference()
        {
            rounded_cube(slot_length + rail_length + support_thickness, width, base_thickness, edge_round);
            //cube([slot_length * 2, width, base_thickness]);
            /* Rails */
            translate([slot_length + support_thickness, rail_distance, base_thickness - rail_depth + epsilon]) 
              rail(rail_length + epsilon, rail_width, rail_depth + gamma);
            translate([slot_length + support_thickness, width - rail_distance - rail_width, base_thickness - rail_depth + epsilon]) 
              rail(rail_length + epsilon, rail_width, rail_depth + gamma);
            /* Slots */
            translate([slot_width, width / 2 - major_slot_distance / 2 - slot_width / 2, -epsilon])
              rounded_cube(slot_length - slot_width * 2, slot_width, height, slot_width / 2);
            translate([slot_width, width / 2 + major_slot_distance / 2 - slot_width / 2, -epsilon])
              rounded_cube(slot_length - slot_width * 2, slot_width, height, slot_width / 2);
            translate([slot_width, width / 2 - major_slot_distance / 2 + minor_slot_distance - slot_width / 2, -epsilon])
              rounded_cube(slot_length - slot_width * 2, slot_width, height, slot_width / 2);
            translate([slot_width, width / 2 + major_slot_distance / 2 - minor_slot_distance - slot_width / 2, -epsilon])
              rounded_cube(slot_length - slot_width * 2, slot_width, height, slot_width / 2);
            /* Sinked slot */
            translate([slot_length + support_thickness + slot_width, width / 2 - slot_width / 2, -epsilon])
              rounded_cube(rail_length - slot_width * 2, slot_width, height, slot_width / 2);
            translate([slot_length + support_thickness + slot_width / 2, width / 2 - slot_width / 2, base_thickness - slot_sink - epsilon])
              rounded_cube(rail_length - slot_width, slot_width, height, slot_width);
        }
    }
    q = min(height,slot_length - edge_round);
    translate([0, 0, height + base_thickness]) rotate([0, 90, 90]) linear_extrude(base_thickness) polygon(points=[[0, 0], [height, q],[height, 0]] );
    translate([0, width - base_thickness, height + base_thickness]) rotate([0, 90, 90]) linear_extrude(base_thickness) polygon(points=[[0, 0], [height, q], [height, 0]] );
}

/* Slide */
if (part == "both" || part == "jaw" || part == "jaw_rot" || part == "print")
{
    rot = (part == "jaw_rot") || (part == "print") ? 90 : 0;
    trans_y = (part == "print") ? rail_length + support_thickness + 3 : 0;
    trans_x = (part == "both") ? (rail_length + support_thickness) + 20 : -jaw_thickness;
    
    rotate([0, rot, 0]) translate([trans_x, 0, trans_y])
    {
        union()
        {
            difference()
            {
                translate([0, 0, base_thickness]) rounded_cube(jaw_thickness, width, height, 1);
                translate([-epsilon, width / 2, drill_h]) rotate([0, 90, 0])
                {
                    union()
                    {
                        translate([0, 0, jaw_thickness / 2]) union()
                        {
                            cylinder(d = washer_diameter, h = washer_thickness, center=true, $fn=fn);
                            translate([-height / 2, 0, 0]) cube([height, washer_diameter, washer_thickness], center=true);
                        }
                        cylinder(d = nut_diameter, h = jaw_thickness + epsilon * 2, center=false, $fn=fn);
                    }
                }
                /* Horizontal holder slot */
                translate([-x + holder_slot_depth, width / 2, drill_h]) rotate([0, 45, 0]) cube([holder_slot_w, width, holder_slot_w], true);
                translate([-x + holder_slot_depth, width / 2, base_thickness + height - holder_slot_pos_horiz]) rotate([0, 45, 0]) cube([holder_slot_w, width, holder_slot_w], true);
                translate([-x + holder_slot_depth, width / 2, base_thickness + holder_slot_pos_horiz]) rotate([0, 45, 0]) cube([holder_slot_w, width, holder_slot_w], true);

                translate([jaw_thickness + x - holder_slot_depth, width / 2, drill_h]) rotate([0, 45, 0]) cube([holder_slot_w, width, holder_slot_w], true);
                translate([jaw_thickness + x - holder_slot_depth, width / 2, base_thickness + height - holder_slot_pos_horiz]) rotate([0, 45, 0]) cube([holder_slot_w, width, holder_slot_w], true);
                translate([jaw_thickness + x - holder_slot_depth, width / 2, base_thickness + holder_slot_pos_horiz]) rotate([0, 45, 0]) cube([holder_slot_w, width, holder_slot_w], true);

                /* Vertical holder_slot */
                translate([-x + holder_slot_depth, width / 2, base_thickness + height / 2]) rotate([0, 0, 45]) cube([holder_slot_w, holder_slot_w, height], true);
                translate([-x + holder_slot_depth, holder_slot_pos_vert, base_thickness + height / 2]) rotate([0, 0, 45]) cube([holder_slot_w, holder_slot_w, height], true);
                translate([-x + holder_slot_depth, width - holder_slot_pos_vert, base_thickness + height / 2]) rotate([0, 0, 45]) cube([holder_slot_w, holder_slot_w, height], true);

                translate([jaw_thickness + x - holder_slot_depth, width / 2, base_thickness + height / 2]) rotate([0, 0, 45]) cube([holder_slot_w, holder_slot_w, height], true);
                translate([jaw_thickness + x - holder_slot_depth, holder_slot_pos_vert, base_thickness + height / 2]) rotate([0, 0, 45]) cube([holder_slot_w, holder_slot_w, height], true);
                translate([jaw_thickness + x - holder_slot_depth, width - holder_slot_pos_vert, base_thickness + height / 2]) rotate([0, 0, 45]) cube([holder_slot_w, holder_slot_w, height], true);
            }
            translate([0, rail_distance + gamma, base_thickness - rail_depth])
                rail(jaw_thickness, rail_width - gamma * 2, rail_depth);
            translate([0, width - rail_distance - rail_width + gamma, base_thickness - rail_depth])
                rail(jaw_thickness, rail_width - gamma * 2, rail_depth);
        }
    }
}

/*** Helper functions ***/
module rail(l,rail_width,rail_depth)
{
    rail_delta = min(rail_width * abs(rail_shape), 2);
    if (rail_shape > 0)
    {
        rotate([0, 90, 0]) linear_extrude(l) 
            polygon( points=[[0,0],[-rail_depth,rail_delta],[-rail_depth,rail_width - rail_delta],[0,rail_width]] );
    }
    else
    {
        rotate([0, 90, 0]) linear_extrude(l) 
            polygon( points=[[0,rail_delta],[-rail_depth,0],[-rail_depth,rail_width],[0,rail_width - rail_delta]] );
    }
}

module rounded_cube(w, l, h, r)
{
    hull()
    {
     translate([0 + r, 0 + r, 0]) cylinder(r=r, h=h);
     translate([w - r, 0 + r, 0]) cylinder(r=r, h=h);
     translate([w - r, l - r, 0]) cylinder(r=r, h=h);
     translate([0 + r, l - r, 0]) cylinder(r=r, h=h);
    }
}

module hexagon(width, height, baseAngle) 
{
  bwidth = width / 1.75;
  for (angle = [baseAngle, baseAngle + 60, baseAngle + 120]) 
  {
      rotate([0, 0, angle]) cube([bwidth, width, height], true);
  }
}
