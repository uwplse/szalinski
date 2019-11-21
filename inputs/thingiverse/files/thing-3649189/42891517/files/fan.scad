/* [Blade disc] */

// Which one would you like to see?
part                          = "all"; // [blade_disc:Blade disc,blade_cap:Blade cap,case_top:Case top,case_bottom:Case bottom,blade:Blade parts,case:Case parts,all:All]

// Type of motor
motor_type                    = "none"; // [none:None,round_clip:Round clip]

$fn                           = 64;

// Outer diameter of fan blades disc
disc_outer_diameter           = 23.5; // [15:.5:200]

// Inner diameter of fan blades disc. Must be less than 'fan_outer_diameter'
disc_inner_diameter           = 10.0; // [10:.5:195]

// Thickness for the blade disc.
disc_thickness                = 10.0; // [5:.5:100]

// Thickness of the wall of the disc
disc_wall_thickness           = .8; // [0.4:.05:3.0] 

// Diameter of the hole for the shaft
disc_shaft_diameter           = 2.05; // [1:.05:6]

// Depth of the holde for the shaft
disc_shaft_depth              = 5.7; // [5:.1:100]

// Thickness of the rounded wall of the hub embedding the shaft
disc_hub_round_wall_thickness = 0.8; // [0.4:.05:3.0]

// Thickness of the end wall of the hub embedding the shaft
disc_hub_end_wall_thickness   = 0; // [0.0:.05:3.0]

// The diameter on the base of the hub
disc_hub_base_diameter        = 1.0; // [0.1:0.5:20]

// Size of the rim on the cap
disc_cap_rim_height           = 1.0; // [0:0.1:5]

// Thickness of the rim on the cap
disc_cap_rim_wall_thickness   = 0.8; // [0.4:.05:3.0]

/* [Blades] */

// Number of blades
disc_blades_count             = 6; // [3:100]

// Direction of rotation seen from into the inlet
disc_blade_direction          = "CW"; // [CW:Clockwise, CCW:Counter clockwise]

// Thickness of the blade
disc_blade_thickness          = 0.8; // [0.4:0.05:5]

// Angle of the blade relative to the rotation surface
disc_blade_angle_of_attack    = 15; // [10:90]

// Amount of twist of the blades relative to the phase of the blades
disc_blade_twist              = 0.0; // [0.0:0.1:2.0]

// Bevel of the hole for the shaft
disc_shaft_bevel              = 0.3; // [0:.1:1]

/* [Case] */

// Smallest clearance between the sides of the fan disc and the wall of the case.
case_clearance_from           = 0.5; // [0.1:0.1:3.0]

// Biggest clearance between the sides of the fan disc and the wall of the case.
case_clearance_to             = 3.5; // [0.1:0.1:50.0]

// Clearance between the top and bottom of the fan disc and the top and bottom of the case
case_disc_clearance           = 0.5; // [0.1:0.1:5.0]

// Clearance between the shaft and the case
case_shaft_clearance          = 0.5; // [0.1:0.1:5.0]

// Clearance between the rim and the case
case_rim_clearance            = 0.5; // [0.1:0.1:5.0]

// Length of the outlet measured from the outer diameter
case_outlet_length            = 5.0; // [0.0:0.1:50.0]

// Angle widening the outlet
case_outlet_angle             = 45; // [0:60]

// Thickness of the side walls
case_side_wall_thickness      = 0.8; // [0.4:.05:3.0]

// Thickness of the top wall
case_top_wall_thickness       = 0.5; // [0.4:.05:3.0]

// Thickness of the bottom wall
case_bottom_wall_thickness    = 1.2; // [0.4:.05:3.0]

/* [Motor: Round Clip] */

// Diameter of the motor
round_clip_motor_diameter    = 24.4; // [5.0:0.1:100.0]

// Height of the cylindrical part of the motor
round_clip_motor_height      = 18.2; // [5.0:0.1:100.0]

// Diameter of the hole in the case for the motor axle
round_clip_hole_diameter     = 6.5; // [0.0:0.1:15.0]

// Number of clips to holed the motor
round_clip_count             = 2; // [2:6]

// Rotation of the clips
round_clip_rotation          = 0.0; // [0.0,11.25,15.0,18.0,22.5,30.0,36.0,45.0,90.0,120.0,135.0]

// Width of each clip
round_clip_width             = 10; // [5:0.5:50]

// Thichness of each clip
round_clip_thickness         = 2.0; // [0.4:0.1:10.0]

// Overhang of the hook
round_clip_overhang          = 0.4; // [0.0,0.1,1.0]

// Height of the hook
round_clip_hook_height       = 1.0; // [0.5,0.1,3.0]

// Amount of scew to squeeze the motor between the clip
round_clip_scew              = 0.1; // [0.0,0.1,0.5]

/* [hidden] */

disc_inner_radius = (disc_inner_diameter / 2);
disc_outer_radius = (disc_outer_diameter / 2);

case_top_thickness = disc_thickness
                      + 2 * case_disc_clearance
                      + case_top_wall_thickness;

module sanity_check() {
    if (disc_inner_diameter >= disc_outer_diameter) {
        echo(str("WARNING: Parameter 'disc_inner_diameter' (",
             disc_inner_diameter,
             ") must be less than 'disc_outer_diameter' (",
             disc_outer_diameter, ")"));
    }
    if (case_clearance_from > case_clearance_to) {
        echo(str("WARNING: Parameter 'case_clearance_from' (",
             case_clearance_from,
             ") should be less of equal to 'case_clearance_to' (",
             case_clearance_to, ")"));
    }
}

print_part();
sanity_check();

/* Parts */
module print_part() {
	if (part == "blade_disc") {
		blade_disc();
	} else if (part == "blade_cap") {
		blade_cap();
    } else if (part == "case_top") {
        case_top();
    } else if (part == "case_bottom") {
        rotate(180, [1, 0, 0])case_bottom();
    } else if (part == "all" || part == "blade" || part == "case") {
        show_blade_disc  = part == "all" || part == "blade";
        show_blade_cap   = part == "all" || part == "blade";
        show_case_top    = part == "all" || part == "case";
        show_case_bottom = part == "all" || part == "case";
    
        translate([0, 0, case_disc_clearance]) {  
            if (show_blade_disc) {
                color("green") blade_disc();
            }
            if (show_blade_cap) {
                translate([0,0,disc_thickness]) {
                    color("blue") blade_cap();
                }
            }
        }
        if (show_case_top) {
            translate([0,0, case_top_thickness]) {
                rotate(180, [0, 1, 0]) color("red") case_top();
            }
        }
        if (show_case_bottom) {
            translate([0,0, -case_bottom_wall_thickness]) {
                color("yellow") case_bottom();
            }
        }
    } else {
        echo(str("ERROR: Parameter 'part' (", part, ") unknown)"));
    }
}

module blade_disc() {
    union() {
        _disc_back_with_hub();
        _disc_blades();
    }
}

module _disc_back_with_hub() {
    rotate_extrude() {
        difference() {
            hub_depth = disc_shaft_depth + disc_hub_end_wall_thickness;
            hub_width = disc_shaft_diameter + 
                        disc_hub_round_wall_thickness * 2;
            
            square([disc_outer_diameter / 2, hub_depth]);
            r = max(1,
                    min((disc_hub_base_diameter - hub_width) / 2,
                        min((disc_outer_diameter - hub_width) / 2,
                            hub_depth - disc_wall_thickness)));
            translate([hub_width/2, disc_wall_thickness]) {
                hull() {
                    translate([r ,r]) {
                        circle(r);
                    }
                    translate([2* r + disc_outer_diameter,r]) {
                        square(r*2, true);
                    }
                    translate([2* r + disc_outer_diameter,2*r + hub_depth]) {
                        square(r*2, true);
                    }
                    translate([r, 2*r + hub_depth]) {
                        square(r*2, true);
                    }
                }
            }
            
            square([disc_shaft_diameter, 2 * disc_shaft_depth], true);
            if (disc_shaft_bevel > 0) {
                translate([disc_shaft_diameter / 2, disc_shaft_bevel]) {
                    rotate(-135) square(disc_shaft_bevel * 2);
                }
            }
        }
    }
}

module _disc_blades() {
    overlap = disc_wall_thickness / 2;
    translate([0,0, disc_wall_thickness - overlap]) {
        for(index = [0 : disc_blades_count - 1]) {
            angle = 360 / disc_blades_count * index; 
            rotate(angle) { 
                if (disc_blade_direction == "CW") {
                    mirror() _disc_blade();
                } else {
                    _disc_blade();
                }
            }
        }
    }
}

function propotional(f, from, to) = from * (1.0 - f) + to * f;

module _disc_blade() {
    tangent_of_attack = tan(90 - disc_blade_angle_of_attack);
    
    r_from = disc_inner_diameter / 3;
    r_to   = disc_outer_diameter / 2;
    r_step = (r_to - r_from) / $fn;
    
    twist = (360 / disc_blades_count) * disc_blade_twist;
    
    mid_line = [
        for(n = [-.5:$fn + 0.5],
            r = r_from + (r_to - r_from) * (n / $fn),
            a = (r - disc_inner_radius) * PI * tangent_of_attack
        ) [
            [
                sin(a) * r,
                cos(a) * r,
                0
            ], [
                sin(a - twist) * r,
                cos(a - twist) * r,
                max(0.0, min(1.0, 
                    (r - r_from) / (disc_inner_radius - r_from)))
            ]
        ]
    ];
    top = disc_thickness- disc_wall_thickness * 1.5;
    j_max = round(max(2, 1 + 0.5 * $fn * disc_thickness * disc_blade_twist
                   / (disc_outer_radius - disc_inner_radius) ));
    points = [
        for (
            d = [-disc_blade_thickness/2,
                  disc_blade_thickness/2],
            j = [0: j_max],
            i = [0:len(mid_line) - 2],
            pz0  = propotional(j / j_max,
                               mid_line[i + 0][0][2],
                               mid_line[i + 0][1][2]),
            pz1  = propotional(j /j_max,
                               mid_line[i + 1][0][2],
                               mid_line[i + 1][1][2]),
            pz   = (pz0 + pz1) / 2,
        
            p0_x = propotional(pz, mid_line[i + 0][0][0],
                                   mid_line[i + 0][1][0]),  
            p0_y = propotional(pz, mid_line[i + 0][0][1],
                                   mid_line[i + 0][1][1]),
            ,
            p1_x = propotional(pz, mid_line[i + 1][0][0],
                                   mid_line[i + 1][1][0]),
            p1_y = propotional(pz, mid_line[i + 1][0][1],
                                   mid_line[i + 1][1][1]),
            a = ((p1_x < p0_x)?180:0) + atan((p1_y - p0_y) / (p1_x - p0_x))
        ) [
            (p0_x + p1_x) / 2 + sin(-a) * d,
            (p0_y + p1_y) / 2 + cos(-a) * d,
            pz * top
        ]
    ];
    j_count = j_max + 1;
    i_count = len(mid_line) - 1;
    
    faces_side1 = [for (i = [0:len(mid_line) - 3], j=[0:j_max - 1]) [
        (0 + i) + (0 + j) * i_count,
        (0 + i) + (1 + j) * i_count,
        (1 + i) + (1 + j) * i_count,
        (1 + i) + (0 + j) * i_count
    ]];
    faces_side2 = [for (i = [0:len(mid_line) - 3], j=[0:j_max - 1]) [
        (0 + i) + ((0 + j) + j_count) * i_count,
        (1 + i) + ((0 + j) + j_count) * i_count,
        (1 + i) + ((1 + j) + j_count) * i_count,
        (0 + i) + ((1 + j) + j_count) * i_count,
    ]];
    faces_bottom = [for (i = [0:len(mid_line) - 3]) [
        (0 + i) + (0 * j_count) * i_count,
        (1 + i) + (0 * j_count) * i_count,
        (1 + i) + (1 * j_count) * i_count,
        (0 + i) + (1 * j_count) * i_count,
    ]];
    faces_top = [for (i = [0:len(mid_line) - 3]) [
        (0 + i) + (j_max + 0 * j_count) * i_count,
        (0 + i) + (j_max + 1 * j_count) * i_count,
        (1 + i) + (j_max + 1 * j_count) * i_count,
        (1 + i) + (j_max + 0 * j_count) * i_count,
    ]];
    faces_front = [for (j=[0:j_max - 1]) [
        (0 + j + 0 * j_count) * i_count,
        (0 + j + 1 * j_count) * i_count,
        (1 + j + 1 * j_count) * i_count,
        (1 + j + 0 * j_count) * i_count
    ]];
    faces_back = [for (j=[0:j_max - 1]) [
        i_count - 1 + (0 + j + 0 * j_count) * i_count,
        i_count - 1 + (1 + j + 0 * j_count) * i_count,
        i_count - 1 + (1 + j + 1 * j_count) * i_count,
        i_count - 1 + (0 + j + 1 * j_count) * i_count
    ]];
    faces = concat(
        faces_side1,
        faces_side2,
        faces_bottom,
        faces_top,
        faces_front,
        faces_back
    );
    
    difference() {
        polyhedron(points=points, faces=faces, convexity=2);
        difference() {
            cylinder(d=disc_outer_diameter * 2, 
                     h=disc_thickness * 2, center= true);
            cylinder(d=disc_outer_diameter, 
                     h=disc_thickness * 3, center=true);
        }
    }
}

module blade_cap() {
    rotate_extrude() polygon([
        [disc_inner_radius, -disc_wall_thickness],
        [disc_outer_radius, -disc_wall_thickness],
        [disc_outer_radius, 0],
        [disc_inner_radius + disc_cap_rim_wall_thickness, 0],
        [disc_inner_radius + disc_cap_rim_wall_thickness, disc_cap_rim_height],
        [disc_inner_radius, disc_cap_rim_height]
    ]);
}

module case_top() {
    if (disc_blade_direction == "CW") {
        mirror() _case_top();
    } else {
        _case_top();
    }
}

module _case_top() {
    render(2) difference() {
    
        linear_extrude(case_top_thickness) {
            _case_shape(case_side_wall_thickness, 0);
        }
        translate([0, 0, case_top_wall_thickness]) {
            linear_extrude(case_top_thickness) {
                _case_shape(0, 1);
            }
        }
        cylinder(d=disc_inner_diameter + 
                   ((disc_cap_rim_height > 0)
                    ? (2 * disc_cap_rim_wall_thickness + 
                       2 * case_rim_clearance)
                    : 0.0), 
                 h = 3 * case_top_wall_thickness,
                 center = true);
    }
}

module case_bottom() {
    difference() {
        union() {
            linear_extrude(case_bottom_wall_thickness) {
                difference() {
                    _case_shape(case_side_wall_thickness, 0);
                    circle(d = disc_shaft_diameter + 2 * case_shaft_clearance);
                }
            }
            _motor("add");
        }
        _motor("substract");
    }
}

module _case_shape(offset_wall = 0, offset_outlet = 0) { 
    step    = 1 / $fn;
    
    r_from  = disc_outer_radius + case_clearance_from + offset_wall;
    r_to    = disc_outer_radius + case_clearance_to + offset_wall;
    
    a_from  = asin((-disc_inner_radius + offset_wall) / r_from)
              + case_outlet_angle;
    a_to    = 270;
    
    points_curve = [for (
            f = [0.0:step:1.0],
            a = a_from + f * (a_to - a_from),
            r = r_from + f * (r_to - r_from)
        ) [
            sin(a) * r,
            cos(a) * r
        ]
    ];
    x1 = sin(a_from) * r_from;
    y1 = cos(a_from) * r_from;
    y2 = disc_outer_radius + case_outlet_length + offset_outlet;
    points_outlet = [
        [
            -disc_outer_radius - case_clearance_to - offset_wall,
             disc_outer_radius + case_outlet_length + offset_outlet
        ] , [
            x1 + tan(case_outlet_angle) * (y2 - y1),
            y2
        ]
    ];
    polygon(concat(points_curve, points_outlet));
}

module _motor(operator) {
    if (motor_type == "round_clip") {
		_motor_round_clip(operator);
	} else if (motor_type != "none") {
        echo(str("ERROR: Parameter 'motor_type' (", 
                 motor_type, ") unknown)"));
    }
}

module _motor_round_clip(operator) {
    rotate(round_clip_rotation) {
        mirror([0, 0, 1]) {
            if (operator == "add") {
                for (i = [0 : round_clip_count - 1],
                     a = 360 * i / round_clip_count)
                {
                    rotate(a) _motor_add_round_single_clip();
                }
            } else if (operator == "substract") {
                translate([0,0, -case_bottom_wall_thickness - .1]) {
                    cylinder(d = round_clip_hole_diameter,
                             h = case_bottom_wall_thickness + 0.2);
                }
            }
        }
    }
}

module _motor_add_round_single_clip() {
    r = round_clip_motor_diameter / 2 + round_clip_thickness;
    h = round_clip_motor_height + round_clip_hook_height;
    round_clip_motor_radius = round_clip_motor_diameter / 2;
    
    intersection() {
        rotate_extrude() {
            polygon(points = [
                [
                    0,
                    -case_bottom_wall_thickness
                ], [
                    0,
                    0
                ], [
                    round_clip_motor_radius + round_clip_scew,
                    0
                ], [
                    round_clip_motor_radius - round_clip_scew,
                    round_clip_motor_height
                ], [
                    round_clip_motor_radius - round_clip_overhang 
                            - round_clip_scew,
                    round_clip_motor_height
                ], [
                    round_clip_motor_radius - round_clip_overhang 
                            - round_clip_scew,
                    round_clip_motor_height 
                            + (1/3) * round_clip_hook_height
                ], [
                    round_clip_motor_radius + round_clip_overhang 
                            - round_clip_scew,
                    round_clip_motor_height 
                            + (4/3) * round_clip_hook_height
                ], [
                    round_clip_motor_radius + round_clip_thickness 
                            - round_clip_scew,
                    round_clip_motor_height 
                            + (4/3) * round_clip_hook_height
                ], [
                    round_clip_motor_radius + round_clip_thickness 
                            + round_clip_scew,
                    -case_bottom_wall_thickness
                ]
            ]);
        }
        translate([0, -round_clip_width / 2, - case_bottom_wall_thickness]) {
            cube([r + round_clip_scew, 
                  round_clip_width,
                  h + case_bottom_wall_thickness]);
        }
    }
}