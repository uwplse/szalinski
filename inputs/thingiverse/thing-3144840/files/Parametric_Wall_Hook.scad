//Width
w=15;
//Height
h=35;
//Thickness
t=8;
//Hole Diameter
d=3;
//Resolution
$fn = 20;

//Tim Billman
//MSE4777
//10/8/2018
//Initial intention of the model is to familiarize myself with parametric modeling in OpenSCAD

//Build Code
difference () {    
cube([w,t,h]); //initial shape
    
rotate (a=[-90,0,0]) translate([w/2,-w/2,-.5*t]) cylinder(d=.75*w,h=2*t); //subtract hook shape while keeping centered
    
translate([.125*w,-.5*t,w/2]) cube([w,t*2,h]); //subtract remaining material in line with radius of prior cylinder subtraction
    
rotate (a=[0,90,0]) translate([-h+(2*d),t/2,0-.5*t]) cylinder(d=d,h=t*2); //nail or screw hole modeled to always be proportinally near to the top relative to the hole size
}