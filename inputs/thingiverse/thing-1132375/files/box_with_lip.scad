$fn=50;

length = 45;
width = 30;
height = 15;
cornerRadius = 3;
thickness = 2;
lipDepth = 6;
dividerHeight = 0; //height - thickness;

translate([0, 0, 0]) {
    box(length, width, height, cornerRadius, thickness, lipDepth, dividerHeight);
}

module box(length, width, height, radius, thickness, lipDepth, dividerHeight) {
    thickness2 = 2*thickness;
    union(){
        difference() {
            boxpart(length, width, height, radius);
            translate([thickness, thickness, thickness]) 
              boxpart(length-thickness2, width-thickness2, height-thickness+0.01, radius);
        }
        if (lipDepth > 0) {
            translate([0, 0, height-thickness]) cube([width, lipDepth, thickness]);
        }
        if (dividerHeight > 0) {
            translate([0, length/2, thickness]) cube([width-thickness, thickness, dividerHeight]);
        }
    }
}

module boxpart(length, width, height, radius) {
    difference() {
        cube(size=[width, length, height]);
        // The intersection of these will give corners which are imperfect,
        // but good enough.
        rounderZ(length, width, height+0.2, radius);
        rounderXL(length, width, height, radius);
        rounderYL(length, width, height, radius);
    }
}

module rounderZ(length, width, height, radius) {
    rounder2(height, radius, width);
    translate([width, length, 0]) rotate([0, 0, 180]) rounder2(height, radius, width);
}

module rounderXL(length, width, height, radius) {
    rotate([90, 0, 90]) rounder2(width, radius, length);
}

module rounderYL(length, width, height, radius) {
    translate([0, length, 0]) rotate([90, 0, 0]) rounder2(length, radius, width);
}

module rounder2(height, radius, spacing) {
    rounder(height, radius);
    translate([spacing, 0, 0]) rotate([0, 0, 90]) rounder(height, radius);
}

module rounder(height, radius) {
    slop = 0.2;
    difference() {
        translate([-radius, -radius, 0]) cube(size=[radius*2, radius*2, height]);
        translate([radius, radius, -slop/2]) cylinder(h=height+slop, r=radius, center=false);
    }
}
