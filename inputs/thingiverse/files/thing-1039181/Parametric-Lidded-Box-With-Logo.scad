use <utils/build_plate.scad>

/* [Box And Lid] */

// Do you want to generate both box and lid?
objects_to_generate = 0; // [0:Box and lid,1:Box only,-1:Lid only]

// How wide should the box be? Imagine it being seen from above, and define the radius of the circle it should be contained into (in mm)
outer_radius = 30; 

// How thick should the walls of the box be (in mm)? This number should be smaller that the Outer Radius and Box Height for the box to make sense.
wall_thickness = 3;

// How many sides should the box have? A very high number will produce a box that approximates a cylinder.
sides = 8;

// How tall should the box be (in mm)?  This number should be larger than the Wall Thickness for the box to make sense.
box_height = 50;

// How tall should the lid be (in mm)?
lid_height = 15;

// How much room should be left on all sides between the box and the lid, when the box is closed (in mm)? 
lid_clearance = 0.4; //[0:0.1:1]

/* [Logo] */

// Do you want a logo cut into the lid? If so, choose a 100x100 pixels black and white png file. Please note that detached parts in the logo will fall off, if not connected to the rest of the lid.
lid_logo = ""; // [image_surface:100x100]

// Decide the angle of rotation of the logo to be cut, depending on how many faces your box has, or just on your personal taste
logo_angle = "22"; // [0:1:90]

// Decide how large the logo should be on the lid, in percentage of the inner lid radius
logo_size = 0.5; // [0:0.1:1]
/* [Build Plate] */

// display or hide the build plate
show_build_plate = 1; // [0:Hide,1:Show]

//for display only, doesn't contribute to final object
build_plate_selector = 3; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]
//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 140; //[100:400]
//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]


/* [Hidden] */

doLid = false;
translation = outer_radius + 1;
doBox = false;

if (objects_to_generate >= 0) { // draw box
    assign(doBox = true) {
        if (doBox == true) {
            
            translate([translation,0,0]) {
                difference() {
                    linear_extrude(height = box_height) {
                    circle(r = outer_radius, center=true, $fn = sides);
                    }
                    translate([0,0,wall_thickness]) {
                        linear_extrude(height = box_height) {
                        circle(r = outer_radius - wall_thickness, center=true, $fn = sides);
                        }
                    }
                }
            }
        }
    }
} 


if (objects_to_generate <= 0) { // draw lid
    assign(doLid = true) {
        if(doLid == true) {
            translate([-translation,0,0]) {
                
                    if (lid_logo != "") {
                        
                        inner_radius    = outer_radius - (wall_thickness * 2);
                        inner_diameter  = inner_radius * 2;
                        logo_multiplier = 10/inner_diameter;
                        
                        difference() {
                        lid();
                        translate([0,0,lid_height + 10])                        
                            rotate([0,180,logo_angle])
                                scale([logo_size * logo_multiplier,logo_size * logo_multiplier,(lid_height + 10) * 2])
                                    surface(file = lid_logo, center = true, invert=false);
                        }
                    
                    } else {
                        lid();
                    }
            }
        }
    }
}

module lid() {
    difference() {
                    union() {
                        linear_extrude(height = lid_height) {
                        circle(r = outer_radius, center=true, $fn = sides);
                        }
                        linear_extrude(height = lid_height + wall_thickness) {
                        circle(r = outer_radius - (wall_thickness + lid_clearance), center=true, $fn = sides);
                        }
                    }
                    translate([0,0,wall_thickness]) {
                        linear_extrude(height = lid_height + wall_thickness) {
                        circle(r = outer_radius - (wall_thickness *2), center=true, $fn = sides);
                        }
                    }
                }
}

if (show_build_plate == 1) {
build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);
}


