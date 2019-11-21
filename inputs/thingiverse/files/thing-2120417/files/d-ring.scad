/*
*   D Ring mounting bracket.
*   CudaTox, http://cudatox.ca/l/
*   @cudatox
*
*   Feb 17, 2017
*
*   A simple, procedural mounting bracket that can be used to affix a D Ring to many
*   different surfaces. 
*
*   This software and 3D model(s) are experimental and are provided for educational 
*   purposes only. 
*
*   Use of this software, any of its derivatives, or use of any of the models or 
*   parts provided with or created using this software is done at your own risk. 
*
*   DO NOT use this part for securing loads. DO NOT use this part in applications 
*   that may result in property damage, injury or death. NOT FOR CLIMBING USE.
*
*/


OD = 15;                        //Diameter of the outer cylindrical part of the bracket.
                                //This should be larger than ID

ID = 3.5;                       //Inner diameter of the bracket

length = 21;                    //width of the bracket, this should be smaller 
                                //than the width of the D ring.
                                
thickness = 6;                  //Thickness of the flat parts of the bracket

drill_centers = 20;             //Distance between the mounting holes

drill_dia = 4.6;                //Diameter of the mounting holes

head_dia = 12;                  //Cutaway for the head of the screw or washer. Zero to disable.

head_inset = 0.1;               //Inset distance for the head of the screw, 
                                //if head cutaway enabled.

$fn = 64;                       //Resolution

difference(){
    
    union(){
        hull(){
            translate([0,ID/2,0])
                cylinder(length, OD/2, OD/2,  true);
            translate([0,-ID/2,0])
                cylinder(length, OD/2, OD/2,  true);
        }
        rotate([90,0,0])
            difference(){

                hull(){
                    translate([-drill_centers/2,0,0])
                        cylinder(thickness * 2, length/2, length/2, true);
                    translate([drill_centers/2,0,0])
                        cylinder(thickness * 2, length/2, length/2, true);
                }
                
                union(){
                    translate([-drill_centers/2,0,0])
                        cylinder(thickness * 2, drill_dia/2, drill_dia/2, true);
                    translate([drill_centers/2,0,0])
                        cylinder(thickness * 2, drill_dia/2, drill_dia/2, true);
                }
            }
    }
    
    union(){
        //Cuts with a small factor added to avoid manifold issues.
        hull(){
        translate([0,ID/2,0])
            cylinder(length + 0.1, ID/2, ID/2, true);
        translate([0,-ID/2,0])
            cylinder(length + 0.1, ID/2, ID/2, true);
        }
        
        rotate([-90,0,0]) translate([0,0,thickness-head_inset])
        if (head_dia > 0){
            translate([-drill_centers/2,0,0])
                cylinder(thickness * 2, head_dia/2, head_dia/2, false);
            translate([drill_centers/2,0,0])
                cylinder(thickness * 2, head_dia/2, head_dia/2, false);
        }
        
        translate([0,-max(OD, thickness)/2,0])
            cube([drill_centers + 2 * length, max(OD, thickness) + 0.1, length + 0.1], true);
    }
    
}