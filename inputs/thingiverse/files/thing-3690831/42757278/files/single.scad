// All measurements are in mm.

// The inside depth of the bowl.
bowl_depth = 18;

// The width (short diagonal) of the hexagon.
hex_width = 100;

// The thickness of the bowl's walls. The interal diameter of the bowl will be the width of the hexagon minus twice this value.
hex_wall_thickness = 5;

// The extra thickness of the bottom of the bowl. (This is in addition to the lip depth.)
hex_bottom_thickness = 0;

// The width of the lip around the top edge.
lip_width = 2;

// The depth of the lip around the top edge.
lip_depth = 2;

// Decrease for tighter fit when stacked.
lip_spacing = 0.25;

// The amount of curvature to the bottom of the bowl.
corner_radius = 5;

// The magnet hole diameter. Add 0.5mm to the actual size of the magnet.
magnet_diameter = 5.5;

// The magnet hole depth. Add 0.25mm to the actual size of the magnet.
magnet_depth = 1.25;

module hexagon_short_diagonal(height, short_diagonal) {
    translate([0, 0, height / 2])
        for (a = [-60, 0, 60])
            rotate([0, 0, a])
                cube([
                    short_diagonal * sqrt(3) / 3,
                    short_diagonal,
                    height
                ], true);
}

union() {

    // small hex under for bottom lip
    translate([0, 0, -lip_depth])
        hexagon_short_diagonal(lip_depth, hex_width - lip_width * 2 - lip_spacing);

    difference() {

        // main hex block
        hexagon_short_diagonal(bowl_depth + lip_depth, hex_width);

        // cut out smaller hex for top lip
        translate([0, 0, bowl_depth])
            hexagon_short_diagonal(lip_depth + 1, hex_width - lip_width * 2);

        // position the hockey puck cutout just a bit over the bottom
        translate([0, 0, bowl_depth / 2 + corner_radius + hex_bottom_thickness - bowl_depth / 2])
            minkowski() {
                cylinder(
                    bowl_depth,
                    hex_width / 2 - corner_radius - hex_wall_thickness,
                    hex_width / 2 - corner_radius - hex_wall_thickness,
                    $fn = 200
                );
                sphere(corner_radius, $fn = 75);
            }

        // magnet cutouts
        for (a = [0:5]) {
            rotate([0, 0, a * 60])
                translate([
                    0,
                    - hex_width / 2 + magnet_depth - 0.001,
                    bowl_depth / 2 + lip_depth / 2
                ])
                rotate([90, 0, 0])
                cylinder(3, magnet_diameter / 2, magnet_diameter / 2, $fn = 30);
        }

    }

}
