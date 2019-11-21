/*  EasyShelves. Wall mount Generator. Enables users of the Moidules/EasyShelves
    modules to create a customized wall mount bracket. The design is simple in order to be easilly printable.
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
// Height of the piece that supports the polehanger
support_height=60;
// Width of the support at the top near the bracket
support_width_top=60;
// Width of the support at the bottom
support_width_bottom=40;
//Thickness of the wood
wood_thickness=12;
//Depth of the bracket
depth=50;
//Bracket Screws
number_of_screws = 2; //[0,1,2]
//Screw diameter
bracket_screw_diameter = 4; //[1:12]
//Top screws
top_screws = "no";
//Inner screws
inner_screws= "yes";
// Support screw position
support_screw_position = 0;
// Support screw diameter
support_screw_diameter = 6;
//countersunk height
countersunk_height = 3;

/* [Hidden] */
// The height of the bracket
hCube = wood_thickness+2*wall_thickness;
// length of the bracket 
front_side_length = support_width_top;
//Fillet of the pole hanger
fillet_size = 5;
//Fillet inside the bracket
board_fillet_size=0.5;
//Fillet between the bracket and the support
link_fillet=7;
//countersunk diameter
countersunk_diameter=support_screw_diameter*2+2;

//Main module
wallMount();


// This module creates the complete wall mount bracket. 
module wallMount() {
    difference() {
       union() {
            //The main piece
            translate([0,support_height/2-link_fillet,-support_width_top/2]) rotate([90,-90,90]) trapezoid(support_width_top, support_width_bottom, support_height-link_fillet,wall_thickness);
            // Create the bracket
            translate([0,support_height/2,-support_width_top/2]) 
                difference() {
                    bracket(inner_screws,top_screws,0);
                    translate([wall_thickness,wall_thickness,0]) 
                        boardH(0);
                }
            // Create the fillet between the bracket and the support
            translate([0,support_height/2-link_fillet,-support_width_top/2]) {
                difference() {
                    cube([link_fillet+wall_thickness,link_fillet,support_width_top]);
                    translate([link_fillet+wall_thickness,0,-0.1]) cylinder(r=link_fillet, h=support_width_top+1);
                }
            }
            // Countersunck hole
            translate([wall_thickness-0.1,support_screw_position,0]) rotate([0,90,0]) cylinder(r=countersunk_diameter/2, h=countersunk_height);
            
        }
        union() {
        // Support screw hole
        translate([-0.1,support_screw_position,0]) rotate([0,90,0]) cylinder($fn=24, r=support_screw_diameter/2, h=countersunk_height+wall_thickness+0.2);
        translate([wall_thickness-0.3,support_screw_position,0]) rotate([0,90,0]) cylinder($fn=24, r1=support_screw_diameter/2, h=countersunk_height+0.5, r2=countersunk_diameter/2-1);
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
                
                //Draw the left screws
                if( left_screws == "yes" ) {
                    width = wall_thickness;
                    height = front_side_length;
                    if( number_of_screws == 1 ) { 
                      translate([depth*2/3,wall_thickness+0.1,front_side_length/2]) rotate([90,0,0]) cylinder($fn=24, r=bracket_screw_diameter/2, h=width+2);                
                    } else if(number_of_screws == 2) {
                      translate([depth*2/3,wall_thickness+0.1,front_side_length/4]) rotate([90,0,0]) cylinder($fn=24, r=bracket_screw_diameter/2, h=width+2);                
                      translate([depth*2/3,wall_thickness+0.1,front_side_length*3/4]) rotate([90,0,0]) cylinder($fn=24, r=bracket_screw_diameter/2, h=width+2);             
                    }
                }
                //Draw the right screws
                if( right_screws == "yes" ) {
                    width = wall_thickness;
                    screw_shift = wall_thickness*2 + wood_thickness + 1;
                    height = front_side_length;
                    if( number_of_screws == 1 ) { 
                      translate([depth*2/3,screw_shift+0.1,front_side_length/2]) rotate([90,0,0]) cylinder($fn=24, r=bracket_screw_diameter/2, h=width+2);                
                    } else if(number_of_screws == 2) {
                      translate([depth*2/3,screw_shift+0.1,front_side_length/4]) rotate([90,0,0]) cylinder($fn=24, r=bracket_screw_diameter/2, h=width+2);                
                      translate([depth*2/3,screw_shift+0.1,front_side_length*3/4]) rotate([90,0,0]) cylinder($fn=24, r=bracket_screw_diameter/2, h=width+2);             
                    }
                }
           }
       }
}