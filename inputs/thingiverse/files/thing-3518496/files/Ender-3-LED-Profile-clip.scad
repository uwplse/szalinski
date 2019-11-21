// Length of LED Section 
length=100; // [5:200]

width=13.66+0.00;
$fn=20+0;

translate([0, length/2-1, 0]) { endarch(); }
translate([0, 0-(length/2-1), 0]) { endarch(); }
difference() {
    cube([width, length, 1], center=true);
    cube([width-4, length-4, 2], center=true);
}

module endarch() {
    rotate([90,0,0]) {
            resize(newsize=[width, 2, 2]) {
            difference() {
                cylinder(h=1, r=5, center=true);
                translate([0, -25,0]) cube(50, center=true);
            }
        }
    }
}