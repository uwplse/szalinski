//Massage Wand Head
//CudaTox (@cudatox) 2017

/*

Copyright 2017 Cudatox

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

*/


motor_dia = 20.8 + 1.5;         //Motor cavity diameter
motor_body_length = 32;         //Overall length of motor cavity including terminals
motor_cabling_tolerance = 3 ;   //Thickness of the shell behind the motor
motor_cabling_dia = 4;          //Diameter of the hole for the cables
motor_shaft_offset = 12;        //Extra body length to account for height of the mass.
motor_retention_thickness = 2;  //Thickness of the retention slot
mass_radius = 20;               //Clearance required by the rotating mass
mass_shaft_dia = 8;             //This is the diameter that the CUTOUT needs to be.
shell_thickness = 2;            //Minimum thickness
sphere_top_scale = 0.5;         //"Roundness" of the tip
barb_dia = 15.0;                //Diameter of the hose barb
barb_ridge = 1.2;               //Amount the ridge on the hose barb overhangs the barb
barb_height = 15;               //Overall height of the barb
barb_chamfer = 3;               //Chamfer between barb and body
lower_screw_offset = 3;         //Extra offset for the lower screws from the barb side
top = false;                    //Which half should be generated?
$fs = 0.1;                      //Resolution

M3_NUT_HEAD = 6.6; 
M3_SCREW_DIA = 3.2;
M3_SCREW_HEAD_CUTOUT = 7;

outside_dia = mass_radius * 2 + shell_thickness * 2;
inside_dia = mass_radius * 2;

head_body_length = max(outside_dia/2, (motor_body_length + motor_cabling_tolerance + motor_shaft_offset + motor_retention_thickness));

overall_length = (outside_dia * sphere_top_scale)/2 + head_body_length + barb_height;

echo(head_body_length);
echo("<b>Overall length: </b>", overall_length);
echo("<b>Overall length of main body (use this to generate a cover): </b>", overall_length - barb_height);
echo("<b>Sphere top scaling: </b>", sphere_top_scale);
echo("<b>Outside diameter: </b>", outside_dia);

module screw_cutaway(thickness, nut_retention = false){
    cylinder(d = M3_SCREW_DIA, h = thickness * 1.1, center=false);
    translate([0,0,thickness])
    if (nut_retention == false){
        cylinder(d = M3_SCREW_HEAD_CUTOUT, h = outside_dia, center=false);
    }else{
        cylinder(d = M3_NUT_HEAD, h = outside_dia, center=false, $fn=6);
    }
}

module screws(nut_retention=false){
    
    translate([0,motor_dia/2 + shell_thickness + M3_SCREW_HEAD_CUTOUT/2, motor_shaft_offset + motor_retention_thickness + shell_thickness + M3_SCREW_HEAD_CUTOUT/2])
            rotate([0,-90,0])
                screw_cutaway(2,nut_retention);
    
    translate([0,-motor_dia/2 - shell_thickness - M3_SCREW_HEAD_CUTOUT/2, motor_shaft_offset + motor_retention_thickness + shell_thickness + M3_SCREW_HEAD_CUTOUT/2])
            rotate([0,-90,0])
                screw_cutaway(2,nut_retention);
    
    translate([0,-motor_dia/2 - shell_thickness - M3_SCREW_HEAD_CUTOUT/2, head_body_length - M3_SCREW_HEAD_CUTOUT/2 - shell_thickness- lower_screw_offset])
            rotate([0,-90,0])
                screw_cutaway(2,nut_retention);

    translate([0,motor_dia/2 + shell_thickness + M3_SCREW_HEAD_CUTOUT/2, head_body_length - M3_SCREW_HEAD_CUTOUT/2 - shell_thickness - lower_screw_offset])
            rotate([0,-90,0])
                screw_cutaway(2,nut_retention);
    
}

module chamfer_cut(major, minor){
    rotate_extrude(angle=360)
    translate([major,0,0])
    rotate([0,0,180])
    difference(){
        square([minor,minor]);
        translate([minor, minor,0])
        circle(r=minor);
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

module main_body (top=false){
    difference(){
        difference(){
            union(){
                //Head
                scale([1,1,sphere_top_scale])
                sphere(d = outside_dia, center=true);
                cylinder(d = outside_dia, h = head_body_length, center=false);
                //Hose barb
                translate([0,0,head_body_length])
                barb(barb_dia, barb_ridge, barb_height/3, barb_height, barb_chamfer);
            }

            //internal cutout for rotating mass
            union(){
                cylinder(d = inside_dia, h = motor_shaft_offset, center = false);
                translate([0,-outside_dia/2,-outside_dia/2])
                cube([outside_dia/2, outside_dia, head_body_length + outside_dia/2 + barb_height], center = false);
            }
        }
        //Motor and shaft cutouts
        union(){
            //Motor cutout
            translate([0,0,motor_shaft_offset + motor_retention_thickness])
            cylinder(d = motor_dia, h = motor_body_length, center = false);
            //Shaft cutout
            translate([0,0,motor_shaft_offset])
            cylinder(d = mass_shaft_dia, h = motor_body_length, center = false);
            //Cabling cutout
            translate([0,0,head_body_length - motor_cabling_tolerance])
            cylinder(d = motor_cabling_dia, h = motor_body_length, center = false);
            //Screws.
            screws(top);
            //chamfer
            translate([0,0,head_body_length])
            chamfer_cut(outside_dia/2,2);
        }
        
    }
}

main_body(top);