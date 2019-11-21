XXX = str("XXX");

// CUSTOMIZER VARIABLES
/* [Basic] */
// Labels for each of the holes (Use XXX to skip a hole)
hole_labels = [[XXX, 4.0, 5.0, 6.0, 8.0, 10], [4.5, 4.8, 5.0, 5.5, 6.0, 6.5], [1.5, 2.0, 2.5, 3.0, 3.5, 4.0]];
// Hole depth (in mm)
hole_depth = 10;
// Space between hole and label (in mm)
hole_to_label_gap = 2;
// Minimum gap between columns (in mm)
min_column_gap = 8;
// Minimum gap between rows (in mm)
min_row_gap = 5;
// Border width around the edge of the holes and labels (in mm)
min_border = 5;
// Minimum depth of the container
min_container_depth = 10;

/* [Advanced] */
// Name to label a hole so that it is skipped
skip_name = "XXX";
// Hole diameter at widest point
hole_diameter = 7.8;
// Hole Sides
hole_sides = 6;
// Label width
label_width = 10;
// Label depth
label_depth = 2;
// Label font
label_font = "Liberation Sans:style=Bold";
// Label size
label_font_size = 8;
// Radius of the container chamfer
chamfer_radius = 5;

// CUSTOMIZER VARIABLES END

module go() {
    // Localised tidy variables
    labels = hole_labels;
    h_depth = hole_depth;
    hl_gap = hole_to_label_gap;
    col_gap = min_column_gap;
    row_gap = min_row_gap;
    border = max(min_border, chamfer_radius);
    container_depth = min_container_depth;
    s_name = skip_name;
    h_diameter = hole_diameter;
    h_sides = hole_sides;
    l_height = label_font_size;
    l_width = label_width;
    l_depth = label_depth;
    font = label_font;
    font_size = label_font_size;
    font_fudge = 0;
    fillet_radius = min(min_border, chamfer_radius);

    // Quicky print debug values
    /*
    labels = [["?.?"]];
    h_depth = 5;
    container_depth = 10;
    border = 8;
    fillet_radius = 5;
    */

    // Constants
    X = 0;
    Y = 1;
    Z = 2;
    // Vertex colision avoidance values
    d = 0.1;
    dd = 2 * d;
    dddd = 4 * d;

    rows = len(labels);
    cols = max([for (r = [0:rows-1]) len(labels[r])]);
    h_radius = h_diameter / 2;
    
    // Size of one hole and label
    unit_size = [max(h_diameter, l_width), h_diameter + hl_gap + l_height];
    echo(unit_size=unit_size);

    // Size of overall container
    box_x = (border * 2) + (cols * unit_size[X]) + ((cols - 1) * col_gap);
    box_y = (border * 2) + (rows * unit_size[Y]) + ((rows - 1) * row_gap);
    box_z = max(container_depth, h_depth + 2);
    echo(box_x=box_x, box_y=box_y, box_z=box_z);

    module hole_and_label(x, y, label) {
        // Place a hole and label at the supplied offet
        h_centre_x = x + unit_size[X] / 2;
        h_centre_y = y - h_radius;
        // echo(h_c_x=h_centre_x, h_c_y=h_centre_y);
        translate([h_centre_x, h_centre_y, box_z - h_depth])
            if (h_sides)
                cylinder(r=h_radius, h=h_depth + 1, $fn=h_sides);
            else
                cylinder(r=h_radius, h=h_depth + 1);
        label_x = x + unit_size[X] / 2;
        label_y = y - h_diameter - l_height - hl_gap - font_fudge;
        translate([label_x, label_y, box_z - l_depth]) {
            *cube([l_width, l_height, l_depth + 1]);
            linear_extrude(height=l_height) 
                text(label, font=font, size=font_size, halign="center");
        }
        
    }

    module holes_and_labels() {
        // Place all the holes and labels
        function x_offset(c) = border + c * (unit_size[X] + col_gap);
        function y_offset(r) = border + r * (unit_size[Y] + row_gap);

        for (row = [0:rows - 1]) {
            r_labels = labels[row];
            for (col = [0:cols - 1]) {
                label = r_labels[col];
                if (label == undef) {
                    echo("Skipping");
                } else {
                    yo = box_y - y_offset(row);
                    xo = x_offset(col);
                    // Check that this is not the skipping label
                    if (label != s_name) {
                        // echo(r=row, c=col, p=[xo, yo], label=label);
                        hole_and_label(xo, yo, str(label));
                    }
                }
            }
        }
    }

    module bevels() {
        // Build the edge bevels
        translate([-dd, -dd, -dd])
            difference() {
                // Oversized box
                cube([box_x + dddd, box_y + dddd, box_z + dddd]);
                // Subtract area to keep
                translate([dd, dd, dd])
                    hull() {
                        for (x = [fillet_radius, box_x - fillet_radius]) {
                            for (y = [fillet_radius, box_y - fillet_radius]) {
                                for (z = [0, box_z - fillet_radius]) {
                                    translate([x, y, z])
                                        sphere(r=fillet_radius+d);
                                }
                            }
                        }
                    }
                // Subtract center window inside borders
                translate([border, border, -1])
                    cube([box_x - 2 * border, box_y - 2 * border, box_z + 2]);
            }
    }

    // Build the final product
    difference() {
        // Outline
        cube([box_x, box_y, box_z]);
        // Subtract holes and labels
        holes_and_labels();
        // Subtract bevels
        bevels();
    }
}

go();