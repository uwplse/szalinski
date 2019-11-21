/*
*   Procedural Cuff
*   CudaTox, http://cudatox.ca/l/
*   @cudatox
*
*   Aug 18, 2017
*
*
* Copyright 2017 Cudatox
*
* Redistribution and use in source and binary forms, with or without modification, are permitted provided that
* the following conditions are met:
*
* 1. Redistributions of source code must retain the above copyright notice, this list of conditions and the
* following disclaimer.
*
* 2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the
* following disclaimer in the documentation and/or other materials provided with the distribution.
*
* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED
* WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
* PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY
* DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
* PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
* CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
* OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*
*
*/


//Inner diameter
inner_d = 75;
//Thickness of the cuff
thickness = 7;
//Height of the cuff
height = 25;
//Radius of the chamfer around the cuff. Cannot be greater than thickness/2
chamfer = 2;
//Gap between halves of the cuff (where the cuff opens)
cuff_gap = 0.5;
//Gap between parts of the hinge
hinge_gap = 0.5;
//height of the hinge
hinge_height = 21.5;
//Diameter of the hinge pin
pin_dia = 6.4;
pin_head = 10;
//Diameter of the lock shackle
shackle_dia = 8.4;
//Distance of the shakle hole to the cuff. This leaves some room between the outside of the cuff and the hole for the padlock so that the padlock can move freely
shackle_offset = 1;
//This is the radial thickness of the loop that retains the lock
shackle_hasp_thickness = 5;
//This is the thickness of each peice that retains the shackle
shackle_hasp_height = 8;
//Wall thickness of the loops that make the hinge
pin_hinge_thickness=4;


//These are not user-adjustable parameters
hinge_diameter = pin_dia + pin_hinge_thickness * 2;
hasp_dia = shackle_hasp_thickness*2 + shackle_dia;

module copy_mirror(vec=[0,1,0])
{
    children();
    mirror(vec) 
    children();
} 

module rounded_rect(x, y, rad){

    copy_mirror(vec=[1,0,0]) copy_mirror(vec=[0,1,0]){
            union(){
                translate([x/2 - rad, y/2 - rad, 0]) circle(rad, true, $fn=50);
                square([x/2, y/2 - rad], false);
                square([x/2 - rad, y/2], false);
                }
    }

}

module half_cyl(h, d){
    difference(){
        cylinder(h=h, d=d, center=true, $fn=50);
        translate([-d/2,0,-h/2])cube([d,d,h]);
    }
}

module hinge_triangle(a, h){
    linear_extrude(height=h, center=true)
    polygon([
        [inner_d/2 + hinge_diameter, 0],
        [(inner_d/2 + thickness) * cos(a), (inner_d/2 + thickness)* sin(a)],
        [inner_d/2, 0],
        [inner_d/2 + hinge_diameter, 0]
    ]);
    
}

union(){
    difference(){
        rotate_extrude($angle=10, $convexity=2, $angle=180, $fn=100)
            translate([thickness/2 + inner_d/2, 0, 0]) 
                rounded_rect(thickness, height, chamfer);
        union(){
            //registration
            //TODO: make this work with all sizes of cuff.
            translate([-inner_d/2 - thickness, hasp_dia/2, 0]) 
                cube([thickness * 2.01, cuff_gap, height / 2], false);
            translate([-inner_d/2 - thickness, -hasp_dia/2 -cuff_gap, -height/2]) 
                cube([thickness * 2.01, cuff_gap, height / 2], false);
            translate([-inner_d/2, 0, 0]) 
                cube([thickness * 2.01, hasp_dia + cuff_gap * 2, cuff_gap], true);
            //Cut to remove section of cuff that intersects with inside of hinge
            //TODO: OpenSCAD complains about the object not being a 2-manifold when
            //this feature is enabled.
            translate([inner_d/2+hinge_diameter/2,0,0])
                cylinder(d=pin_dia, h=height, center=true, $fn=50);
            //Cutaway parts where hinge barrell should not touch cuff.
             hinge_cut = (pin_dia + 2 * pin_hinge_thickness + 2 * hinge_gap);
            translate([inner_d/2+hinge_diameter/2,0,0]){
               
                difference(){
                    half_cyl(height, hinge_cut);
                    half_cyl(hinge_height/3 - hinge_gap, hinge_cut);
                }
                mirror([0,1,0]) half_cyl(hinge_height/3 + hinge_gap, hinge_cut);
                //Remove remaining bits of cuff over the hinge
                translate([0,0,height/2])
                    cylinder(h=(height - hinge_height), d = hinge_cut, center=true);
                translate([0,0,-height/2])
                    cylinder(h=(height - hinge_height), d = hinge_cut, center=true);
            }
            
        }
    }


    //Hinge v2
    //reinforcement


    difference(){

        union(){
            difference(){
                hinge_triangle(30, hinge_height);
                //the 1.01 multiple is a kluge to fix the object not being a 2-manifold.
                hinge_triangle(30, hinge_height/3 + hinge_gap*1.01);
            }

            mirror ([0,1,0])hinge_triangle(30, hinge_height/3 - hinge_gap);
        }
        
        //Remove bits inside the hole for the pin.
        translate([inner_d/2+hinge_diameter/2,0,0]) 
            cylinder(d=pin_dia, h=height, center=true, $fn=50);
        //Remove any bits inside the cuff
        cylinder(d=inner_d, h=height, center=true, $fn=50);
    }

    translate([inner_d/2+hinge_diameter/2,0,0]) difference(){
        union(){
        //overall length = hinge length
        hinge_barrel_dia = (pin_dia+pin_hinge_thickness*2);
        cylinder(h=hinge_height, d=(pin_dia+pin_hinge_thickness*2), center=true, $fn=50);
        }
        //Gaps between hinge sections
        translate([0,0,hinge_height/3/2]) 
            cylinder(d=(pin_dia+pin_hinge_thickness*2), h=hinge_gap, center=true, $fn=50);
        translate([0,0,-hinge_height/3/2]) 
            cylinder(d=(pin_dia+pin_hinge_thickness*2), h=hinge_gap, center=true, $fn=50);
        //Hole for pin
        cylinder(d=pin_dia, h=height, center=true, $fn=50);
    }


    //Closure
    difference(){
    translate([-inner_d/2 - thickness + shackle_hasp_thickness - hasp_dia/2 - shackle_offset,0,0])
        difference(){
            union(){
                translate([inner_d/4,0,0]) cube([inner_d/2,hasp_dia,shackle_hasp_height * 2], true);
                cylinder(d=hasp_dia, h = 2 * shackle_hasp_height, center=true, $fn=50);
            }
            union(){
                translate([inner_d/4,0,0]) cube([inner_d/2,hasp_dia,hinge_gap], true);
                cylinder(d=hasp_dia, h = cuff_gap, center=true, $fn=50);
                cylinder(d=shackle_dia, h = 2 * shackle_hasp_height, center=true, $fn=50);
            }
        };
    cylinder(d=inner_d + thickness * 2, h = height, center=true);
    }
}