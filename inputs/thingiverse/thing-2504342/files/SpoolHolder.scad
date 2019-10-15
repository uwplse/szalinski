$fs = 0.01;

tableThickness = 15.4;
tableDepth = 14;
wallThickness = 3;
spoolLength = 80;
spoolRadius = 15;
spoolWallThickness = 5;
spoolRimOffset = 4;
spoolRimRadius = 10;
spoolRimThickness = 4;
totalRadius = spoolRadius + spoolRimRadius;

difference() {
    union() {
        // Top Rim
        translate([0, 0, spoolLength / 2 - spoolRimOffset])
            cylinder(h = spoolRimThickness, r = spoolRadius + spoolRimRadius, center = true);
        // Main Cylinder
        cylinder(h = spoolLength, r = spoolRadius, center = true);

        // Holder part
        translate([0, 0, -spoolLength / 2 - tableDepth / 2])
            difference() {
                difference() {
                    translate([0, 0, wallThickness])
                        cylinder(h = tableDepth, r = spoolRadius + spoolRimRadius, center = true);
                    cube([tableThickness, totalRadius * 2, tableDepth], center = true);
                }
                difference() {
                    translate([0, 0, wallThickness])
                        cylinder(h = tableDepth, r = spoolRadius + spoolRimRadius - wallThickness, center = true);
                    cube([tableThickness + 2 * wallThickness, totalRadius * 2, tableDepth], center = true);
                }
            }

        // Lower Rim
        translate([0, 0, -spoolLength / 2 + 2])
            cylinder(h = spoolRimThickness, r = spoolRadius+spoolRimRadius, center = true);
    }
    translate([0, 0, tableDepth / 4])
        cylinder(h = spoolLength - tableDepth / 2, r = spoolRadius - spoolWallThickness, center = true);
}

