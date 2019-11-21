// Handlebar diameter
bar = 26.0; // [25.4, 26.0, 31.8]
// Decaleur length, center of bar to center of rod
length = 60; // [30:100]
// Rod diameter
rod = 16;  // [8,10,12,16]
/* [Hidden] */
bar_wall = 5 * 2;
rod_wall = 4 * 2;
width = 15;
slot = 3;
key = 3;

module borehole(d1,d2,w) {
    rotate([90,0,0])
    union() {
        cylinder(h=w*2, d=d1, center=true, $fn=100);
        translate([0,0,w]) cylinder(h=w, d=d2, center=true, $fn=100);
        translate([0,0,-w]) cylinder(h=w, d=d2, center=true, $fn=100);
        translate([d2/4,0,w/2-key/2]) cube(size=[d2/2,key,key], center=true);
    }
}
difference() {
    union() {
        cylinder (h=width, d=bar+bar_wall, center=true, $fn=100);
        translate([length, 0, 0]) cylinder (h=width, d=rod+rod_wall, center=true, $fn=100);
        linear_extrude(height = width, center = true, convexity = 0, twist = 0)
        polygon( points=[[0,0], 
                        [0, ((bar+bar_wall)/2)],
                        [length, ((rod+rod_wall)/2)],
                        [length, -((rod+rod_wall)/2)],
                        [0, -((bar+bar_wall)/2)],
                        [0,0]]);
    }
    cylinder (h=width+1, d=bar, center=true, $fn=100);
    translate([length, 0, 0]) cylinder (h=width+1, d=rod, center=true, $fn=100);
    translate([length/2, 0, 0]) cube(size=[length, slot, width+1], center=true);
    center = (bar+bar_wall+rod+rod_wall)/2 - 2*2;
    translate([length/2, 0, 0]) borehole(8,12,center);
}