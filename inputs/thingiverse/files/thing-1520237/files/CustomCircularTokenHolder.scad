//
// Custom Circular Token Holder
//
// Copyright 2016 Julia Valencia
//
// Creative Commons Attribution-NonCommercial 3.0 Unported (CC BY-NC 3.0)
// http://creativecommons.org/licenses/by-nc/3.0/

//diameter(mm) of the hole for the token
diameter = 20;
//height(mm) of the holder
height = 40;
//how thick(mm) the walls are
thk = 3;
//how many holders?
count = 3;
//do you want it to be easily grabable? NOTE: this is to allow creativity! Like making a custom toilet paper holder! or a pencil holder! :D
grab = 1;// [1:Yes,0:No]

radius = diameter/2;
difference (){
    for(i=[0:1:count-1]){
     translate([0,(diameter+thk/2)*i,0])
       cylinder(h=height+thk, d = diameter+thk);
    }
    for(i=[0:1:count]){
     translate([0,(diameter+thk/2)*i,thk])
       cylinder(h=height, d = diameter);
     if (grab == 1){
      translate([-radius-thk/2,(diameter+thk/2)*i+(-radius/2),thk])
       cube([diameter+thk,radius,height]);
     }
    }
}