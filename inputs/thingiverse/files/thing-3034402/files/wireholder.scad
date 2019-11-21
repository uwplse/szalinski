// https://gist.github.com/dustin/0b48e7e7b7d318752acccaaaf4f590a5
// https://gist.github.com/dustin/80645ad3078394fbd784d2a226bc386f (multi)
$fa = 2 * 1;
$fs = 0.3 * 1;

// Smooth = 1 smooths out all the edges (and takes a lot more time).
smooth = 1; // [0:no, 1:yes]
// How many wires would you like to hold?
num_holders = 2;
// How large of a gap would you like between the holders? (negative causes overlap)
holder_gap = -5;
// How large (diameter) of a mounting plate do you want?  (0 disables)
mount_plate = 8;
// How large of a hole would you like for the mounting screws?
mount_hole_size = 1.5;

module line(points=[], width=1) {
    for(i = [1:len(points)-1]) {
        hull() {
            translate([points[i-1][0], points[i-1][1]]) circle(d=width);
            translate([points[i][0], points[i][1]]) circle(d=width);
        }
    }
}

module cableroute(length, width, thickness) {
    line([for(i = [0 : 20 : 360]) [i / (360/length), width * sin(i)]], width=thickness);
}

module wireholder(width, gap) {
    difference() {
        translate([width/2, 0, 0]) sphere(d=width);
        linear_extrude(width/2 + .1) cableroute(width, 3.5, gap);
        translate([0, -width/2, -width/2-2]) cube([width, width, width/2]);
        translate([0, -width/4, 0]) cube([width, width/2, gap+.5]);
    }
}

module smoothedHolder(width, gap) {
    if (!$preview && smooth > 0) {
        minkowski() {
            wireholder(width, gap);
            sphere(d=smooth);
        }
    } else {
        wireholder(width, gap);
    }
}

module multiHolder(width, gap) {
    for (i = [0:num_holders-1]) {
        translate([0, (width+holder_gap)*i, 0])
            smoothedHolder(width, gap);
    }
}

module mountPlate(width, mountPlateSize) {
    w = width + holder_gap;
    leftPoint = - (width / 2) - (mountPlateSize/2);
    rightPoint = (w * (num_holders-1)) + (width / 2) + (mountPlateSize / 2);
    difference() {
        hull() {
            translate([width/2, leftPoint, -2]) {
                cylinder(d=mountPlateSize, h=2);
            }
            translate([width/2, rightPoint, -2]) {
                cylinder(d=mountPlateSize, h=2);
            }
        }
        translate([width/2, leftPoint, -2.1]) {
            cylinder(d=mount_hole_size, h=3);
        }
        translate([width/2, rightPoint, -2.1]) {
            cylinder(d=mount_hole_size, h=3);
        }
    }
}

// These aren't parameters.
width = 25 + 0;
gap = 5 + 0;
multiHolder(width, gap);
if (mount_plate > 0) {
    mountPlate(width, mount_plate);
}
