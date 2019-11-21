
depth = 4;
width = 80;
heightFactor = 0.7;

thumbHoleDiameter = 10;
thumbHolePosition = 0;

thumbBedDepth     = 10;
thumbBedOffset    = 3;
thumbBedSharpness = 1.2;

wingsEndRadius = 5;

$fn = 48;

/* [Hidden] */

r2 = wingsEndRadius;
d2 = r2 * 2;

r1 = (width - d2) / 2;
d1 = r1 * 2;

module twoCircle() {
    translate([-r1, 0, -0.001]) cylinder(r = r1, h = thumbBedDepth + 0.002);
    translate([r1, 0, -0.001])  cylinder(r = r1, h = thumbBedDepth + 0.002);
}

module fourCircle() {
    translate([0, r1 + r2, 0])  twoCircle();
    translate([0, -r1 - r2, 0]) twoCircle();
}

module circles() {
    translate([0, r1 + r2, 0]) {
        translate([-r1, 0, -0.001]) cylinder(r = r1, h = thumbBedDepth + 0.002);
        translate([r1, 0, -0.001])  cylinder(r = r1, h = thumbBedDepth + 0.002);
    }
    translate([0, -r1 - r2, 0]) {
        translate([-r1, 0, -0.001]) 
            scale([thumbBedSharpness, 1, 1])
                cylinder(r = r1, h = thumbBedDepth + 0.002);
        translate([r1, 0, -0.001]) 
            scale([thumbBedSharpness, 1, 1])
                cylinder(r = r1, h = thumbBedDepth + 0.002);
    }
}

module star() {
    d = sqrt(pow(r1, 2) + pow(r1, 2));
    r = d - r1;
    x = cos(45) * r;
    y = (sin(45) * r) + r2;

    difference() {
        translate([-r1, -r1-r2, 0]) cube([d1, d1 + d2, thumbBedDepth]);
        circles();
        translate([-x, y, -0.001])
            cube([x * 2, r1, thumbBedDepth + 0.002]);
    }

    translate([-r1, 0, 0])
        cylinder(r = r2, h = thumbBedDepth);
    translate([r1, 0, 0])
        cylinder(r = r2, h = thumbBedDepth);

    translate([0, r2, 0])
        cylinder(r = r, h = thumbBedDepth);
}

difference() {
    scale([1, heightFactor, 1])
        star();

    translate([-width / 2, -thumbHoleDiameter+thumbHolePosition+thumbBedOffset, depth])
        cube([width, r1, thumbBedDepth]);

    translate([0, thumbHolePosition, -0.001])
        cylinder(r = thumbHoleDiameter, h = thumbBedDepth + 0.002);
}
