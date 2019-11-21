// Modular Tops Disc Generator
// 2019/03/04
// Update 1a: 2019/03/05
// Author: crashdebug
// Licensed under the Creative Commons - Attribution - Non-Commercial - 
// Share Alike license. 
// https://www.thingiverse.com/crashdebug
//
// For Modular Tops construction kit:
// https://www.thingiverse.com/thing:3440472

// disc user parameters
// -----------------------------------------------
// diameter for standard small disc=44, standard large disc=52
disc_diameter = 44;
// single, double or triple thickness
disc_thickness = 1;                 // [1:1:3]
// number of sides of the disc
disc_sides = 9;                     // [3:1:36]

/* [Spokes] */
// number of spokes (0 for no spokes)
num_spokes = 3;                     // [0,2,3,4,5,6,7,8,9,10,11,12]
// outer ring width when using spokes
outer_ring_width = 5;
// inner ring width additional to standard of 2 mm
inner_ring_width_add = 0;
// objects to add around edge

/* [Edge Objects] */
// number of edge objects, 0 for none
num_edge_objects = 3;               
// shape of edge objects
edge_objects_type = "triangle";       // [triangle, square, octagon, round]
// size/radius of edge objects
edge_objects_size = 5;
// thickness additional to disc thickness
edge_objects_thick_add = 2;
// position from center
edge_objects_pos = disc_diameter/2;

/* [Advanced] */
// Angular offset of spokes
spoke_offset = 0;
// Angular offset of edge objects
edge_offset = 0;
// Angular offset of center hex receiver
center_offset = 0;

// preview[view:south, tilt:top]

/* [Hidden] */

thickness = 2.5 * disc_thickness;
radius = disc_diameter/2.0;

spoke_angle = 20; // 20 degrees per spoke
spoke_total_angle = spoke_angle * num_spokes;
spoke_reminder = 360-spoke_total_angle;
spoke_space_angle = spoke_reminder / num_spokes;

spoke_start_radius = 8.25 + inner_ring_width_add;
spoke_end_radius = radius - outer_ring_width;

hole_radius = 6.25;

edge_fn = edge_objects_type=="triangle" ? 3 :
          edge_objects_type=="square" ? 4 :
          edge_objects_type=="octagon" ? 8 :
          edge_objects_type=="round" ? 36 : 36;


// creates one of the spoke cutter tools
// which = 1 to num_of_spokes (which one to create)
module make_spoke_cutter(which) {
    sah = spoke_angle/2;
    sa = spoke_angle;
    
    difference() {
        cylinder(thickness*2,spoke_end_radius, spoke_end_radius, $fn=36, center=true);
        cylinder(thickness*2.1,spoke_start_radius, spoke_start_radius, $fn=36, center=true);
        rotate([0,0,sah+(which-1)*sa+which*spoke_space_angle + spoke_offset])
            translate([-disc_diameter/2,0,-thickness*3/2])
                cube([disc_diameter,radius,thickness*3]);    
        rotate([0,0,sah+(which-1)*sa+(which-1)*spoke_space_angle + spoke_offset])
            translate([-disc_diameter/2,-radius,-thickness*3/2])
                cube([disc_diameter,radius,thickness*3]);
    }
}

module make_edge_shape() {
    if(edge_objects_type=="square") {
        translate([-edge_objects_size,-edge_objects_size,0])
        cube([edge_objects_size*2,edge_objects_size*2,thickness+edge_objects_thick_add]);
    } else {
        cylinder(thickness+edge_objects_thick_add,edge_objects_size, edge_objects_size, $fn=edge_fn);
    }
        
}

module make_edge_obj(which) {
    ea = 360/num_edge_objects;
    
    rotate([0,0,(which-1)*ea + edge_offset])
        translate([edge_objects_pos,0,-thickness/2])
            make_edge_shape();
        
}

union() {
    difference() {
        cylinder(thickness, radius, radius, $fn=disc_sides, center=true);
        
        if ( num_spokes != 0 ) {
            for(i=[1:num_spokes]) {
                make_spoke_cutter(i);
            }
        }
        
        rotate([0,0,center_offset])
            cylinder(thickness*2, hole_radius, hole_radius, $fn=6, center=true);
    }

    if ( num_edge_objects != 0 ) {
        for(i=[1:num_edge_objects]){
            make_edge_obj(i);
        }
    }
}





