width = 17.6;
height = 33.5;
length = 16.3;
poleWidth = 9;
axisMetric = 3.2;
tensorMetric = 4.2;
tensorHead = 7;
tensorHeadLength = 3;
assWeight = 8;

protoRadius = 1.5;
protoThicknes = 0.2;

radius = width / 2;
cubeHeigh = height - radius;
lateralThicknes = (length - poleWidth) / 2;

$fn = 25;

module nut(metric, length) {
    cylinder(r=metric/sqrt(3), h=length, $fn=6);
}


rotate([0, -90, 0])
difference() {
    union() {
        cube([width, cubeHeigh, length]);
        translate([radius, cubeHeigh, 0])
            cylinder(h=length, r=radius);
    }

    difference() {
        translate([0, assWeight, lateralThicknes])
            cube([width, height, poleWidth]);

        translate([radius, cubeHeigh, lateralThicknes])
            cylinder(h=protoThicknes, d=axisMetric+(2*protoRadius));

        translate([radius, cubeHeigh, length-lateralThicknes-protoThicknes])
            cylinder(h=protoThicknes, d=axisMetric+(2*protoRadius));
    }

    translate([radius, cubeHeigh, 0])
        cylinder(h=length, d=axisMetric);

    translate([width/2, assWeight+1, length/2])
        rotate([90, 0, 0])
            nut(metric = tensorHead, length=tensorHeadLength+1);

    translate([width/2, assWeight, length/2])
        rotate([90, 0, 0])
            cylinder(h=assWeight, d=tensorMetric);
}