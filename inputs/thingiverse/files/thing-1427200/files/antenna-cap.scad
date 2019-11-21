cap_radius = 20;
cable_radius = 1.75;
clamp_height = 7;
thickness = 1;

module cap(rad) {
        difference() {
        sphere(r=rad, $fn=50);
        translate([0, 0, -(rad/2)]) {
            cube([rad*2, rad*2, rad], center=true);
        }
    }
}

module thick_cap(rad, thk) {
    difference() {
        cap(rad + thk);
        difference() {
            cap(rad);
            translate([0, 0, -(rad/2)+thk]) {
                cube([rad*2, rad*2, rad], center=true);
            }
        }
    }
}

module cable(h, r, t) {
    translate([0, 0, -(h/2)+(t*.5)]) {
        cylinder(h=h+(3*t), r=r, center=true, $fn=25);
    }
}

module clamp(h, r, t) {
    translate([0, 0, -(h/2)]) {
        cylinder(h=h, r=r+t, center=true, $fn=25);
    }
}

module cut(r, h, t) {
    translate([(r/2)+t, 0, (r-h)/2]) {
        cube([r+(t*2), (r*2)+(t*2), (t*2)+r+h], true);
    }
}

module component(cap_rad, cab_rad, h, t) {
    
    difference() {
        union() {
            difference() {
                thick_cap(cap_rad, t);
                cable(h, cab_rad, t);
            }
            difference() {
                clamp(h, cab_rad, t);
                cable(h, cab_rad, t);
            }
        }
        cut(cap_radius, clamp_height, thickness);
    }
}

component(cap_radius, cable_radius, clamp_height, thickness);