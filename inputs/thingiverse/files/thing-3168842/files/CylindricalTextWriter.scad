// (c) 2018 Zoé Bőle / Fully Automated Technologies
// GNU GPLv3
/*
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/


//t = "OpenSCAD is AWESOME  *  ";
circularText = "Circular Reasoning Works Because ";

baseRadius = 36; 
height = 20; 
thickness = 2;

engraving  = true;
useMonospace = false;

$fn = 128;

/// ----

module cylinderWriter(t, radius, thickness, textHeight,monospace=false) {
    epsilon = 0.001;
//    typeface = monospace? "Liberation Mono:style=Bold Italic": "DINPro:style=Regular";
    typeface = monospace? "Liberation Mono:style=Bold Italic": undef;
    l = len(t);
    step = radius*2*PI/l;
    autoTextHeight = step / 0.75;
    tH = textHeight==undef?autoTextHeight:textHeight;
    intersection() {
        for(i=[0:l-1]) 
            rotate([0, 0, 360*i/l])
                rotate([90, 0, 0])
                    translate([radius-thickness, step/-2, step/2])
                        rotate([0, 90, 0])
                            linear_extrude(3*thickness)
                                text(t[i],size=tH,font=typeface, $fn=16);
        difference() {
            translate([0,0,-tH])
                cylinder(r=radius+thickness, h=2*tH,$fn=3*l);
            translate([0,0,-epsilon-tH])
                cylinder(r=radius, h=tH*2+2*epsilon,$fn=3*l);
        }
    }
}


/// main code

t = circularText;
r = baseRadius; h = height; th = thickness;
epsilon = 0.001;

difference() {
    union() {
        cylinder(r=r,h=h);
        if (!engraving) {
            translate([0,0,h/2])
                cylinderWriter(t, r-th/2, th, undef, useMonospace);
        }
    }
    union() {
        if (engraving) {
            translate([0,0,h/2])
                cylinderWriter(t, r-th/2, th, undef, useMonospace);
        }
        translate([0,0,-epsilon])
            cylinder(r=r-th, h=h+epsilon*2);
    }
}
