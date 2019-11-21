// ****************************************************************************
// RC Car Paddles
// Author: Peter Holzwarth
// ****************************************************************************
// https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/The_OpenSCAD_Language

Menu();
// OnePaddle();
// FourRims();
// RimGlueSupport();
// WheelRim();
// WheelTire();

/* [What to show/ print] */

// What to do
menu= "Paddle"; // [Paddle,Tire,Rim,Four Rims,Rim Gluing Support]

/* [Wheel general settings] */

// Number of floats to print
// numWheels= 4; // [1:4] takes too long to render

// Wheel radius in mm without paddles
wheelRadius= 36; // 40 is radius of traxxas 1:16 std wheels

// Tire thickness
wheelThick= 14;

// Width of the wheel
wheelWidth= 48; // 48 is original wheels

// Number of paddle elements
numPaddleElements= 10;

// Number of spikes in the rim
numWheelSpikes= 5;

/* [Propulsion Connector] */

// Propulsion screw diameter
propScrewDia= 4;

// Propulsion connector
propConnector= "Hexagon"; // [Hexagon,Cross]

// Propulsion hexagon shape diameter
propHexDia= 12;

// Propulsion cross shape diameter
propCrossDia= 8;

// Propulsion cross shape thickness
propCrossThick= 2.3;

/* [Additional Settings] */

// Thickness of the paddles
paddleThick= 6;

// Height of the paddles
paddleHeight= 5;

// 0: don't fill the rim, <>0: fill it
filledRim=0;

// Paddle rounding up
r1= 10;
// Paddle rounding radius
r2= 15;

// For two part paddles: space between tire and rim, as neede for glue
spc=0.3;
// Precision of roundings, high values cause high computation times
$fn=40;


// ////////////////////////////////////////////////////////////////
// derived parameters for the wheels
// used in Wheel() and in WheelFixtureInside()
// ////////////////////////////////////////////////////////////////

// hex connector: outer radius of the hexagon space for the propulsion nut
ro= propHexDia/2/cos(30) +0.4; // add some space for printing tolerance
echo(ro);
fixR= filledRim!=0 ? wheelRadius-wheelThick-spc-0.1 : ro+2;
echo(fixR);

// cross connector: diameter of the cylinder around the cross
fixRc= filledRim!=0 ? wheelRadius-wheelThick-spc-0.1 : propCrossDia/2+3;


// ////////////////////////////////////////////////////////////////
// Menu for thingiverse customizer
// ////////////////////////////////////////////////////////////////
module Menu() {
    if (menu=="Paddle") {
        OnePaddle();
    } else if (menu=="Tire") {
        WheelTire();
    } else if (menu=="Rim") {
        WheelRim();
    } else if (menu=="Four Rims") {
        FourRims();
    } else { // "Rim Gluing Support"
        RimGlueSupport();
    }
}

// ////////////////////////////////////////////////////////////////
// Four rims for the two part paddles, to be printed at once
// ////////////////////////////////////////////////////////////////
module FourRims() {
    d= 2*(wheelRadius-wheelThick);
    WheelRim();
    translate([d,0,0]) WheelRim();
    translate([0,d,0]) WheelRim();
    translate([d,d,0]) WheelRim();
}

// ////////////////////////////////////////////////////////////////
// One rim for the two part paddles
// ////////////////////////////////////////////////////////////////
module WheelRim() {
    intersection() {
        // a complete wheel
        Wheel();
        // cut away the tire, only leave the rim
        cylinder(r=wheelRadius-wheelThick-spc-0.01,h=wheelWidth+1);
    }
}

// ////////////////////////////////////////////////////////////////
// Gluing support for the rims, give them the correct height in the wheel
// ////////////////////////////////////////////////////////////////
module RimGlueSupport() {
    difference() {
        // basic pipe shape
        pipe(wheelRadius-wheelThick-spc-0.01,5,wheelWidth/2-2);
        // space for the rim at the right height
        translate([0,0,(wheelWidth-wheelThick)/2]) 
            wheelShape(wheelRadius-wheelThick/4, wheelThick, wheelWidth/2);
    }
    // handle to remove the support easily
    translate([-(wheelRadius-wheelThick-spc-2),-2.5,0]) cube([2*(wheelRadius-wheelThick-spc-2),5,5]);
}

// ////////////////////////////////////////////////////////////////
// One paddle tire, without the rim
// ////////////////////////////////////////////////////////////////
module WheelTire() {
    difference() {
        // the complete paddle
        OnePaddle();
        // space for the rim
        cylinder(r=wheelRadius-wheelThick-0.01,h=wheelWidth+1);
    }
}


// ////////////////////////////////////////////////////////////////
// Multiple paddles - doing four takes very long to render
// ////////////////////////////////////////////////////////////////
module Paddles(numWheels) {
    paddleDia= 2*(wheelRadius+paddleHeight)+paddleThick;
    for (a=[1:1:numWheels/2]) {
        translate([0,(a-1)*paddleDia+1,0]) {
            // one left
            OnePaddle();
            /// one right
            translate([paddleDia+1,0,0]) mirror([0,1,0]) OnePaddle();
        }
    }
}

// ////////////////////////////////////////////////////////////////
// One complete paddle
// ////////////////////////////////////////////////////////////////
module OnePaddle() {
    // the basic wheel
    Wheel();
    wr= wheelRadius-wheelThick/2;
    d= sqrt(wr*wr-r2*r2);
    // the paddle wings surrounding it
    for (a=[0:360/numPaddleElements:359]) {
        rotate([0,0,a]) {
            translate([d,-r2,wheelWidth]) {
                rotate([0,90,0]) Paddle();
            }
        }
    }
}

// ////////////////////////////////////////////////////////////////
// One complete wheel, but without the paddle wings
// ////////////////////////////////////////////////////////////////
module Wheel() {
    // outer wheel
    color("darkgray") wheelShape(wheelRadius, wheelThick, wheelWidth);
    // inner wheel
    color("silver") translate([0,0,(wheelWidth-wheelThick)/2]) 
        wheelShape(wheelRadius-wheelThick/4, wheelThick, wheelWidth/2);

    translate([0,0,wheelWidth-3-15]) {
        // wfor= 6; // wheel fixture outer radius
        wfor= propConnector=="Hexagon" ? fixR : fixRc;
        difference() {
             // wheel fixture (inner ring outer side)
            cylinder(r=wfor,h=3);
            // space for propulsion screw
            translate([0,0,-0.01]) cylinder(r=(propScrewDia+0.4)/2,h=3.02);
        }

        // wheel spokes
        wheelSpikesAngle= 360/numWheelSpikes;
        sa= wfor*sin(wheelSpikesAngle/2);
        difference() {
            for (a=[0:wheelSpikesAngle:359]) {
                rotate([0,0,a]) hull() {
                    // inner square for hull
                    translate([sa+1,-sa-0.5,-2.5]) cube([0.1,2*sa+1,3+2.5]);
                    // outer square for hull
                    translate([wheelRadius-wheelThick/4-1,-(sa+2),-10]) cube([1,(2*sa+2),14]);
                }
            }
            // translate([0,0,-4-5]) cylinder(r=(14+4)/2,h=4+5);
            translate([0,0,-4-5]) cylinder(r=wfor,h=4+5);
        }
        // wheel fixture inner ring
        translate([0,0,-4]) WheelFixtureInside();
    }
}

// Ring with hexagon or cross inside to fit the propulsion connector from the car
module WheelFixtureInside() {
    if (propConnector=="Hexagon") {
        difference() {
            // ring
            cylinder(r=fixR,h=5);
            // space for suspension bolt
            translate([0,0,-0.01]) cylinder(r=ro,h=5.02,$fn=6);
        }
    } else { // Cross
        difference() {
            // ring
            cylinder(r=fixRc,h=5);
            // space for suspension bolt
            translate([0,0,-0.01]) {
                // space for screw
                cylinder(r=(propScrewDia+0.4)/2,h=5.02);
                // space for cross shape
                translate([-(propCrossDia+0.4)/2,-(propCrossThick+0.4)/2,0]) 
                    cube([propCrossDia+0.4,propCrossThick+0.4,5.02]);
                translate([-(propCrossThick+0.4)/2,-(propCrossDia+0.4)/2,0]) 
                    cube([propCrossThick+0.4,propCrossDia+0.4,5.02]);
            }
        }
    }
}

// Basic wheel shape
module wheelShape(r, thick, width) {
    translate([0,0,thick/2]) rotate_extrude(convexity=4,$fn=90)
        translate([r-thick/2, 0, 0])
            rotate([0,0,90]) longhole(thick/2,width,0);
}

// log hole shape
// longhole(2.5,10,30);
module longhole(r,w,h) {
    circle(r=r);
    translate([0,-r,0]) square([w-2*r,2*r]);
    translate([w-2*r,0,0]) circle(r=r);
}


// ////////////////////////////////////////////////////////////////
// a pipe - a hollow cylinder
// pipe(20,5,20);
module pipe(outerRadius, thickness, height) {
    difference() {
        cylinder(h=height, r=outerRadius);
        translate([0, 0, -0.1]) 
            cylinder(h=height+0.2, r=outerRadius-thickness);
    }
}

// one paddle wing
// Paddle();
module Paddle() {
    // left paddle half
    translate([r2+paddleThick/2,0,0]) paddleHalf(r1,r2,paddleThick/2,paddleHeight);
    // middle paddle piece
    translate([r2+paddleThick/2,r2,0]) {
        translate([0,0,10+paddleHeight]) rotate([0,90,0]) cylinder(r=paddleThick/2,h=wheelWidth-(2*r2+paddleThick));
        translate([0,-paddleThick/2,0]) cube([wheelWidth-(2*r2+paddleThick),paddleThick,10+paddleHeight]);
    }
    // right paddle half
    translate([wheelWidth-(r2+paddleThick/2),0,0]) mirror([1,0,0]) paddleHalf(r1,r2,paddleThick/2,paddleHeight);
}

// left/ right side of the paddle wing
// paddleHalf(r1,r2,paddleThick/2,paddleHeight);
module paddleHalf(r1,r2,th,hadd) {
    for (a=[-90:1:0]) {
        translate([r2*sin(a),r2*cos(a), r1*cos(a)+hadd]) sphere(r=th);
        translate([r2*sin(a),r2*cos(a), 0]) cylinder(r=th,h=r1*cos(a)+hadd);
    }
}

