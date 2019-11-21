// Rattle
// author: Benedict Endemann
// https://www.thingiverse.com/thing:3037626

////////// Thingiverse Customizer //////////
diameter = 30; // [25:1:150]
height_factor = 1.25; // [0.5:0.05:2]
wall_thickness = 0.8; // [0.1:0.1:4]
set_fn_value = 90; // [15:1:360]
$fn = set_fn_value;
////////// Thingiverse Customizer //////////

rattle(
    diameter       = diameter,
    height_factor  = height_factor,
    wall_thickness = wall_thickness
);

module rattle(
    diameter       = 30,
    height_factor  = 1.25,
    wall_thickness = 0.8
) {
    translate([
        0,
        0,
        diameter * height_factor / 2
    ])
        difference() {

            hull() {

                // basic sphere
                resize([
                    diameter,
                    diameter,
                    diameter * height_factor
                ])
                    sphere(
                        d = diameter
                    );

                // cylinder as socket
                translate([
                    0,
                    0,
                    -diameter * height_factor / 2
                ])
                    cylinder(
                        d = diameter / 2,
                        h = diameter * height_factor / 2
                    );
            }

            // remove inside of sphere
            resize([
                diameter - wall_thickness * 2,
                diameter - wall_thickness * 2,
                diameter * height_factor - wall_thickness * 2
            ])
                sphere(
                    d = diameter
                );


            // make hole in top
           cylinder(
                d = diameter / 3 / 2,
                h = diameter * height_factor
            );
        }

    // add pea holder
    cylinder(
        d = diameter / 10,
        h = diameter * height_factor / 15 + diameter / 3 / 2
    );

    // add pea
    translate([
        0,
        0,
        diameter * height_factor / 15 + diameter / 3 / 2
    ])
        sphere(
            d = diameter / 3
        );
}