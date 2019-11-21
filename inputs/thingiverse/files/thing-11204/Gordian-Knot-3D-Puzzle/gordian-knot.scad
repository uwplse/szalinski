// "Gordian Knot" 3D puzzle.
// Len Trigg <lenbok@gmail.com>
// Modelled off the designs at: http://www.cs.tau.ac.il/~efif/applications/puzzles/knot/
// If you get stuck, see the animation at: http://www.youtube.com/watch?v=xNtNQRTdxps

// Size of one "unit" in mm.
basewidth = 8;  // [5:20]
// Tolerance between parts, in tenths of a mm.
tolerance = 4; // [0:40]

width=basewidth*5;
height=basewidth*7;
tolerance1 = tolerance/10;
tolerance2 = tolerance1*2;
echo("Each piece is ",width," by ",height);

module green2d() {
    difference() {
        square([width, height]);
        translate([basewidth-tolerance1, basewidth-tolerance1]) square([basewidth+tolerance2, basewidth*5+tolerance2]);
        translate([basewidth*3-tolerance1, basewidth-tolerance1]) square([basewidth+tolerance2, basewidth*5+tolerance2]);
    }
}
module yellow2d() {
    difference() {
        square([width, height]);
        translate([basewidth-tolerance1, basewidth-tolerance1]) square([basewidth+tolerance2, basewidth*5+tolerance2]);
        translate([basewidth*3-tolerance1, basewidth-tolerance1]) square([basewidth+tolerance2, basewidth*5+tolerance2]);
        translate([-0.1, basewidth*4-tolerance1]) square([basewidth*3+0.2, basewidth+tolerance2]);
    }
}
module opiece2d() {
    difference() {
        square([width, height]);
        translate([basewidth-tolerance1, basewidth-tolerance1]) square([basewidth+tolerance2, basewidth*5+tolerance2]);
        translate([basewidth*3-tolerance1, basewidth-tolerance1]) square([basewidth+tolerance2, basewidth*5+tolerance2]);
        translate([basewidth*2-0.1, basewidth*2-tolerance1]) square([basewidth+0.2, basewidth*3+tolerance2]);
        translate([-0.1, basewidth*4-tolerance1]) square([basewidth*3+0.2, basewidth+tolerance2]);
    }
}
module red2d() {
    difference() {
        square([width, height]);
        translate([basewidth-tolerance1, basewidth-tolerance1]) square([basewidth+tolerance2, basewidth*2+tolerance2]);
        translate([basewidth-tolerance1, basewidth*4-tolerance1]) square([basewidth+tolerance2, basewidth*2+tolerance2]);
        translate([basewidth*3-tolerance1, basewidth-tolerance1]) square([basewidth+tolerance2, basewidth*5+tolerance2]);
        translate([-0.1, basewidth*4-tolerance1]) square([basewidth+0.2, basewidth+tolerance2]);
        translate([-0.1, basewidth*2-tolerance1]) square([basewidth+0.2, basewidth+tolerance2]);
        translate([basewidth*3, basewidth*2-tolerance1]) square([basewidth*2+0.2, basewidth+tolerance2]);
    }
}
module blue2d() {
    difference() {
        square([width, height]);
        translate([basewidth-tolerance1, basewidth-tolerance1]) square([basewidth+tolerance2, basewidth+tolerance2]);
        translate([basewidth-tolerance1, basewidth*3-tolerance1]) square([basewidth+tolerance2, basewidth*3+tolerance2]);
        translate([basewidth*3-tolerance1, basewidth-tolerance1]) square([basewidth+tolerance2, basewidth*5+tolerance2]);
        translate([basewidth*2-0.1, basewidth*2-tolerance1]) square([basewidth+0.2, basewidth*3+tolerance2]);
        translate([-0.1, basewidth*4-tolerance1]) square([basewidth*3+0.2, basewidth+tolerance2]);
    }
}

module green() {
    color([0,1,0]) linear_extrude(height=basewidth) green2d();
}
module yellow() {
    color([1,1,0]) linear_extrude(height=basewidth) yellow2d();
}
module orange() {
    color([1,0.5,0]) linear_extrude(height=basewidth) opiece2d();
}
module purple() {
    color([1,0,1]) linear_extrude(height=basewidth) opiece2d();
}
module red() {
    color([1,0,0]) linear_extrude(height=basewidth) red2d();
}
module blue() {
    color([0,0,1]) linear_extrude(height=basewidth) blue2d();
}

module printall() {
    translate([-width*3/2-5, 5, 0]) green();
    translate([-width*1/2, 5, 0]) yellow();
    translate([width*1/2+5, 5, 0]) orange();
    translate([-width*3/2-5, -height, 0]) red();
    translate([-width*1/2, -height, 0]) purple();
    translate([width*1/2+5, -height, 0]) blue();
}

// Roughly how it should look when assembled, but the pieces may be in different orientations
module assembled() {
    translate([0, 0, basewidth*2]) {
        translate([0, 0, 0]) red();
        translate([0, 0, basewidth*2]) yellow();
    }
    translate([basewidth*1,basewidth,0]) rotate([90,0,90]) {
        translate([0, 0, 0]) purple();
        translate([0, 0, basewidth*2]) green();
    }
    translate([-basewidth,basewidth*5,basewidth*6]) rotate([-90,90,180]) {
        translate([0, 0, 0]) orange();
        translate([0, 0, basewidth*2]) blue();
    }
}
//assembled();
//translate([-width/2,-height/2,0]) blue();
printall();

