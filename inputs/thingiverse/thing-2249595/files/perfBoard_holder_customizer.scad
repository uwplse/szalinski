NumberOfBoards = 6; //[3:9]

/* [Magnet Size] */
MagnetWidth = 6; //diameter of the magnet in mm
MagnetHeight = 1.5; //height of the magnet in mm

/* [Hidden] */
holeRad = MagnetWidth;
zSize = MagnetHeight;
gapSize = .25 + NumberOfBoards*1.57; //number of boards times the height of each board

module base() {
    union() {
        cube([90, gapSize, 10], center = true);//big base
        difference() {
            translate([0, 0, -2.5]) cube([20, 30 + gapSize, 5], center = true);//side thing
            translate([0, 15 + gapSize/2, 0]) rotate([75, 0, 0]) cube([25, 5, 25], center = true);//cut the sides off
            translate([0, -15 -gapSize/2, 0]) rotate([-75, 0, 0]) cube([25, 5, 25], center = true);//cut the sides off
        }
        difference() {
            translate([0, 0, 5]) cube([20, gapSize, 20], center = true);//middle hump
            translate([10, 0, 17]) rotate([0, 45, 0]) cube([5, gapSize + 1, 5], center = true);//minus a corner
            translate([-10, 0, 17]) rotate([0, 45, 0]) cube([5, gapSize + 1, 5], center = true);//minus another corner
        }
    }
}
module holes() {
    cylinder(r = holeRad/2, h = zSize*2, $fn = 36, center = true);
}
module sides() {
    union() {
        difference() {
            cube([90, 5, 70], center = true);//main wall
            translate ([0, 0, 25]) cube([80, 20, 70], center = true);//minus the big hole in middle
            translate([0, 7, 35]) rotate([45, 0, 0]) cube([95, 10, 10], center = true);//minus the rounded top
            }
            translate([10, 0, 0]) rotate([0, 45, 0]) cube([2.5, 2.5, 90], center = true);//plus cross bar 1
            translate([-10, 0, 0]) rotate([0, -45, 0]) cube([2.5, 2.5, 90], center = true);//plus cross bar 2
            translate([-17, 0, 0]) rotate([0, 45, 0]) cube([2.5, 2.5, 50], center = true);//plus crossbar 3
            translate([17, 0, 0]) rotate([0, -45, 0]) cube([2.5, 2.5, 50], center = true);//plus crossbar 4
            translate([0, 0, 18]) cube([6, 2.5, 6], center = true);//plus middle cube
    }
}
module megaBase() {
    union() {
        base();
        translate([0, 2.5 +  gapSize/2, 30]) rotate([0, 0, 180]) sides();//put on the sides
        translate([0, -2.5 -gapSize/2, 30]) sides();//put on the sides
    }
}
difference() {
    megaBase();
    translate([47, 0, -5]) rotate([0, 45, 0]) cube([5, gapSize + 20, 5], center = true);//cut off corners
    translate([-47, 0, -5]) rotate([0, 45, 0]) cube([5, gapSize + 20, 5], center = true);//cut off corners
    translate ([35, 0, -5]) holes();//let's cut some holes out
    translate ([-35, 0, -5]) holes();//let's cut some holes out
    translate ([0, 7 + gapSize/2, -5]) holes();//let's cut some holes out
    translate ([0, -7 - gapSize/2, -5]) holes();//let's cut some holes out
}