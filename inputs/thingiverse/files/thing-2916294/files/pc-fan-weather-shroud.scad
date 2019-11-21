$fn=100;

diam = 140;
width = 125;
height = 125;
thickness = 5;

xOffset = width / 2;
yOffset = height / 2;
zOffset = - diam * 0.25;

difference() {
    union() {
        cylinder(h = diam * 0.5, d1 = diam, d2 = diam * 0.8, center = true);  
        translate([0, 0, zOffset]) cylinder(h = thickness, d = diam * 1.2, , center = true);
        translate([xOffset, yOffset, zOffset]) cylinder(h = thickness, d = 15, center = true);
        translate([-xOffset, yOffset, zOffset]) cylinder(h = thickness, d = 15, center = true);
        translate([xOffset, -yOffset, zOffset]) cylinder(h = thickness, d = 15, center = true);
        translate([-xOffset, -yOffset, zOffset]) cylinder(h = thickness, d = 15, center = true); 
    }  
    translate([0, 0, -1]) cylinder(h = diam, d1 = diam * 1.08, d2 = diam * 0.68, center = true);
    translate([diam * 0.25, 0, diam * 0.74]) rotate([0, 23, 0]) cube([diam * 1.5, diam * 1.5, diam * 1.5], center = true);
    translate([xOffset, yOffset, zOffset]) cylinder(h = thickness, d = 5, center = true);
    translate([-xOffset, yOffset, zOffset]) cylinder(h = thickness, d = 5, center = true);
    translate([xOffset, -yOffset, zOffset]) cylinder(h = thickness, d = 5, center = true);
    translate([-xOffset, -yOffset, zOffset]) cylinder(h = thickness, d = 5, center = true);
}