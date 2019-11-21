$fn=96;

/// Parameters

// Avoid artifacts
clearance = 0.01;

// Number of holes
holes = 1;

// Thickness of the wall
wall_width = 1.6;

// Corner radius
corner_radius = 2;

// With of the clip, Usually 20.
clip_width = 20;

// Depth of the clip, higher values givr more space in the clip
clip_depth = 10;

// Length of the clip
clip_length = 12;

// Slot with
slot_width = 4;

// Slot angle
slot_angle = 30;

// Countersunk screw large head diameter
screw_head_diameter = 8.8;

// Countersunk screw small head diameter
screw_head_height = 2.8;

// Mounting screw hole diameter
screw_hole_diameter = 4.3;

// Outer bulge width large
outer_bulge_width_1 = 6.8;

// Outer bulge width smaller
outer_bulge_width_2 = 5.8;

// Outer bulge length
outer_bulge_depth = 0.3;

// Inner bulge width large
inner_bulge_width_1 = 10;

// Inner bulge width large
inner_bulge_width_2 = 12;

// Inner bulge length
inner_bulge_depth = 1.2;

difference() {
    
    union() {
        holedRoundedRectangle(clip_width, clip_depth, clip_length, corner_radius);

        // Outer bulge
        translate([clip_width/2-outer_bulge_width_1/2,clip_depth,0]) {
            bulge(outer_bulge_width_1,outer_bulge_width_2,outer_bulge_depth,clip_length);
        }
        
        // Inner bulge
        translate([clip_width/2-inner_bulge_width_1/2,clip_depth-wall_width-inner_bulge_depth,0]) {
            bulge(inner_bulge_width_1,inner_bulge_width_2,inner_bulge_depth,clip_length);
        }
    }
    
    // Subtract slot
    translate([clip_width/2,wall_width/2+clearance,clip_length/2]) {
        rotate(slot_angle, [0,1,0]) {
            cube([slot_width, 2*wall_width+2*clearance,pow(clip_length,2)+2*clearance], center=true);
        }
    }
    
    // Screw hole
    step = clip_length / holes;
    for (n=[0:step:(holes-1)*step]) {
        translate([clip_width/2,clip_depth-wall_width-inner_bulge_depth-clearance,step/2+n]) {
            rotate(270, [1,0,0]) {
                // Screw head
                cylinder(d1=screw_head_diameter, d2=screw_hole_diameter, h=screw_head_height);
                // Screw hole
                cylinder(d=screw_hole_diameter, h=inner_bulge_depth+wall_width+2*clearance+outer_bulge_depth);
            }
        }
    }
}



///////////////
// Modules //
///////////////

module bulge(width1, width2, depth, height) {
    linear_extrude(height=height) {
        polygon([
            [0,0],
            [width1,0],
            [width2+(width1-width2)/2,depth],
            [(width1-width2)/2,depth]
        ]);
    }
}

module holedRoundedRectangle(width, depth, height, radius) {

    difference() {
        
        // Outer cube
        roundedRectangle(width, depth, height, radius);
        
        // Substract inner rectangle
        translate([wall_width,wall_width,-clearance]) {
            roundedRectangle(width-2*wall_width, depth-2*wall_width, height+2*clearance, radius);
        }
    }
}

module roundedRectangle(width, depth, height, radius) {
    hull () {    
        translate([radius,radius,0]) {
            cylinder(h=height, r=radius, $fn=90);
        }
        translate([width-radius,radius,0]) {
            cylinder(h=height, r=radius, $fn=90);
        }
        translate([radius,depth-radius,0]) {
            cylinder(h=height, r=radius, $fn=90);
        }
        translate([width-radius,depth-radius,0]) {
            cylinder(h=height, r=radius, $fn=90);
        }
    }
}
