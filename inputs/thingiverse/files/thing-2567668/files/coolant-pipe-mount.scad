$fn = 100;

module countersunk_hole(x = 0, y, diameter, depth, strength) {
    translate([x, y, -1]) {
        cylinder(depth + 2, r = diameter / 2); /* bore */
    }
    translate([x, y, depth - (diameter / 2 + strength)]) {
        cylinder(diameter / 2 + strength + 1, r1 = 0, r2 = diameter / 2 + strength + 1);
    }
}

module pipeelement(sphereRadius, sphereCenterHeight, cylinderRadius,
    baseWidth, baseLength, baseHeight) {
    cylinderHeight = sphereCenterHeight - baseHeight;
    translate([0, 0, sphereCenterHeight]) {
        sphere(r = sphereRadius);
    }
    translate([0, 0, baseHeight]) {
        cylinder(cylinderHeight, r = cylinderRadius);
    }
    translate([-baseWidth / 2, -baseLength / 2, 0]) {
        cube([baseWidth, baseLength, baseHeight], center = false);
    }
}

module upper_limit(sides, height, z) {
    translate([-sides / 2, -sides / 2, z]) {
            cube([sides, sides, height], center = false);
        }
}

module mount() {
    difference() {
        pipeelement(sphereRadius = 15.3/2, sphereCenterHeight = 3 + 3 + 8.5 /* measured height */ / 2, cylinderRadius = 12/2,
            cylinderHeight = 7, baseWidth = 20, baseLength = 50, baseHeight = 3);
        countersunk_hole(y = 15, diameter = 4, depth = 3, strength = 1.5);
        countersunk_hole(y = -15, diameter = 4, depth = 3, strength = 1.5);
        upper_limit(sides = 30, height = 10, z = 3+11.5);
    }
}

mount();