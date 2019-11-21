/* [Cards] */
// The number of SD cards you want to fit inside
number_of_cards = 2; // [1,2,3]

// The width of the SD card (mm)
card_width = 25; // [10:50]
// The height of the SD card (mm)
card_height = 34; // [10:50]
// The depth of the SD card (mm)
card_depth = 2.25; 

// The thickness you want the edges of the container to be (mm)
edge_thickness = 1; // [1,2]

/* [Hinge] */
// The thickness you want the hinge to be (mm)
hinge_thickness = 0.5; // 
// The dimensions of the gap used to help the 90 degree bends (mm)
hinge_bend_gap = 0.4; // 

/* [Loop] */
// The inner radius of the loop's hole (mm)
loop_hole_radius = 2.5; 
// The outer radius of the loop (mm)
loop_outer_radius = 4.5; 
// The location of the loop hole (mm)
loop_hole_location = 4.5;

fudge = 0.2;
halffudge = fudge / 2;

    container_depth = card_depth * number_of_cards;
    halfcontainer_depth = container_depth / 2;

    model_height = card_width + edge_thickness * 2;
    model_depth = halfcontainer_depth + edge_thickness;

    hole_depth = model_depth;

    // not including loop
    modelwidth = (card_height + edge_thickness + model_depth) * 2;

    // center x and y on axes
    translate([-model_height/2, -modelwidth/2, 0])
    difference() {
        union() {
            difference() {
                union() {
                    // main body
                    cube([model_height, modelwidth, model_depth], center = false);
                }
                union() {
                    // remove space for cards
                    translate([edge_thickness, edge_thickness, edge_thickness]) 
                    cube([card_width, card_height + fudge, halfcontainer_depth + fudge]);
                    translate([edge_thickness, card_height + edge_thickness + model_depth * 2, edge_thickness]) 
                    cube([card_width, card_height, halfcontainer_depth + fudge]);
                }
            }
            union() {
                // loop for keychain
                translate([loop_hole_location, 0, 0]) 
                cylinder(h = hole_depth, r = loop_outer_radius);    
                translate([loop_hole_location, modelwidth, 0]) 
                cylinder(h = hole_depth, r = loop_outer_radius);    
            }
        }
        union() {
            // hole in loop
            translate([loop_hole_location, 0, -halffudge]) 
            cylinder(h = hole_depth + fudge, r = loop_hole_radius);    
            translate([loop_hole_location, modelwidth, -halffudge]) 
            cylinder(h = hole_depth + fudge, r = loop_hole_radius);    

            // hinge area
            translate([-halffudge, card_height + edge_thickness, .5]) 
            cube([model_height + fudge, model_depth * 2 + fudge, model_depth - hinge_thickness + fudge]);

            // gap for bending
            translate([0, card_height + edge_thickness - hinge_bend_gap, 0]) 
            cube([model_height, hinge_bend_gap, hinge_bend_gap], center = false);
            translate([0, card_height + edge_thickness + model_depth * 2, 0]) 
            cube([model_height, hinge_bend_gap, hinge_bend_gap], center = false);
        }
    }
