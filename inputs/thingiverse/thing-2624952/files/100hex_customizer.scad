/*
//-- Customizable Basic 100hex object | 100hex and similar basic wizard
//-- 
//-- With this customizable script, by default, you can design basic hexagonal objects for
//-- the 100hex project (https://www.thingiverse.com/thing:2477471) and objects with
//-- other regular polygons as well.
//--
//-- This script was based from Customizable Lithopane
//-- (https://www.thingiverse.com/thing:74322) by Makerbot 
//-- 
//-- (c)  2017 Juan Manuel Amuedo Gonzalez - (ºLe    coleoptero(AT)google(DOT)com
//-- Customizable Basic 100hex object is licensed under the
//-- Creative Commons 3.0 - Attibution-ShareAlike license.
//-- https://creativecommons.org/licenses/by-sa/3.0/
*/

use <write/Write.scad>

// preview[view:south, tilt:top]

/* [Polygon] */

// Regular polygon sides number. (If you want to create a 100hex object don't change this parameter.)
polygon_sides=6; // [3:20]

//Side size (mm) (If you want to create a 100hex object don't change this parameter.)
size_side=60; // [10:200]

// Height (mm) (If you want to create a 100hex object don't change this parameter.)
height=2; // [1:100]

has_frame = "yes"; // [yes, no]

// Polygon frame width (mm)
polygon_frame_width=2; // [1:200]

// Interior regular polygon sides number. (If you want to create a 100hex object don't change this parameter.)
interior_polygon_sides=6; // [3:100]

/* [TemplateSurface Picture] */

// Create a separator template for 100hex object. You must set 'has_frame' property to "no".
has_separator_template = "no"; // [yes, no]

// Separator Template width (mm)  (It's a parameter for 100hex objects only)
separator_width = 15; // [2:100]

/* [Surface Picture] */

has_image = "no"; // [yes, no]

// Simple photos with many shades of light/dark areas work best. Don't forget to click the Invert Colors checkbox!
image_file = "image-surface.dat"; // [image_surface:100x100]

// Image X Scale
x_scale=1.2; // [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0, 1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9, 2.0]

// Image Y Scale
y_scale=1.2; // [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0, 1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9, 2.0]

// Image Y Scale
z_scale=1; // [0.01, 0.1, 1]

// Image X offset
x_image_offset=0.0; // [-120.0:120.0]

// Image Y offset
y_image_offset=0.0; // [-120.0:120.0]

// Image Z offset
z_image_offset=0.0; // [-120.0:120.0]


/* [Grid] */

// Object design has horizontal lines
has_horizontal_lines = "no"; // [yes, no]

// Horizontal lines number
horizontal_lines_number = 10; // [1:200]

// Horizontal line width
horizontal_line_width = 1; // [1:100]

// Horizontal line X axis angle 
horizontal_line_x_angle = 0; // [0:359]

// Horizontal line Y axis angle 
horizontal_line_y_angle = 0; // [0:359]

// Horizontal line Z axis angle 
horizontal_line_z_angle = 0; // [0:359]

// Horizontal line X offset
x_horizontal_line_offset=0.0; // [-120.0:120.0]

// Horizontal line Y offset
y_horizontal_line_offset=0.0; // [-120.0:120.0]

// Horizontal line Z offset
z_horizontal_line_offset=0.0; // [-119.9:119.9]


// Object design has horizontal lines
has_vertical_lines = "no"; // [yes, no]

// Verticral lines number
vertical_lines_number = 10; // [1:200]

// Vertical line width
vertical_line_width = 1; // [1:100]

// Vertical line X axis angle 
vertical_line_x_angle = 0;  // [0:359]

// Vertical line Y axis angle 
vertical_line_y_angle = 0;  // [0:359]

// Vertical line Z axis angle 
vertical_line_z_angle = 0;  // [0:359]

// Vertical line X offset
x_vertical_line_offset=0.0; // [-120.0:120.0]

// Vertical line Y offset
y_vertical_line_offset=0.0; // [-120.0:120.0]

// Vertical line Z offset
z_vertical_line_offset=0.0; // [-120.0:120.0]


/* [Concentric Regular Polygons] */

// Object design has concentric regular polygons
has_concentric_regular_polygons = "no"; // [yes, no]

//Concentric regular polygon sides number. 
concentric_polygon_sides=6; // [3:100]

//Concentric regular polygon sides number.
interior_concentric_polygon_sides=6; // [3:100]

// Concentric polygons number
concentric_polygons_number=10; // [1:200]

// Concentric polygon width (mm)
concentric_polygon_frame_width=4; // [1:200]

// Concentric polygon X axis angle 
concentric_polygon_x_angle = 0;  // [0:359]

// Concentric polygon Y axis angle 
concentric_polygon_y_angle = 0;  // [0:359]

// Concentric polygon Z axis angle 
concentric_polygon_z_angle = 0;  // [0:359]

// X concentric origin offset
x_concentric_origin_offset=0.0; // [-120.0:120.0]

// Y concentric origin offset
y_concentric_origin_offset=0.0; // [-120.0:120.0]

// Z concentric origin offset
z_concentric_origin_offset=0.0; // [-120.0:120.0]

/* [Spiralize] */

// Object design has spiral regular polygons
has_spiral_regular_polygons = "no"; // [yes, no]

//Spiral with regular polygon sides number. 
spiral_polygon_sides=6; // [3:100]

//Spiral with regular polygon sides number.
interior_spiral_polygon_sides=6; // [3:100]

// Spiral polygons number
spiral_polygons_number=20; // [1:200]

// Spiral polygon width (mm)
spiral_polygon_frame_width=2; // [1:200]

// Spiral polygon X axis angle 
spiral_polygon_x_angle = 0;  // [0:359]

// Spiral polygon Y axis angle 
spiral_polygon_y_angle = 0;  // [0:359]

// Spiral polygon Z axis angle 
spiral_polygon_z_angle = 60;  // [0:359]

// Slice offset
spiral_slice_offset = 2; // [1:100]

// X spiral origin offset
x_spiral_origin_offset=0.0; // [-120.0:120.0]

// Y spiral origin offset
y_spiral_origin_offset=0.0; // [-120.0:120.0]

// Z spiral origin offset
z_spiral_origin_offset=0.0; // [-120.0:120.0]


/* [Font] */

/*
// Segment position = index of element in vector (typo).
//
//                   0
//            ---------------
//         /  \      |      /  \
//        /    \ 7   | 8   /    \
//    5  /      \    |    /      \  1
//      /        \   |   / 9      \
//     /    6     \  |  /    10    \
//     -------------   -------------
//     \          /  |  \          /
//      \        /   |   \ 11     /      
//    4  \      /    |    \      /  2      
//        \    /13   | 12  \    /      
//         \  /      |      \  /      
//            ---------------
//                   3
*/


// 100hex typo design
has_font = "no";  // [yes,no]

// segment 0 
segment0 = 0; // [[0],[1]]
// segment 1
segment1 = 0; // [[0],[1]]
// segment 2
segment2 = 0; // [[0],[1]]
// segment 3
segment3 = 0; // [[0],[1]]
// segment 4
segment4 = 0; // [[0],[1]]
// segment 5
segment5 = 0; // [[0],[1]]
// segment 6
segment6 = 1; // [[0],[1]]
// segment 7
segment7 = 1; // [[0],[1]]
// segment 8
segment8 = 0; // [[0],[1]]
// segment 9
segment9 = 1; // [[0],[1]]
// segment 10
segment10 = 1; // [[0],[1]]
// segment 11
segment11 = 1; // [[0],[1]]
// segment 12
segment12 = 0; // [[0],[1]]
// segment 13
segment13 = 1; // [[0],[1]]

typo = [segment0, segment1, segment2, segment3, segment4, segment5, segment6, segment7, segment8, segment9, segment10, segment11, segment12, segment13];

/*
// Uncoment single typo definition line 

//typo = [0,0,0,0,0,0,0,0,0,0,0,0,0,0]; // none_typo
//typo = [1,1,1,1,1,1,1,1,1,1,1,1,1,1]; // test
//typo = [1,1,1,1,1,1,0,0,1,0,0,0,0,0]; // power

//typo = [1,1,1,1,1,1,0,0,0,1,0,0,0,1]; // 0
//typo = [0,0,0,0,0,0,0,0,1,0,0,0,1,0]; // 1
//typo = [1,1,0,1,1,0,1,0,0,0,1,0,0,0]; // 2
//typo = [1,1,1,1,0,0,1,0,0,0,1,0,0,0]; // 3
//typo = [0,1,1,0,0,1,1,0,0,0,1,0,0,0]; // 4
//typo = [1,0,1,1,0,1,1,0,0,0,1,0,0,0]; // 5
//typo = [1,0,1,1,1,1,1,0,0,0,1,0,0,0]; // 6
//typo = [1,0,0,0,0,0,0,0,0,1,0,0,1,0]; // 7
//typo = [1,1,1,1,1,1,1,0,0,0,1,0,0,0]; // 8
//typo = [1,1,1,1,0,1,1,0,0,0,1,0,0,0]; // 9
//typo = [1,1,1,0,1,1,1,0,0,0,1,0,0,0]; // A
//typo = [1,1,1,1,0,0,0,0,1,0,1,0,1,0]; // B
//typo = [1,0,0,1,1,1,0,0,0,0,0,0,0,0]; // C
//typo = [1,1,1,1,0,0,0,0,1,0,0,0,1,0]; // D
//typo = [1,0,0,1,1,1,1,0,0,0,1,0,0,0]; // E  //version 1
//typo = [1,0,0,1,1,1,1,0,0,0,0,0,0,0]; // E  //version 2 
//typo = [1,0,0,1,0,0,0,1,0,0,1,0,0,1]; // E  //version 3
//typo = [1,0,0,0,1,1,1,0,0,0,1,0,0,0]; // F  //version 1
//typo = [1,0,0,0,1,1,1,0,0,0,0,0,0,0]; // F  //version 2 
//typo = [1,0,0,0,0,0,0,1,0,0,1,0,0,1]; // F  //version 3

// Define other typos here
// ...typo[13] = 0; // [0:1]


// See typo aspect when:
//        has_horizontal_lines ="yes"; // [yes,no]
//        horizontal_lines_number = 40; // [1:200]
//        horizontal_line_z_angle = 60; // [0:359]
*/

/* [Text] */

text_line_1 = "";
text_line_2 = "";
text_line_3 = "";

text_size = 10;
text_vertical_position = 0; // [-80:80]

/* [Hidden] */

// Image dimensions
logox=100;
logoy=100;



module my_100hex(){


// Image surface cutting height
min_layer_height=0.4;


   union(){
       if(has_frame == "yes"){
          difference(){
            cylinder(h=height,r=size_side,$fn=polygon_sides);
            cylinder(h=height,r=size_side - polygon_frame_width,$fn=interior_polygon_sides);
          }
       } // if
       
       if(has_image == "yes" || has_horizontal_lines == "yes" || has_vertical_lines == "yes" || has_concentric_regular_polygons == "yes" || has_spiral_regular_polygons == "yes" || has_font == "yes" || 
           has_separator_template == "yes") {
          intersection(){
             cylinder(h=height,r=size_side,$fn=polygon_sides);
           
             union(){  
                if(has_image == "yes"){
                   translate([x_image_offset, y_image_offset, -min_layer_height+z_image_offset]) 
                      scale([x_scale,y_scale,z_scale]) 
                         surface(file=image_file, center=true, convexity=5);
                } // if
            
                if(has_horizontal_lines == "yes"){
                   for(i=[-size_side:(size_side*2)/horizontal_lines_number:size_side]){
                      rotate([horizontal_line_x_angle,horizontal_line_y_angle,horizontal_line_z_angle])
                         translate([-size_side+x_horizontal_line_offset,i+y_horizontal_line_offset,z_horizontal_line_offset])
                            cube([size_side*2,horizontal_line_width,height]);
                   }  // for
                } // if 
            
                if(has_vertical_lines == "yes"){
                   for(j=[-size_side:(size_side*2)/vertical_lines_number:size_side]){
                      rotate([vertical_line_x_angle,vertical_line_y_angle,vertical_line_z_angle])
                         translate([j+x_vertical_line_offset,-size_side+y_vertical_line_offset,z_vertical_line_offset])
                            cube([vertical_line_width,size_side*2,height]);
                   } // for
                } // if 

                if(has_concentric_regular_polygons == "yes"){
                     for(k=[0:(size_side*2)/concentric_polygons_number]){
                        rotate([concentric_polygon_x_angle,concentric_polygon_y_angle,concentric_polygon_z_angle])
                           translate([x_concentric_origin_offset, y_concentric_origin_offset,z_concentric_origin_offset])
                              difference(){
                                 cylinder(h=height,r=k*(size_side/concentric_polygons_number),$fn=concentric_polygon_sides);
                                 cylinder(h=height,r=k*((size_side - concentric_polygon_frame_width)/concentric_polygons_number),$fn=interior_concentric_polygon_sides);
                              }                       
                     } // for  
                } // if 

                if(has_spiral_regular_polygons == "yes"){
                   for(i=[1:spiral_polygons_number]){
                      rotate([spiral_polygon_x_angle,spiral_polygon_y_angle,spiral_polygon_z_angle*i])
                         translate([(i*spiral_polygon_frame_width+spiral_slice_offset)+x_spiral_origin_offset,y_spiral_origin_offset,z_spiral_origin_offset])
                            difference(){
                               cylinder(h=height,r=i+spiral_polygon_frame_width,$fn=spiral_polygon_sides);
                               cylinder(h=height,r=i,$fn=interior_spiral_polygon_sides);
                            }
                   } // for
                } // if
                
                if(has_font == "yes"){
                    if(typo[0] == 1) translate([0,(size_side-(size_side/6)-3),height/2]) segment();
                    if(typo[1] == 1) rotate([0,0,120]) translate([0,-(size_side-(size_side/6)-3),height/2]) segment();
                    if(typo[2] == 1) rotate([0,0,60]) translate([0,-(size_side-(size_side/6)-3),height/2]) segment();
                    if(typo[3] == 1) translate([0,-(size_side-(size_side/6)-3),height/2]) segment();
                    if(typo[4] == 1) rotate([0,0,120]) translate([0,(size_side-(size_side/6)-3),height/2]) segment();
                    if(typo[5] == 1) rotate([0,0,60]) translate([0,(size_side-(size_side/6)-3),height/2]) segment();
                    if(typo[6] == 1) translate([-(size_side/2),0,height/2]) segment();
                    if(typo[7] == 1) rotate([0,0,120]) translate([(size_side/2),0,height/2]) segment();
                    if(typo[8] == 1) rotate([0,0,90]) translate([(size_side/2),0,height/2]) segment();
                    if(typo[9] == 1) rotate([0,0,60]) translate([(size_side/2),0,height/2]) segment();
                    if(typo[10] == 1) translate([(size_side/2),0,height/2]) segment();
                    if(typo[11] == 1) rotate([0,0,-60]) translate([(size_side/2),0,height/2]) segment();
                    if(typo[12] == 1) rotate([0,0,-90]) translate([(size_side/2),0,height/2]) segment();
                    if(typo[13] == 1) rotate([0,0,-120]) translate([(size_side/2),0,height/2]) segment();
                        
                } // if 
                
                if(has_separator_template == "yes"){
                         blade(0);
                         blade(120);
                         blade(240);
                } // if 
                
             } // union
          } // intersection
       } // if
       if(text_line_1 != "" || text_line_2 != "" || text_line_3 != "") {
          intersection(){
                cylinder(h=height,r=size_side,$fn=polygon_sides);
                translate([0, text_vertical_position, height/2])
                   union() {
                      translate([0, (text_size+(text_size)/2) * 2, 0])  write(text_line_1, t=height, h=text_size, center=true);
                      translate([0, (text_size+(text_size)/2) * 1, 0])  write(text_line_2, t=height, h=text_size, center=true);
                      translate([0, (text_size+(text_size)/2) * 0, 0])  write(text_line_3, t=height, h=text_size, center=true);
                  } // union
          } // intersection
       } // if
   } // union     

}


module segment(){
    union(){
        cube([size_side-(size_side/6),size_side/6,height], center=true);
        translate([-(size_side-(size_side/6))/2,0,0])
           cylinder(h=height, r=(size_side/6)/2, $fn=100, center=true);
        translate([(size_side-(size_side/6))/2,0,0])
           cylinder(h=height, r=(size_side/6)/2, $fn=100, center=true);
    } // union    
} // module

module blade(rotate_angle){
   rotate([0,0,rotate_angle])
      translate([0,size_side/4,0])
         cube([separator_width,size_side/2,height], center=true);
}


my_100hex();

