/* Open SCAD Name.: CNC_Indicator_Collar_v1.scad
*  Copyright (c)..: 2017 www.DIY3DTech.com
*
*  Creation Date..: 08/03/2017
*  Description....: Collar CNC Dial Indicator
*
*  Rev 1: Develop Model
*  Rev 2: 
*
*  This program is free software; you can redistribute it and/or modify
*  it under the terms of the GNU General Public License as published by
*  the Free Software Foundation; either version 2 of the License, or
*  (at your option) any later version.
*
*  This program is distributed in the hope that it will be useful,
*  but WITHOUT ANY WARRANTY; without even the implied warranty of
*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*  GNU General Public License for more details.
*  This version is for non-comerical use only.
*/ 

/*------------------Customizer View-------------------*/

// preview[view:north, tilt:top]

/*---------------------Parameters---------------------*/

//Dia of Spindle in mm (0.2mm is for contraction)
spindle_dia     =   65.2;//[50.2:1:75.2]

//Wall Thickness in mm
wall_Thick      =    5;//[3:1:5]

//Height of collar in mm
collar_height   =   40;//[40:1:50]

//Lengeth of x/y mount in mm
x_length       =    90;//[100:2:200]

//Lengeth of z mount in mm
z_length        =   20;//[10:1:30]

//Mount width in mm (do not recommend changing)
mount_width     =   18;//[18:1:20]


/*-----------------------Execute----------------------*/

main_module();

/*-----------------------Modules----------------------*/

module main_module(){ //create module
    difference() {
            union() {//start union
                
                //crreate main body of collar
                translate ([0,0,0]) rotate ([0,0,0]) cylinder(collar_height,(spindle_dia+wall_Thick)/2,(spindle_dia+wall_Thick)/2,$fn=60,true);
                
                //create cinch tab
                translate ([spindle_dia/2,0,0]) rotate ([0,0,0]) cube([50,15,collar_height],true);
                
                //create x mounts
                translate ([-((spindle_dia+wall_Thick)/2)+(mount_width/2),-((spindle_dia+wall_Thick))+(spindle_dia/4),(collar_height/2)-2.5]) rotate ([0,0,0]) oblong(mount_width,x_length,5,0,6.4,true);
                
                //create x support
                translate ([-((spindle_dia+wall_Thick)/2)+(mount_width/2),-((spindle_dia+wall_Thick))+(spindle_dia/4)+10,(collar_height/2)-5]) rotate ([90,90,0]) cylinder(x_length,10/2,10/2,$fn=60,true);
                                
                //create z mount
                translate ([(spindle_dia+mount_width+14)/2,5,-z_length-2.5]) rotate ([90,0,0])oblong(18,(z_length+collar_height),5,0,6.4,true);
                
                    } //end union
                            
    //start subtraction of difference
                    
                //Differance center of collar
                translate ([0,0,0]) rotate ([0,0,0]) cylinder(collar_height*2,(spindle_dia)/2,(spindle_dia)/2,$fn=60,true);
                    
                //create opening for cinch
                translate ([spindle_dia/2,0,0]) rotate ([0,0,0]) cube([52,5,collar_height+2],true);
                    
                //create hole for cinch bolt
                translate ([(spindle_dia+25)/2,0,0]) rotate ([90,0,0]) cylinder(20,6.4/2,6.4/2,$fn=60,true);
                                               
    } //end difference
}//end module

module oblong(dia,len,tall,hole_1,hole_2,center){
    difference() {
        union() {
            //create base oblong structure
            cube([dia,len,tall], center);
            translate ([0,len/2,0]) {cylinder(tall,dia/2,dia/2,$fn=60, center);
            }
            translate ([0,-len/2,0]) {cylinder(tall,dia/2,dia/2,$fn=60, center);
            }
        } //end union
     //if hole is greater than zero, remove hole otherwise do nothing   
     if (hole_1>0) {
        translate ([0,len/2,-1]) {cylinder(tall+3,hole_1/2,hole_1/2,$fn=60, center);
        }}
        if (hole_2>0) {
        translate ([0,-len/2,-1]) {cylinder(tall+3,hole_2/2,hole_2/2,$fn=60, center);
        }}
    } //end differance
}//end module

                 
/*----------------------End Code----------------------*/
//translate ([0,0,0]) rotate ([0,0,0]) cylinder(5,3,3,true);
//translate ([0,0,0]) rotate ([0,0,0]) cube([18,18,18],true);
//translate ([0,0,0]) sphere($fn = 0, $fa = 12, $fs = 2, r = 1);
//translate ([0,0,0]) rotate ([0,0,0]) rounded (15,15,1,1,true);