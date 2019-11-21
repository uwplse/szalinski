// Small hook for tool walls using the european "Eurolochung" pattern
// Author: Peter Jochum <peter.jochum@aau.at>

//include <utils/build_plate.scad>

// Length of the hook (horizontal part)
length = 25; // [15:60]

// Height of the hook (vertical part)
height = 25; // [10:50]

// Width of the hook
width = 8; // [5:30]

// Height of the horizontal hook part
height_bottom = 5; // [3:10]

// width the wall hook part
width_wall = 5; // [3:10]

// Sizes and type of hook end
hook_end_length = 4; // how deep the end of the hook is
hook_end_height = 5;  // height of the end of the hook

// Type of the hook end
hook_end_type = "triangle";  // [square,triangle]

// Sizes regarding the holders for your tool wall
// Space between holes in tool wall (12 and 15mm seem to be common)
hole_vertical_distance = 12;

// Diameter of the holes
hole_diameter = 5;

// Length of the holding cylinders
holder_height = 2; // [0.0:10.0]

// Thickness of the metal - a smaller cylinder is created along this distance
metal_thickness = 1; 

// This value is subtracted from the cylinders to make holders fit easier into the wall holes
fitting_modifier = 0.2;


// Performance variables
cylinder_segments = 20*1; // how detailed the segments of the used cylinders are

// Calculated variables (DO NOT TOUCH)
spacer_height = metal_thickness + fitting_modifier; // add fitting_modifier for an easier fit
hole_radius = hole_diameter / 2;


// Main body of the hook, a cube
module body() {
    union() {
    color("Lightblue") cube([width_wall, width, height]);
        translate([width_wall, 0, 0]) {
            color("Red") cube([length-width_wall, width, height_bottom]);
        }
    }
}

module hook_end() {
    translate([length-hook_end_length,0,height_bottom]) {
        if(hook_end_type == "square")  hook_end_square(); 
        if (hook_end_type == "triangle") hook_end_triangle();
    }
}

// Adds a square end to the hook so tools don't fall off
module hook_end_square() {
    color("Green") cube([hook_end_length, width, hook_end_height]);
}

// Adds a triangular end to the hook for easier removal of tools
module hook_end_triangle() {
    hook_points = [[0,0], [hook_end_length,0], [hook_end_length, hook_end_height]];
    translate([0,width, 0]) {
        rotate([90, 0, 0]) {
            linear_extrude(height=width) {
                polygon(points=hook_points);
            }
        }
    }
}

module hole_mount() {
    rotate([0,90,0]) {
        union () {
                cylinder(h=spacer_height, r=hole_radius*0.67, center=true,  $fn=cylinder_segments);
            translate([0, 0, -spacer_height]) {
                cylinder(h=holder_height, r=hole_radius-fitting_modifier, center=true, $fn=cylinder_segments); // fitting modifier is subracted from the radius to facliate insertion
            }
        }
    }
}

rotate([90,0,0]) { // Part will be printed sideways
    union () {
        body();
        hook_end();
         translate([-spacer_height/2,  width/2,  0]) {
             for(i=[0:1]) {
                 translate([0,0,height*.1 + hole_radius + (i*hole_vertical_distance)]) {
                        hole_mount();
                 }
             }
         }
     }
 }

//build_plate(3,250,210);
