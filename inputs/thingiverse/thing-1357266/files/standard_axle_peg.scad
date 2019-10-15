l=150;
w=22;
h=20;
t=1;
g=40;
pegnumber=10;
$fn=50;



tolerance=0.1;
indent_hole_radius=6.5; 
thickness=2;
axle_radius=3; //3
axle_length=20;


module peg ()
{
difference()
{
//tack indent
difference()
{
hull()
{translate([0,-g,0])
cylinder(r=axle_radius+1,h=2*t); //h/5 originally
cylinder(r=indent_hole_radius+thickness,h=2*t);}
//lip
translate([0,0,t])
cylinder(r=indent_hole_radius+tolerance,h=h);
}
//hole
translate([0,0,-h/2])
cylinder(r=1.5,h=w+5);
}

translate([0,-g,0])
cylinder(r=axle_radius-tolerance,h=axle_length); //h/5 originally
}




translate([0,1.5*g,0])
for (i=[0:2:pegnumber-1], j=[1:2:pegnumber])
{
translate([h*i,-g*(i()),0])
rotate([0,0,180*i])
peg();

translate([h*j,-g,0])
rotate([0,0,180*j])
peg();

}


for (i=[0:2:pegnumber-1], j=[1:2:pegnumber])
{
translate([h*i,-g*(i()),0])
rotate([0,0,180*i])
peg();

translate([h*j,-g,0])
rotate([0,0,180*j])
peg();

}