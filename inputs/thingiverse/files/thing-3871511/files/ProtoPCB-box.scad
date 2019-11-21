//What entities do you need?
Render_now = "both"; // [both,box_only,cap_only]
// mm
PCB_X_Dimension = 90; // [1:200]
// mm
PCB_Y_Dimension = 70; // [1:200]
// mm
PCB_Width = 1.6; // [0.4:0.1:4]
// Extra space around PCB in X and Y to be sure it's not too thight
PCB_Extra_Space = .6; // [0:0.1:2]
// Space below the PCB, left it as 0 if you don't need PCB holder
PCB_Bottom_Space = 5; // [1:10]
// Space above the PCB inside the box
PCB_Top_Space = 25; // [1:60]
// Box wall width in bottom and sides
Wall_Width = 1.6; // [1:0.1:4]

/* [ PCB Holder pads ] */

// Set true if you need cap holder
With_PCB_Holder = true;
// PCB holders size in corners, X and Y too
PCB_Holder_Size = 5; // [1:20]
// PCB holder's screw diameter
PCB_Holder_Hole_Diameter = 2.5; // [2:0.5:4]

/* [ Cap Holder ] */

// Set true if you need cap holder
With_Cap_Holder = true;
// Cap holder's screw diameter
Cap_Holder_Hole_Diameter = 2.5; // [2:0.5:4]
// How many bigger the cap holder than the screw in it
Cap_Holder_Size_Multipleter = 4; // [2:0.5:6]

/* [ Wall Mount Points ] */

// Set true if you need 2 wall mount points
With_Double_Wall_Mount_Points = true;
// Set true if you need 4 wall mount points
With_Quad_Wall_Mount_Points = false;
// Wall mount point's screw diameter
Wall_Mount_Hole_Diameter = 4; // [2:0.5:4]
// Wall mount point height (thickness)
Wall_Mount_Height = 4; // [2:10]
// How many bigger the wall mount point than the screw in it
Wall_Mount_Size_Multipleter = 3.5; // [2:0.5:6]

/* [ Hexa ventilation holes ] */

Hexa_Hole_Diameter = 7; // [2:10]
Hexa_Hole_In_X = 8; // [0:10]
Hexa_Hole_In_Y = 7; // [0:10]
Hexa_Hole_Wall = 2.4; // [1:0.2:5]

module hide() {}
// With this extra space you can be sure there is no space between different elements, and your slicer will be work properly
Fix_STL_Build_Issue = .05;
// If you want render the two object in one step how many distance should be keep between them
Spacer_between_objects = 10;
// Precounted value
Absolute_Height = Wall_Width + PCB_Bottom_Space + PCB_Width + PCB_Top_Space;
// Precounted value
Absolute_X = PCB_X_Dimension + 2 * (PCB_Extra_Space + Wall_Width);
// Precounted value
Absolute_Y = PCB_Y_Dimension + 2 * (PCB_Extra_Space + Wall_Width);

// Base board
module BaseBoard() {
    linear_extrude(height = Wall_Width)
        square([
            Absolute_X,
            Absolute_Y,
        ], center = true);
}

// Walls
module Walls() {
    module YWall(){
        cube([
            Absolute_X,
            Wall_Width,
            Absolute_Height
        ]);
    }
    module XWall(){
        cube([
            Wall_Width,
            Absolute_Y - 2 * Wall_Width,
            Absolute_Height
        ]);
    }
    translate([
        -(PCB_X_Dimension / 2 + PCB_Extra_Space + Wall_Width),
        PCB_Y_Dimension / 2 + PCB_Extra_Space,
        0
    ])
        YWall();
    translate([
        -(PCB_X_Dimension / 2 + PCB_Extra_Space + Wall_Width),
        -(PCB_Y_Dimension / 2 + PCB_Extra_Space + Wall_Width),
        0
    ])
        YWall();
    translate([
        -(PCB_X_Dimension / 2 + PCB_Extra_Space + Wall_Width),
        -(PCB_Y_Dimension / 2 + PCB_Extra_Space),
        0
    ])
        XWall();
    translate([
        PCB_X_Dimension / 2 + PCB_Extra_Space,
        -(PCB_Y_Dimension / 2 + PCB_Extra_Space),
        0
    ])
        XWall();
}

// PCB holders in corners
module PCBHolders() {
    module PCBHolder() {
        difference() {
            cube([
                PCB_Holder_Size + PCB_Extra_Space,
                PCB_Holder_Size + PCB_Extra_Space,
                PCB_Bottom_Space + Wall_Width
            ]);
            translate([
                PCB_Holder_Size / 2 + PCB_Extra_Space,
                PCB_Holder_Size / 2 + PCB_Extra_Space,
                Wall_Width
            ])
                cylinder(
                    d = PCB_Holder_Hole_Diameter,
                    h = PCB_Bottom_Space + 1,
                    $fn = 50
                );
        }
    }
    translate([
        PCB_X_Dimension / 2 + PCB_Extra_Space,
        PCB_Y_Dimension / 2 + PCB_Extra_Space,
        0
    ])
        rotate([0, 0, 180]) PCBHolder();
    translate([
        -PCB_X_Dimension / 2 - PCB_Extra_Space,
        PCB_Y_Dimension / 2 + PCB_Extra_Space,
        0
    ])
        rotate([0, 0, 270]) PCBHolder();
    translate([
        PCB_X_Dimension / 2 + PCB_Extra_Space,
        -PCB_Y_Dimension / 2 - PCB_Extra_Space,
        0
    ])
        rotate([0, 0, 90]) PCBHolder();
    translate([
        -PCB_X_Dimension / 2 - PCB_Extra_Space,
        -PCB_Y_Dimension / 2 - PCB_Extra_Space,
        0
    ])
        PCBHolder();
}

// Cap holders
module CapHolders(height, hole_bottom_space) {
    cap_holder_size = Cap_Holder_Hole_Diameter * Cap_Holder_Size_Multipleter;
    module CapHolder(block_size, hole_bottom_space) {
        difference() {
            intersection() {
                cube([
                    block_size,
                    block_size,
                    height
                ]);
                translate([
                    0,
                    block_size / 2,
                    0
                ])
                    cylinder(
                        d = block_size,
                        h = height,
                        $fn = 50
                    );
            }
            translate([
                Cap_Holder_Hole_Diameter / 2,
                block_size / 2,
                hole_bottom_space
            ])
                cylinder(
                    d = Cap_Holder_Hole_Diameter,
                    h = height,
                    $fn = 50
                );
        }
    }
    translate([
        Absolute_X / 2 - Fix_STL_Build_Issue,
        Absolute_Y / 2 - cap_holder_size,
        0
    ])
        CapHolder(cap_holder_size, hole_bottom_space);
    translate([
        Absolute_X / 2 - Fix_STL_Build_Issue,
        -Absolute_Y / 2,
        0
    ])
        CapHolder(cap_holder_size, hole_bottom_space);
    translate([
        -Absolute_X / 2 + Fix_STL_Build_Issue,
        -Absolute_Y / 2,
        0
    ])
        mirror([1, 0, 0]) CapHolder(cap_holder_size, hole_bottom_space);
    translate([
        -Absolute_X / 2 + Fix_STL_Build_Issue,
        Absolute_Y / 2 - cap_holder_size,
        0
    ])
        mirror([1, 0, 0]) CapHolder(cap_holder_size, hole_bottom_space);
}

// Wall mount points
module WallMountPoints() {
    wall_mount_point_size = Wall_Mount_Hole_Diameter * Wall_Mount_Size_Multipleter;
    module WallMountPoint(block_size) {
        difference() {
            intersection() {
                cube([
                    block_size,
                    block_size,
                    Absolute_Height
                ]);
                translate([
                    block_size / 4,
                    block_size / 2,
                    0
                ])
                    cylinder(
                        d = block_size,
                        h = Wall_Mount_Height,
                        $fn = 50
                    );
            }
            translate([
                block_size / 4,
                block_size / 2,
                0
            ])
            cylinder(
                d = Wall_Mount_Hole_Diameter,
                h = Wall_Mount_Height,
                $fn = 50
            );
        }
    }
    if (With_Quad_Wall_Mount_Points) {
        cap_holder_size = Cap_Holder_Hole_Diameter * Cap_Holder_Size_Multipleter;
        translate([
            Absolute_X / 2,
            Absolute_Y / 2 - cap_holder_size / 4 * 3 - wall_mount_point_size,
            0
        ])
            WallMountPoint(wall_mount_point_size);
        translate([
            Absolute_X / 2,
            -Absolute_Y / 2 - cap_holder_size / 4 * 3 + wall_mount_point_size,
            0
        ])
            WallMountPoint(wall_mount_point_size);
        translate([
            -Absolute_X / 2,
            Absolute_Y / 2 - cap_holder_size / 4 * 3 - wall_mount_point_size,
            0
        ])
            mirror([1, 0, 0]) WallMountPoint(wall_mount_point_size);
        translate([
            -Absolute_X / 2,
            -Absolute_Y / 2 - cap_holder_size / 4 * 3 + wall_mount_point_size,
            0
        ])
            mirror([1, 0, 0]) WallMountPoint(wall_mount_point_size);
    }
    if (With_Double_Wall_Mount_Points) {
        translate([
            Absolute_X / 2,
            -wall_mount_point_size / 2,
            0
        ])
            WallMountPoint(wall_mount_point_size);
        translate([
            -Absolute_X / 2,
            -wall_mount_point_size / 2,
            0
        ])
            mirror([1, 0, 0]) WallMountPoint(wall_mount_point_size);
    }
}

// Hexa holes
module HexaHole() {
    rotate([0, 0, 30]) cylinder(
        d = Hexa_Hole_Diameter,
        h = Wall_Width,
        $fn = 6
    );
}
module HexaHoles() {
    hole_space_x = Hexa_Hole_Diameter / 2 * sqrt(3) + Hexa_Hole_Wall;
    hole_space_y = Hexa_Hole_Diameter * 2 / 3 + Hexa_Hole_Wall;
    for (x = [1:Hexa_Hole_In_X]) {
        for (y = [1:Hexa_Hole_In_Y]) {
            translate([
                -hole_space_x * ((Hexa_Hole_In_X - 1) / 2) + (x - 1) * hole_space_x + ((y/2==round(y/2)) ? hole_space_x / 2 : 0),
                -hole_space_y * ((Hexa_Hole_In_Y - 1) / 2) + (y - 1) * hole_space_y,
                0
            ]) HexaHole();
        }
    }
}

// The objects

module PCB_box() {
    BaseBoard();
    Walls();
    if (With_Cap_Holder) { CapHolders(Absolute_Height, Wall_Width); }
    WallMountPoints();
    if (With_PCB_Holder) { PCBHolders(); }
}

module PCB_cap() {
    difference() {
        union() {
          BaseBoard();
          if (With_Cap_Holder) { CapHolders(Wall_Width, 0); }
        }
        if (Hexa_Hole_In_X > 0 && Hexa_Hole_In_Y > 0) HexaHoles();
    }
}

if (Render_now == "both") {
    PCB_box();
    translate([0, Absolute_Y + Spacer_between_objects, 0]) PCB_cap();
}

if (Render_now == "box_only") {
    PCB_box();
}

if (Render_now == "cap_only") {
    PCB_cap();
}