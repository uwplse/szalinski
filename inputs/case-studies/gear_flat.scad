$fn = 50;

shaft_r = 80;
shaft_h = 100;

gear_r = shaft_r * 1.5;
gear_h = shaft_h * 0.5;

hole_r = 25;

module shaft() {
    cylinder(r = shaft_r, h = shaft_h);
}

module gear_base() {
    cylinder(r = gear_r, h = gear_h);
}

module center_hole() {
    translate([0, 0, -1]) {
        cylinder(r = hole_r, h = shaft_h + 2);
    }
}

module tooth(x) {
    scale([2.5, 1, 1]) {
        rotate([0, 0, 45]) {
            translate([0, 0, gear_h/2]) {
                cube([10, 10, gear_h + 2], center = true);
            }
        }
    }
}


n_teeth = 60;
difference() {
    union() {
        shaft();
        gear_base();
    }
    center_hole();
    for(i = [1:n_teeth]) {
        rotate([0, 0, i * 360 / n_teeth]) {
            translate([gear_r + 5, 0, 0]) {
                tooth(n_teeth);
            }
        }
    }
}
