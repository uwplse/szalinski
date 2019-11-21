//Width of the board
board_width = 40;

//Depth of the board
board_depth = 40;

//Thickness of the board
board_thickness = 1.6;

//Thickness of the surrounding border
border_thickness = 1.2;

//Thickness of the border that will support the board. Use 0 to disable and use only spacer to support the board.
border_support = 0.5;

//Height of border above the board
extra_border = 1;

//Thickness of the part at the bottom
bottom_thickness = 1.2;

//The space left at the bottom of the board
bottom_spacing = 3.5;

//Controls the roundness of the corners
roundness = 1;

//Diameter of the mounting hole, set 0 to disable
hole_diameter = 2.8;

//Distance of the mounting hole from the edges
hole_distance = 3;

//Extra height for mounting pillars above the board surface
extra_mounting_height = 0.4;

//Diameter of the spacers that will raise the board. Spacers will be centered on the holes. Setting this to 0 will support the board only with border.
spacer_diameter = 4;

//Whether to add pins that allows additional mounting options, this leave 4 0.5cm squares that are 0.5cm apart. Only 0, 1 and 2 are supported. If 2 is selected, pins will be repeated along the width of the part.
pins = 1;

//Clearance of the parts, adjust for your printer
clearance = 0.2;

/* [hidden] */


module rcube(d, r = 1, $fn = 64) {
    rd = r;
    
    hull() {
        translate([rd, rd, 0])
        cylinder(r = r, h = d[2], $fn = $fn);

        translate([d[0] - rd, rd, 0])
        cylinder(r = r, h = d[2], $fn = $fn);
        translate([d[0] - rd, d[1] - rd, 0])
        cylinder(r = r, h = d[2], $fn = $fn);
        translate([rd, d[1] - rd, 0])
        cylinder(r = r, h = d[2], $fn = $fn);
    }
}

module create_pin() {
    translate([-7.5+clearance, -7.5+clearance, -0.1])
    rcube([5+clearance*2, 5+clearance*2, bottom_thickness+0.2]);
    
    translate([2.5-clearance, -7.5+clearance, -0.1])
    rcube([5+clearance*2, 5+clearance*2, bottom_thickness+0.2]);

    translate([-7.5+clearance, 2.5-clearance, -0.1])
    rcube([5+clearance*2, 5+clearance*2, bottom_thickness+0.2]);
    
    translate([2.5-clearance, 2.5-clearance, -0.1])
    rcube([5+clearance*2, 5+clearance*2, bottom_thickness+0.2]);
}

difference() {
    rcube([
        board_width + clearance * 2 + border_thickness * 2,
        board_depth + clearance * 2 + border_thickness * 2,
        bottom_thickness + bottom_spacing + board_thickness + extra_border
    ], roundness + border_thickness);
    
    if(roundness) {
        translate([
            border_thickness, 
            border_thickness, 
            bottom_thickness + bottom_spacing
        ])
        rcube([
            board_width + clearance * 2,
            board_depth + clearance * 2,
            board_thickness + extra_border+0.1
        ], roundness);
        
        translate([
            border_thickness + border_support, 
            border_thickness + border_support, 
            bottom_thickness
        ])
        rcube([
            board_width + clearance * 2 - border_support * 2,
            board_depth + clearance * 2 - border_support * 2,
            bottom_spacing + 0.1
        ], roundness - border_support);
    }
    else {
        translate([
            border_thickness, 
            border_thickness, 
            bottom_thickness + bottom_spacing
        ])
        cube([
            board_width + clearance * 2,
            board_depth + clearance * 2,
            board_thickness + extra_border+0.1
        ]);
        
        translate([
            border_thickness + border_support, 
            border_thickness + border_support, 
            bottom_thickness
        ])
        cube([
            board_width + clearance * 2 - border_support * 2,
            board_depth + clearance * 2 - border_support * 2,
            bottom_spacing + 0.1
        ]);
    }
    
    if(pins == 1) {
        translate([
            board_width / 2 + clearance + border_thickness,
            board_depth / 2 + clearance + border_thickness,
        ])
        create_pin();
    }
    else if(pins == 2) {
        translate([
            board_width / 4 + clearance * 2/4 + border_thickness * 2/4,
            board_depth / 2 + clearance + border_thickness,
        ])
        create_pin();

        translate([
            3 * board_width / 4 + 3 * clearance * 2/4 + 3 * border_thickness * 2/4,
            board_depth / 2 + clearance + border_thickness,
        ])
        create_pin();
    }
}

color([1, 0, 0])
translate([
    clearance + border_thickness, 
    clearance + border_thickness, 
    bottom_thickness-0.01]
) {
    //spacers
    translate([
        hole_distance, 
        hole_distance]
    )
    cylinder(
        r = spacer_diameter / 2, 
        h = bottom_spacing, 
        $fn = 32
    );

    translate([
        board_width - hole_distance, 
        hole_distance]
    )
    cylinder(
        r = spacer_diameter / 2, 
        h = bottom_spacing, 
        $fn = 32
    );
    
    translate([
        hole_distance, 
        board_depth - hole_distance]
    )
    cylinder(
        r = spacer_diameter / 2, 
        h = bottom_spacing, 
        $fn = 32
    );

    translate([
        board_width - hole_distance, 
        board_depth - hole_distance]
    )
    cylinder(
        r = spacer_diameter / 2, 
        h = bottom_spacing, 
        $fn = 32
    );


    //mounting pillars
    translate([
        hole_distance, 
        hole_distance]
    )
    cylinder(
        r = hole_diameter / 2 - clearance, 
        h = bottom_spacing + board_thickness + extra_mounting_height, 
        $fn = 24
    );

    translate([
        board_width - hole_distance, 
        hole_distance]
    )
    cylinder(
        r = hole_diameter / 2 - clearance, 
        h = bottom_spacing + board_thickness + extra_mounting_height, 
        $fn = 24
    );
    
    translate([
        hole_distance, 
        board_depth - hole_distance]
    )
    cylinder(
        r = hole_diameter / 2 - clearance, 
        h = bottom_spacing + board_thickness + extra_mounting_height, 
        $fn = 24
    );

    translate([
        board_width - hole_distance, 
        board_depth - hole_distance]
    )
    cylinder(
        r = hole_diameter / 2 - clearance, 
        h = bottom_spacing + board_thickness + extra_mounting_height, 
        $fn = 24
    );
}
