
height = 12.0;

thickness = 2.0;
fudge = 0.1;

width = 38.5 + 16.5;
depth = 30.50 - 3.0;
 
cavity_width = width - (2 * thickness);
cavity_depth = depth - (2 * thickness);
cavity_height = height - thickness + fudge;

hole_diameter = 5.5;

slit_width = 4.0;
slit_height = 23.0 + 14.0;

// lid
difference() {
    union () {
        translate([-(width / 2.0), 20, 0.0]) cube([width, depth, 2.0]);
        translate([-(cavity_width / 2.0 - 0.25), 22, 2.0]) cube([cavity_width - 0.5, cavity_depth, 1.5]);            
    }
    translate([-10, 22 + (cavity_depth / 2), 2.5]) cylinder(h = 5 + fudge, r1 = hole_diameter, r2 =hole_diameter, center = true);
    translate([10, 22 + (cavity_depth / 2), 2.5]) cylinder(h = 5 + fudge, r1 = hole_diameter, r2 =hole_diameter, center = true);
    rotate([0, 0, 90]) translate([21.9, -17.5, 0]) cube([slit_width, slit_height, 10]);
    rotate([0, 0, 90]) translate([41.6, -17.5, 0]) cube([slit_width, slit_height, 10]);
    rotate([0, 0, 180]) translate([-27.5, -42.5, 0]) cube([8, 18, 10]);
}

// base
union() {
    translate([18, -(cavity_depth / 2.0), 2]) cube([4.0, cavity_depth, 2.0]);
    translate([-25, -(cavity_depth / 2.0), 2]) cube([4.0, cavity_depth, 2.0]);
    difference () {
        translate([0, 0, height / 2.0]) cube([width, depth, height], center = true); 
        translate([0, 0, (cavity_height / 2.0) + thickness]) cube([cavity_width, cavity_depth, cavity_height], center = true);
        rotate([0, 0, 90]) translate([7.75, -17.5, 0]) cube([slit_width, slit_height, 5]);
        rotate([0, 0, 90]) translate([-11.75, -17.5, 0]) cube([slit_width, slit_height, 5]);
        translate([-28, -6, 4]) cube([3, 12, 6]);
        translate([25, -9, 4]) cube([3, 18, 11]);
    }
}