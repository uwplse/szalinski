//use <Thread_Library.scad>
use </mnt/HomeExt/HW-Entwicklung/OpenScad/Screw_Library/Thread_Library.scad>

$fn=120;
GewindeSteps=60;
LochR=21;

module Skull()
{
    translate([0,0,0]) 
    difference()
    {  
        union()
        {  
             translate([-110,-110,-2])
            rotate([0,0,0])
            {
                color( "LightGreen", 1.0 )
                rotate([0,0,0])
                import ("hpArtistSkull.stl", convexity = 5);
            }
         translate([0,0,-10]) cylinder(h=20,d=(LochR+4)*2,center=false); 
        }
        union()
        { 
            translate([0,0,-40]) color("Red",1.0) cylinder(h=40,d=200,center=false);
            translate([0,0,-1]) color("Blue",1.0) cylinder(h=116,r1=LochR,r2=LochR,center=false);
            translate([0,0,115]) color("Blue",1.0) cylinder(h=10,r1=LochR,r2=LochR/2,center=false);
            translate([0,0,-10]) trapezoidThreadNegativeSpace(length=34,threadAngle=90,stepsPerTurn=GewindeSteps,pitch=4,pitchRadius=22);
            translate([0,0,0]) color("red",1.0) cylinder(h=4,r1=LochR+3,r2=LochR+3,center=false);      
            translate([0,0,4]) color("red",1.0) cylinder(h=3,r1=LochR+3,r2=LochR,center=false);      
            translate([0,LochR+15,0]) color("red",1.0) cylinder(h=16,d=5,center=false);              
            translate([0,LochR+15,-0.1]) color("red",1.0) cylinder(h=8,d1=8,d2=5,center=false);      
         }
    }
}

module Stopfen()
{
    difference()
    {  
        union()
        {  
            translate([0,0,0]) color("lightgreen",1.0) cylinder(h=2,r1=LochR+2.5,r2=LochR+2.5,center=false);      
            translate([0,0,2]) color("lightgreen",1.0) cylinder(h=3,r1=LochR+2.5,r2=LochR,center=false);      
            translate([0,0,0]) trapezoidThread(length=15,threadAngle=90,stepsPerTurn=GewindeSteps,pitch=4,pitchRadius=22); 
            translate([0,0,18.3]) color("lightgreen",1.0) cylinder(h=3,r1=LochR-0.15,r2=LochR-3,center=false);      
        }
        union()
        {  
            translate([0,0,-0.1]) color("red",1.0) cylinder(h=3.2,r1=LochR-1,r2=LochR-1,center=false);      
            translate([0,0,3]) color("red",1.0) cylinder(h=10,r1=LochR-1,r2=LochR-10,center=false);      
        }
    }
   translate([0,0,8]) color("lightgreen",1.0) cube([LochR*2-1,6,16],center=true);    
}

module Trichter()
{
    difference()
    {  
        union()
        { 
            translate([0,0,75]) cylinder(h=7,d1=8,d2=5,center=false);
            translate([0,0,65]) cylinder(h=10,d=8,center=false);
            translate([0,0,40]) cylinder(h=25,d1=50,d2=8,center=false);
            translate([0,0,0]) cylinder(h=40,d=50,center=false);
            difference()
            {  
                translate([0,22,20]) rotate([0,90,0]) cylinder(h=4,d=30,center=false);
                translate([-0.1,22,20]) rotate([0,90,0]) cylinder(h=4.2,d=23,center=false);
            }
        }
        union()
        {
             translate([0,0,40-0.2]) cylinder(h=25,d1=46,d2=5,center=false);
             translate([0,0,-0.1]) cylinder(h=40,d=46,center=false);
             translate([0,0,-0.1]) cylinder(h=100,d=5,center=false);
        }
    }
} 


Skull();
//Stopfen();
//Trichter();
