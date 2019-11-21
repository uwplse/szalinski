// ****************************************************************************
// Customizable Bike Mount for Smartphone Holders
// to mount your smartphone to a bike or in general some tube
// Author: Peter Holzwarth
// ****************************************************************************
// https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/The_OpenSCAD_Language

/* [mount dimensions in mm] */
// diameter of the handlebar
tubeDiameter= 22.5;
// width of the mounting ring
width= 20;
// mounting: use screws or cable ties
mountType= "screws"; // [screws,zip ties]
// in case of using zip ties, their width
cableTiesWidth= 3;

/* [hidden] */
// plate thickness 1
th= 2;
// plate thickness 2
bt= 4;
$fn=150;

BikeMountUpper();
translate([width+4,0,0]) BikeMountLower();

module BikeMountUpper() {
    difference() {
        union() {
            difference() {
                difference() {
                    MountBase();
                    if (mountType=="screws") {
                        translate([width/2,-tubeDiameter/2-6,-0.01]) Screw(4.3, 20, 3);
                        translate([width/2,tubeDiameter/2+6,-0.01]) Screw(4.3, 20, 3);
                    }
                }
                // space for screw bolts
                translate([width/2,0,tubeDiameter/2+6]) mirror([0,0,1]) Plate_rem();
            }
            translate([width/2,0,tubeDiameter/2+6]) mirror([0,0,1]) Plate();
        }
        if (mountType!="screws") {
            translate([width/3-cableTiesWidth/2,0,0]) ring();
            translate([width*2/3-cableTiesWidth/2,0,0]) ring();
        }
    }
    
}

module BikeMountLower() {
    difference() {
        MountBase();
        if (mountType=="screws") {
            translate([width/2,-tubeDiameter/2-6,-0.01]) Screw(4.3, 20, 3, 6);
            translate([width/2,tubeDiameter/2+6,-0.01]) Screw(4.3, 20, 3, 6);
        } else {
            translate([width/3-cableTiesWidth/2,0,0]) ring();
            translate([width*2/3-cableTiesWidth/2,0,0]) ring();
        }
    }
}

// a half ring and side wings for the screws
module MountBase() {
    difference() {
        rotate([0,90,0]) emptyWheel(tubeDiameter/2+3+3,width,3); 
        translate([0,-tubeDiameter/2-3-3-0.01,-tubeDiameter/2-3-3-0.01]) 
            cube([width,tubeDiameter+4*3+0.02,tubeDiameter/2+3+3+0.01]);
    }
    if (mountType=="screws") {
        difference() {
            hull() {
                translate([width/2,-tubeDiameter/2-6,0]) buttonRound(width/2,6,2);
                translate([width/2,tubeDiameter/2+6,0]) buttonRound(width/2,6,2);
            }
            translate([-0.01,0,0]) rotate([0,90,0]) 
                cylinder(r=tubeDiameter/2+3,h=width+0.02);
        }
    }
}

module Plate() {
    difference() {
        Plate_add();
        Plate_rem();
    }
}

// the plate
module Plate_add() {
    translate([0,0,(th+bt)/2]) cubeR([26,26,th+bt],2, true);
}

// space for the screws and bolts
module Plate_rem() {
    translate([0,0,-0.01]) fourScrews(16,16,3.3,th+bt+0.02);
    translate([0,0,(th+bt)/2]) fourScrews(16,16,6.5,th+bt+10,6);
}

// ////////////////////////////////////////////////////////////////
// cube with rounded corners
module cubeR(dims, rnd=1, centerR= false) {
    translate(centerR?[-dims[0]/2,-dims[1]/2,-dims[2]/2]:[]) {
        hull() {
            translate([rnd,rnd,rnd]) sphere(r=rnd);
            translate([dims[0]-rnd,rnd,rnd]) sphere(r=rnd);
            translate([rnd,dims[1]-rnd,rnd]) sphere(r=rnd);
            translate([dims[0]-rnd,dims[1]-rnd,rnd]) sphere(r=rnd);

            translate([rnd,rnd,dims[2]-rnd]) sphere(r=rnd);
            translate([dims[0]-rnd,rnd,dims[2]-rnd]) sphere(r=rnd);
            translate([rnd,dims[1]-rnd,dims[2]-rnd]) sphere(r=rnd);
            translate([dims[0]-rnd,dims[1]-rnd,dims[2]-rnd]) sphere(r=rnd);
        }
    }
}

// four screw nuts without threads - good for metal screws
// x, y: distances of mid points
// d: screw diameter
// h: nut height
module fourScrews(x, y, d, h, fn=20) {
    translate([x/2,y/2,0]) cylinder(r=d/2,h=h,$fn=fn);
    translate([-x/2,y/2,0]) cylinder(r=d/2,h=h,$fn=fn);
    translate([x/2,-y/2,0]) cylinder(r=d/2,h=h,$fn=fn);
    translate([-x/2,-y/2,0]) cylinder(r=d/2,h=h,$fn=fn);
}

// ////////////////////////////////////////////////////////////////
// rounded button - lower part is a cylinder, upper part like a filled ring
// r= outer radius
// h= height
// rr= upper rounding
// buttonRound(20,10,2);
module buttonRound(r, h, rr) {
    hull() {
        translate([0,0,h-rr]) bikeWheel(r, rr);
        cylinder(r=r,h=h-rr);
    }
}



// like a bike wheel
// bikeWheel(20,10,2);
module bikeWheel(wr, rr) {
    translate([0,0,rr]) rotate_extrude(convexity= 2) translate([wr-rr, 0, 0]) circle(r=rr);
}

// like a car wheel
// wheel(20,10,2);
module wheel(wr, h, rr) {
    hull() {
        translate([0,0,rr]) rotate_extrude(convexity= 2) translate([wr-rr, 0, 0]) circle(r=rr);
        translate([0,0,h-rr]) rotate_extrude(convexity= 2) translate([wr-rr, 0, 0]) circle(r=rr);
    }
}

// like an empty car wheel
// emptyWheel(20,10,2);
module emptyWheel(wr, h, rr) {
    translate([0,0,rr]) rotate_extrude(convexity= 2) translate([wr-rr, 0, 0]) circle(r=rr);
    translate([0,0,rr]) difference() {
        cylinder(r=wr,h=h-2*rr);
        translate([0,0,-0.01]) cylinder(r=wr-2*rr,h=h);
    }
    translate([0,0,h-rr]) rotate_extrude(convexity= 2) translate([wr-rr, 0, 0]) circle(r=rr);
}

// simple screw model
// Screw(4, 10, 7, 6);
module Screw(m, h, th, fn= 50) {
    cylinder(r= m/2, h= h);
    translate([0,0,th]) cylinder(r= m, h= h-th, $fn= fn);
}

// ring space to fix zip ties
// translate([-20,0,0]) ring();
module ring() {
    rotate([0,90,0]) 
        difference() {
            cylinder(r= tubeDiameter/2+3+3.01,h=cableTiesWidth);
            translate([0,0,-0.01]) 
                cylinder(r= tubeDiameter/2+1+3.01,h=cableTiesWidth+0.02);
        }
}