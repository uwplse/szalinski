/////Wilson's Cup Holder/////////
//Author: Tim Driskell//////////
//Date: 9/22/2016///////////////

diameter=55;
logo="Wilson";
height=60;
handle=25;
spacing=1.5;//[1:0.1:5]

use<Write.scad>
difference(){
cylinder(r=diameter,h=height,$fn=100);
    translate([0,0,5])
    cylinder(r=diameter-5,h=height-4.9,$fn=100);
    translate([diameter-6.6,-handle/2,15])
    cube([7,handle,height-14.9]);
writecylinder(logo,bold=1,[0,0,0],diameter-2.5,height,space=spacing,t=7,h=height/2,east=-90);
}