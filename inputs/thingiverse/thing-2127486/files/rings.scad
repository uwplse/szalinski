/*
*   Configurable Harness Center Ring
*   CudaTox, http://cudatox.ca/l/
*   @cudatox
*
*   Feb 21, 2017
*
*   A procedural strap ring for use in novelty body.
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

belt_width = 26;        //Width of the belt you wish to use
n_sides = 5;            //Number of sides on the ring
thickness = 4;          //Thickness of the plastic on all sides
inside_radius = 3;      //Radius of the inside corners of the ring
$fn = 20;


outside_radius = inside_radius + thickness;

module rounded_polygon(n_sides, radius, side_length, height){
    //Actual side length does not include the outside radius.
    hyp = (side_length/2) / cos(180/n_sides);
    hull()
    for( i = [0 : n_sides] ){
        translate([hyp * cos(360 * i/n_sides), hyp * sin(360 * i/n_sides), 0])
            cylinder(h=height, r = radius, center = true);
    }

}


difference(){
  rounded_polygon(n_sides, outside_radius, belt_width, thickness);
  rounded_polygon(n_sides, inside_radius, belt_width, thickness);
}