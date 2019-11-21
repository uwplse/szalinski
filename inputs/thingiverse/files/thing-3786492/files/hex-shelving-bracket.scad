/*

Hex Shelving Bracket 

Revision History
- Patrick McGorrill 08/2019 - first version

This work is licensed under a 
Commons Attribution-ShareAlike 4.0 International License. 
To view a copy of the license, visit 
https://creativecommons.org/licenses/by-sa/4.0/

*/


// this sets the width of the gap in the protruding bits
width = 7.5;

// this sets the length of the protruding bits
depth = 16.5;

// this sets the thickness of the shape
thickness = 4;

// this sets the height of the shape
height = 10;

//this sets whether the piece will have two or three protruding bits
two_or_three=2;// [1:Two, 2:Three,]

outer_width = width+thickness;

outer_depth = depth+(thickness/2);

travel = (outer_depth/2)+(sqrt(3)*outer_width)/6;

// this "bracket" is the base shape of the design 
// a rectangular prism minus a smaller rectangular prism

module bracket(){
difference(){
    cube([outer_width,outer_depth,height],center=true);
    translate([0,thickness/4+1,0])
        cube([width,depth,height+1], center=true);
}
}

translate(v=[0,0,height/2]){

// for two or three iterations, we make the bracket shape and 
// rotate it by 120 degrees around the z axis
// also we move the bracket shape, along its y axis, out from 
// the center "travel" number of units so they form a triangle 
// with sides roughly "outer_width" long

    for (i=[0:two_or_three])
        rotate(a=[0,0,i*120])
        translate(v=[0,travel,0])
        bracket();

// a triangular cylinder to fill in the center

    rotate(a=[0,0,30])
        cylinder(h=height, r=sqrt(3)*outer_width/3, center=true, $fn=3);
}