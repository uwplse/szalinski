/*
Parametric LEGO Grove Module Enclosure
From http://www.thingiverse.com/thing:2298129
Maintained at https://github.com/paulirotta/lego_grove/
Designed for use with http://wiki.seeed.cc/Grove_System/

By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: https://medium.com/@paulhoughton

Creative Commons Attribution ShareAlike License
https://creativecommons.org/licenses/by-sa/4.0/legalcode

Although this file is parametric and designed for use with an online customizer, it is too slow and things break in the cloud- you must download it to make changes vs the pre-generated .STL files normally found with this file.
*/

/* [LEGO Connector Fit Options] */

// Top connector size tweak (0 is nominal spec for ABS. Try -0.05 for PLA, NGEN and other stiff plastic if the top connector is too tight)
top_tweak = 0; //-0.05;

// Bottom connector size tweak (0 is nominal spec for ABS, Try -0.05 for NGEN, PLA and other stiff stiff plastic if the bottom connector is too tight)
bottom_tweak = 0; //-0.05;



/* [LEGO Options] */

// Number of facets to form a circle
$fn=32;

// Clearance space on the outer surface of bricks
skin = 0.1;

// Size of the connectors
knob_radius=2.4;

// Height of the connectors
knob_height=1.8;

// Depth which connectors may press into part bottom
socket_height=3;

// Bottom connector assistance ring size
ring_radius=3.25;

// Bottom connector assistance ring thickness
ring_thickness=0.8;

// Basic unit horizonal size of LEGO
block_width=8;

// Basic unit vertial size of LEGO
block_height=9.6;

// Thickness of the solid outside surface of LEGO
block_shell=1.3; // thickness




// The round bit on top of a lego block
module knob(top_size_tweak=0) {
    cylinder(r=knob_radius+top_size_tweak,h=knob_height);
}

// The rectangular part of the the lego plus the knob
module block(z=1,top_size_tweak=0) {
    cube([block_width,block_width,z*block_height]);
    translate([block_width/2,block_width/2,z*block_height])
        knob(top_size_tweak);
}

// Several blocks in a grid, one knob per block
module block_set(x=2,y=2,z=2,top_size_tweak=0) {
    for (i = [0:1:x-1]) {
        for (j = [0:1:y-1]) {
            translate([i*block_width,j*block_width,0])
                block(z,top_size_tweak);
        }
    }
}

// That solid outer skin of the block set
module block_shell(x=2,y=2,z=2) {
    cube([block_shell,y*block_width,z*block_height]);
    translate([x*block_width-block_shell,0,0]) 
        cube([block_shell,y*block_width,z*block_height]);
    
    cube([x*block_width,block_shell,z*block_height]);
    translate([0,y*block_width-block_shell,0])
        cube([x*block_width,block_shell,z*block_height]);
    
    translate([0,0,z*block_height-block_shell])
        cube([x*block_width,y*block_width,block_shell]);
}

// Bottom connector- negative space for one block
module socket(bottom_size_tweak=0) {
    difference() {
        cube([block_width,block_width,socket_height]);
        union() {
            translate([0,0,0])
                socket_ring(bottom_size_tweak);
            translate([block_width,0,0])
                socket_ring(bottom_size_tweak);
            translate([0,block_width,0]) 
                socket_ring(bottom_size_tweak);
            translate([block_width,block_width,0])
                socket_ring(bottom_size_tweak);
        }
    }
}

// The circular bottom insert for attaching knobs
module socket_ring(bottom_size_tweak=0) {
    difference() {
        cylinder(r=ring_radius+bottom_size_tweak,h=socket_height);
        cylinder(r=ring_radius+bottom_size_tweak-ring_thickness,h=socket_height);
    }
}

// Bottom connector- negative space for multiple blocks
module socket_set(x=2,y=2,bottom_size_tweak=0) {
    for (i = [0:1:x-1]) {
        for (j = [0:1:y-1]) {
            translate([i*block_width,j*block_width,0])
                socket(bottom_size_tweak);
        }
    }
}

module skin(x=2,y=2,z=2) {
    difference() {
        cube([block_width*x,block_width*y,z*block_height]);
        translate([skin,skin,0])
            cube([block_width*x - 2*skin,block_width*y - 2*skin,z*block_height]);
    }
}

// A complete LEGO block, standard size, specify number of layers in X Y and Z
module lego(x=2,y=2,z=2,bottom_size_tweak=0,top_size_tweak=0) {
    difference() {
        union() {
            block_shell(x,y,z);
            difference() {
                block_set(x,y,z,top_size_tweak);
                socket_set(x,y,bottom_size_tweak);
            }
        }
        skin(x,y,z);
    }
}

// Function for access to horizontal size from other modules
function lego_width(x=1) = x*block_width;

// Function for access to vertical size from other modules
function lego_height(z=1) = z*block_height + knob_height;

// Function for access to outside shell size from other modules
function lego_shell_width() = block_shell;

// Function for access to clearance space from other modules
function lego_skin_width() = skin;

//////////////////////////////////////////////////////////


/* [Grove Module Options] */

// Grove sensor board size
grove_width = 20;

// Room below the board
bottom_space = 2.2;

// Board thickness
thickness = 1.8;

// Screw mount space on edge of board
eye_radius = 2.5; 

// Slide in mounting groove depth
edge_inset = 0.6;

// Additional space around the module for easly slotting the module into a surrounding case (make this bigger if the board fits too tightly)
mink = 0.25;

// Length of the negative space exclusion zone in front of the module
negative_space_height=100;

// For use in other code: use <grove_module.scad>
function grove_width() = grove_width;

// A complete Grove module negative space assembly. These are all the areas where you do _not_ want material in order to be able to place a real Grove module embedded within another part
module grove() {
    minkowski() {
        union() {
            board();
            negative_space();            
        }
        sphere(r=mink);
    }
}

// Grove module main board (PCB with two screw mounts)
module board() {
    translate([0,0,bottom_space])
        cube([grove_width,grove_width,thickness]);
    translate([grove_width/2,0,bottom_space])
        eye();
    translate([grove_width/2,grove_width,bottom_space])
        eye();            
}

// The bump on the side of a Grove module where a screw holder can be inserted. In this design, this is simply used for orienting the Grove module within another block (no screws are usually used)
module eye() {
    cylinder(r=eye_radius,h=thickness);
}

// Space for the board components and access to the Grove connector on the front of the board (no material is here)
module negative_space() {
    translate([edge_inset,edge_inset,0])
        cube([grove_width-2*edge_inset,grove_width-2*edge_inset,negative_space_height]);
}


/////////////////////////////////

// A 4-2-3 LEGO block with a Grove-sized hole in it. This block must be sliced into top and bottom halves (.scad files elsewhere) in order for you to be able to fit the Grove module inside.
module lego_grove(top_size_tweak=0,bottom_size_tweak=0) {
    difference() {
        lego(4,2,3,top_size_tweak,bottom_size_tweak);
        translate([grove_width() + (lego_width(4)-grove_width())/2,lego_width(2)-2*lego_shell_width(),(lego_height(3)-grove_width())/2])
            rotate([90,0,0]) rotate([0,0,90]) 
            grove();       
    }
}

////////////////////////////////

// Size of the cut block to separate top and top parts (any sufficiently large number)
s = 1000;

// The shape, including alignment notch, which separates the top and bottom halves of a part
module cut_block(h = 3) {
    translate([-s/2, -s/2, h/2 - s])
        cube(s,s,s);
}


/////////////////////////////////


translate([0,0,-lego_height(1.5)+knob_height/2]) 
difference() {
    lego_grove(top_tweak,bottom_tweak);
    cut_block(lego_height(3)+skin);
}


///////////////////////////////



// This piece is flipped upside down for ease of printing next to the top half pieces with support strctures turned on. Cleaning support structures from the bottom connector of LEGO would be messy and most people will print top and bottom halves at the same time.
translate([-5,0,lego_height(1.5)-knob_height/2]) 
rotate([0,180,0])
    intersection() {
        lego_grove(top_tweak,bottom_tweak);
        cut_block(lego_height(3)-skin);
    }