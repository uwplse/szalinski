// honeycomb modules by PrzemoF
// see http://forum.openscad.org/Beginner-Honeycomb-advice-needed-tp4556p4592.html

/* [Box] */

// Width/depth of the box
square_sides=80;
// Height of the box
height=100;
// Thickness of the walls
wall_thickness=5;
// Thickness of the base
base_thickness=5;

/* [Honeycomb] */
// Diameter of the hexagons
hc_cell_size=6;
// space between hexagons
hc_wall_thickness=1.6;
// amount of space to leave around the honeycomb
border=25;

/* [Hidden] */

module hc_column(length, cell_size, wall_thickness) {
        no_of_cells = floor(length / (cell_size + wall_thickness));

        for (i = [0 : no_of_cells]) {
                translate([0,(i * (cell_size + wall_thickness)),0])
                         circle($fn = 6, r = cell_size * (sqrt(3)/3));
        }
}

module honeycomb (length, width, height, cell_size, wall_thickness) {
        no_of_rows = floor(1.2 * length / (cell_size + wall_thickness));

        tr_mod = cell_size + wall_thickness;
        tr_x = sqrt(3)/2 * tr_mod;
        tr_y = tr_mod / 2;
        linear_extrude(height = height, center = true, convexity = 10,
twist = 0, slices = 1)
            for (i = [0 : no_of_rows]) {
                    translate([i * tr_x, (i % 2) *
tr_y,0])
                            hc_column(width, cell_size,
wall_thickness);
            }
}

width=square_sides;
depth=square_sides;
hc_extrude=wall_thickness+10;
width_border=border;
height_border=border+hc_cell_size;

hc_cells_high=floor((height-height_border) / (hc_cell_size + hc_wall_thickness))+1;
hc_cells_wide=floor(1.2 * (width-width_border) / (hc_cell_size +hc_wall_thickness))+1;
tr_mod = hc_cell_size + hc_wall_thickness;
tr_x = sqrt(3)/2 * tr_mod;
hc_width=(hc_cells_wide*tr_x) - hc_wall_thickness/2;
hc_height=(hc_cells_high*(hc_cell_size + hc_wall_thickness)) + ((hc_cell_size + hc_wall_thickness)/2);

move_width_hc=(hc_cell_size/2) + ((width-hc_width)/2);
move_height_hc=((hc_cell_size + hc_wall_thickness)/2) + ((height-hc_height)/2);
move_hc=2;

difference() {
    difference() {
        cube(size=[width,depth,height]);
        translate([wall_thickness/2, wall_thickness/2, base_thickness]) {
            cube(size=[width-wall_thickness,depth-wall_thickness,height]);
        };
    }
    translate([move_width_hc,0,move_height_hc]) {
        rotate([90,0,0]) {
            honeycomb(width-width_border, height-height_border, hc_extrude, hc_cell_size, hc_wall_thickness);
        }
    }
    translate([width,move_width_hc,move_height_hc]) {
        rotate([0,90,0]) rotate([0,0,90]) {
            honeycomb(width-width_border, height-height_border, hc_extrude, hc_cell_size, hc_wall_thickness);
        }
    }
    translate([0,move_width_hc,move_height_hc]) {
        rotate([0,90,0]) rotate([0,0,90]) {
            honeycomb(width-width_border, height-height_border, hc_extrude, hc_cell_size, hc_wall_thickness);
        }
    }
    translate([move_width_hc,width,move_height_hc]) {
        rotate([90,0,0]) {
            honeycomb(width-width_border, height-height_border, hc_extrude, hc_cell_size, hc_wall_thickness);
        }
    }
}