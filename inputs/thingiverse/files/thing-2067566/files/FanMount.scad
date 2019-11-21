inn_sq_h = 34;
inn_sq_w = 34;
inn_sq_x = 3;
inn_sq_y = 3;
screw1_offs = [4.5,4];
screw2_offs = [35.5,4];
screw3_offs = [4.5,36];
screw4_offs = [35.5,36];
mag1_offs = [11,4];
mag2_offs = [29,4];
mag3_offs = [11,36];
mag4_offs = [29,36];
mag_diam = 5;
probe_rad = 9.5;

fan_prot_dist = 4;

difference() {
    union() {
        linear_extrude(3) {
            difference() {
                square(40);
                translate([inn_sq_x,inn_sq_y]) square([inn_sq_w, inn_sq_h]);
            };
        };
        // top magnets
        //translate(mag3_offs) cylinder(3, d=(mag_diam+3), $fn=20);
        //translate(mag4_offs) cylinder(3, d=(mag_diam+3), $fn=20);
        // screw holders
        intersection() {
            hull() {
                translate(screw1_offs) cylinder(3, d=10, $fn=20);
                translate(mag1_offs) cylinder(3, d=(mag_diam+3), $fn=20);
            };
            cube(40,40,3);
        };
        intersection() {
            hull() {
                translate(screw2_offs) cylinder(3, d=10, $fn=20);
                translate(mag2_offs) cylinder(3, d=(mag_diam+3), $fn=20);
            };
            cube(40,40,3);
        };
        intersection() {
            hull() {
                translate(screw3_offs) cylinder(3, d=10, $fn=20);
                translate(mag3_offs) cylinder(3, d=(mag_diam+3), $fn=20);
            };
            cube(40,40,3);
        };
        intersection() {
            hull() {
                translate(screw4_offs) cylinder(3, d=10, $fn=20);
                translate(mag4_offs) cylinder(3, d=(mag_diam+3), $fn=20);
            };
            cube(40,40,3);
        };
        
        // fan protectors
        translate([20,20])
        difference () {
            linear_extrude(2)
            union () {
                for (i=[8:fan_prot_dist+2:18]) {
                    difference() {
                        circle(i);
                        circle(i-2);
                    };
                };
                rotate(45)  square([sqrt(2)*30,2], center=true);
                rotate(-45) square([sqrt(2)*30,2], center=true);
            };
            cylinder(2, r=6);
        };
    };
    // screws
    translate(screw1_offs) cylinder(10, d=4, $fn=50);
    translate(screw2_offs) cylinder(10, d=4, $fn=50);
    translate(screw3_offs) cylinder(10, d=4, $fn=50);
    translate(screw4_offs) cylinder(10, d=4, $fn=50);
    translate(concat(screw1_offs, [.6])) cylinder(8, d=6, $fn=50);
    translate(concat(screw2_offs, [.6])) cylinder(8, d=6, $fn=50);
    translate(concat(screw3_offs, [.6])) cylinder(8, d=6, $fn=50);
    translate(concat(screw4_offs, [.6])) cylinder(8, d=6, $fn=50);
    // magnets
    translate(concat(mag1_offs,[.6])) cylinder(4, d=mag_diam, $fn=7);
    translate(concat(mag2_offs,[.6])) cylinder(4, d=mag_diam, $fn=7);
    translate(concat(mag3_offs,[.6])) cylinder(4, d=mag_diam, $fn=7);
    translate(concat(mag4_offs,[.6])) cylinder(4, d=mag_diam, $fn=7);
};