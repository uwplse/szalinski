/*
|========================================
|                          
|Design:    Dial Gauge holder         
|Made by:   BeeDesign                       
|Date:      05/03/2018
|
|========================================
*/

//Parameters

//Height of base
baseheight = 7.5;// [5:15]
//Lenght of Holder
baselengt = 67; 
// Width of holder
basewidth = 15; //[8:20]
// Screwsize
screw = 5;          //[3,4,5,6]
//Screw type
screwhead = 2;    //[1:COUNTERSUNK, 2:PAN HEAD]
//Mounting bracket
mountingbracket = true; //[false, true]
//Mountingbracket width
mountingbracketwidth = 5; //[5:15]
//Dial Gauge size (radius)
DialGaugeR = 26.4;



$fa = 0.01; $fs = 0.3;
Xcentre = 0.5 * basewidth -2;

//Renders
if (mountingbracket == true) mount();


difference(){
    minkowski(){
        union(){
            cube([basewidth - 4,baselengt -4,baseheight -2]);
            cube([basewidth - 4,1,baseheight + 16 ]);
            translate([Xcentre-1.5,0,baseheight])cube([3,2*DialGaugeR+5,2]);
        }
        sphere(2);
    }
    union(){
        translate([0.5 * basewidth -2,-5,baseheight + 9.8])rotate([-90,0,0])cylinder(10,4.1,4.1);
        translate([-5,-5,-5])cube([basewidth + 10,baselengt + 10,5]);
        if (mountingbracket == false){
            screwhole(baselengt * 0.25);
            screwhole(baselengt * 0.75);
        }
        translate([Xcentre,DialGaugeR + 1.5,baseheight])cylinder(20,DialGaugeR,DialGaugeR);
    }
    
}
   
//Modules

module screwhole(Y){
    translate([Xcentre,Y,-1])cylinder(baseheight,screw/2, screw/2);
    if (screwhead== 1 ) { 
        translate([Xcentre,Y,baseheight - 1.9])cylinder(2,screw/2,screw); 
    }else{
         translate([Xcentre,Y,baseheight - 2.9])cylinder(3,screw,screw);
    }
}

module mount(){
    translate([Xcentre - 0.5*basewidth,baselengt/2,baseheight-9])rotate([0,90,0])
    difference(){
        cylinder(mountingbracketwidth,8.9,8.9);
        union(){
            translate([4,0,-1])cylinder(basewidth*2,2.5,2.5);
            translate([-baseheight-2,-10,-5])cube([5,20,basewidth*2]);
        }
    }
}
