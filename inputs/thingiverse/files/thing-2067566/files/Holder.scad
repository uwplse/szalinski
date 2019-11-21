inn_sq_h = 28;
inn_sq_w = 28;
inn_sq_x = 6;
inn_sq_y = 6;
screw1_offs = [4.5,4];
screw2_offs = [35.5,4];
mag1_offs = [11,4];
mag2_offs = [29,4];
mag3_offs = [11,36];
mag4_offs = [29,36];
mag_diam = 5;
probe_rad = 9.5;

rotate([90,0,0]) union() {
    difference() {
        union() {
            linear_extrude(6) {
                difference() {
                    square(40);
                    translate([inn_sq_x,inn_sq_y]) polygon([[0,0],[inn_sq_w, 0],[inn_sq_w,inn_sq_h],[0,inn_sq_h]]);
                };
            };
            // top magnets
            translate(mag3_offs) cylinder(10, d=(mag_diam+3), $fn=50);
            translate(mag4_offs) cylinder(10, d=(mag_diam+3), $fn=50);
            // screw holders
            intersection() {
                hull() {
                    translate(screw1_offs) cylinder(10, d=10, $fn=50);
                    translate(mag1_offs) cylinder(10, d=(mag_diam+3), $fn=50);
                };
                cube(40,40,10);
            };
            intersection() {
                hull() {
                    translate(screw2_offs) cylinder(10, d=10, $fn=50);
                    translate(mag2_offs) cylinder(10, d=(mag_diam+3), $fn=50);
                };
                cube(40,40,10);
            };
        };
        // screws
        translate(screw1_offs) cylinder(10, d=4, $fn=50);
        translate(screw2_offs) cylinder(10, d=4, $fn=50);
        translate(concat(screw1_offs, [2])) cylinder(8, d=6, $fn=50);
        translate(concat(screw2_offs, [2])) cylinder(8, d=6, $fn=50);
        // magnets
        translate(concat(mag1_offs,[6])) cylinder(4, d=mag_diam, $fn=7);
        translate(concat(mag2_offs,[6])) cylinder(4, d=mag_diam, $fn=7);
        translate(concat(mag3_offs,[6])) cylinder(4, d=mag_diam, $fn=7);
        translate(concat(mag4_offs,[6])) cylinder(4, d=mag_diam, $fn=7);
    };

    translate([38.4,0,5]) cube([7.6,6,5]);

    translate([45,6,3]) rotate([90,0,0]) {
        difference() {
            union() {
                translate([probe_rad+5,probe_rad+5]) cylinder(6, r=probe_rad+5, $fn=50);
                linear_extrude(6) polygon([[0,2],[15,0],[15,15],[0,15]]);
            };
        translate([probe_rad+5,probe_rad+5]) cylinder(6, r=probe_rad, $fn=50);
        };
    };
};