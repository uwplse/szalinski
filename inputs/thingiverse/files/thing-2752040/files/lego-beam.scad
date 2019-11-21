/*

        Super Customizable Lego Technic Beam
        Modified by Christopher Litsinger
        January 2018
        
        
        Based on Even More Customizable Straight LEGO Technic Beam
        which in turn was Based on Customizable Straight LEGO Technic Beam
             and Parametric LEGO Technic Beam by "projunk" and "stevemedwin"
        www.thingiverse.com/thing:1119651
        Modified by Sam Kass
        November 2015

        Customizable Straight LEGO Technic Beam
        Based on Parametric LEGO Technic Beam by "projunk"
        www.thingiverse.com/thing:203935
        Modified by Steve Medwin
        January 2015
*/

$fn=50*1.0;

/*  Parameters modified for best print on 
    Steve Medwin's Replicator 2 with PLA
    from his original design,
    with Sam Kass' "Plus" measurements
*/

Pitch = 8*1.0;
Radius1 = 5.0/2;
Radius2 = 6.1/2;
Height = 7.8*1.0;
Depth = 0.85*1.0;
Width = 7.3*1.0; 
Plus_Width = 2.0*1.0;

Overhang = 0.05*1.0;


/* [Customize] */
//the "shape" of the brick to print: can be L, T, or O. You can also create straight beam by setting the y axis holes to a one character string
beamShape = "#"; // [L, T, O, #]

//The holes to print along the x-axis. This also determined the width of the peice. Use the character "o" (lowercase letter, not the number) to represent a round hole and a "+" (the plus symbol) to represent a notched axle hole. Any other character will create a blank space - I use "x" for readability.
x_axis_holes = "o+xox+o";
//The holes to print along the y-axis. This uses the same symbology as above. You should probably make sure the intersecting symbols match
y_axis_holes = "o+xox+o";
//the number of spaces you want overhanging each intersection along the x axis. This is only processed by the "#" shape
x_overhang = 1;
//the number of spaces you want overhanging each intersection along the y axis. This is only processed by the "#" shape
y_overhang = 2;

// preview[view:south, tilt:top]
// Model - Start

primaryHoles = x_axis_holes;
secondaryHoles = y_axis_holes;

module hole() {
    union() {
        //core
        cylinder(r=Radius1,h=Height);
        
        //top countersink
        translate([0,0,Height-Depth+Overhang]) 
            cylinder(r=Radius2,h=Depth);
        
        //bottom countersink
        translate([0,0,-Overhang/2]) 
            cylinder(r=Radius2,h=Depth);
        
        translate([0,0,Depth-Overhang])
            cylinder(h=(Radius2 - Radius1), r1=Radius2, r2=Radius1);
    }
}

module plus() {
    union() {
        translate([-Plus_Width/2, -Radius1, -Overhang]) 
            cube([Plus_Width, Radius1*2, Height+Overhang*2]);
        translate([-Radius1, -Plus_Width/2, -Overhang]) 
            cube([Radius1*2, Plus_Width, Height+Overhang*2]);
    }
}

module drawSolidBeam(holeCount) {
    union() {
        beamLength = (holeCount-1) * Pitch;
        cube([beamLength, Width, Height]);
        //rounded ends are nice
        translate([0, Width/2,0]) { 
            cylinder(r=Width/2, h=Height);
        }
        translate([(holeCount-1) * Pitch, Width/2,0]) {
            cylinder(r=Width/2, h=Height);
        }
    }
}

module drawHoles(holePattern) {
    for (holeIndex = [1:len(holePattern)]) {
        translate([(holeIndex-1)*Pitch, Width/2,0]) {
            if (holePattern[holeIndex-1] == "+") {
                plus();
                }
            else if (holePattern[holeIndex-1] == "o") {
                hole();
            }
        }
    }
}

module drawBeam(holePattern) {
    difference() {
        drawSolidBeam(len(holePattern));
        drawHoles(holePattern);
    }
}

module drawBeams(xHoles="+o+", yHoles="+ooo+", shape="T") {
    xLength = (len(xHoles)-1) * Pitch;
    yLength = (len(yHoles)-1) * Pitch;
    yOffset = (shape != "#") ? 0 : -y_overhang * Pitch;
    xOffset = (shape != "#") ? ((shape != "T") ? 0: -xLength/2) : -x_overhang * Pitch;
    union() {
        translate(xOffset,0,100) {
            drawBeam(xHoles);
        }
        translate([Width/2-xOffset,Width/2+yOffset,0]) {
            rotate([0,0,90]) {
                drawBeam(yHoles);
                }
            }
        if ((shape == "U") || (shape == "O") || (shape == "#")) {
            translate([0,yLength+yOffset*2, 0]) {
                drawBeam(xHoles);
            }
        }

        if ((shape == "O") || (shape == "#")) {
            translate([xLength+Width/2+xOffset, Width/2+yOffset, 0]) {
                rotate([0,0,90]) {
                    drawBeam(xHoles);
                }
            }
        } 
	}
}

drawBeams(primaryHoles,secondaryHoles,beamShape);

