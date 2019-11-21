//Massage Wand Head Cover, Chamfer tipped version
//Designed to be easier to print than the rounded version.
//CudaTox (@cudatox) 2017

/*

Copyright 2017 Cudatox

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

*/

//INSTRUCTIONS

//This is a cover for the head of the massager intended to prevent fluid ingress.
//It is designed to be printed in a flexible filament such as TPU and slipped over
//the head of the massager to prevent fluid ingress. 

//This version of the cover uses a chamfer rather than a sphere in order 
//to make it easier to print.

//Measure your massager tip and set outside_dia and head_body_length you'll also need
//to get sphere_top_scale from the script (default: 0.5)


cover_thickness = 1.2;          //Thickness of the cover
sphere_top_scale = 0.5;         //"Roundness" of the tip
overall_length = 60;            //Overall length of the massager head
outside_dia = 44.5;             //Outside diameter of massager tip. You may want to add a small factor to this if it is too tight.
chamfer_radius = 10;

added_length = cover_thickness;
sphere_tip_length = (outside_dia * sphere_top_scale)/2;
overall_cover_length = overall_length + cover_thickness;

$fs = 0.5;
echo(outside_dia);
echo(overall_length);
echo(overall_length - (outside_dia * sphere_top_scale)/2);

module chamfer_cut(major, minor){
    rotate_extrude(angle=360)
    translate([major,0,0])
    rotate([0,0,90])
    difference(){
        square([minor,minor]);
        translate([minor, minor,0])
        circle(r=minor);
    }
}

difference(){
    union(){
        translate([0,0, -sphere_tip_length])
        cylinder(d = outside_dia + cover_thickness * 2, h = overall_cover_length, center=false);
    }
    union(){
        translate([0,0, cover_thickness]){
        scale([1,1,sphere_top_scale])
            sphere(d = outside_dia, center=true);
        cylinder(d = outside_dia, h = overall_length - sphere_tip_length, center=false);
        }
        translate([0,0, -sphere_tip_length - 0.001])
            chamfer_cut(outside_dia/2 + cover_thickness, chamfer_radius);
    }
}
