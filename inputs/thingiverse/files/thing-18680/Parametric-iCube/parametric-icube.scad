/*
Parametric iCube
Originally designed by Buback as thing:18670
Uses Sorup's openscad iphone if you have it thing:12879
Coded by Ben Rockhold in 2012
*/

// Change this line to fit the cube to YOUR needs!
size=300;

iCube(size);

module iCube(size){
	cube(size,center=true);
}

use<iphone4_model.scad>;
iPhone();

module iPhone(){
translate([0,0,size/2])iphone4(true, true, true, true, true, [0,.7,0]);
}