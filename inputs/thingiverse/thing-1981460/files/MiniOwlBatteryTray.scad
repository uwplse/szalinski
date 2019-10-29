//This code uses the 'Chamfered primitives for OpenSCAD library, by SebiTimeWaster - https://github.com/SebiTimeWaster/Chamfers-for-OpenSCAD
//For the convenience of users, that code is included in this file, as noted in the lower part of this file
//For users wishing to link in the latest Chamfers-for-OpenSCAD code, the following line can be uncommented, and the included code at the bottom of this page can be commented out or removed.
//use <Chamfers-for-OpenSCAD/Chamfer.scad>;
    
$fn=50;

bolt_c_c = 43.5;        //center-to-center distance between bolts
bolt_shank_dia = 6;     //shank diameter of bolt (where bolting battery tray to quad frame) - make same diameter as bolt head for tray that will simply sit over bolt heads
bolt_head_dia = 6;      //bolt head diameter of bolt (where countersinking bolt, or making tray to sit over bolt head)
bolt_head_inset = 1;    //depth to countersink bolt head to (applicable if bolt shank and head settings are different diameters)
batt_len = 62.5;        //length of the battery, plus a mm or so of wiggle room
batt_w = 17.4;          //width of the battery, plus a mm or so of wiggle room
base_t = 2;             //thickness of the base plate
base_corner_r = 7;      //corner radius of plate external corners - must be a sensible value that works with plate width - some experimentation may be needed
finger_t = 2;           //thickness of battery holding fingers
finger_w = 8;           //width of battery holding fingers
finger_h = 7.5;         //height of battery holding fingers
hole_web_t = 3;         //width of side walls - should be at least as bit as finger_t parameter
center_hole_r = 4;      //inside corner radious of plate internal corners - must be a sensible value that works with plate width - some experimentation may be needed

difference() {
    union() {
        batt_base();
        batt_fingers();
    }
    
    bolt_holes();
    center_hole();
}



module batt_base() {
    hull() {
        translate([batt_len/2 - base_corner_r + finger_t, batt_w/2 - base_corner_r + finger_t, 0]) {
            cylinder(r=base_corner_r, h=base_t);
        }
        translate([batt_len/2 - base_corner_r + finger_t, -batt_w/2 + base_corner_r - finger_t, 0]) {
            cylinder(r=base_corner_r, h=base_t);
        }
        translate([-batt_len/2 + base_corner_r - finger_t, batt_w/2 - base_corner_r + finger_t, 0]) {
            cylinder(r=base_corner_r, h=base_t);
        }
        translate([-batt_len/2 + base_corner_r - finger_t, -batt_w/2 + base_corner_r - finger_t, 0]) {
            cylinder(r=base_corner_r, h=base_t);
        }
       }
}

module batt_fingers() {
    //end fingers
    translate([batt_len/2, -finger_w/2, base_t]) {
         chamferCube(finger_t, finger_w, finger_h, chamferHeight=1, chamferX = [0,0,1,1], chamferY = [0,1,1,0], chamferZ = [1,0,0,1]); 
    }
    translate([-batt_len/2 - finger_t, -finger_w/2, base_t]) {
        chamferCube(finger_t, finger_w, finger_h, chamferHeight=1, chamferX = [0,0,1,1], chamferY = [0,1,1,0], chamferZ = [0,1,1,0]); 
    }
    
    //side fingers
    translate([bolt_c_c/2 - bolt_shank_dia/2 - hole_web_t - finger_w, batt_w/2, base_t]) {
        chamferCube(finger_w, finger_t, finger_h, chamferHeight=1, chamferX = [0,0,1,1], chamferY = [0,1,1,0], chamferZ = [1,1,0,0]);
    }
    
    translate([bolt_c_c/2 - bolt_shank_dia/2 - hole_web_t - finger_w, -batt_w/2 - finger_t, base_t]) {
        chamferCube(finger_w, finger_t, finger_h, chamferHeight=1, chamferX = [0,0,1,1], chamferY = [0,1,1,0], chamferZ = [0,0,1,1]);
    }

    translate([-bolt_c_c/2 + bolt_shank_dia/2 + hole_web_t, batt_w/2, base_t]) {
        chamferCube(finger_w, finger_t, finger_h, chamferHeight=1, chamferX = [0,0,1,1], chamferY = [0,1,1,0], chamferZ = [1,1,0,0]);
    }
    
    translate([-bolt_c_c/2 + bolt_shank_dia/2 + hole_web_t, -batt_w/2 - finger_t, base_t]) {
        chamferCube(finger_w, finger_t, finger_h, chamferHeight=1, chamferX = [0,0,1,1], chamferY = [0,1,1,0], chamferZ = [0,0,1,1]);
    }
}

module center_hole() {
    hull() {
        translate([bolt_c_c/2 - bolt_shank_dia/2 - hole_web_t - center_hole_r, batt_w/2 - center_hole_r + finger_t - hole_web_t]) {
            cylinder(r=center_hole_r, h=base_t);
        }
        translate([bolt_c_c/2 - bolt_shank_dia/2 - hole_web_t - center_hole_r, -(batt_w/2 - center_hole_r + finger_t - hole_web_t), 0]) {
            cylinder(r=center_hole_r, h=base_t);
        }
        translate([-(bolt_c_c/2 - bolt_shank_dia/2 - hole_web_t - center_hole_r), batt_w/2 - center_hole_r + finger_t - hole_web_t, 0]) {
            cylinder(r=center_hole_r, h=base_t);
        }
        translate([-(bolt_c_c/2 - bolt_shank_dia/2 - hole_web_t - center_hole_r), -(batt_w/2 - center_hole_r + finger_t - hole_web_t), 0]) {
            cylinder(r=center_hole_r, h=base_t);
        }
    }
}

module bolt_holes() {
    translate([bolt_c_c/2, 0, 0]) {
        cylinder(d=bolt_shank_dia, h=base_t);
    }

    translate([-bolt_c_c/2, 0, 0]) {
        cylinder(d=bolt_shank_dia, h=base_t);
    }
    //bolt head holes
    translate([bolt_c_c/2, 0, base_t - bolt_head_inset]) {
        cylinder(d=bolt_head_dia, h=base_t);
    }

    translate([-bolt_c_c/2, 0,  base_t - bolt_head_inset]) {
        cylinder(d=bolt_head_dia, h=base_t);
    }
}

//vvvvvv SebiTimeWaster Chamfers-for-OpenSCAD code is included below, for end user convenience.
//       If desired, the following code can be commented out or removed, and the latest Chamfers-for-OpenSCAD code
//       can be linked in, via the 'use <Chamfers-for-OpenSCAD/Chamfer.scad>;' line near the top of this file
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
  * chamferCube returns an cube with 45° chamfers on the edges of the
  * cube. The chamfers are diectly printable on Fused deposition
  * modelling (FDM) printers without support structures.
  *
  * @param  sizeX          The size of the cube along the x axis
  * @param  sizeY          The size of the cube along the y axis
  * @param  sizeZ          The size of the cube along the z axis
  * @param  chamferHeight  The "height" of the chamfers as seen from
  *                        one of the dimensional planes (The real
  *                        width is side c in a right angled triangle)
  * @param  chamferX       Which chamfers to render along the x axis
  *                        in clockwise order starting from the zero
  *                        point, as seen from "Left view" (Ctrl + 6)
  * @param  chamferY       Which chamfers to render along the y axis
  *                        in clockwise order starting from the zero
  *                        point, as seen from "Front view" (Ctrl + 8)
  * @param  chamferZ       Which chamfers to render along the z axis
  *                        in clockwise order starting from the zero
  *                        point, as seen from "Bottom view" (Ctrl + 5)
  */
module chamferCube(sizeX, sizeY, sizeZ, chamferHeight = 1, chamferX = [1, 1, 1, 1], chamferY = [1, 1, 1, 1], chamferZ = [1, 1, 1, 1]) {
    chamferCLength = sqrt(chamferHeight * chamferHeight * 2);
    difference() {
        cube([sizeX, sizeY, sizeZ]);
        for(x = [0 : 3]) {
            chamferSide1 = min(x, 1) - floor(x / 3); // 0 1 1 0
            chamferSide2 = floor(x / 2); // 0 0 1 1
            if(chamferX[x]) {
                translate([-0.1, chamferSide1 * sizeY, -chamferHeight + chamferSide2 * sizeZ])
                rotate([45, 0, 0])
                cube([sizeX + 0.2, chamferCLength, chamferCLength]);
            }
            if(chamferY[x]) {
                translate([-chamferHeight + chamferSide2 * sizeX, -0.1, chamferSide1 * sizeZ])
                rotate([0, 45, 0])
                cube([chamferCLength, sizeY + 0.2, chamferCLength]);
            }
            if(chamferZ[x]) {
                translate([chamferSide1 * sizeX, -chamferHeight + chamferSide2 * sizeY, -0.1])
                rotate([0, 0, 45])
                cube([chamferCLength, chamferCLength, sizeZ + 0.2]);
            }
        }
    }
}

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
//^^^^^ end of SebiTimeWaster's Chamfers-for-OpenSCAD code