// Cubistand Pencil Holder Remix
// Based off of sdmc's Cubistand Pencil Holder
// link: https://www.thingiverse.com/thing:1294085
// Author: mrmath3
// Version: 2
// Last update: 4/19/17

//// Parameters ///////////////////////////////////////

// Enter the maximum diameter of your pen/pencil in mm
// This will usually be the grip or the clip

// The biggest diameter of your object in mm
max_diameter = 10;

// Specify the number of cells for the length
// If you have a length of 8, then you will have a grid of 64
// Note that 1 to 2 cells in the grid might be use for the stand

// The number of cells for the length and width (square this number)
n_cells_long = 9;

// Text to put on rod
// Note you need a short phrase (unless you want to make the font smaller)
// To change more specifics (like font size) see below under the rod module

// This is on the bottom of the rod
rod_text = "text here";
// Changes the font size (as a percent)
text_size = 70; // [20:80]

// Choose which part(s) to print
part = "all parts"; // [all parts,top grid,base grid, rod, cap]

/* [Other Variables that don't need to be changed] */

// Distance between the 2 grids
rod_height = 60; // [20:200]
// Height of the grids
stand_height = 10; // [2:20]
// Width of the solid floor for the base
floor_height = 3; // [0:10]
// Height of the cap
cap_height = 5; // [0:10]
// Thickness of all of the walls
wall_width = 1; // [1:5]
// Snugness - how tight the rod fits with the rest of the parts
snug = .5;
// Distance between prints
print_distance = 5; // [1:50]


/* [Hidden] */

// Calculations
cell_length = 1.1*max_diameter;
n_walls = n_cells_long + 1; // 8 cells needs 9 walls
total_length = cell_length * n_cells_long + n_walls * wall_width;

//// Render ///////////////////////////////////////

$fn = 50; // makes circles look better with more edges

print_part(part);

//// Modules ///////////////////////////////////////
module print_part(part) {
	if (part == "all parts") {
		all_parts();
	} else if (part == "top grid") {
		main_grid();
	} else if (part == "base grid") {
		grid_base();
	} else if (part == "rod") {
		rod();
	} else if (part == "cap") {
        cap();
    }
}

module all_parts(){
    grid_base();
    translate([0,total_length+print_distance,0]){
        main_grid();
    }
    translate([total_length+print_distance,0,0]){
        rod();
    }
    translate([total_length+print_distance,rod_height+stand_height+stand_height+cap_height-wall_width+print_distance,0]){
        cap();
    }
}

module main_grid(){
    difference(){
        // Making big rectangular prism
        // Need to translate as a result of winkowski adding 1mm
        translate([1,1,0]){
            minkowski(){
                // Need to subtract 1 b/c minkowski always adds 1mm in z and 2mm in x and y
                cube([total_length-2,total_length-2,stand_height-1]);
                cylinder([1,1,1]);
            }
        }
        
        // Need to repeat mini cubes to hollow out spaces
        for (i = [1:n_cells_long]){
            for (j= [1:n_cells_long]){
                translate([wall_width*i+cell_length*(i-1),wall_width*j+cell_length*(j-1),-.01]){
                    cube([cell_length,cell_length,stand_height*1.05]);
                }
            }
        }
    }
}

module grid_base(){
    translate([0,0,floor_height]){
        main_grid();
        translate([1,1,-floor_height]){
            minkowski(){
                // Need to subtract 1 b/c minkowski always adds 1mm in z and 2mm in x and y
                cube([total_length-2,total_length-2,floor_height -1]);
                cylinder([1,1,1]);
            }
        }
    }
}

module rod(){
    difference(){
        translate([0,0,cell_length+2]){
            rotate([-90,0,0]){
                union(){
                    translate([1,1,stand_height]){
                        minkowski(){
                            cube([cell_length+wall_width-1,cell_length+wall_width-1,rod_height-1]);
                            cylinder([1,1,1]);
                        }
                    }
                    translate([wall_width,wall_width,0]){
                        cube([cell_length-snug,cell_length-snug,stand_height]);
                    }
                    translate([wall_width,wall_width,rod_height+stand_height]){
                        cube([cell_length-snug,cell_length-snug,stand_height+cap_height-wall_width]);
                    }
                }
            }
        }
        linear_extrude(height=1){
            translate([cell_length/2+1,rod_height/2+stand_height,0]){
                rotate([180,0,90]){
                    // Time to add the text!
                    text(rod_text,size=cell_length*text_size/100,font="Futura",halign="center",valign="center");
                }
            }
        }
    }
}

module cap(){
    translate([1,1,0]){
        difference(){
            minkowski(){
                cube([cell_length+wall_width-1,cell_length+wall_width-1,cap_height-1]);
                cylinder([1,1,1]);
            }
            translate([0,0,wall_width]){
                cube([cell_length,cell_length,cap_height]);
            }
        }
    }
}