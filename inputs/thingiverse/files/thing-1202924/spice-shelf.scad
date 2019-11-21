
container_diameter = 42; // [20:80]
container_margin = 5; // [5,10,15,20]
container_count = 4; // [1:15]

wall_thicknes = 5; // [3:20]

tray_height = 20; // [20:60]
back_height = 55; // [30:100]

print_part();

module print_part() {
    inner_size_x = container_count * (container_diameter + container_margin);
    inner_size_y = container_diameter + container_margin;
    inner_size_z = tray_height - wall_thicknes;

    outer_size_x = inner_size_x + (2 * wall_thicknes);
    outer_size_y = inner_size_y + (2 * wall_thicknes);
    outer_size_z = tray_height;

    rotate ([0,0,180]) {
        intersection() {
            union() {
                difference() {

                    radius = 5;


                    linear_extrude(height=outer_size_z) {
                        hull() {
                            translate([(-outer_size_x/2)+(radius/2), (-outer_size_y/2)+(radius/2), 0])
                            circle(r=radius/2,$fn=50);

                            translate([(outer_size_x/2)-(radius/2), (-outer_size_y/2)+(radius/2), 0])
                            circle(r=radius/2,$fn=50);

                            translate([(-outer_size_x/2)+(radius), (outer_size_y/2)-(radius), 0])
                            circle(r=radius,$fn=50);

                            translate([(outer_size_x/2)-(radius), (outer_size_y/2)-(radius), 0])
                            circle(r=radius,$fn=50);
                        }
                    }

                    translate([- inner_size_x / 2, -inner_size_y / 2, wall_thicknes]) {
                        cube([inner_size_x, inner_size_y, inner_size_z]);
                    }
                }


                translate([0,0,0]) {
                    back_size_x = inner_size_x + (2 * wall_thicknes);
                    back_size_y = inner_size_y + (2 * wall_thicknes);
                    back_size_z = back_height;

                    radius = 2.5;
                    linear_extrude(height=back_size_z) {
                        hull()
                        {
                            translate([(-back_size_x/2)+(radius), (-back_size_y/2)+(radius), 0])
                            circle(r=radius,$fn=50);

                            translate([(back_size_x/2)-(radius), (-back_size_y/2)+(radius), 0])
                            circle(r=radius,$fn=50);
                        }
                    }
                }
            }

            back_radius = outer_size_x;

            translate([0,0,-(back_radius - back_height)]) {
                rotate([90,0,0]) {
                    cylinder(outer_size_y,back_radius, back_radius,true, $fn=200);
                }
            }
        }
    }
}
