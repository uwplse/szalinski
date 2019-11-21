// The length of the rails
length = 180; // [30:400]

// Is the hole in the center needed or not
make_hole = "yes"; // [yes, no]

/* [Hidden] */

$fn = 200;
almost_zero = 0.01;

R = 12.5 / 2;
r = 12 / 2;

W = 41;
H = 12;

c_y = 15;
c_offset = 7;

module profile() {
    polygon(
        points=[
            [0, 1],
            [0, 11],
            [1, H],
            [4, H],
            [5, 9],
            [10, 9],
            [11, H],
            [30, H],
            [31, 9],
            [36, 9],
            [37, H],
            [40, H],
            [W, 11],
            [W, 1],
            [39, 0],
            [1, 0],
        ]
    );
}

module road_body(l) {
    rotate(v=[0, 0, 1], a=90) {
        rotate(v=[1, 0, 0], a=90) {
            linear_extrude(height = l) {
                profile();
            }
        }
    }
}

module mf_road(l) {
    difference() {
        road_body(l);
        union() {
            translate([R + 5, W / 2, -almost_zero / 2]) {
                cylinder(r=R, h=H + almost_zero);
            }
            translate([-almost_zero / 2, W / 2 - 7 / 2, -almost_zero / 2]) {
                cube([7, 7, H + almost_zero]);
            }
            translate([-almost_zero, W / 2 - 9 / 2, -almost_zero / 2]) {
                linear_extrude(height=H + almost_zero) {
                    polygon(
                        points=[
                            [0, 0],
                            [2, 2],
                            [2, 7],
                            [0, 9]
                        ]
                    );
                }
            }
            if (l >= 55 && make_hole == "yes") {
                translate([5 + 2 * R + c_offset + c_y/2, (W - c_y) / 2, -almost_zero / 2]) {
                    cube([l - 5 - 2 * R - 2 * c_offset - c_y, c_y, H + almost_zero]);
                }
                translate([5 + 2 * R + c_offset + c_y/2, W/2, -almost_zero / 2]) {
                    cylinder(r=c_y/2, h=H+almost_zero);
                }
                translate([l - c_y/2 - c_offset, W/2, -almost_zero / 2]) {
                    cylinder(r=c_y/2, h=H+almost_zero);
                }
            }
        }
    }
    union() {
        translate([l, W / 2, 0]) {
            translate([0, -6.5/2, 0]) cube([7, 6.5, H]);
            translate([5.5 + r, 0, 0]) cylinder(r=r, h=H);
        }
    }
}

mf_road(length);