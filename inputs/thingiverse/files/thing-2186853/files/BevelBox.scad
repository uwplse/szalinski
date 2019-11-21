// BevelBox by Erik Wrenholt 2017-03-18
// License: Creative Commons - Attribution

$fn = 96;

// set to true to debug cross section
debug = false;

// Radius of cylinder ends
cylinder_radius = 12; // [6:40]

// Length of the box from middle of cylinder to cylinder
box_length = 28; // [0:100]

// Height of the box (excluding the bevels)
box_height = 6; // [2:40]

// Margin between lid and box
margin = 0.1;


// Thickness of the wall
wall = 1.6; // [0.8:2.0]

// Size of the frame around lid
inset = 1.2; // [0.8:1.6]

// This also specifies the lid height
bevel_height = 1.6;

// This is the bevel inset radius. Must be positive to hold a lid
bevel_radius = 1.6;

// Shelf must be greater than inset
shelf_height = 1.2;

// Shelf radius must be greater than inset
shelf_radius = 1.2;

// Increase to get a complete ring
fudge = 0.01; // [0:0.2]

wall_thickness = wall + fudge;
lid_inset = inset + fudge;


difference() {
    union() {
        box();
        translate([cylinder_radius*2, 0, -(bevel_height+box_height-0.001)]) 
            lid(margin);
    }
    if (debug) {
        translate([-30,0,-10]) 
            cube([80,40,40]);
    }
}


module box() {
    difference() {
        box_exterior();
        box_interior();
        lid_part(0, 20);
    }
}

module lid(margin = 0) {
    
    union() {
        
        intersection() {
            box_exterior();
            lid_part(margin, 20);
        }
        
        // lines on the lid to make it easier to slide
        for (i = [-1:1])
            translate([0, -box_length/2 + i*2, bevel_height*2+box_height-0.001])
                cube([cylinder_radius*2 - bevel_radius*2 - lid_inset*6, 0.8, 0.8], center=true);
    }
}

module lid_part(margin = 0, extra_length=0) {
    translate([0, -extra_length / 2, bevel_height+box_height-0.001])
        lozenge(
            cylinder_radius-lid_inset-margin, 
            cylinder_radius-bevel_radius-lid_inset-margin, 
            bevel_height+0.002, 
            box_length+extra_length);
    
}

module box_exterior() {
    
    lozenge(cylinder_radius-bevel_radius, cylinder_radius, bevel_height, box_length);
    translate([0,0,bevel_height])
        lozenge(cylinder_radius, cylinder_radius, box_height, box_length);
    translate([0,0,bevel_height+box_height])
        lozenge(cylinder_radius, cylinder_radius-bevel_radius, bevel_height, box_length);

}

module box_interior() {
    // inner box
    translate([0,0,bevel_height-0.001])
        lozenge(
            cylinder_radius-wall_thickness, 
            cylinder_radius-wall_thickness, 
            box_height-shelf_height+0.002, 
            box_length);
    translate([0,0,box_height-shelf_height+bevel_height])
        lozenge(
            cylinder_radius-wall_thickness, 
            cylinder_radius-wall_thickness-shelf_radius, 
            shelf_height+0.001, 
            box_length);
}

module lozenge(r1, r2, height, length) {
    hull() {
        translate([0, -length / 2, 0])
            cylinder(r1 = r1, r2 = r2, h = height);
        translate([0, length / 2, 0])
            cylinder(r1 = r1, r2 = r2, h = height);
    }
}
