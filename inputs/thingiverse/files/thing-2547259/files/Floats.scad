// ****************************************************************************
// DJI Spark floats
// Author: Peter Holzwarth
// ****************************************************************************
// https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/The_OpenSCAD_Language

// What to do
menu= "Floats"; // [Floats,Painting Plate,Circle Mask,REC Mask,Smiley Mask]

// Number of floats to print
numFloats= 4; // [1:4]

// Ball radius in mm
ballRadius= 33; // [32:40]

// Radius of bow between motor and ball in mm
armRadius= 10; // [10:70]

// For the painting masks, their kind
maskKind="Hull"; // [Stamp,Hull]

// Radius of motor cover
mcWidth= 23.3/2; // don't change this w/o intention

$fn=100;

// Ball thickness
ballThick= 0.8+0; // don't change this w/o intention
wallThick= 2+0; // don't change this w/o intention

dz= 2.0+0;

Menu();

// ////////////////////////////////////////////////////////////////
// Menu for thingiverse customizer
module Menu() {
    if (menu=="Floats") {
        Floats(numFloats);
    } else if (menu=="Painting Plate") {
        PaintingPlate();
    } else if (menu=="Circle Mask") {
        MaskCircle();
    } else if (menu=="REC Mask") {
        MaskRec();
    } else {
        MaskSmiley();
    }
}

// Float();

// ////////////////////////////////////////////////////////////////
// 1..4 floats
module Floats(n) {
    c1= 2*(ballRadius +ballThick);
    // distance required for large balls
    a1= sqrt(c1*c1/2);
    c2= 2* (mcWidth +wallThick);
    // distance required for large arms
    a2= sqrt(c2*c2/2) +armRadius;
    // distance of each float from the middle
    a= max(a1, a2)+1;
    for (i= [1:n]) {
        rotate([0,0,i*90-45]) translate([a,0,0]) Float();
    }
}

// ////////////////////////////////////////////////////////////////
// one float
module Float() {
    difference() {
        union() {
            // ball
            translate([0,0,ballRadius-3]) 
                sphere(r=ballRadius+ballThick);
            // quater ring
            translate([0,0,2*ballRadius+armRadius-3-2.5-dz])
                rotate([0,90,90]) quaterRing(r=armRadius, th=5);
        }
        // make ball hollow
        translate([0,0,ballRadius-3]) sphere(r=ballRadius);
        // make quater ring hollow
        /* no - this is the weak part which breaks first
        translate([0,0,2*ballRadius+armRadius-3-2.5-dz])
            rotate([0,90,90]) quaterRing(r=armRadius, th=5-ballThick);
        */
        // flat bottom to fit print bed
        w= ballRadius+ballThick;
        translate([0,0,-5]) cube([w,w,10],center=true);
    }
    // close flattened bottom of ball
    plate(ballRadius+ballThick,3,3+wallThick);    
    // cone to motor
    translate([-armRadius,0,2*ballRadius+armRadius-3-2.5-dz]) difference() {
        cone(outerRadius2=mcWidth+wallThick-0.4, outerRadius1=5, 
                    thickness=wallThick, height=18.01);
        // spaces for LED lights
        for (a= [1:6]) {
            rotate([0,0,a*60]) translate([mcWidth-2,0,0]) 
                cylinder(r=2.5,h=50);
        }
    }
    // motor cover
    translate([-armRadius,0,2*ballRadius+armRadius-3-2.5-dz+18]) difference() {
        union() {
            cone(outerRadius1=mcWidth+wallThick-0.4, outerRadius2=mcWidth+wallThick, 
                    thickness=wallThick, height=2.01);
            translate([0,0,2]) 
                pipe(outerRadius=mcWidth+wallThick, thickness=wallThick, height=7.51);
            translate([0,0,2+7.5]) 
                cone(outerRadius2=mcWidth+wallThick-0.4, 
                    outerRadius1=mcWidth+wallThick, 
                    thickness=wallThick, height=2);
        }
        // opening for copers arm
        translate([-20,-7,2.01]) cube([20,14,1.5+8]);
    }
}

// ////////////////////////////////////////////////////////////////
// plate for painting the floats
module PaintingPlate() {
    hull() pp(2);
    pp(10);
}

module pp(h) {
    c1= 2*(ballRadius +ballThick);
    // distance required for large balls
    a1= sqrt(c1*c1/2);
    c2= 2* (mcWidth +wallThick);
    // distance required for large arms
    a2= sqrt(c2*c2/2) +armRadius;
    // distance of each float from the middle
    a= max(a1, a2)+1 -armRadius;
    for (i= [1:4]) {
        rotate([0,0,i*90+45]) translate([a,0,0]) pipe(mcWidth-0.3,1.2,h);
    }
}

// Painting mask 
module MaskCircle() {
    h= 2;
    difference() {
        translate([0,0,h/2]) cube([2*ballRadius, 2*ballRadius, h],center=true);
        // translate([0,0,-1.5]) cylinder(r=ballRadius-5,h=3);
        translate([0,0,20]) sphere(r=ballRadius);
    }
}

module MaskRec() {
    difference() {
        mask();
        translate([0,0,99]) rotate([0,180,0]) 
            linear_extrude(100)
                text("REC", size=20, valign="center", halign="center",
                    font="Arial:style=Bold");
    }
}

module mask() {
    outerRad= ballRadius+ballThick;
    difference() {
        if (maskKind=="Stamp") {
            cylinder(r=outerRad,h=outerRad);
        } else {
            difference() {
                translate([0,0,outerRad]) sphere(r=outerRad+1.6);
                // translate([0,0,ballRadius-2]) sphere(r=ballRadius-2);
                translate([0,0,-1]) cube([2*outerRad,2*outerRad,2],center=true); 
                translate([0,0,(outerRad+1.6)*1.5]) 
                    cube([2*(outerRad+1.6),2*(outerRad+1.6),
                         (outerRad+1.6)],center=true); 
            }
        }
        // translate([0,0,-1.5]) cylinder(r=ballRadius-5,h=3);
        translate([0,0,outerRad+1]) sphere(r=outerRad);
    }
}

module MaskSmiley() {
    difference() {
        mask();
        translate([0,0,-0.01]) {
            translate([10,10,0]) cylinder(r=5,h=ballRadius+5);
            translate([-10,10,0]) cylinder(r=5,h=ballRadius+5);
            // no nose cylinder(r=5,h=ballRadius+5);
            translate([0,1,0]) linear_extrude(50) projection() rotate([0,0,-135]) {
                translate([0,20,0]) sphere(r=3);
                translate([20,0,0]) sphere(r=2);
                quaterRing(r=20,th=2);
            }
        }
    }
}


module plate(r,h1,h2) {
    difference() {
        translate([0,0,r-h1]) sphere(r);
        translate([-r,-r,-h1-0.01]) {
            cube([2*r,2*r,h1+0.01]);
            translate([0,0,h2]) cube([2*r,2*r,2*r-h2+0.01]);
        }
    }
}

// ////////////////////////////////////////////////////////////////
// a pipe - a hollow cylinder
module pipe(outerRadius, thickness, height) {
    difference() {
        cylinder(h=height, r=outerRadius);
        translate([0, 0, -0.1]) 
            cylinder(h=height+0.2, r=outerRadius-thickness);
    }
}

// ////////////////////////////////////////////////////////////////
// a hollow cone
module cone(outerRadius1, outerRadius2, thickness, height) {
    difference() {
        cylinder(h=height, r1=outerRadius1, r2=outerRadius2);
        translate([0, 0, -0.1]) 
            cylinder(h=height+0.2, r1=outerRadius1-thickness, 
                                   r2=outerRadius2-thickness);
    }
}

// ////////////////////////////////////////////////////////////////
// a ring with a radius and a thickness
module ring(r, th) {
    rotate_extrude(convexity = 4, $fn = 100)
        translate([r, 0, 0])
            circle(r = th, $fn = 100);
}

module halfRing(r, th) {
    difference() {
        ring(r, th);
        translate([-r-th, -r-th, -th]) cube([2*r+2*th, r+th, 2*th]);
    }
}

module quaterRing(r, th) {
    difference() {
        halfRing(r, th);
        translate([-r-th, -0.01, -th]) cube([r+th, r+th+0.02, 2*th]);
    }
}

