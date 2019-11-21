/*
 * Customizable Gift Box - https://www.thingiverse.com/thing:3114226
 * by ASP3D - https://www.thingiverse.com/asp3d/about
 * created 2018-09-23
 * version v1.0
 *
 * Changelog
 * --------------
 * v1.1 - 2018-09-29
 *  - [add] Ribbons gaps added
 *  - [fix] Some minor fixes
 * v1.0 - 2018-09-23:
 *  - [fix] Some minor fixes and andding comments.
 * v0.9 - 2018-09-22:
 *  - Initial design, printing, testing.
 * --------------
 * 
 * This work is licensed under the Creative Commons - Attribution - Non-Commercial ShareAlike license.
 * https://creativecommons.org/licenses/by-nc-sa/3.0/
 */


/* [Printer params] */

// Walls will be based on this value (see "Walls and shells" section)
extrusion_width = 1;

// Bottom and Top shells will be based on this value
layer_height = 0.2;

// Choose "Solid" for vase mode printing or "Standatd" for other purposes. It is better to use "Standard mode" for preview and "Vase mode" for export, even you choose walls with 2-3 extrusions.
render_mode = 0; // [0:Standard mode,1:Solid - Vase mode]

// What part to render. Many other parameters as sizes, walls, shells, top ornament are in other sections
render = 0; // [0:Assembly,1:All parts,2:Box bottom,3:Box top,4:Primary ribbon,5:Secondary ribbon,6:Top ornament,7:Top ornament+Primary ribbon(std mode)]


/* [Gift Box Sizes] */

// Box width (top ornament located on this dimention)
box_size_x = 50;
// Box length (for square box, enter the same value as above)
box_size_y = 50;

// Base height (under cap)
box_bottom_height = 15;
// Cap height (total box height is (box_bottom_height + box_top_height)
box_top_height = 5;
// Corner radius
box_corner_radius_percent = 20; // [1:50]


/* [Ribbon] */

// Shape of the top ornament
ribbon_top_shape = 4; // [1:Rounded,2:Inverted rounded,3:ZigZag,4:Heart]
// Count of ornament elements
ribbon_top_param = 4;
// Size of ornament base on box width
ribbon_top_size_percent = 90; // [40:140]

// Width of main ribbon (with ornament)
primary_ribbon_width = 15;
// Width of second ribbon (enter the same value for equal ribbons)
secondary_ribbon_width = 15;


/* [Walls and shells] */

// How many extrusion lines do you want for box base
bottom_wall_lines = 1;
// ... box cap
top_wall_lines = 1;
// ... ribbons ans ornament
ribbon_wall_lines = 1;

// Count of box base layers (total bottom width will be (bottom_layers * layer_height)
bottom_layers = 3;
// Count of cap layers (total bottom width will be (bottom_layers * layer_height)
top_layers = 3;


/* [Extra] */
// Height of transition between box base and box cap. Too small value with 1 line perimeter may cause delamination. If you print with 2-3 lines perimeter, you may try to reduce this value
box_bottom_to_top_transition = 4;
// XY gap between box, secondary ribbon and primary ribbon
primary_ribbon_gap = 0.1;
// XY gap between box and secondary ribbon (without ornament)
secondary_ribbon_gap = 0.2;


/* [Hidden] */

$fa = 1;
$fs = 1;

box_corner_radius = box_size_x*box_corner_radius_percent/100;

bottom_wall_width = bottom_wall_lines * extrusion_width;
top_wall_width = top_wall_lines * extrusion_width;
ribbon_wall_width = ribbon_wall_lines * extrusion_width;

bottom_height = bottom_layers * layer_height;
top_height = top_layers * layer_height;

render_distance = 5;
primary_ribbon_middle_circle_radius = primary_ribbon_width * 0.2;

ribbon_top_type = 1;

ribbon_top_size = box_size_x*ribbon_top_size_percent/100;

ribbon_top_1_offset = (ribbon_wall_width/2)*0.5;

if (render == 0) {
    color("Yellow") {
        box_bottom_3d();
        translate([0, 0, box_bottom_height + box_top_height])
            rotate([180, 0, 0])
                box_top_3d();
    }
    color("Red") {
        translate([-secondary_ribbon_width/2, 0, (box_bottom_height+box_top_height)/2])
            rotate([0, 90, 0])
                secondary_ribbon_3d();
        translate([0, -primary_ribbon_width/2, (box_bottom_height+box_top_height)/2])
            rotate([0, 90, 90])
                primary_ribbon_3d();
        translate([0, -primary_ribbon_width/2, box_bottom_height+box_top_height+ribbon_wall_lines*extrusion_width+primary_ribbon_gap])
            rotate([0, 90, 90])
                ribbon_top_3d();
    }
} else if (render == 1) {
    translate([-box_size_x*3, 0, 0])
        union() {
            translate([box_size_x + render_distance, 0, 0])
                box_top_3d();
            translate([box_size_x*2 + render_distance*2, 0, 0])
                box_bottom_3d();
            translate([box_size_x*3 + render_distance*3, 0, 0])
                secondary_ribbon_3d();
            translate([box_size_x*4 + render_distance*4, 0, 0])
                primary_ribbon_3d();
            translate([box_size_x*5 + render_distance*5, 0, 0])
                ribbon_top_3d();
        }
} else if (render == 2) {
    box_top_3d();
} else if (render == 3) {
    box_bottom_3d();
} else if (render == 4) {
    primary_ribbon_3d();
} else if (render == 5) {
    secondary_ribbon_3d();
} else if (render == 6) {
    ribbon_top_3d();
} else if (render == 7) {
    primary_ribbon_3d();
    translate([-((box_bottom_height+box_top_height)/2 + ribbon_wall_lines*extrusion_width + primary_ribbon_gap + secondary_ribbon_gap), 0, 0])
        ribbon_top_3d();
}




module ribbon_top_3d() {
    ribbon_top();
}

module ribbon_top() {
    if (ribbon_top_type == 1) {
        rotate([0, 0, 90])
            ribbon_top_1();
    }
}

module ribbon_top_1() {
    linear_extrude(primary_ribbon_width)
        difference() {
            ribbon_top_1_all();
            if (render_mode == 0) {
                offset(delta = -ribbon_wall_width)
                    ribbon_top_1_all();
            }
        }
}

module ribbon_top_1_all() {
    difference() {
        union() {
            for (i = [0 : ribbon_top_param-1]) {
                offset(delta = -ribbon_top_1_offset)
                    ribbon_top_1_element(i);
            }
            circle(primary_ribbon_middle_circle_radius + ribbon_wall_width*2);
        }
        circle(primary_ribbon_middle_circle_radius);
        translate([-primary_ribbon_middle_circle_radius*20, -primary_ribbon_middle_circle_radius*40 + ribbon_top_1_offset, 0])
            square(primary_ribbon_middle_circle_radius*40);
    }
}

module ribbon_top_1_element(n) {
    if (ribbon_top_shape == 1) {
        ribbon_top_1_shape_1(n);
    } else if (ribbon_top_shape == 2) {
        ribbon_top_1_shape_2(n);
    } else if (ribbon_top_shape == 3) {
        ribbon_top_1_shape_3(n);
    } else if (ribbon_top_shape == 4) {
        ribbon_top_1_shape_4(n);
    }
}

module ribbon_top_1_shape_1(n) {
    size = 0.8*ribbon_top_size/2;
    angle = 180/ribbon_top_param;
    round_r = sin(angle/2)*size;
    rotate([0, 0, angle/2 + angle*n])
        hull() {
            circle(0.01);
            translate([size, 0, 0])
                circle(round_r);
        }
}

module ribbon_top_1_shape_2(n) {
    size = 1.25*ribbon_top_size/2;
    angle = 180/ribbon_top_param;
    round_r = sin(angle/2)*size;
    rotate([0, 0, angle/2 + angle*n])
        difference() {
            hull() {
                circle(0.01);
                translate([size, 0, 0])
                    circle(round_r);
            }
            translate([size, 0, 0])
                    circle(round_r);
        }
}

module ribbon_top_1_shape_3(n) {
    size = ribbon_top_size/2;
    angle = 180/ribbon_top_param;
    round_r = sin(angle/2)*size;
    rotate([0, 0, angle/2 + angle*n])
        polygon([
            [0, 0],
            [cos(angle/2)*size, sin(angle/2)*size],
            [size*0.65, 0],
            [cos(angle/2)*size, -sin(angle/2)*size],    
        ]);
}

module ribbon_top_1_shape_4(n) {
    size = 0.8*ribbon_top_size/2;
    angle = 180/ribbon_top_param;
    anglep = 0.45*angle;
    round_r = sin((angle-anglep)/2)*size;
    rotate([0, 0, (angle-anglep)/2 + angle*n])
        hull() {
            circle(0.01);
            translate([size, 0, 0])
                circle(round_r);
        }
    rotate([0, 0, (angle+anglep)/2 + angle*n])
        hull() {
            circle(0.01);
            translate([size, 0, 0])
                circle(round_r);
        }
}

module primary_ribbon_3d() {
    linear_extrude(primary_ribbon_width)
        difference() {
            primary_ribbon();
            if (render_mode == 0) {
                offset(delta = -ribbon_wall_width)
                    primary_ribbon();
            }
    }
}

module primary_ribbon() {
    union() {
        rotate([0, 0, 90]) 
        square([box_size_x + ribbon_wall_width*2+primary_ribbon_gap*2, box_bottom_height + box_top_height + ribbon_wall_width*2 + ribbon_wall_width*2+primary_ribbon_gap*2], center=true);
        translate([-(box_bottom_height + box_top_height)/2 - primary_ribbon_gap - ribbon_wall_width*1.5, 0, 0])
            circle(primary_ribbon_middle_circle_radius*0.8);
    }
}

module secondary_ribbon_3d() {
    rotate([0, 0, 90])
        linear_extrude(secondary_ribbon_width)
            difference() {
                square([box_size_y + ribbon_wall_width*2+secondary_ribbon_gap*2, box_bottom_height + box_top_height + ribbon_wall_width*2+secondary_ribbon_gap*2], center=true);
                if (render_mode == 0) {
                    square([box_size_y+secondary_ribbon_gap*2, box_bottom_height + box_top_height+secondary_ribbon_gap*2], center=true);
                }
            }
}

module box_bottom_3d() {
    union() {
        difference() {
            minkowski() {
                linear_extrude(0.01)
                    square([box_size_x-box_corner_radius*2-top_wall_width*2, box_size_y-box_corner_radius*2-top_wall_width*2], center=true);
                rotate_extrude()
                    box_bottom_wall();
            }
            if (render_mode == 0) {
                minkowski() {
                    linear_extrude(0.01)
                        square([box_size_x-box_corner_radius*2-top_wall_width*2-bottom_wall_width*2, box_size_y-box_corner_radius*2-top_wall_width*2-bottom_wall_width*2], center=true);
                    rotate_extrude()
                        box_bottom_wall();
                }
            }
        }
        if (render_mode == 0) {
            linear_extrude(bottom_height)
                minkowski() {
                    square([box_size_x-box_corner_radius*2.1, box_size_y-box_corner_radius*2.1], center=true);
                    circle(box_corner_radius);
                }
        }
    }
}

module box_bottom_wall() {
    p1x = box_corner_radius + top_wall_width;
    p2y = box_bottom_height - box_bottom_to_top_transition;
    p3x = p1x - top_wall_width;
    p3y = p2y + box_bottom_to_top_transition;
    p4y = p3y + box_top_height - top_height - layer_height;
    polygon([ [0, 0], [p1x, 0], [p1x, p2y], [p3x, p3y], [p3x, p4y], [0, p4y] ]);
}

module box_top_3d() {
    difference() {
        linear_extrude(box_top_height)
            box_top();
        if (render_mode == 0) {
            translate([0, 0, top_height])
                linear_extrude(box_top_height)
                    offset(delta = -top_wall_width)
                        box_top();
        }
    }
}

module box_top() {
    minkowski() {
        square([box_size_x-box_corner_radius*2, box_size_y-box_corner_radius*2], center=true);
        circle(box_corner_radius);
    }
}

