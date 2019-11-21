//**********************************************************************
// Created By:  Humberto Kelkboom
// Date:        1 nov 2015
// Description: A cap to close a cable hole in a desk. The cable hole 
//              can be adjusted to fit any hole size.
//**********************************************************************

include<TextGenerator.scad>;

HoleInDesk = 95;
RimOutside = 10;
Height = 2.4;
Thickness = 1.2;
TableThickness = 30;
$fn=74;

module holecover(){
difference()
{
    union(){
        cylinder(d=HoleInDesk+(RimOutside*2), h=Thickness);
        translate([0,0,Thickness])
        cylinder(d=HoleInDesk, h=TableThickness);
    }
    
    cylinder(d=HoleInDesk-(2*Height), h=TableThickness+Thickness);
}
}

module Plate()
{
    
    difference(){
    union(){
        cylinder(d=(HoleInDesk)+(RimOutside*2), h=Thickness);
        translate([0,0,Thickness])cylinder(d=(HoleInDesk-(2*(Height+0.2))), h=TableThickness/2);
    }
        
    
    union(){
        translate([HoleInDesk/4,0,0])cylinder(d=HoleInDesk/2, h = TableThickness/2+Thickness);
        translate([HoleInDesk/4,-HoleInDesk/4,0])cube([HoleInDesk/2,HoleInDesk/2,TableThickness/2+Thickness]);
          }
          
    difference(){
    translate([0,0,Thickness])cylinder(d=(HoleInDesk-4*Height), h=TableThickness/2);
        
    
    union(){
        translate([HoleInDesk/4,0,0])cylinder(d=HoleInDesk/2+(2*(Height+0.2)), h = TableThickness/2+Height);
        translate([HoleInDesk/4,-(HoleInDesk/4+Height),0])cube([HoleInDesk/2+(2*Height),HoleInDesk/2+(2*Height),TableThickness/2+Thickness]);
          }
    }
    translate([-10,30,0])mirror([0,1,0])rotate([0,0,90])
    resize([60,12,1])drawtext("LarkInfolab");
    }
}

translate([HoleInDesk/2+RimOutside,0,0])
holecover();
translate([-(HoleInDesk/2+RimOutside),0,0])
//translate([0,0,-Thickness])
Plate();

