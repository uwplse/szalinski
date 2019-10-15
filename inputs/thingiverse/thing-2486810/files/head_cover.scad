//Massage Wand Head Cover
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

//This script uses the same variables as the tip, so copy them here

//OR

//Measure your massager tip and override outside_dia and head_body_length

cover_thickness = 1.2;          //Thickness of the cover
tol = 0.5;                      //Extra space between massager tip and cover

mass_radius = 20;               //Clearance required by the rotating mass
shell_thickness = 2;            //Minimum thickness
motor_body_length = 32;         //Overall length of motor cavity including terminals
motor_cabling_tolerance = 3 ;   //Thickness of the shell behind the motor
motor_shaft_offset = 12;        //Extra body length to account for height of the mass.
motor_retention_thickness = 2;  //Thickness of the retention slot
sphere_top_scale = 0.5;         //"Roundness" of the tip

added_length = cover_thickness;

outside_dia = mass_radius * 2 + shell_thickness * 2 + tol;
head_body_length = max(outside_dia/2, (motor_body_length + motor_cabling_tolerance + motor_shaft_offset + motor_retention_thickness)) + added_length;

$fs = 0.5;

echo(outside_dia);

difference(){
    union(){
        //Head
        scale([1,1,sphere_top_scale])
        sphere(d = outside_dia + cover_thickness, center=true);
        cylinder(d = outside_dia + cover_thickness, h = head_body_length, center=false);
    }
    translate([0,0,cover_thickness])
    union(){
        //Head
        scale([1,1,sphere_top_scale])
        sphere(d = outside_dia, center=true);
        cylinder(d = outside_dia, h = head_body_length, center=false);
    }
}
