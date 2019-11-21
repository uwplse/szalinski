
/* [Shaft] */

// The major radius of the collar
major_radius = 6.6; // [2:.05:10]

// The minor radius of the collar
minor_radius = 2.5; // [1:.05:9]

// The thickness of the collar
width = 6.1; // [2:.1:20]

// The amount to cut off to make a flat surface for printing
cutoff = .5; // [0:.1:5]

/* [Screw Threads] */

// The diameter of the screw threads
screw_diameter = 3.5; // [.05:.001:10]

// The pitch fo the screw threads
pitch = .79; // [.01:.001:5]

// The layer height of the machine used
layer_height = .1; 

/* [Tolerances] */

// The amount of play to add on the major radius of the thread
major_play = .75; // [.05:.01:2]

// The amount of play to add on the minor radius of the thread
minor_play = .5; // [.05:.01:2]

// The amount of detail to generate the part with
detail = 50; // [5:200]


/* [Hidden] */

collar(major_radius, minor_radius, width, cutoff, screw_diameter, pitch, layer_height, major_play, minor_play, $fn = detail);

pitch_multiplier = sqrt(3) / 2;

module collar(outer_radius, inner_radius, width, cutoff, screw_diameter, screw_pitch, layer_height, outer_tol, inner_tol) {
    translate([0, 0, -cutoff])
    difference() {
        translate([0, 0, outer_radius])
        collar_part(outer_radius, inner_radius, width);
        r = screw_diameter / 2;
        h = screw_pitch * pitch_multiplier;
        r_minor = r - 5 * h / 8;
        angle_step = 360 * layer_height / screw_pitch;
        union() {
            screw_part(r + outer_tol, r_minor + inner_tol, layer_height, angle_step, outer_radius);
            linear_extrude(height = cutoff * 2, center = true, convexity = 2, scale = [1])
            square([outer_radius * 2, width * 1.5], center = true);
        }
    }
    
    
}

module collar_part(outer_radius, inner_radius, width) {
    rotate([90, 0, 0])
    linear_extrude(height = width, center = true, convexity = 4, scale = [1])
    difference() {
        circle(outer_radius);
        circle(inner_radius);
    };
}

module screw_part(outer_size, inner_size, layer_height, angle_step, total_height) {
    layers = ceil(total_height/layer_height);
    union() {
        for (i = [0:layers - 1]) {
            rotate([0, 0, angle_step * i])
            translate([0, 0, layer_height * i])
            screw_layer(outer_size, inner_size, layer_height);
        }
    }
}

module screw_layer(outer_size, inner_size, height) {
    linear_extrude(height = height, center = false, convexity = 2, scale = [1])
    intersection() {
        circle(outer_size);
        d = (square(outer_size) - square(inner_size)) / 2 / inner_size;
        translate([0, d, 0])
        circle(d + inner_size);
    }
}

function square(x) = x * x;