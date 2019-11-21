//
// This is customizable jig for drilling shelf pin holes with a drilling machine
// The drill holes are enforced by a metal bearing or bushing. 
// The default settings assume a 16x5x5 bearing. You might also use a bushing by setting
// bearing_diameter and bearing_run_diameter to equal values.
// Notes: 
//   - use depth stop on drill
//   - requires good clamping, otherwise drill moves the jig

$fa=1*1;
$fs=0.25*1;

// max size of printing bed. Determines number of holes
max_print_size = 200;

// distance between 2 pin holes
hole_to_hole_distance = 32;

// distance from pin hole to edge/fence
hole_to_edge_distance = 37;

// diameter of pin/drill hole
pin_hole_diameter = 5;

// use fence 
use_fence = 1; // [1:With Fence, 0:No Fence]

// bearing or bushing diameter: 
// NOTE: this value should take into account: a) the actual bearing diameter, b) the precision by which your printer prints inner cut-outs, and c) the pressure by which the bearing should fit.  E.g. my printer prints cut-outs 0.4mm too tight -> for a 16mm bearing: 16.4mm and to give a tight fit: 16.2 (for mine)
bearing_diameter = 16.0;

// diameter of inner bushing of the bearing
bearing_run_diameter = 9.5;
// space under inner bushing of the bearing
bearing_run_height=1;
// height of the bearing
bearing_height = 5;


// height of wood chip path
chip_support_height = 2.5;

// width of wood chip path
chip_support_width = 8;

// thickness of fence/edge part
jig_fence_thickness = 8;

// computed params
nof_holes = floor(max_print_size / hole_to_hole_distance);
jig_thickness = bearing_height+bearing_run_height+2;
jig_length = hole_to_hole_distance * nof_holes;
jig_width = hole_to_edge_distance + bearing_diameter/2 + 5;
jig_fence_height = jig_thickness + chip_support_height + 15;


difference() {
    union() {
        // side edge
        if (use_fence == 1) {
            translate([0, -jig_fence_thickness, 0]) {
                cube([jig_length, jig_fence_thickness, jig_fence_height], center=false);
            }
        }
        // plate
        cube([jig_length, jig_width, jig_thickness], center=false);
    };
    group() {
        for ( i = [hole_to_hole_distance/2:hole_to_hole_distance:nof_holes*hole_to_hole_distance] ) {
            translate([i, hole_to_edge_distance, 0]) {
                cylinder(jig_thickness, d=pin_hole_diameter, center=false);
                cylinder(bearing_height, d=bearing_diameter, center=false);
                translate([0, 0, bearing_height]) {
                    cylinder(bearing_run_height, d=bearing_run_diameter, center=false);
                };
            };
        };
        
    }
    
    /*
    // save material
    translate([0,jig_thickness,jig_thickness/2])
        cube([jig_length, jig_width/4, jig_thickness/2]);
    */
    
}

if (chip_support_height > 0) {

    chip_support();
    translate([0, jig_width-chip_support_width, 0])
        chip_support();
    
    translate([0, jig_width/2-chip_support_width/2, 0])
        chip_support();
}


module chip_support() {
    
    translate([0, 0, jig_thickness])
        cube([jig_length, chip_support_width, chip_support_height]);
    
}


