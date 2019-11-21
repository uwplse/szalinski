/*
*   Configurable Harness Center Ring
*   CudaTox, http://cudatox.ca/l/
*   @cudatox
*
*   Feb 21, 2017
*
*   A procedural strap ring for use in novelty body harnesses with text.
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
* 
*   This software and files are licensed under the Creative Commons 
*   Attribution-NonCommercial 3.0 license.
*   
*
*/


belt_width = 25;        //Width of the belt you wish to use
belt_thickness = 3;     //Width of the slots. 
n_sides = 5;            //Number of sides on the ring. This script uses a distance
                        //approximation that only works well if this is greater than three.
thickness = 5;          //Thickness of the plastic on all sides
outside_radius = 6;     //Radius of the filleted corners.
height = 4;             //Extrusion height. this is the actual thickness of the object.

font_size = 7;
font_text = "SAMPLE";
font = "Arial";
text_thickness = 1;     //How far the text sticks out above the surface
text_rotation = -90;

$fn = 20;

module rounded_polygon(n_sides, radius, hypotenuse, height){
    //Actual side length does not include the outside radius.

    hull()
    for( i = [0 : n_sides] ){
        translate([hypotenuse * cos(360 * i/n_sides),  hypotenuse * sin(360 * i/n_sides), 0])
            cylinder(h=height, r = radius, center = true);
    }

}

module belt_slot(belt_width, belt_thickness, height){

        hull(){
            translate([0,-belt_width/2,0])
                cylinder(h=height, r = belt_thickness/2, center = true);
            translate([0,belt_width/2,0])
                cylinder(h=height, r = belt_thickness/2, center = true);
        }

}

module belt_slots(n_sides, distance, thickness, belt_width, belt_thickness, height){
    for (i = [0 : n_sides]){
        rotate([0, 0, i * (360 / n_sides) + 180/n_sides])
            translate([distance,0,0])
                belt_slot(belt_width, belt_thickness, height);
    }
}


//inside side virtual length. This is used to calculate how far the belt slots need to be offset.
side_l = belt_width + belt_thickness + thickness;
//Distance to offset the slots.
distance = side_l/2 / tan(180/n_sides);
echo(side_l);
echo(distance);
edge_distance = distance + belt_thickness / 2 + thickness - outside_radius;
hypot = edge_distance / cos(180/n_sides);

difference(){
    union(){
        rounded_polygon(n_sides, outside_radius, hypot, height);
        rotate([0,0,text_rotation])
        color("orange")
        linear_extrude(text_thickness + thickness/2)
            text(font_text, font_size, font, halign="center", valign="center");
    }
    belt_slots(n_sides, distance, belt_width, belt_width, belt_thickness, height);
}