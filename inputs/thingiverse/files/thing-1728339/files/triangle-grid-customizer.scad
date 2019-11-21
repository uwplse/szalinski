triangle_edge_length = 5;

// Set "true" if you want to make the triangles hollow
hollow = false; // [false, true];

// Space between each triangle
spacing = 0.8; 

// For 3d printing, set to an integer multiple of the extrusion width
joint_width = 0.8;

height = 1;

// The outer diameter of the disk
diameter = 140;

/* [Hidden] */
nudge = 0.0001;
precision = 200;
n_x = ceil(diameter / triangle_edge_length); // Number of rows of triangles to be generated
n_y = ceil(diameter / triangle_edge_length); // Number of columns of triangles to be generated

disc();
// diamond

module disc() {
    linear_extrude(height = height, twist = 0, $fn = 1000)
    union(){
        intersection() {
            circle(r = diameter / 2 - joint_width, $fn = precision);
            diamond();
        }

        difference() {
            circle(r = diameter / 2, $fn = precision);
            circle(r = diameter / 2 - joint_width, $fn = precision);        
        }
    }
}

module diamond() {
    // center in Y (assuming n_x equals n_y)
    translate([0, - triangle_edge_length / 2 - cos(30) * spacing, 0])
    translate([0, (triangle_edge_length + cos(30) * spacing * 2) * (n_x * 2 - n_y) / 2])
    // Create the pattern along X and Y. Well, not really X and Y, but you get the idea
    for(x = [0: n_x - 1]) {
        translate([(-spacing - triangle_edge_length / 2 * pow(3, .5) - sin(30) * spacing) * x, (-triangle_edge_length / 2 - cos(30) * spacing) * x])
        for(y = [0: n_y - 1]) {
            translate([(spacing + triangle_edge_length / 2 * pow(3, .5) + sin(30) * spacing) * y, (-triangle_edge_length / 2 - cos(30) * spacing) * y])
            two();
        }
    }
}

module two() {
    // center the piece in X
    translate([triangle_edge_length / 2 / pow(3, .5) + spacing / 2, 0, 0])
    union(){
        // create the mirrored piece
        translate([-triangle_edge_length / pow(3, .5) - spacing, 0])
        mirror([1, 0])
        piece();

        piece();
    }
}

module piece() {
    // generate the joints
    for(i = [0: 2]){
        rotate([0, 0, 120 * i])
        translate([-triangle_edge_length / pow(3, .5) / 2 - spacing, -triangle_edge_length / 2, 0])
        // expand the joints just barely to ensure that the objects all touch
        translate([spacing / 2, joint_width / 2])
        square([spacing + nudge, joint_width + nudge], center = true);
    }

    // generate the main piece
    difference() {
        circle(r = triangle_edge_length / pow(3, .5), $fn = 3);
        if (hollow) {
            circle(r = (triangle_edge_length) / pow(3, .5) - joint_width * 2, $fn = 3);        
        }
    }
}