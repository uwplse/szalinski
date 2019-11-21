/*  EasyShelves. Pole hanger Generator. Enables users of the Moidules
    modules to create a customized pole hanger. The design is simple in order to be easilly printable.
    EasyShelves is Not Moidules.
    Copyright (C) 2015  PMorel for Thilab (www.thilab.fr)

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

//Thickness of the walls
wall_thickness=5;
//Distance between the top of the pole hanger and the bottom of the bracket
polehanger_distance_from_top=50;
//Radius of the pole that must fit in this pole hanger
pole_radius = 10;
//Height of the pole hanger
polehanger_height=70;
//Depth of the pole hanger
polehanger_depth=30;
//Solid bottom part of the pole hanger
polehanger_solid_part_bottom=10;
//Thickness of the wood
wood_thickness=12;
//Depth of the bracket
depth=50;
//Screws
number_of_screws = 2; //[0,1,2]
//Screw diameter
screw_diameter = 4; //[1:12]
//Top screws
top_screws = "no";
//Inner screws
inner_screws= "yes";

/* [Hidden] */
// The height of the bracket
hCube = wood_thickness+2*wall_thickness;
// Width of the pole hanger
polehanger_width=pole_radius*2+wall_thickness*2;
// Height of the piece that supports the pole hanger
support_height=polehanger_distance_from_top+polehanger_height+polehanger_distance_from_top/2;
// Width of the support at the top near the bracket
support_width_top=polehanger_width*2.5;
// Width of the support at the bottom
support_width_bottom=polehanger_width*2;
// length of the bracket 
front_side_length = support_width_top;
//Fillet of the pole hanger
fillet_size = 5;
//Fillet inside the bracket
board_fillet_size=0.5;
//Fillet between the bracket and the support
link_fillet=7;


//Main module
poleHanger();


// This module creates the complete pole hanger. 
module poleHanger() {
   union() {
        translate([0,-support_height/2+polehanger_height/2 + polehanger_distance_from_top , 0])
        union() {
            //The support of the hanger
            translate([-polehanger_depth/2-wall_thickness,support_height/2-link_fillet,-support_width_top/2]) rotate([90,-90,90]) trapezoid(support_width_top, support_width_bottom, support_height-link_fillet,wall_thickness);
            // Create the bracket
            translate([-polehanger_depth/2-wall_thickness,support_height/2,-support_width_top/2]) 
                difference() {
                    bracket(inner_screws,top_screws,0);
                    translate([wall_thickness,wall_thickness,0]) 
                        boardH(0);
                }
            //Add a fillet between the support and the bracket
                translate([-polehanger_depth/2-wall_thickness,support_height/2-link_fillet,-support_width_top/2]) {
                difference() {
                    cube([link_fillet+wall_thickness,link_fillet,support_width_top]);
                    translate([link_fillet+wall_thickness,0,-0.1]) cylinder(r=link_fillet, h=support_width_top+1);
                }
            }
        }        
        // Create the hanger
        createHanger();
    }
}

module createHanger() {
    sphere_radius = pole_radius*0.5;
    internal_cube_width=pole_radius*2 - 2*sphere_radius;
    difference() {

        difference() {

           union() {
               //the main cube that forms the coat_hanger
                cube([polehanger_depth,polehanger_height,polehanger_width],true);
                //the cube used to create a fillet between the main cube and the support
                translate([-polehanger_depth/2+fillet_size/2,-fillet_size/2,0]) cube([fillet_size,polehanger_height+fillet_size,polehanger_width+fillet_size*2],true);
           }
           
           union() {
               // First cylinder for the fillet
                translate([-polehanger_depth/2+fillet_size+0.1,0,polehanger_width/2+fillet_size]) rotate([90,0,0]) cylinder(r=fillet_size,h=80,center=true);
               // Second cylinder for the fillet 
                translate([-polehanger_depth/2+fillet_size+0.1,0,-polehanger_width/2-fillet_size]) rotate([90,0,0]) cylinder(r=fillet_size,h=80,center=true);
                // Third cylinder for the fillet
                translate([-polehanger_depth/2+fillet_size+0.1,-polehanger_height/2-fillet_size,0]) rotate([0,0,0]) cylinder(r=fillet_size,h=80,center=true);
               // The shape that forms the hole for the coat hanger pole
                
               translate([sphere_radius,sphere_radius/2+polehanger_solid_part_bottom,0])
                    minkowski() {
                        sphere($fn=24,r=sphere_radius);
                        cube([polehanger_depth,polehanger_height-polehanger_solid_part_bottom,internal_cube_width],true);
                    }
           }
       }
    }
}

// Create a trapezoid
module trapezoid(width_base, width_top,height,thickness) {
    linear_extrude(height = thickness) polygon(points=[[0,0],[width_base,0],[width_base-(width_base-width_top)/2,height],[(width_base-width_top)/2,height]], paths=[[0,1,2,3]]);
}

module boardH( shift ) {
    sphere_radius = board_fillet_size*wall_thickness;
    board_cube_thickness = wood_thickness-sphere_radius*2;
    translate([sphere_radius,sphere_radius,0])
        minkowski() {
            sphere($fn=32, r=sphere_radius);
            cube([depth, board_cube_thickness, front_side_length]);
            }
}

// Draw the bracket shape
module bracket( left_screws, right_screws, shift) {
        rotate([0,0,0]) {
            difference() {
                cube([depth,hCube,front_side_length]);
                
                //Draw the inner screws
                if( left_screws == "yes" ) {
                    width = wall_thickness;
                    height = front_side_length;
                    if( number_of_screws == 1 ) { 
                      translate([depth*2/3,wall_thickness+0.1,front_side_length/2]) rotate([90,0,0]) cylinder($fn=24, r=screw_diameter/2, h=width+2);                
                    } else if(number_of_screws == 2) {
                      translate([depth*2/3,wall_thickness+0.1,front_side_length/4]) rotate([90,0,0]) cylinder($fn=24, r=screw_diameter/2, h=width+2);                
                      translate([depth*2/3,wall_thickness+0.1,front_side_length*3/4]) rotate([90,0,0]) cylinder($fn=24, r=screw_diameter/2, h=width+2);             
                    }
                }
                //Draw the top screws
                if( right_screws == "yes" ) {
                    width = wall_thickness;
                    screw_shift = wall_thickness*2 + wood_thickness + 1;
                    height = front_side_length;
                    if( number_of_screws == 1 ) { 
                      translate([depth*2/3,screw_shift+0.1,front_side_length/2]) rotate([90,0,0]) cylinder($fn=24, r=screw_diameter/2, h=width+2);                
                    } else if(number_of_screws == 2) {
                      translate([depth*2/3,screw_shift+0.1,front_side_length/4]) rotate([90,0,0]) cylinder($fn=24, r=screw_diameter/2, h=width+2);                
                      translate([depth*2/3,screw_shift+0.1,front_side_length*3/4]) rotate([90,0,0]) cylinder($fn=24, r=screw_diameter/2, h=width+2);             
                    }
                }
           }
       }
}