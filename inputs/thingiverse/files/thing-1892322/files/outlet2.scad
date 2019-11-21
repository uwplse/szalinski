//include <2dplug.scad>;

inch = 25.4;
width = 2.75 * inch;
height = 4.5 * inch;
depth = 6.4;

cyl = 8;
cyld = 1;

$fn=40;
union() {
    difference() {
        intersection() {
            hull() {
                translate([cyl/2,cyl/2,0]) longsphere(cyl,depth*2);
                translate([width-cyl/2,cyl/2,0]) longsphere(cyl,depth*2);
                translate([cyl/2,height-cyl/2,0]) longsphere(cyl,depth*2);
                translate([width-cyl/2,height-cyl/2,0]) longsphere(cyl,depth*2);
            }
            cube([width, height, depth]);
        }
        translate([width/2, 8.75, 0]) screwhole(3);
        translate([width/2, height-8.75, 0]) screwhole(3);
        translate([3,3,-.1]) cube([width-6, height-6, depth-2+.2]);
//        totalHeight = 1.5*inch;
//        translate([(width)/2, (height-totalHeight)/2, 0]) linear_extrude(depth+.1) 2dplug();
//        translate([(width)/2, (height+totalHeight)/2, 0]) linear_extrude(depth+.1) 2dplug();
//        translate([width/2, height/2, 0]) screwhole(3);
        //translate([(width-33.2+cyl/2)/2,(height-66.8+cyl/2)/2,0]) largeSwitch();
        //translate([width-5,13,depth]) resize([width-10,height-26,1.5]) rotate([0,0,90]) surface("/Users/rmd/Documents/cannabis.png",invert=true);
    }
    //translate([width/2,height/2,0]) screwguide(3);
    translate([width/2, 8.75, 0]) screwguide(3);
    translate([width/2, height-8.75, 0]) screwguide(3);
    translate([15,13,depth-.1]) rotate([0,0,90]) linear_extrude(1.1) text(text="  COMMODORE BASIC V2", font="Commodore 64 Rounded:style=Regular", size=4);
    translate([22,13,depth-.1]) rotate([0,0,90]) linear_extrude(1) text(text="38912 BASIC BYTES FREE", font="Commodore 64 Rounded:style=Regular", size=4);
    translate([27,13,depth-.1]) rotate([0,0,90]) linear_extrude(1) text(text="ready.", font="Commodore 64 Rounded:style=Regular", size=4);
    translate([34,13,depth-.1]) rotate([0,0,90]) linear_extrude(1) text(text="█", font="Commodore 64 Rounded:style=Regular", size=4);
}

module longsphere(diam, height) {
    resize([diam, diam, height]) sphere(diam/2);
}

module screwhole(diam) {
    translate([0,0,depth-2-0.1]) cylinder(d1=diam, d2=diam*2, h=2+.2);
}

module screwguide(diam) {
    union() {
        difference() {
            cylinder(d=diam*2, h=depth-2+.2);
            translate([0,0,-.1]) cylinder(d=diam+.5, h=depth-2+.4);
        }
        translate([0,0,depth-4]) rotate_extrude() {
            translate([diam, 0, 0]) intersection() {
                translate([0, -2, 0]) difference() {
                    square(4);
                    translate([2,2,0]) circle(2);
                }
                square(2);
            }
        }
    }
}

module largeSwitch() {
    minkowski() {
        cube([33.2-cyl/2, 66.8-cyl/2,depth]);
        cylinder(d=cyl/2, h=cyld);
    }
}