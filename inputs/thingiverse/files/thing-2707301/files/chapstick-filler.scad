// Adjust the following parameters to 
// to get a number of holes which isn't a multiple of the rows * columns.
//
// Example: To get a 10 hole template...
// rows = 3;
// columns = 4;
// block_out = 2;

// To get a 50 hole template....
//rows = 5;
//columns = 10;
//block_out = 0;

// Number of rows and columns of holes to produce.
rows = 5;
columns = 10;

// Fills back in this many holes in the first row.
block_out = 0;

// Diameter of the holes (in mm)
hole_diameter = 13.9;

// Rim height in mm.
rim_height = 4;

// -- End of editable parameters -- //

// Size of the tray to print, calculated from the above parameters.
width = columns * 20;
height = rows * 20;

union() {
    difference() {
        scale([1/10, 1/10, 1/10])
            minkowski() {
                cube([width * 10, height * 10, ((3 + rim_height) * 10) / 2]);
                cylinder(r=15, h = ((3 + rim_height) * 10) / 2);
            };
        translate([0, 0, 3])
            cube([width, height, rim_height]);
        
        for(x = [10 : 20 : width]) {
            for (y = [10 : 20 : height]) {
                translate([x, y, 0])
                    scale([1/10, 1/10, 1/10])
                        cylinder(30, d= hole_diameter * 10);
            }
        }
    };
    
    
    // refill holes we don't want to be holes.
    if (block_out > 0) {
        translate([0, 0, 0])
            cube([20, 20 * block_out, 3]);
    }
}
