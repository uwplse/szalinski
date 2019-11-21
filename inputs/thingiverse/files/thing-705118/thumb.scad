/* [Main] */
diameter = 30; //[10:100]
height = 12;
//smooth =

/* [Cuts] */
cut_diameter = 5; //[0:50]
cut_count = 25; //[0:300]


/* [Shaft] */
shaft_on_top = 0; // [1:Top, -1:Bottom, 0:Both]
shaft_diameter = 15; // [0:100]
shaft_height = 3; // [0:10]

/* [Center Bolt] */
nut_on_top = -1; // [1:Top,-1:Bottom, 0:None]
bolt_size = 4; //[2:M2,2.5:M2.5,3:M3,4:M4,5:M5,6:M6,7:M7,8:M8]


module bolt(height, size, top = 1) {
    preview = 0.1;
    //translate([0,0,-height/2]) cylinder(h=height,d=3, $fn=32);
    translate([0, 0, -height / 2 - preview / 2]) {
        cylinder(h = height + preview, d = size + 0.2, $fn = 32);
    }
    if (top != 0) {
        translate([0, 0, (height / 2 - (size * 0.7) / 2) * top]) cylinder(h = size * 0.7 + preview, d = size * 1.8, $fn = 6, center = true);
    }

}

module body(h, d, sh, sp, cc, cd) {
    //height, diameter, shaft_height, shaft_position, cut_count, cut_diameter
    $fn = 50;
    translate([0, 0, sh / 2 * -sp])
    linear_extrude(height = h - sh * (2 - abs(sp)), center = true, convexity = 1, twist = 0) {
        minkowski() {
            difference() {
                circle(d = d);
                for (i = [0: cc]) {
                    rotate([0, 0, 360 / cc * i]) translate([d * 0.5, 0, 0]) circle(d = cd * 0.8, $fn = 32);
                }
            }
            circle(r = cd * 0.2);
        }
    }
}

module shaft(d, h) {
    $fn = 50;
    cylinder(d = d, h = h, center = true);
}


module trimmer(height, diameter, shaft_height, shaft_on_top, cut_count, cut_diameter, shaft_diameter, bolt_size, nut_on_top) {
    difference() {
        union() {
            body(height, diameter, shaft_height, shaft_on_top, cut_count, cut_diameter);
            shaft(shaft_diameter, height);
        }
        bolt(height, bolt_size, nut_on_top);
    }

}

trimmer(height, diameter, shaft_height, shaft_on_top, cut_count, cut_diameter, shaft_diameter, bolt_size, nut_on_top);
