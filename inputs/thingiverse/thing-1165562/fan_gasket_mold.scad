
/////////////////////////////////////////////////////////////////////
//                                                                           
// File: fan_gasket_mold.scad                                              
// Author: Stephan Mueller                                                 
// Date: 2015-12-03                                                        
// Description: Customizable fan gasket and suitable mold                
//                                                                          
/////////////////////////////////////////////////////////////////////

// Customizer Settings: //

/* [Options] */

//gasket or gasket mold
part = 0; // [0:fan gasket,1:fan gasket mold]

//fan size, e.g. 30x30 => 30
fan_size = 30; // [10:1:200]

//air_flow_diameter
airflow_diameter = 26; // [6:1:200]

//screw hole diameter
screw_diameter = 3.5; // [1:0.1:10]

//screw distance
screw_distance = 24; // [5:1:200]

//corner radius
corner_radius = 3; // [0:0.1:50]

//gasket height
gasket_height = 2; // [1:0.1:10]

//mold wall thickness
wall_thickness = 3; // [1:0.1:10]


// Static Settings: //

/* [Hidden] */

overlap = 0.04;
$fn = 50;

// preview[view:south, tilt:top]

print_part();

module print_part() {
	if (part == 0) {
		fan_gasket(fan_size, screw_diameter, screw_distance, corner_radius, airflow_diameter, gasket_height);
	} else if (part == 1) {
		fan_gasket_mold(fan_size, screw_diameter, screw_distance, corner_radius, airflow_diameter, gasket_height, wall_thickness);
    }
}

module fan_gasket(
    width = 30,                 // gasket size
    screw_diameter = 3.5,      // diameter of the screw holes
    screw_distance = 24,       // distance of the screw hole centers
    corner_radius = 3,         // radius of the corner
    airflow_diameter = 26,    // diameter of the airflow hole
    height = 2                 // gasket height
){
    corner_radius = max(corner_radius, 0.01);
    
    screw_offset = (width - screw_distance) / 2;
    
    difference(){
        // main body
        hull(){
            translate([corner_radius, corner_radius, 0])
                cylinder(r = corner_radius, h = height);
            translate([width - corner_radius, corner_radius, 0])
                cylinder(r = corner_radius, h = height);
            translate([corner_radius, width - corner_radius, 0])
                cylinder(r = corner_radius, h = height);
            translate([width - corner_radius, width - corner_radius, 0])
                cylinder(r = corner_radius, h = height);
        }
        
        // holes for screws and airflow
        union(){
            // air flow hole
            translate([width / 2, width / 2, -overlap])
                cylinder(d = airflow_diameter, h = height + 2 * overlap);
            
            // screw holes
            translate([screw_offset, screw_offset, -overlap])
                cylinder(d = screw_diameter, h = height + 2 * overlap);
            translate([screw_offset + screw_distance, screw_offset, -overlap])
                cylinder(d = screw_diameter, h = height + 2 * overlap);
            translate([screw_offset, screw_offset + screw_distance, -overlap])
                cylinder(d = screw_diameter, h = height + 2 * overlap);
            translate([screw_offset + screw_distance, screw_offset + screw_distance, -overlap])
                cylinder(d = screw_diameter, h = height + 2 * overlap);
        }            
    }
}

module fan_gasket_mold(
    width = 30,                 // gasket size
    screw_diameter = 3.5,      // diameter of the screw holes
    screw_distance = 24,       // distance of the screw hole centers
    corner_radius = 2,         // radius of the corner
    airflow_diameter = 27,    // diameter of the airflow hole
    height = 2,                // gasket height
    wall_thickness = 3        // wall thickness of the mold
){
    difference(){
        // main mold
        cube([width + 2 * wall_thickness, width + 2 * wall_thickness, height + wall_thickness]);
        
        // subtract fan gasket
        translate([wall_thickness, wall_thickness, wall_thickness])
            fan_gasket(width, screw_diameter, screw_distance, corner_radius, airflow_diameter, height + overlap);
    }
    
}

module easy_fan_gasket(
    width = 30,                 // gasket size
    screw_diameter = 3.5,      // diameter of the screw holes
    screw_distance = 24       // distance of the screw hole centers
){
    fan_gasket(width, screw_diameter, screw_distance, floor(screw_diameter), width - 4, 2);
}

module easy_fan_gasket_mold(
    width = 30,                 // gasket size
    screw_diameter = 3.5,      // diameter of the screw holes
    screw_distance = 24       // distance of the screw hole centers
){
    fan_gasket_mold(width, screw_diameter, screw_distance, floor(screw_diameter), width - 4, 2, 3);
}
