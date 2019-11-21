dispenser_x = 70;
dispenser_y = 82;
dispsnser_z = 150;
wall_thickness = 1;
enterance_thickness = 5;

cutout_overlap_size = 4;

teabag_dispenser(dispenser_x, dispenser_y, dispsnser_z, wall_thickness, enterance_thickness, cutout_overlap_size);

module teabag_dispenser(x, y, z, thick, enter_thick, cutout) {
    module frame(thickness) {
        difference() {
            children();
            offset(r = -thickness) children();
        }
    }

    translate([0, 0, thick]) union() {
        // walls
        difference() {
            linear_extrude(z, 0)
                frame(thick)
                square([x, y], center = true);

            // front part
            translate([-x / 4, -y / 2 - cutout / 2, -cutout / 2])
                cube([x / 2, thick + cutout, z + cutout]);
            
            // pull out part
            translate([-x / 2 + thick, -y / 2 - cutout / 2, 0]) scale([1, (thick + cutout) / thick, 1]) union() {
                x = x - thick * 2;

                cube([x, thick, enter_thick]);

                // rounded top
                round_top = enter_thick;
                translate([0, thick, round_top]) rotate([90, 0, 0]) hull() {
                    translate([0 + round_top, 0, 0])
                        cylinder(r = round_top, h = thick, center = false);
                    translate([x - round_top, 0, 0])
                        cylinder(r = round_top, h = thick, center = false);
                }
            }
        }

        // floor
        translate([-x / 2, -y / 2, -thick]) difference() {
            // floor
            cube([x, y, thick]);

            // puch out
            punch_radius = min(x, y) / 8;
            translate([x / 2, 0, -cutout / 2])
                cylinder(r = punch_radius, h = thick + cutout, center = false);
        }
    }
}