// wheel radius in mm (default for 26")
RADIUS_WHEEL      = 275;

// distance to rim (front) in mm
THICKNESS_FRONT   = 2.4;   // [0:5]

// distance to rim (back) in mm
THICKNESS_BACK    = 1.3;   // [0:5]

// in mm, thickness of the separator between shoe and tire
DISTANCE_TO_TIRE  = 1;     // [0:5]

// height of the brake shoe or rim width in mm
RIM_WIDTH         = 13;    // [0:30]

// length of the brake shoe in mm
SHOE_LENGTH       = 70;

// height of the separator between shoe and tire in mm
TIRE_SEP_HEIGHT   = 10;

// diameter of hole (e.g. for keyrings) in mm
HOLE_SIZE         = 3;

// set resolution...
$fn = 200;


/* [Hidden] */


/* ---- Variables ---- */
r_rim_middle = (RADIUS_WHEEL - (RIM_WIDTH / 2));
shoe_angle = asin(SHOE_LENGTH / (2 * r_rim_middle)) * 2;

h1 = max(THICKNESS_FRONT, THICKNESS_BACK);
h2 = min(THICKNESS_FRONT, THICKNESS_BACK);
h1_h2_middle = (h1 + h2) / 2;



/* ---- Braktuners ---- */
braketuners();


/**
 * Braktuners for both sides (L and R).
 */
module braketuners() {
    translate([-5,0,0]) {
        braketuner("R");
    }
    translate([5,0,0]) {
        mirror([1,0,0]) braketuner("L", mirrored=true);
    }
}


/**
 * Braketuner. Everything assembled for one side.
 */
module braketuner(left_right, mirrored=false) {
    difference() {
        difference() {
            base();
            hole();
        }
        letter(left_right, mirrored);
    }
}


/**
 * The Base.
 * Combindes PART I, II, III.
 * Base is everything needed to work (i.e. a wall between shoe and tire (top) and
 * another wall between shoe and rim (side)).
 * This is used for the right side, mirror it for the left side.
 */
module base() {
    union(){
        translate([-RADIUS_WHEEL, 0, 0]){
            difference() {
                rotate(-shoe_angle/2, [0,0,1]) part1();
                part2();
            }
            rotate(-shoe_angle/2, [0,0,1]) part3();
        }
    }
}



/* ---- PART 1: extruded ring sector aka. part of tube ---- */
module part1() {
    extruded_ring_sector(height = h1 * 2,
                         radius_outer = RADIUS_WHEEL,
                         wall_thick = RIM_WIDTH,
                         angle = shoe_angle);
}



/* ---- PART 2: rotated thing for subtraction ---- */
// this part is subtracted from part 1 to make it slanted

module part2() {
    // this is not very correct
    angle_slanted = atan((2 * (h1_h2_middle - h2)) / SHOE_LENGTH);
    size_x_for_substr = RADIUS_WHEEL * 3;
    size_y_for_substr = RADIUS_WHEEL * 3;
    size_z_for_substr = h1 * 3;

    translate([0, 0, h1_h2_middle]) {
        rotate(angle_slanted, [1,0,0]) {
            translate([0, -size_y_for_substr/2, 0]) {
                cube(size = [size_x_for_substr,
                        size_y_for_substr, size_z_for_substr]) {
                }
            }
        }
    }
}



/* ---- PART 3: wheel distance keeper ---- */
module part3() {
    extruded_ring_sector(height = TIRE_SEP_HEIGHT,
                         radius_outer = RADIUS_WHEEL + DISTANCE_TO_TIRE,
                         wall_thick = DISTANCE_TO_TIRE,
                         angle = shoe_angle);
}



/* ---- Addons ---- */
// these are parts add to the base, e.g. holes, letters, arrows, ...

/**
 * Hole is the object to subtract a hole (for keys etc).
 */
module hole() {
    offset_x = cos(shoe_angle/2) * RADIUS_WHEEL - RADIUS_WHEEL;
    offset_y =  -sin(shoe_angle/2) * RADIUS_WHEEL + 1.3*HOLE_SIZE; // the last summand is a fast workaround
    offset_z = TIRE_SEP_HEIGHT - HOLE_SIZE;
    translate([offset_x, offset_y, offset_z]) {
        rotate (-shoe_angle, [0,0,1]) {
            translate([-DISTANCE_TO_TIRE, 0, 0]) {
                rotate(90, [0,1,0]) {
                    cylinder(h=3*DISTANCE_TO_TIRE, r=HOLE_SIZE/2);
                }
            }
        }
    }
}

module letter(left_right, mirrored=false) {
    if (! mirrored) {
        letter_no_mirror(left_right);
    }
    else {
        rotate(180, [0, 0, 1]) {
            mirror([1, 0, 0]) letter_no_mirror(left_right);
        }
    }
}

module letter_no_mirror(left_right) {
    translate([DISTANCE_TO_TIRE-RIM_WIDTH, 0, THICKNESS_FRONT/2]) {
        rotate(-90, [0, 0, 1]) {
            scale([0.2,0.2,0.2]) {
                import(str("letter_", left_right, ".stl"));
            }
        }
    }
}



/* ---- Helper modules ---- */

/**
 * A Tube
 */
module tube(height, radius_outer, wall_thick) {
    difference() {
        cylinder(h = height, r = radius_outer);
        // we subtract a higher cylinder, because of rounding issues
        translate([0,0, -height * 0.5]) {
            cylinder(h = height * 2, r = radius_outer - wall_thick);
        }
    }
}


/**
 * Pie slice, an extruded circle sector.
 *
 * from http://www.thingiverse.com/thing:34027
 * Example: pie_slice(radius=100,height=30,angle=90,step=5);
 * Note: angle in degree
 */
module pie_slice(radius, height, angle, steps, center=false) {
    step_size = angle / steps;
    for(theta = [0:step_size:angle-step_size]) {
        rotate([0,0,0])
        linear_extrude(height = height, center=center)
        polygon(
            points = [
                [0,0],
                [radius * cos(theta+step_size) ,radius * sin(theta+step_size)],
                [radius*cos(theta),radius*sin(theta)]
            ]
        );
    }
}


/**
 * A part of a tube.
 */
module extruded_ring_sector(height, radius_outer, wall_thick, angle) {
    intersection() {
        tube(height = height,
             radius_outer = radius_outer,
             wall_thick = wall_thick);
        pie_slice(radius = radius_outer * 2,
                  height = height * 2.5,
                  angle = angle,
                  steps = 5.0, // this means that a pie_slice with 5 corners
                               // is used to cut th pie slice out of the tube
                  center=true);
    }
}
