/*
|========================================
|                          
|Design:    Brush hook         
|Made by:   BeeDesign                       
|Date:      11/02/2018
|
|========================================
*/


//Parameters
$fa = 5; $fs = 0.5;
width = 15; 
depth = 30;
TEXT = "Brush";

//Renders

//baseplate
difference(){
    minkowski(){
        cube([width,width*2,3]);
        sphere(2); 
    }
    union(){
        translate([-3,-3,-5,])cube([width*2,width*3,5]);
        translate([width/2,width*1.5,4.5])linear_extrude(height = 4) {
                text(TEXT, font = "arial", size = 3, halign = "center");
                }
    }
}    
//pillars
    Pillar();
    translate([width,0,0])Pillar();

 //bridge   
   difference(){
    translate([0,-2,0])cube([width,4,15]); 
    translate([width/2,5,30])rotate([90,0,0])cylinder(10,20,20); 
   }

    
            
   
//Modules

module Pillar(){
    //pillarbase
    cylinder(10,3,3);
    //pillar
    minkowski(){
        translate([0,0,9.9])rotate([-10,0,0])cylinder(depth-10,1,1);
        sphere(2);
    } 
}


