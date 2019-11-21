/*
* written 2018-11-20 by till busch <buti@bux.at>
* version 1.1.3, 2018-11-22
*/

// top edge of board [mm]
height              = 100;    // [50:150]
// width of board, depth of finished stand [mm]
board_width         = 200;    // [150:300]
// height of the printed element [mm]
extrusion_height    =  30;    // [20:30]
// thickness of wooden board, mm
board_height        =   8.3;  // [7:0.1:20]
// thickness of wall below board, for stability and to allow for too long screws [mm]
wall_below_board    =  12;    // [4:20]
// preferred shape of foot [mm]
foot_width          =  12;    // [6:50]
// wall thickness, for stability [mm]
walls               =   4;    // [3:6]
// top wall can be thinner [mm]
top_wall            =   2;    // [0:6]
// hole diameter for screws [mm]
screw_diameter      =   3.3;  // [1:0.1:5]
// height of countersunk head [mm]
screw_head_height   =   2;    // [1:0.1:3]

// thingiverse customizer does not support booleans yet
// enable rounded corners
rounded_corners     = "no";  // [no,yes]
/* [Rounded Corners] */
corner_radius_obtuse = 10;    // [1:30]
corner_radius_sharp  =  3;    // [1:6]

top_width = board_width+2*walls;
bottom_width = top_width;

module main_shape() {
    // calculate x of last point from cutout
    x1 = -bottom_width/2+foot_width;
    y1 = 0;
    x2 = -top_width/4;
    y2 = height-board_height-wall_below_board;
    m = (y2-y1)/(x2-x1);
    yt = (height-board_height-wall_below_board+walls);
    x = ((yt-y1)/m)+x1;    
    points_cut = [
        [-top_width/2, height-board_height-wall_below_board+walls],
        [-bottom_width/2, 0],
        [-bottom_width/2+foot_width, 0],
        [x, height-board_height-wall_below_board+walls],
    ];
    points = [
        [-bottom_width/2, 0],
        [-bottom_width/2+foot_width, 0],
        [-top_width/4, height-board_height-wall_below_board],

        [top_width/4, height-board_height-wall_below_board],
        [bottom_width/2-foot_width, 0],
        [bottom_width/2, 0],

        [top_width/2, height+top_wall],
        [-top_width/2, height+top_wall]
    ];

    if(rounded_corners == "yes") {
        r2 = corner_radius_obtuse;
        r1 = corner_radius_sharp;
        $fs = 0.1;
        $fn = 48;
        difference() {
            offset(r = -r2) offset(r=r2) offset(r = 3) offset(r=-3)
                polygon(points = points);
            offset(r = r1) offset(r=-r1) offset(r = -walls)
                polygon(points = points_cut);
            mirror([1, 0, 0]) offset(r = r1) offset(r=-r1) offset(r = -walls)
                polygon(points = points_cut);
        }
    } else {
        difference() {
            polygon(points = points);
            offset(r = -walls) polygon(points = points_cut);
            mirror([1, 0, 0]) offset(r = -walls) polygon(points = points_cut);
        }
    }
}

module screw_hole() {
    union() {
        rotate([-90, 0, 0]) cylinder(h=wall_below_board*1.2, d=screw_diameter);
        rotate([-90, 0, 0]) cylinder(h=screw_head_height, d1=screw_diameter*2, d2=screw_diameter);
        rotate([90, 0, 0]) cylinder(h=5, d=screw_diameter*2);
    }
}


difference() {
    /*
    // "bevel"
    union() {
        linear_extrude(height=0.2) offset(r=-0.5) main_shape();
        translate([0, 0, 0.2])
            linear_extrude(height=0.2) offset(r=-0.25) main_shape();

        translate([0, 0, extrusion_height-0.2])
            linear_extrude(height=0.2) offset(r=-0.5) main_shape();
        translate([0, 0, extrusion_height-0.4])
            linear_extrude(height=0.2) offset(r=-0.25) main_shape();

        translate([0, 0, 0.4])
            linear_extrude(height=extrusion_height-0.8) {
                main_shape();
    }
    */
    linear_extrude(height=extrusion_height-0.8) {
        main_shape();
    }
    // board
    translate([-top_width/2+walls, height-board_height, walls]) {
        cube(size=[board_width, board_height, extrusion_height]);
    }
    // screw holes
    sy = height-board_height-wall_below_board-0.1;
    sz = extrusion_height/2 + walls;
    translate([-top_width/5, sy, sz]) screw_hole($fs=0.2);
    translate([0, sy, sz]) screw_hole($fs=0.2);
    translate([top_width/5, sy, sz]) screw_hole($fs=0.2);
}
