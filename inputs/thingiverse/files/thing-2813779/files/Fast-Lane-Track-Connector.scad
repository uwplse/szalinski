include <MCAD/shapes.scad>

$fs = 0.5;
$fa = 0.5;

// Parameters for base shape of the connector
base_length = 66.7;
base_width = 27;
base_thickness = 1.6;

// Parameters for edge rounding
end_rounding_radius = 4; // Large radius at 4 corners
edge_rounding_radius = base_thickness / 2 - 0.01; // Small radius for edge treatment

// Arrow dimensions (for locking into track cutouts)
arrow_length = 7.75;
arrow_width = 8;
arrow_thickness = 1.25;

// Spacing between flat backs of arrows
arrow_separation = 29;

// --------

// Defines base coupling for sliding into track grooves
module baseplate(dims, edge_radius, end_radius) {
    length = dims[0];
    width = dims[1];
    height = dims[2];
    translate([0, 0, base_thickness / 2]) {
        minkowski() {
            roundedBox(
                width=length - 2 * edge_radius,
                height=width - 2 * edge_radius,
                depth=height - 2 * edge_radius,
                radius=end_radius
            );
            sphere(r=edge_radius);
        }
    }
}

// Defines locking arrow for interfacing with track pieces
module arrow_lock(dims) {
    length = dims[0];
    width = dims[1];
    height = dims[2];        
    vertices = [
        [0, width/2, 0],
        [0, width/2, height],
        [0, -width/2, height],
        [0, -width/2, 0],
        [length, 0, 0],
        [length, 0, height]
    ];
    faces = [
        [0, 1, 2, 3], // back of triangle
        [0, 3, 4], // top of triangle
        [1, 5, 2], // bottom of triangle
        [0, 4, 5, 1], // angle face 1
        [2, 5, 4, 3] // angle face 2
    ];
    polyhedron(
        points=vertices,
        faces=faces,
        convexity=2
    );
}

// v-------- Active geometry --------v

baseplate(
    [base_length, base_width, base_thickness],
    edge_radius=edge_rounding_radius,
    end_radius=end_rounding_radius
);

translate([0, 0, base_thickness]) {
    translate([arrow_separation/2, 0, 0]) {
        arrow_lock([
            arrow_length,
            arrow_width,
            arrow_thickness
        ]);
    }
    translate([-arrow_separation/2, 0, 0]) {
        mirror([1, 0, 0]) {
            arrow_lock([
                arrow_length,
                arrow_width,
                arrow_thickness
            ]);
        }
    }
}