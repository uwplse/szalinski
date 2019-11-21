post_diameter_tolerance = 0.2;
post_diameter = 6 + post_diameter_tolerance;
post_height = 11; 

knob_height = 14;
knob_bottom_r = 10;
knob_top_r = 6.5;
knob_wing_w = 4;

full_part();

module full_part() {
    difference() {
        union() {
            knob();
            wing();
        }
        
        union() {
            dimple();
            mount();
            hollow();
        }
    }
}

module knob() {
    cylinder(h=knob_height, r1 = knob_bottom_r, r2 = knob_top_r);
}

module dimple() {
    translate([0, 0, knob_height*1.6])
        sphere(r=knob_bottom_r);
}

module wing() {
    intersection() {
        translate([0, -knob_wing_w / 2, 0]) {
            cube([4 * knob_top_r, knob_wing_w, knob_height]);
        }
        
        scale([2, 2, 2]) {
            knob();
        }
    }
}

module mount() {
    cylinder(h = post_height, r = post_diameter / 2);
}

module hollow() {
    translate([0, 0, -0.1]) {
        cylinder(h = post_height / 2, r1 = knob_bottom_r - 2, r2 = post_diameter/2);
    }
}

