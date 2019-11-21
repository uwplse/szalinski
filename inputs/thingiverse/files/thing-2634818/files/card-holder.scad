// Parametric Nintendo Switch card holder
// Author: Mark Feldman
// Contact: https://www.thingiverse.com/Myndale/about

// number of card sockets in the X and Y directions
numX = 5;
numY = 2;

bottom_thickness = 1;   // thickness of the base
border = 1;             // width of border between cards
holder_radius = 3;      // radius of the outer corners

// dimensions for the cards themselves
card_width = 22.4;
card_height = 31.2;
card_depth = 4.5;
card_radius = 2;

// dimensions for the little cut-out windows at the back of each card
window_width = 16;
window_height = 12;
window_radius = 1;

// dimensions for the small clips that hold the cards in
clip_width = 0.5;
clip_height = 2;
clip_depth = 0.5;
clip_offset = 5;

// calculated values
window_offset = (card_height-window_height)/2 - (card_width-window_width)/2;
windowX = (card_width - window_width) / 2 + border;
windowY = (card_height - window_height) / 2 + window_offset + border;
holder_width = card_width + 2 * border;
holder_height = card_height + 2 * border;
holder_depth = bottom_thickness + card_depth + clip_depth;
clipX = clip_width/2 + border;
clipY = holder_height/2;
clipZ = bottom_thickness + card_depth + clip_depth/2;


$fn = 32;

// arbitrary value used for objects that are used in boolean
// operations so that we don't get flat surfaces appearing at
// the boundries (some slicers aren't very good with them)
delta = 1;  

// a cube with rounded corners on the the x and y axis
module rounded_cube(width, height, depth, radius) {
    translate([radius, radius, 0])
    linear_extrude(height = depth)
    offset(r = radius)
    square([width-2*radius, height-2*radius]);
}

// rounded cube representing the card itself
module card() {
    translate([border, border, bottom_thickness])
    rounded_cube(card_width, card_height, card_depth+delta, card_radius);
}

// geometry used to cut the window
module window() {
    translate([windowX, windowY, -delta])
    rounded_cube(window_width, window_height, card_depth+bottom_thickness+2*delta, window_radius);
}

// creates geometry for the 4 small clips that hold the card in
module clips() {
    translate([clipX, clipY - clip_offset, clipZ])
        cube([clip_width+border, clip_height, clip_depth+delta], center=true);
    translate([clipX, clipY + clip_offset, clipZ])
        cube([clip_width+border, clip_height, clip_depth+delta], center=true);
    translate([holder_width-clipX, clipY - clip_offset, clipZ])
        cube([clip_width+border, clip_height, clip_depth+delta], center=true);
    translate([holder_width-clipX, clipY + clip_offset, clipZ])
        cube([clip_width+border, clip_height, clip_depth+delta], center=true);
}

// creates the geomtery need to "cut out" a single socket 
module cut_out() {
    difference() {
        union() {
            card();
            window();        
        }
        clips();
    }
}

// creates geometry for all sockets
module cut_outs() {
    for (y = [0:numY-1])
        for (x = [0:numX-1])
            translate([x * (holder_width - border), y * (holder_height - border), 0])
                cut_out();
    
}

// top-level piece, creates a single rounded cube of the correct size
// then subtracts the geometry for all the sockets that need to be
// cut out.
module holder() {
    difference() {
        rounded_cube(numX * (holder_width - border) + border, numY * (holder_height - border) + border, holder_depth, holder_radius);
        cut_outs();
    }
}

// 3...2...1...go!
holder();
