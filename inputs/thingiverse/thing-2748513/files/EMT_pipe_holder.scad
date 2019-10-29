// 1/2" EMT Pipe Dry Box Filament Spool Holder Support Bracket
// author: fiveangle@gmail.com
// date: 2018jan06
// ver: 1.0
// notes: originally indended to build dry-box as in this video: https://www.youtube.com/watch?v=OY5n9q-wS7k
// fixes/improvements:
//     -none
// adjust to increase/decrease polygon count at expense of processing time
$fn = 50; //

rodDiameter = 18;

supportDepth = 20;

supportHeight = 50;

supportThickness = 3;


difference() {

    hull() {
        translate([0, 0, 0]) cylinder(d = rodDiameter + 2 * supportThickness, h = supportDepth);
        translate([0, 0, 0]) cylinder(d = rodDiameter, h = supportDepth);
        translate([supportHeight + 4 * supportThickness, 0 - (supportThickness / 2), 0]) cube([0.01, supportThickness, 0.1]);

    }
    hull() {
        translate([0, 0, 0]) cylinder(d = rodDiameter, h = supportDepth);
        translate([-supportHeight, 0, 0]) cylinder(d = rodDiameter, h = supportDepth);
    }


}

hull() {
    translate([0, 0, 0]) cylinder(d = rodDiameter + 3 * 2 * supportThickness, h = supportThickness);
    translate([supportHeight, 0, 0]) cylinder(d = rodDiameter + 2 * supportThickness, h = supportThickness);
}