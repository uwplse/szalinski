// Measure your phone length (round up to nearest mm)
length = 138;

// Measure your phone width (round up to nearest mm)
width=69;

// Measure your phone depth (round up to nearest mm)
depth=9;

module case(length,width,depth) {
    real_length = length + 5;
    real_width = width < 70 ? 80 : width + 10;
    real_depth = depth + 5.5;
    back(real_length, real_width, real_depth);
    side(real_width, real_depth);
    translate([real_length,0,0]) mirror([1,0,0]) side(real_width, real_depth);
}

module back(length, width, depth) {
    difference() {
        union() {
            hull() {
                translate([3,depth-2,width-3]) rotate([-90,0,0]) cylinder(2,3,3,$fn=20);
                translate([length-3,depth-2,width-3]) rotate([-90,0,0]) cylinder(2,3,3,$fn=20);
                translate([0,depth-2,0]) cube([length,2,1]);
            }
            translate([length/2,depth-2,width/2]) rotate([-90,0,0]) cylinder(4,40,40,$fn=50);
            translate([length/2-98/2,depth-2,0]) cube([98,4,width/2+16]);
            hull() {
                translate([length/2-10/2,3.5,0]) cube([10,depth-3,4]);
                translate([length/2-10/2,3.5,1.5]) rotate([0,90,0]) cylinder(10,1.5,1.5,$fn=20);
                translate([length/2-10/2,3.5,4-1.5]) rotate([0,90,0]) cylinder(10,1.5,1.5,$fn=20);
            }
        }
        translate([length/2,depth-3,width/2]) rotate([-90,0,0]) cylinder(7,35,35,$fn=50);
        translate([length/2-44,depth-4,width/2+11]) rotate([-90,0,0]) cylinder(7,2.5,2.5,$fn=20);
        translate([length/2-44,depth-4,width/2+11]) rotate([-90,0,0]) cylinder(2.7,5,5,$fn=20);
        translate([length/2+44,depth-4,width/2+11]) rotate([-90,0,0]) cylinder(7,2.5,2.5,$fn=20);
        translate([length/2+44,depth-4,width/2+11]) rotate([-90,0,0]) cylinder(2.7,5,5,$fn=20);

        translate([length/2-44,depth-4,width/2-13]) rotate([-90,0,0]) cylinder(7,2.5,2.5,$fn=20);
        translate([length/2-44,depth-4,width/2-13]) rotate([-90,0,0]) cylinder(2.7,5,5,$fn=20);
        translate([length/2+44,depth-4,width/2-13]) rotate([-90,0,0]) cylinder(7,2.5,2.5,$fn=20);
        translate([length/2+44,depth-4,width/2-13]) rotate([-90,0,0]) cylinder(2.7,5,5,$fn=20);
    }
}

module side(width, depth) {
    cube([6,2,width/2+6.5]);
    cube([2,depth,width/2+6.5]);
    hull() {
        translate([0,0,width/2+6]) cube([2,depth,15]);
        translate([0,0,width/2+6]) rotate([8,0,0]) cube([2,1,15]);
    }
    hull() {
        translate([1,5,0]) cube([10.5,depth-5,4]);
        translate([1,2,0]) cube([7.5,14.5,4]);
        translate([8.5,5,0]) cylinder(4,3,3,$fn=20);
    }
    translate([0,0,width/2+6]) rotate([8,0,0]) cube([6,2,15]);
}

case(length,width,depth);
