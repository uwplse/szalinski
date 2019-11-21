/*----------------------------------------------------------------------------*/
/*-------                             Info                            --------*/
/*----------------------------------------------------------------------------*/

// Ruler Holder
// Author: mrmath3
// Version: 1
// Last update: 8/14/18

/*----------------------------------------------------------------------------*/
/*-------                          Parameters                         --------*/
/*----------------------------------------------------------------------------*/

/* [DIMENSIONS] */

// The number of rows (how far up and down)
length = 10; // [1 : 20]

// The number of columns (how far left and right)
width = 3; // number of rulers wide

// The height of the entire holder (z direction)
height = 20; // [10: 5 : 30]

/* [LABELS] */

// Title to display at the top
title = "MrMath3";

// Font size of the title
title_height = 15; // [5 : 30]

// Space between the title and the number below
title_buffer = 3; // [1 : 10]

// Font size of the numbers
label_height = 5; // [2 : 15]

// Space between the number and the hole
label_buffer = 1; // [1 : 0.5 : 3]

// How deep the text is inscribed
text_depth = 2; // [1 : 5]

/* [WALLS] */

// The thickness of the walls between the columns (running up and down)
width_btwn = 3; // [1 : 5]

// The thickness of the outer 3 walls (left, bottom, & right)
wall = 3; // [1 : 5]

/* [HOLES] */

// How thick the hole for each ruler should be
ruler_hole_height = 4; // [2 : 0.5 : 8]

// How long each hole for the ruler should be
ruler_hole_width = 26; // [15 : 35]

/* [HIDDEN] */

fudge = 0.01; // to make difference work properly
totalx = wall+length*(ruler_hole_height+label_height+2*label_buffer)+title_height+title_buffer;
totaly = 2*wall+width*ruler_hole_width+(width-1)*width_btwn;

main();

//// Modules ////

module main() {
    difference() {
        cube([totalx,totaly,height]);
        repeat_holes();
        repeat_labels();
        title();
    }
    //%repeat_holes();
}

module title() {
    translate([totalx-label_buffer-title_height,totaly/2,height-text_depth+fudge])
        rotate([0,0,-90])
            linear_extrude(text_depth)
                text(str(title), title_height, halign = "center");
}

module repeat_labels() {
    for (j=[0:width-1]) {
        translate([0,j*(width_btwn+ruler_hole_width),0])
            for (i=[0:length-1]) {
                translate([wall+label_buffer+ruler_hole_height+i*(ruler_hole_height+label_height+2*label_buffer),0,0])
                    label(length*width-i-length*j);
            }
    }
}

module label(text) {
    translate([0,wall+ruler_hole_width/2,height-text_depth+fudge]) // centered in hole
        rotate([0,0,-90])
            linear_extrude(text_depth)
                text(str(text),label_height, halign = "center");
}

module repeat_holes() {
    for (j=[0:width-1]) {
        translate([0,j*(ruler_hole_width+width_btwn),0])
            for (i=[0:length-1]) {
                translate([i*(label_height+ruler_hole_height+2*label_buffer),0,0])
                    ruler_hole();
            }
    }
}

module ruler_hole() {
    translate([wall,wall,wall])
        cube([ruler_hole_height,ruler_hole_width,310]);
}