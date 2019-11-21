// Mirror mount
// Mount a mirror to the dual extruder of a CTC Dual
// author: Benedict Endemann
// https://www.thingiverse.com/thing:3037001

////////// Thingiverse Customizer //////////
mirror_width     = 61;
mirror_height    = 4.25;
mirror_lenght    = 86;
////////// Thingiverse Customizer //////////

mirrormount(
    mirror_width     = mirror_width,   // 61
    mirror_height    = mirror_height, // 4.25
    mirror_lenght    = mirror_lenght,   // 86
    fan_size         = 40,   // 40
    fan_height       = 20,   // 20
    gap_between_fans = 6.25, // 6.25
    gap_before_fans  = 18,   // 18
    gap_under_fans   = 9,    // 9
    thickness        = 1.5   // 1.5
);

module mirrormount(
    mirror_width,
    mirror_height,
    mirror_lenght,
    fan_size,
    fan_height,
    gap_between_fans,
    gap_before_fans,
    gap_under_fans,
    thickness
) {

    fan_holders_total_width = thickness + fan_size + gap_between_fans + fan_size + thickness;
    mirror_holder_width     = thickness + mirror_lenght + thickness;
    holder_size             = thickness + mirror_height + thickness;

    // rotate and translate for print
    rotate([-90, 0, 0]) translate([0, -fan_height - gap_before_fans - thickness, gap_under_fans / 2])

    union() {

        // left fan holder
        translate([-gap_between_fans / 2 - fan_size - thickness, 0, 0])
            fan_holder(
                fan_size,
                fan_height,
                thickness
            );

        // fan holder connection
        translate([-gap_between_fans / 2, 0, 0])
            cube([gap_between_fans, fan_height, thickness + fan_size / 4]);

        // right fan holder
        translate([gap_between_fans / 2 - thickness, 0, 0])
            fan_holder(
                fan_size,
                fan_height,
                thickness
            );

        // spacer before fans
        union() {

            translate([-fan_holders_total_width / 2, fan_height - thickness, 0])
                cube([fan_holders_total_width, thickness + gap_before_fans + thickness, thickness]);


            hull() {

                translate([-fan_holders_total_width / 2, fan_height - thickness, 0])
                    cube([fan_holders_total_width, thickness + thickness, thickness]);

                translate([-fan_holders_total_width / 2, fan_height - thickness, thickness])
                    cube([fan_holders_total_width, thickness, thickness]);

            }

            hull() {

                translate([-gap_between_fans / 2, fan_height - thickness, 0])
                    cube([gap_between_fans, thickness, thickness + fan_size / 4]);

                translate([-thickness / 2, fan_height + gap_before_fans, 0])
                    cube([thickness, thickness, thickness]);

            }

            hull() {

                translate([-fan_holders_total_width / 2, fan_height - thickness, 0])
                    cube([thickness, thickness, thickness + fan_size / 4]);

                translate([-fan_holders_total_width / 2, fan_height + gap_before_fans, 0])
                    cube([thickness, thickness, thickness]);

            }

            hull() {

                translate([fan_holders_total_width / 2 - thickness, fan_height - thickness, 0])
                    cube([thickness, thickness, thickness + fan_size / 4]);

                translate([fan_holders_total_width / 2 - thickness, fan_height + gap_before_fans, 0])
                    cube([thickness, thickness, thickness]);

            }
        }

        // fan mirror connection
        union () {

            hull() {

                translate([-fan_holders_total_width / 2, fan_height + gap_before_fans, 0])
                    cube([fan_holders_total_width / 2, thickness, thickness]);

                translate([
                    -mirror_holder_width / 2,
                    fan_height + gap_before_fans,
                    -gap_under_fans - pyth(thickness, thickness) + thickness
                ])
                    cube([holder_size, thickness, thickness]);

            }

            hull() {

                translate([0, fan_height + gap_before_fans, 0])
                    cube([fan_holders_total_width / 2, thickness, thickness]);

                translate([
                    mirror_holder_width / 2 - holder_size,
                    fan_height + gap_before_fans,
                    -gap_under_fans - pyth(thickness, thickness) + thickness
                ])
                    cube([holder_size, thickness, thickness]);

            }

            hull() {

                translate([
                    fan_holders_total_width / 2 - thickness,
                    fan_height + gap_before_fans - pyth(holder_size, holder_size) + thickness,
                    -thickness
                ])
                    cube([thickness, thickness, thickness]);

                translate([
                    fan_holders_total_width / 2 - thickness,
                    fan_height + gap_before_fans - thickness,
                    0
                ])
                    cube([thickness, thickness, thickness]);

                translate([
                    mirror_holder_width / 2 - thickness,
                    fan_height + gap_before_fans - pyth(holder_size, holder_size) + thickness,
                    -gap_under_fans - pyth(thickness, thickness) + thickness
                ])
                    cube([thickness, pyth(holder_size, holder_size) - thickness, thickness]);

                translate([
                    mirror_holder_width / 2 - thickness,
                    fan_height + gap_before_fans - pyth(holder_size, holder_size) + thickness,
                    -gap_under_fans - pyth(holder_size, holder_size) + thickness
                ])
                    cube([thickness, pyth(holder_size, holder_size) - thickness, thickness]);
            }

            hull() {

                translate([
                    -fan_holders_total_width / 2,
                    fan_height + gap_before_fans - pyth(holder_size, holder_size) + thickness,
                    -thickness
                ])
                    cube([thickness, thickness, thickness]);

                translate([
                    -fan_holders_total_width / 2,
                    fan_height + gap_before_fans - thickness,
                    0
                ])
                    cube([thickness, thickness, thickness]);

                translate([
                    -mirror_holder_width / 2,
                    fan_height + gap_before_fans - pyth(holder_size, holder_size) + thickness,
                    -gap_under_fans - pyth(thickness, thickness) + thickness
                ])
                    cube([thickness, pyth(holder_size, holder_size) - thickness, thickness]);

                translate([
                    -mirror_holder_width / 2,
                    fan_height + gap_before_fans - pyth(holder_size, holder_size) + thickness,
                    -gap_under_fans - pyth(holder_size, holder_size) + thickness
                ])
                    cube([thickness, pyth(holder_size, holder_size) - thickness, thickness]);
            }
        }

        // mirror holder
        translate([
            -mirror_holder_width / 2,
            fan_height + gap_before_fans - pyth(holder_size, holder_size) / 2 + thickness,
            -gap_under_fans - (pyth(holder_size, holder_size) + pyth(holder_size - thickness, holder_size - thickness) / 2) + (thickness - pyth(thickness, thickness) / 2)
        ])
            rotate([45, 0, 0])
                mirror_holder(
                    mirror_lenght,
                    mirror_width,
                    mirror_height,
                    holder_size,
                    thickness
                );

    }
}

function pyth(a,b) = sqrt(a * a + b * b);

module fan_holder(
    fan_size,
    fan_height,
    thickness
) {

    union() {

        // base plate
        cube([
            thickness + fan_size + thickness,
            fan_height,
            thickness
        ]);

        // right plate
        cube([
            thickness,
            fan_height,
            thickness + fan_size / 4
        ]);

        // left plate
        translate([thickness + fan_size ,0 ,0])
            cube([
                thickness,
                fan_height,
                thickness + fan_size / 4
            ]);

        // back plate
        translate([0, fan_height - thickness, 0])
            cube([
                thickness + fan_size + thickness,
                thickness,
                thickness + thickness
            ]);

    }

}

module mirror_holder(
    mirror_lenght,
    mirror_width,
    mirror_height,
    holder_size,
    thickness
) {

    difference() {

        // mirror holder
        union() {

            // left part
            difference() {

                cube([
                    holder_size,
                    2 * holder_size,
                    holder_size
                ]);

                translate([-holder_size / 2, 2 * holder_size, -holder_size])
                    rotate([45, 0, 0])
                        cube([
                            2 * holder_size,
                            pyth(holder_size, holder_size),
                            pyth(holder_size, holder_size)
                        ]);

                translate([-holder_size / 2, 0, -thickness])
                    rotate([45, 0, 0])
                        cube([
                            2 * holder_size,
                            pyth(thickness, thickness),
                            pyth(thickness, thickness)
                        ]);
            }

            // right right
            translate([mirror_lenght - mirror_height, 0, 0])
                difference() {

                    cube([
                        holder_size,
                        2 * holder_size,
                        holder_size
                    ]);

                    translate([-holder_size / 2, 2 * holder_size, -holder_size])
                        rotate([45, 0, 0])
                            cube([
                                2 * holder_size,
                                pyth(holder_size, holder_size),
                                pyth(holder_size, holder_size)
                            ]);

                    translate([-holder_size / 2, 0, -thickness])
                        rotate([45, 0, 0])
                            cube([
                                2 * holder_size,
                                pyth(thickness, thickness),
                                pyth(thickness, thickness)
                            ]);
                }
        }

        // mirror
        translate([thickness, thickness, thickness])
            #cube([mirror_lenght, mirror_width, mirror_height]);


    }
}