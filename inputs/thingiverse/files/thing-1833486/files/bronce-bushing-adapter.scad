/**
  * Christian Völlinger 2016
  * bushing_adapter
  */

// length of the adapter, 24mm for a lm8uu
h=24;
// length of the adapter bushing
l=15.5;
// diameter of the adapter, 15mm for a lm8uu
d=15;
// diameter of the rods + clearance
dRod=9.2;
// outer diameter of the adapted bushing, I uses 12.2
id=12.2; 

// ignore this variable!
$fn=50;




difference() {
    translate([0,0,-h/2]) chamferCylinder(h, d/2, chamferHeight = 0.5, quality = 1); 
    cylinder(h = 24, r = dRod/2, center = true);
    cylinder(h = l, r = id/2, center = true);
}


/**
  *  The MIT License (MIT)
  *
  *  "Chamfers for OpenSCAD" v0.31 Copyright (c) 2016 SebiTimeWaster
  *
  *  Permission is hereby granted, free of charge, to any person obtaining a copy
  *  of this software and associated documentation files (the "Software"), to deal
  *  in the Software without restriction, including without limitation the rights
  *  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  *  copies of the Software, and to permit persons to whom the Software is
  *  furnished to do so, subject to the following conditions:
  *
  *  The above copyright notice and this permission notice shall be included in all
  *  copies or substantial portions of the Software.
  *
  *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  *  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  *  SOFTWARE.
  */

/**

/**
  * chamferCylinder returns an cylinder or cone with 45° chamfers on
  * the edges of the cylinder. The chamfers are diectly printable on
  * Fused deposition modelling (FDM) printers without support structures.
  *
  * @param  height         Height of the cylinder
  * @param  radius         Radius of the cylinder (At the bottom)
  * @param  radius2        Radius of the cylinder (At the top)
  * @param  chamferHeight  The "height" of the chamfers as seen from
  *                        one of the dimensional planes (The real
  *                        width is side c in a right angled triangle)
  * @param  angle          The radius of the visible part of a wedge
  *                        starting from the x axis counter-clockwise
  * @param  quality        A circle quality factor where 1.0 is a fairly
  *                        good quality, range from 0.0 to 2.0
  */
module chamferCylinder(height, radius, radius2=undef, chamferHeight = 1, angle = 0, quality = -1.0) {
    radius2 = (radius2 == undef) ? radius : radius2;
    module cc() {
        if(chamferHeight != 0) {
            translate([0, 0, height - abs(chamferHeight)]) cylinder(abs(chamferHeight), r1 = radius2, r2 = radius2 - chamferHeight, $fn = circleSegments(radius2, quality));
        }
        translate([0, 0, abs(chamferHeight)]) cylinder(height - abs(chamferHeight) * 2, r1 = radius, r2 = radius2, $fn = circleSegments(max(radius, radius2), quality));
        if(chamferHeight != 0) {
            cylinder(abs(chamferHeight), r1 = radius - chamferHeight, r2 = radius, $fn = circleSegments(radius, quality));
        }
    }
    module box(brim = abs(min(chamferHeight, 0)) + 1) {
        translate([-radius - brim, 0, -brim]) cube([radius * 2 + brim * 2, radius + brim, height + brim * 2]);
    }
    module hcc() {
        intersection() {
            cc();
            box();
        }
    }
    if(angle <= 0 || angle >= 360) cc();
    else {
        if(angle > 180) hcc();
        difference() {
            if(angle <= 180) hcc();
            else rotate([0, 0, 180]) hcc();
            rotate([0, 0, angle]) box(abs(min(chamferHeight, 0)) + radius);
        }
    }
}

/**
  * circleSegments calculates the number of segments needed to maintain
  * a constant circle quality.
  * If a globalSegementsQuality variable exist it will overwrite the
  * standard quality setting (1.0). Order of usage is:
  * Standard (1.0) <- globalCircleQuality <- Quality parameter
  *
  * @param  r        Radius of the circle
  * @param  quality  A quality factor, where 1.0 is a fairly good
  *                  quality, range from 0.0 to 2.0
  *
  * @return  The number of segments for the circle
  */
function circleSegments(r, quality = -1.0) = (r * PI * 4 + 40) * ((quality >= 0.0) ? quality : globalCircleQuality);

// set global quality to 1.0, can be overridden by user
globalCircleQuality = 1.0;