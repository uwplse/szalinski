// Stool Glide
// author: fiveangle@gmail.com
// date: 2015may29
// ver: 1.0
// notes: default parameters create glide for stool made with 1/2 EMT pipe
// fixes/improvements:
//     -none
// adjust to increase/decrease polygon count at expense of processing time
$fn = 200; //

shrinkageFactor = 0.27;

legInnerDiameter = 15.7;

legOuterDiameter = 18;

sheathHeight = 10;

sheathThickness = 1.2;

padHeight = 3;

padAngle = 8.3;

innerTaper = 1;

difference() {

    translate([((legOuterDiameter + 2 * sheathThickness) + shrinkageFactor) / 2, ((legOuterDiameter + 2 * sheathThickness) + shrinkageFactor) / 2, 0]) {
        difference() {
            cylinder(d = legOuterDiameter + 2 * sheathThickness + shrinkageFactor, h = sheathHeight + padHeight + (sin(padAngle) * legOuterDiameter));
            difference() {
                cylinder(d1 = legOuterDiameter + shrinkageFactor, d2 = legOuterDiameter + shrinkageFactor, h = sheathHeight);
                cylinder(d1 = legInnerDiameter + shrinkageFactor - innerTaper, d2 = legInnerDiameter + shrinkageFactor, h = sheathHeight + padHeight);
            }
        }

    }
    translate([0, 0, sheathHeight + padHeight]) {
        rotate([padAngle, 0, 0]) {
            cube([2 * legOuterDiameter, 2 * legOuterDiameter, legOuterDiameter]);
        }
    }
}