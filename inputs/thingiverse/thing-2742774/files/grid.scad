/*
 * Author: Amunak < https://www.thingiverse.com/amunak >
 * License: Creative Commons Attribution-ShareAlike (CC BY-SA 4.0) < https://creativecommons.org/licenses/by-sa/4.0/legalcode >
 * Thingiverse: thing:2742774 < https://www.thingiverse.com/thing:2742774 >
 * 
 * Printing note: unless you set a high enough margin print without skirt and brim!
 */

// Configuration:

//    bed size
//        self explanatory
bed_size = 200;

//    margins
//        gap between bed edges and the grid
margins = 10;

//    layer height
//        (aka the height you want the grid to print)
layer_height = 0.2;

//    line width
//        this should be your nozzle size (feel free to make it larger if you wish)
line_width = 0.4;

//    holes multiplier
//        number of "holes" in the grid in one dimension; for most cases 2 or 4 is ideal (even numbers meet at the center, odd numbers have a hole at the center; values under 1 don't really work and it should be a whole number)
holes_multiplier = 4;

// Advanced configuration
// Use when your X and Y sizes differ
x_size = bed_size;
y_size = bed_size;
x_margin = margins;
y_margin = margins;

// --------------------------------

// Checks:
// TODO: put assert() here instead
if (holes_multiplier < 1) {
    echo("Error: holes_multiplier must be at least 1!");
}
if (holes_multiplier != round(holes_multiplier)) {
    echo("Error: holes_multiplier must be a whole number!");
}
   
// Calculate base plate size
calc_x_size = x_size - (x_margin * 2);
calc_y_size = y_size - (y_margin * 2);

// Calculate size of each hole
calc_box_x_size = ((calc_x_size - line_width) / holes_multiplier) - (line_width);
calc_box_y_size = ((calc_y_size - line_width) / holes_multiplier) - (line_width);


// Create "base plate" and diff out individual "holes"/boxes
translate ([x_margin, y_margin, 0]) {
    difference() {
        cube([calc_x_size, calc_y_size, layer_height]);
    
        for(x = [0 : holes_multiplier-1]) {
            for(y = [0 : holes_multiplier-1]) {
                translate ([
                    (x * (line_width + calc_box_x_size)) + line_width,
                    (y * (line_width + calc_box_y_size)) + line_width,
                    -1
                ]) {
                    cube([calc_box_x_size, calc_box_y_size, layer_height+2]);
                }
            }
        }
    }
}