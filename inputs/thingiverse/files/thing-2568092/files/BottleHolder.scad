
/* [Hidden] */
inches = 25.4;
$fs = 1.0;


/* [Bottle Holder] */
rows = 3;
columns = 4;

// The diameter of the holes that will hold bottles.
diameter = 31.75;

// How much spacing is between the edges of the holes.
// If your bottle has lids, don't forget to account for the lid overhang!
gap = 5.0;

// How tall the bottle holder will be.
height = 6.5;

// If the offset rows should have one fewer columns.
// This allows for the whole shape to fit nicely in a rectangle.
smaller_offsets = 0; // [0,1]

// The thickness of the outer loops as a percent of the inner gap.
padding_scale = 1.0; // [1:0.05:2]


// Things I have found useful:
// Film Canisters:
//   diameter = 1.25 * inches
// Medicine Bottles:
//   diameter = 1.25 * inches
//   gap >= 0.45 * inches
// Ikea IHARDIG Spice Jars:
//   diameter = 65.5
// AA Battery Holder:
//   diameter = 14.75
// AAA Battery Holder:
//   diameter = 10.5



function int(bool) = (bool ? 1 : 0);

module HexPack(rows, columns, spacing, smaller_offsets = false) {
    // rows             How many rows of duplicated children.
    // columns          How many columns of duplicated children.
    // spacing          How far the children should be spaced from each other.
    // smaller_offsets  If the offset rows should have one fewer columns.
    //                  This allows for the whole shape to fit nicely in a rectangle.

    // Assuming the objects are hexagonally packed,
    //   this is how far their center points are from each other.
    // We can find the y spacing of the center points using the Pythagorean theorem because
    //   the center points between three adjacent circles will form an equilateral triangle.
    // Shortcut:
    //   The side length is half the hypotenuse, so...
    //   sqrt(hypot^2 - side^2)
    //   => sqrt((side * 2)^2 - side^2)
    //   => sqrt(4 * side^2 - side^2)
    //   => sqrt(3 * side^2)
    //   => sqrt(3) * side
    hex_x_spacing = spacing;
    hex_y_spacing = sqrt(3) * (spacing / 2);

    for ( row = [0 : max(1, rows - 1)] ) {
        is_offset = ( row % 2 );
        offset_shrinkage = int(smaller_offsets) * is_offset;

        // Offset rows are translated over one half a spacing.
        x_offset = (is_offset * (hex_x_spacing / 2));
        y_offset = (row * hex_y_spacing);

        for ( column = [0 : max(0, columns - offset_shrinkage - 1)] ) {
            cur_x_offset = x_offset + (column * hex_x_spacing);
            translate([cur_x_offset, y_offset, 0]) children();
        }
    }
}


module BottleHolder(rows, columns, diameter, gap, height, padding_scale = 1.0, smaller_offsets = false) {
    // rows             Number of rows of holes.
    // columns          Number of columns of holes.
    // diameter         The diameter of the holes that will hold bottles.
    // gap              How much spacing is between the edges of the holes.
    //                  If your bottles have lids, don't forget to account for them!
    // height           How tall the bottle holder will be.
    // padding_scale    The thickness of the outer loops as a percent of the inner gap.
    // smaller_offsets  If the offset rows should have one fewer columns.
    //                  This allows for the whole shape to fit nicely in a rectangle.

    outer_diameter = (diameter + gap);

    difference() {
        union() {
            // Structural cylinders that holes will be cut from.
            HexPack(rows, columns, outer_diameter, smaller_offsets)
                cylinder(height, d = diameter + (2 * gap * padding_scale));

            // Filling any gaps between the inner cylinders.
            // Try making this transparent (with %) to see why it's necessary.
            offset_shrinkage = int(smaller_offsets) * (outer_diameter / 2);
            translate([diameter / 4, 0, 0])
                cube([
                    (columns - 1) * outer_diameter - offset_shrinkage,
                    (rows - 1) * sqrt(3) * (outer_diameter / 2),
                    height
                ]);
        }

        // Cutting holes in the structural cylinders to make loops
        HexPack(rows, columns, outer_diameter, smaller_offsets)
            cylinder(height, d = diameter);
    }
}

// preview[view:south, tilt:top]
BottleHolder(
    rows     = rows,
    columns  = columns,
    diameter = diameter,
    height   = height,
    gap      = gap,
    smaller_offsets = smaller_offsets,
    padding_scale   = padding_scale
);
