// Bracket for the anycubic Ultrabase
// makes sure the glued on base sticks flat and evenly to the heat-bed

/* [Size] */

// combined height of the ultrabase and heat-bed
base_height = 5.5; //[4.5:0.1:7]

// width of the bracket
bracket_width = 25; //[10:1:50]

// depth of the bracket
bracket_depth = 8; //[6:1:20]

// wall thickness
wall = 1.8; //[1:0.1:4]

difference() {
    cube([bracket_width, base_height + wall * 2, wall + bracket_depth]);
    translate([-0.1, wall, wall])
        cube([bracket_width + 0.2, base_height, wall + bracket_depth]);
}
