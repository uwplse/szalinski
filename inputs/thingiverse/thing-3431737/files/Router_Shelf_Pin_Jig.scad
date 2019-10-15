// Settings 

$fa=1*1;
$fs=0.25*1;


// add support fingers to prevent router from tilting
tilt_support = 1; // [0:No Support,1:With Router Support Fingers]

// with fence or flat
with_fence = 1; // [0:Flat,1:With fence]

// the max usable size of the printing bed: determines number of holes
max_print_size = 200;

// center distance between two pin holes 
hole_to_hole_distance = 32;
// distance from fence/edge to hole center
hole_to_fence_distance = 37;

// plate thickness (without chip_support_height). Should be deeper than copy ring depth
jig_thickness = 9;

// diameter of copy ring
copy_ring_diameter = 17;

// adjust cut-out (e.g for copy ring and connector bearing) if printer prints to tight. For my Anycubic I have to set/add 0.4 in order to get correct inner diameters. Adjust this according to the precision of your printer.
cutout_adjust = 0.4;


// height of bottom wood chips path
chip_support_height = 2.5;

// width of chip path strips
chip_support_width = 8;

// thickness of side fence
jig_fence_thickness = 8;

// height of side fence 
jig_fence_height_over_plane = 15;

// connector screw (rod) diameter
connector_screw_diameter = 4;

// spacer screw diameter
spacer_screw_diameter = 4;



// computed figures
nof_holes = floor(max_print_size / hole_to_hole_distance);


// connector screw thickness
connector_nut_thickness = 6 + cutout_adjust;


// computed params
copy_ring_diameter_mod = copy_ring_diameter + cutout_adjust;
jig_fence_height = jig_thickness + chip_support_height + jig_fence_height_over_plane;
jig_length = hole_to_hole_distance * nof_holes;
jig_width = hole_to_fence_distance + copy_ring_diameter_mod/2 + 5;



difference() {
    union() {
        
        if (with_fence == 1) {
            // side fence
            translate([0, -jig_fence_thickness, 0]) {
                cube([jig_length, jig_fence_thickness, jig_fence_height], center=false);
            }
        } 


        // main plate
        cube([jig_length, jig_width, jig_thickness], center=false);

        if (tilt_support == 1) {
            support_dist = jig_length / 4; 
            support_width = support_dist/4;
            for ( i = [support_dist/2:support_dist:4*support_dist] ) {
                translate([i-support_width/2, jig_width-5, 0])
                    cube([support_width, jig_width, jig_thickness+chip_support_height]);

            }
        }
        
        // path for wood chips
        if (chip_support_height > 0) {

            chip_support();
            
            if (tilt_support == 0) {
                translate([0, jig_width-chip_support_width, 0])
                chip_support();
            }
            
            translate([0, jig_width/2-chip_support_width/2, 0])
                chip_support();
            
            spacer_support();
            translate([jig_length-10, 0, 0])
                spacer_support();
            translate([jig_length/2-5, 0, 0])
                spacer_support();
        }
    };
    group() {
        for ( i = [hole_to_hole_distance/2:hole_to_hole_distance:nof_holes*hole_to_hole_distance] ) {
            translate([i, hole_to_fence_distance, 0]) {
                // cylinder(jig_thickness, d=drill_hole_diameter, center=false);
                cylinder(jig_thickness+chip_support_height, d=copy_ring_diameter_mod, center=false);
            };
        };
        
    }
    
    translate([0,chip_support_width/2,0])
        connector_rod();
    translate([0,jig_width/2,0])
        connector_rod();
    
    
    // cutout for connector nuts
    translate([hole_to_hole_distance-connector_nut_thickness/2, 0, 0])
        connector_nuts_cutout();
    translate([jig_length-hole_to_hole_distance-connector_nut_thickness/2, 0, 0])
        connector_nuts_cutout();


    if (with_fence == 1) {
        // bores in fence
        translate([jig_length/4, 0, 0])
            spacer_screw();
        translate([jig_length/4*3, 0, 0])
            spacer_screw();
    }
}


if (with_fence == 0) {
    translate([0, chip_support_width+1, 0])
        cube([jig_length, 5, jig_thickness], center=false);            
}


// additional path for wood chips
module chip_support() {
    
    translate([0, 0, jig_thickness])
        cube([jig_length, chip_support_width, chip_support_height]);

    
}

// additional bridges to avoid skewing due to chip groove if larger spacers are used
module spacer_support() {
    
    translate([0, 0, jig_thickness])
        cube([10, hole_to_fence_distance-copy_ring_diameter/2, chip_support_height]); 
    
}



// bore for threading rod connecting 2 jigs 
module connector_rod() {
    translate([0,0,(jig_thickness+chip_support_height/2)/2])
        rotate([0,90,0])
            cylinder(jig_length, d=connector_screw_diameter+cutout_adjust);
}


// cut-out for connector screw nut 
module connector_nuts_cutout() {   
    translate([0, -2, 0])
    cube([connector_nut_thickness, hole_to_fence_distance-copy_ring_diameter_mod/2+connector_nut_thickness, jig_thickness+chip_support_height]);
}


// bore in fence to attach spacer element
module spacer_screw() {
    
    translate([0,0,jig_thickness+chip_support_height+jig_fence_height_over_plane/2])
        rotate([90,0,0])
            cylinder(jig_fence_thickness, d=spacer_screw_diameter+cutout_adjust);
    
}
