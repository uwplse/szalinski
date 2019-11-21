// Internal diameter of ring (in mm).
internal_diameter = 16.6;
$fn=60 * 1;


module diamond(w, w2, h1, h2) {
    $fn=9;
    cylinder(d1=0, d2=w, h=h1);
    translate([0, 0, h1]) cylinder(d1=w, d2=w2, h=h2);
}

module dvase(w, w2, h1, h2) {
    difference() {
            diamond(w, w2, h1, h2);
            translate([0, 0, 3]) diamond(w-3, w2-3, h1-3, h2);
            translate([0, 0, h1-.1]) cylinder(d=w2-4, h=h2+1);
    }
}

module ring(id) {
    off = (id / 2) - 4;
    difference() {
        union() {
            rotate([180, 0, 0]) dvase(25, 16, 17, 5);
            translate([0, 0, off]) rotate([90, 0, 0])cylinder(d=id+3.9, h=4, center=true);
        }
        translate([0, 0, off]) rotate([90, 0, 0]) cylinder(d=id, h=25, center=true);
    }
}

ring(internal_diameter);
