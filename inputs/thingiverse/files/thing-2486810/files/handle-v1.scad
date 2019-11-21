//Massage Wand Handle Enclosure
//Based on the simple project box by the same author
//CudaTox, 2017 (@cudatox)

/*

Copyright 2017 Cudatox

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

*/

inside_width = 32;
inside_length = 75;
inside_height = 35;
thickness = 1.6;                    //Wall thickness
radius = 1.2;                       //Fillet radius. Should not be larger than thickness
barb_dia = 15.0;                    //Diameter of the hose barb
barb_ridge = 1.2;                   //Amount the ridge on the hose barb overhangs the barb
barb_height = 20;                   //Overall height of the barb
barb_chamfer = 2;                   //Chamfer between barb and body
extra_lid_thickness = 0.5;          //Extra lid thickness above thickness. 
                                    //You may want to tweak this to account for large chamfer radius.
$fs=0.1;
outside_width = inside_width + thickness * 2;
outside_length = inside_length + thickness * 2;


module rounded_box(x,y,z,r){
    translate([r,r,r])
    minkowski(){
        cube([x-r*2,y-r*2,z-r*2]);
        sphere(r=r, $fs=0.1);
    }
}

module main_box(){
    difference(){
        difference(){
            rounded_box(outside_width, outside_length, inside_height + thickness + 2, radius);
            translate([0,0,inside_height + thickness])
            cube([outside_width, outside_length, inside_height + thickness * 2]);
        }
        translate([thickness, thickness, thickness])
        cube([inside_width, inside_length, inside_height + thickness]);
    }
}

module chamfer(major, minor){
    translate([0,0,minor])
    rotate_extrude(angle=360)
    translate([major+minor,0,0])
    rotate([0,0,180])
    difference(){
        square([minor,minor]);
        circle(r=minor);
    }
}


module barb(major_dia, barb_overhang, barb_height, height, barb_chamfer){

    cylinder(h=height, d=major_dia, center=false);
    translate([0,0,height - barb_height])
    cylinder(h=barb_height, d1=major_dia+2 * barb_overhang, d2=major_dia, center=false);
    chamfer(major_dia/2, barb_chamfer);
}

module lid(){
//Lid.
difference(){
    rounded_box(outside_width, outside_length, thickness * 4, radius);
    translate([0,0, thickness + extra_lid_thickness])
        cube([outside_width, outside_length, inside_height + thickness * 4]);
}
//Lip
lip_tol = 0.5;
lip_width = inside_width - lip_tol;
lip_length = inside_length - lip_tol;
translate([(outside_width - lip_width)/2,(outside_length - lip_length)/2, thickness + 0.5])
    difference(){
        cube([lip_width, lip_length, 1.6]);
        translate([thickness, thickness, 0])
            cube([lip_width-thickness*2, lip_length-thickness*2, 1.6]);
    }

}

difference(){
    union(){
    main_box();
    translate([outside_width/2,0,inside_height/2 + thickness])
        rotate([90,0,0])
            barb(barb_dia, barb_ridge, 5, barb_height, barb_chamfer);
    }
    translate([outside_width/2,thickness,inside_height/2 + thickness])
        rotate([90,0,0])
            cylinder(h = 30, d=4, center=false);
}


translate([-outside_width-2,0,0])
    lid();


