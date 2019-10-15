/* [Main] */
number_of_drawers   =     4;        //[2:6]
render_drawers      =     1;        //[1,All]
inner_diameter      =    90;        //[20:0.5:150]   
outer_diameter      =   200;        //[40:0.5:500]   
inner_spool_width   =    56.5;      //[10:0.5:200]   
spool_hole_diameter =    30;        //[20:0.5:200]   
segments_per_circle =   360;        //[18:0.5:360]   

/* [General] */
wall_thickness      =     2;        //[2:0.5:5]
clearance_from_spool=     1;        //[1:0.5:5]
screw_hole_diameter =     2.492;    //[2:0.001:5]
tab_length          =     9;        //[2:0.5:25]
tab_width           =     5;        //[2:0.5:10]
best_scifi_is       = "Star Trek";  //["Star Trek","Star Wars"]

//number_of_drawers   // How many shelves per 360 degrees
//inner_diameter      // What is the diameter of the inner part of the spool
//outer_diameter      // What is the diameter of the outter sides of the spool
//inner_spool_width   // How wide is the inner part of the spool
//spool_hole_diameter // What is the diameter for the center hole
//segments_per_circle // How clean do you want the circles

// preview[view:north west, tilt:top]

//// Spool
//difference() {
//    union() {
//        // Bottom
//        cylinder(h = wall_thickness, d = outer_diameter, center = false, $fn = segments_per_circle);
//
//        // Top
//        translate([0, 0, inner_spool_width + wall_thickness]) cylinder(h = wall_thickness, d = outer_diameter, center = false, $fn = segments_per_circle);
//
//        // Middle
//        translate([0, 0, wall_thickness])
//            cylinder(h = inner_spool_width, d = inner_diameter, center = false, $fn = segments_per_circle);
//    }
//    // Middle Hole
//    cylinder(h = inner_spool_width + wall_thickness*4, d = spool_hole_diameter, center = false, $fn = segments_per_circle);
//}

// Figure out the subidivded angles
dividedByAngles = 360 / number_of_drawers;      // Figure out where to divide
echo(dividedByAngles=dividedByAngles);

// Storage Area
difference() {
    union() {
        difference() {
            // Outer wall
            translate([0, 0, wall_thickness + clearance_from_spool])
                cylinder(h = inner_spool_width - clearance_from_spool*2, d = outer_diameter, center = false, $fn = segments_per_circle);
            
            // Inner void
            translate([0, 0, wall_thickness + clearance_from_spool + wall_thickness])
                cylinder(h = inner_spool_width - clearance_from_spool*2, d = outer_diameter - wall_thickness*2, center = false, $fn = segments_per_circle);
        }

        // Inner wall
        translate([0, 0, wall_thickness + clearance_from_spool])
            cylinder(h = inner_spool_width - clearance_from_spool*2, d = inner_diameter + clearance_from_spool + wall_thickness*2 , center = false, $fn = segments_per_circle);

        // Create Subdivision Walls
        union() {
            // Go around and create walls, mount holes, etc.
            for (split = [0 : dividedByAngles : (render_drawers==1 ? dividedByAngles : 360 - dividedByAngles)]) {
                // Create really thick walls to divide later
                translate([0, 0, wall_thickness + clearance_from_spool]) rotate([0, 0, split]) translate([-wall_thickness*2, 0, 0])
                    cube(size = [wall_thickness*4, outer_diameter/2, inner_spool_width - clearance_from_spool*2], center = false);

                // Mount hole surround
                rotate([0, 0, split]) translate([-wall_thickness*3, outer_diameter/2 - wall_thickness*2, wall_thickness + clearance_from_spool])
                    cylinder(h = inner_spool_width - clearance_from_spool*2, r = screw_hole_diameter/2 + wall_thickness, center = false, $fn = segments_per_circle);
                
                // Pull tabs
                rotate([0, 0, split]) translate([wall_thickness - 1, outer_diameter/2 - wall_thickness, wall_thickness + clearance_from_spool])
                    cube(size = [tab_width + 1, tab_length/2 + wall_thickness , inner_spool_width - clearance_from_spool*2], center = false);
                rotate([0, 0, split]) translate([wall_thickness + tab_width/2, outer_diameter/2 + tab_length/2  , wall_thickness + clearance_from_spool])
                    cylinder(h = inner_spool_width - clearance_from_spool*2, d = tab_width, center = false, $fn = segments_per_circle);
            } // for
        } // union
    } // union
    
    // Create Subdivide voids
    union() {
        for (split = [0 : dividedByAngles : (render_drawers==1 ? dividedByAngles : 360 - dividedByAngles)]) {
            // Void between walls
            translate([0, 0, wall_thickness + clearance_from_spool]) rotate([0, 0, split]) translate([-wall_thickness, 0, -wall_thickness])
                cube(size = [wall_thickness*2, outer_diameter, inner_spool_width + wall_thickness*2], center = false);
            
            // Mount hole
            translate([0, 0, wall_thickness + clearance_from_spool]) rotate([0,0,split]) translate([-wall_thickness*3,outer_diameter/2 - wall_thickness*2,0])
                cylinder(h = inner_spool_width - clearance_from_spool*2, r = screw_hole_diameter/2, center = false, $fn = segments_per_circle);

        } // for
    } // union

    // Middle Delete
    translate([0, 0, wall_thickness]) cylinder(h = inner_spool_width, d = inner_diameter + clearance_from_spool, center = false, $fn = segments_per_circle);
    
    // Create blocks to delete all but one of the drawers if requested
    if ( render_drawers == 1 ) {
        total_length = outer_diameter*2 + tab_length*2;
        
        translate([0,-total_length/2,0]) 
            cube(size = [total_length, total_length, inner_spool_width + clearance_from_spool*2], center = false);

        echo(dividedByAngles=dividedByAngles);
        rotate([0,0,dividedByAngles-180]) translate([0,-total_length/2,0]) 
            cube(size = [total_length, total_length, inner_spool_width + clearance_from_spool*2], center = false);
    }  // if
}  // difference

