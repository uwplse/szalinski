// Structured Media Center bracket generator
// Copyright 2018 - Mike Ryan (falter@gmail.com)

/* [Spacing] */
// Spacing between holes (center-to-center) of rows, in inches.
row_spacing_inches=1;
// Spacing between holes (center-to-center) of columns, in inches.
col_spacing_inches=[3,3,0.625];

/* [Main] */
part = "left"; // [left:Left Mount, right:Right Mount]
// number of rows
numberOfRows = 5; // [1:12]

/* [End Stop and Device Width Options] */


/* [Flange Options] */
// Type of Flange in Row 1
flange01 = 2; // [0:None, 1:Blank, 2:Hole]
// Type of Flange in Row 2
flange02 = 2; // [0:None, 1:Blank, 2:Hole]
// Type of Flange in Row 3
flange03 = 2; // [0:None, 1:Blank, 2:Hole]
// Type of Flange in Row 4
flange04 = 2; // [0:None, 1:Blank, 2:Hole]
// Type of Flange in Row 5
flange05 = 2; // [0:None, 1:Blank, 2:Hole]
// Type of Flange in Row 6
flange06 = 0; // [0:None, 1:Blank, 2:Hole]
// Type of Flange in Row 7
flange07 = 0; // [0:None, 1:Blank, 2:Hole]
// Type of Flange in Row 8
flange08 = 0; // [0:None, 1:Blank, 2:Hole]
// Type of Flange in Row 9
flange09 = 0; // [0:None, 1:Blank, 2:Hole]
// Type of Flange in Row 10
flange10 = 0; // [0:None, 1:Blank, 2:Hole]
// Type of Flange in Row 11
flange11 = 0; // [0:None, 1:Blank, 2:Hole]
// Type of Flange in Row 12
flange12 = 0; // [0:None, 1:Blank, 2:Hole]

/* [Support Block Options] */
// If set, a supportBlockXOffsetInches will be determined that will fit a device of deviceWidthInInches width
deviceWidthInInches = 0;

// support block x offset in inches
supportBlockXOffsetInches = 0.625;

// support block width in inches
supportBlockWidthInches = 0.625;

// support block x offset in inches
sideStopWidthInches= 0.0625;

// end stop height in inches
endStopHeightInches = 0.5;
// end stop width in inches
endStopWidthInches = 0.625;
// strap slot width in inches
strapSlotWidthInches = 0.75;
// Type of Support Block in Row 1
support_block01 = 5; // [ 0:None, 1:Block, 2:BlockWithStrap, 3:EndStop, 4:SideStop, 5:EndStopWithSideStop ]
// Type of Support Block in Row 2
support_block02 = 2; // [ 0:None, 1:Block, 2:BlockWithStrap, 3:EndStop, 4:SideStop, 5:EndStopWithSideStop ]
// Type of Support Block in Row 3
support_block03 = 2; // [ 0:None, 1:Block, 2:BlockWithStrap, 3:EndStop, 4:SideStop, 5:EndStopWithSideStop ]
// Type of Support Block in Row 4
support_block04 = 2; // [ 0:None, 1:Block, 2:BlockWithStrap, 3:EndStop, 4:SideStop, 5:EndStopWithSideStop ]
// Type of Support Block in Row 5
support_block05 = 2; // [ 0:None, 1:Block, 2:BlockWithStrap, 3:EndStop, 4:SideStop, 5:EndStopWithSideStop ]
// Type of Support Block in Row 6
support_block06 = 0; // [ 0:None, 1:Block, 2:BlockWithStrap, 3:EndStop, 4:SideStop, 5:EndStopWithSideStop ]
// Type of Support Block in Row 7
support_block07 = 0; // [ 0:None, 1:Block, 2:BlockWithStrap, 3:EndStop, 4:SideStop, 5:EndStopWithSideStop ]
// Type of Support Block in Row 8
support_block08 = 0; // [ 0:None, 1:Block, 2:BlockWithStrap, 3:EndStop, 4:SideStop, 5:EndStopWithSideStop ]
// Type of Support Block in Row 9
support_block09 = 0; // [ 0:None, 1:Block, 2:BlockWithStrap, 3:EndStop, 4:SideStop, 5:EndStopWithSideStop ]
// Type of Support Block in Row 10
support_block10 = 0; // [ 0:None, 1:Block, 2:BlockWithStrap, 3:EndStop, 4:SideStop, 5:EndStopWithSideStop ]
// Type of Support Block in Row 11
support_block11 = 0; // [ 0:None, 1:Block, 2:BlockWithStrap, 3:EndStop, 4:SideStop, 5:EndStopWithSideStop ]
// Type of Support Block in Row 12
support_block12 = 0; // [ 0:None, 1:Block, 2:BlockWithStrap, 3:EndStop, 4:SideStop, 5:EndStopWithSideStop ]

/* [Hidden] */
inch = 25.4;
$fn = 36;
// Constants
FLANGE_NONE  = 0;
FLANGE_BLANK = 1;
FLANGE_HOLE  = 2;

SUPPORT_BLOCK_NONE = 0;
SUPPORT_BLOCK_BLOCK = 1;
SUPPORT_BLOCK_WITH_STRAP = 2;
SUPPORT_BLOCK_WITH_END_STOP = 3;
SUPPORT_BLOCK_WITH_SIDE_STOP = 4;
SUPPORT_BLOCK_WITH_END_STOP_AND_SIDE_STOP = 5;


vertical_hole_spacing = row_spacing_inches * inch;
hole_diameter = 1/4 * inch;
hole_thickness = 1/16 * inch;
countersunk_hole_diameter = 7/16 * inch;
flange_thickness = 1/8 * inch;
flange_width_max = 5/8 * inch;
stop_side_width = sideStopWidthInches * inch;

function calc_block_x_offset_for_width(width, column = 0, r = -1) = r >= 0 ? r : calc_block_x_offset_for_width(width, column+1, r=((col_right_flange_offset(column) - col_left_flange_offset(0) - width)/2 - stop_side_width));


support_block_x_offset = deviceWidthInInches > 0 ? calc_block_x_offset_for_width(deviceWidthInInches*inch) : supportBlockXOffsetInches*inch;

flange_rows = [flange01,flange02,flange03,flange04,flange05,flange06,flange07,flange08,flange09,flange10,flange11,flange12];
support_block_rows = [support_block01,support_block02,support_block03,support_block04,support_block05,support_block06,support_block07,support_block08,support_block09,support_block10,support_block11,support_block12];

print_part();

module print_part() {
    if (part == "left") {
        make_mount();
    } else if (part == "right") {
        mirror([1,0,0]) make_mount();

    }
}

module make_mount() {
    scmMount(num_rows=numberOfRows,
                    stop_height=endStopHeightInches*inch,
                    support_block_width=supportBlockWidthInches * inch,
                    flange_rows=flange_rows,
                    support_block_rows=support_block_rows,
                    support_block_x_offset=support_block_x_offset,
                    stop_bottom_width=endStopWidthInches * inch,
                    stop_side_width=stop_side_width,
                    strap_slot_width=strapSlotWidthInches * inch
    );
}


function col_hole_offset(x = 0, i = 0, r = 0) =  i < x ? col_hole_offset(x, i + 1, r + col_spacing_inches[i%len(col_spacing_inches)]) : r*inch+flange_width_max/2;
function col_left_flange_offset(x) =  col_hole_offset(x) - flange_width_max/2;
function col_right_flange_offset(x) =  col_hole_offset(x) + flange_width_max/2;
function col_capacity(x) = col_right_flange_offset(x) - col_left_flange_offset(0) - 2*(support_block_x_offset+stop_side_width);
function row_hole_offset(y) = vertical_hole_spacing/2 + y * vertical_hole_spacing;
function row_offset_min(y) = row_hole_offset(y) - vertical_hole_spacing/2;
function row_offset_max(y) = row_offset_min(y) + vertical_hole_spacing;



module cabinetHoles() {
    holes(5,25,5);
}

module scmMount(num_rows=3,
                    strap_slot_width=0.75*inch, 
                    support_block_x_offset=flange_width_max,
                    support_block_width=0.5*inch, 
                    support_block_height=0.5*inch, 
                    flange_rows=[],
                    support_block_rows=[],
                    stop_side_width=1/16*inch,
                    stop_height=0.5*inch, 
                    stop_bottom_length=0.25*inch,
                    stop_bottom_width=0.5*inch,
                    ) {
    
    // TODO: use assert?
    if (support_block_x_offset < 0) {
        echo("ERROR: support_block_x_offset cannot be < 0");
    }

    all_rows = [ for ( zz = [0:1:num_rows-1] ) zz ] ;
    flange_width = max(flange_width_max, support_block_x_offset);
    flange_length = row_hole_offset(num_rows-1) + vertical_hole_spacing/2;
    flange_dims = [flange_width, vertical_hole_spacing, flange_thickness];
    support_block_dims = [support_block_width, vertical_hole_spacing, support_block_height];
    stop_bottom_dims = [stop_bottom_width, stop_bottom_length, stop_height];

    difference() {
        union() {
            for (x=[0:1:num_rows-1]) {
                translate([0,row_offset_min(x)]) {
                    // Create the flanges.
                    make_flange(flange_dims, flange_rows[x]);

                    translate([support_block_x_offset, 0, 0]) {
                        // Create the support blocks
                        if (support_block_rows[x] == SUPPORT_BLOCK_NONE) {
                            // NOP
                        } else if (support_block_rows[x] == SUPPORT_BLOCK_BLOCK) {
                            basic_support_block(support_block_dims);
                        } else if (support_block_rows[x] == SUPPORT_BLOCK_WITH_STRAP) {
                            strap_support(support_block_dims, strap_slot_width);
                        } else if (support_block_rows[x] == SUPPORT_BLOCK_WITH_END_STOP_AND_SIDE_STOP) {
                            make_stop_block(support_block_dims, stop_bottom_dims, stop_side_width);
                        } else if (support_block_rows[x] == SUPPORT_BLOCK_WITH_END_STOP) {
                            make_stop_block(support_block_dims, stop_bottom_dims, 0);
                        } else if (support_block_rows[x] == SUPPORT_BLOCK_WITH_SIDE_STOP) {
                            make_stop_block(support_block_dims, [0,0,stop_bottom_dims[2]], stop_side_width);
                        }

                    }
                }
            }
        }
        // Trim both the ends
        translate([0,0,0]) cube([support_block_x_offset + support_block_width, 1/32*inch, support_block_height+stop_height]);
        translate([0,row_offset_max(num_rows-1),0]) cube([support_block_x_offset + support_block_width, 1/32*inch, support_block_height+stop_height]);
    }

}

module basic_support_block(support_block_dims) {
    cube(support_block_dims);
}

module make_flange(flange_dims, mode) {
    difference() {
        if (mode == FLANGE_BLANK) {
            cube(flange_dims);
        } else if (mode == FLANGE_HOLE) {
            difference() {
                cube(flange_dims);
                hole(0,0);
            }
        } else if (mode == FLANGE_NONE) {
            // Nop

        } else {
            echo("ERROR: unknown flange mode: ", mode);
        }
    }
}

module strap_support(support_block_dims, strap_slot_width) {
    difference() {
        basic_support_block(support_block_dims);
        translate([0, support_block_dims[1]/2, 1/4*inch]) {
            rotate(a=[0,-45,0]) cube([1*inch, strap_slot_width, (1/16)*inch], center=true);
        };
    }
}

module make_stop_block(support_block_dims, stop_bottom_dims, stop_side_width) {
    basic_support_block(support_block_dims);
    translate([0,0,support_block_dims[2]-1]) {
        // Make bottom stop
        if (stop_bottom_dims[0] > 0 && stop_bottom_dims[1] > 0 && stop_bottom_dims[2] > 0) {
            hull() {
                cube([stop_bottom_dims[0], 1, 1]);
                translate([0,stop_bottom_dims[1],0])
                    cube([stop_bottom_dims[0], 1, stop_bottom_dims[2]+1]);
            }
        }
        // Make side stop
        if (stop_side_width > 0) {
                hull() {
                    translate([0,stop_bottom_dims[1]])
                        cube([stop_side_width,1,stop_bottom_dims[2]+1]);
                    translate([0,row_offset_max(0)-1, 0])
                        cube([stop_side_width,1,stop_bottom_dims[2]+1]);
                }
        }
    }
}

module holeOffset(column, row) {
    translate([col_hole_offset(column), row_hole_offset(row)]) children();
}

module hole(column, row) {
    holeOffset(column,row) {
        cylinder(d=hole_diameter, h = hole_thickness);
        translate([0,0,hole_thickness])
            cylinder(d=countersunk_hole_diameter, h = 10);
    }
}

// Lays out a pattern of holes 
module holes(columns, rows, height) {
    for (x=[0:1:columns]) {
        for (y=[0:1:rows]) {
            hole(x,y, height);
        }
    }
}