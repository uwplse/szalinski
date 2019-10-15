

module arm() {
    union() {
        difference() {
            translate([14.5, 0, 0]) {
                rotate([0, 0, -5.5]) {
                    cube([12, 56, 40]);
                }
            }
            translate([19.1, -1, -1]) {
                rotate([0, 0, -11.5]) {
                    cube([15, 102, 102]);
                }
            }
        }
    }
}

module arms() {
    union() {
        difference() {
            union() {
                arm();
                mirror([1, 0, 0]) arm();
            }
            union() {
                translate([-50, -1, 22.5]) {
                    rotate([15, 0, 0]) {
                        cube([100, 100, 100]);
                    }
                }
                translate([-100, -1, -1]) {
                    cube([200, 4.5, 100]);
                }
                translate([-100, 53.5, -1]) {
                    cube([200, 10, 100]);
                }
            }
        }
    }
}

base_x = 67;
base_y = 57;
base_z = 5;

module half_base() {
    difference() {
        cube([base_x / 2, base_y, base_z]);
        translate([22.5, -1, -1]) {
            rotate([0, 0, -12]) {
                cube([100, 100, 100]);
            }
        }
    }
}

module base() {
    half_base();
    mirror([1, 0, 0]) half_base();
}


module core() {
    base();
    arms();
}

module chopper() {
    translate([0, 0, 79]) {
        scale([1, 1, 9]) {
            rotate([45, 0, 0]) {
                cube([base_x, 10, 10], center = true);
            }
        }
    }
}

difference() {
    core();
    union() {
        translate([0, 11, 0]) {
            chopper();
        }
        translate([0, 20, 0]) {
            chopper();
        }
        translate([0, 29, 0]) {
            chopper();
        }
        translate([0, 38, 0]) {
            chopper();
        }
        translate([0, 47, 0]) {
            chopper();
        }
    }
}
