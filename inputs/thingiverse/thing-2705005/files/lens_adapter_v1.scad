/* Open SCAD Name.: lens_adapter_v1.scad
*  Copyright (c)..: 2017 www.DIY3DTech.com
*
*  Creation Date..: 
*  Description....: 
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
*/ 

/*------------------Customizer View-------------------*/

// preview[view:north, tilt:top]

/*---------------------Parameters---------------------*/

//outer dia of filter retainer in mm (about 2mm larger then filter threads)
ring_od         =   53;     //[25:1:100]

//how tall should we make the retaining ring in mm (7 to 100mm should work)
ring_tall       =    7;     //[5:1:10]

//outer dia of filter threads in mm (note threads not filter)
filter_od       =   51;     //[25:1:73]

//outer dia of action camera lens in mm
cam_lens_od     =   17.4;   //[15:0.1:25]

/*-----------------------Execute----------------------*/

main_module();

/*-----------------------Modules----------------------*/

module main_module(){ //create module
    difference() {
            union() {//start union
                
                //create retaining body
                translate ([0,0,0]) rotate ([0,0,0]) cylinder(5,ring_od/2,ring_od/2,$fn=100,true);
                  
                    } //end union
                            
    //start subtraction of difference
                //knock out donut shape to provide room for filter
                translate ([0,0,2]) rotate ([0,0,0]) donut_module(ring_tall,filter_od,cam_lens_od+3);
                //knock out center hole for action camera lens
                translate ([0,0,0]) rotate ([0,0,0]) cylinder(ring_tall*2,cam_lens_od/2,cam_lens_od/2,$fn=100,true);
                //recess center opening to clear filter
                translate ([0,0,4]) rotate ([0,0,0]) cylinder(ring_tall,(cam_lens_od/2)+2,(cam_lens_od/2)+2,$fn=100,true);
                                               
    } //end difference
}//end module

module donut_module(tall,od,id){ //create module
    difference() {
            union() {//start union
                
                //create outer body
                translate ([0,0,0]) rotate ([0,0,0]) cylinder(tall,od/2,od/2,$fn=100,true);
                    } //end union
                            
    //start subtraction of difference
                //create hole
                translate ([0,0,0]) rotate ([0,0,0]) cylinder(tall+2,id/2,id/2,$fn=100,true);
                                               
    } //end difference
}//end module
                 
/*----------------------End Code----------------------*/
//translate ([0,0,0]) rotate ([0,0,0]) cylinder(5,3,3,true);
//translate ([0,0,0]) rotate ([0,0,0]) cube([18,18,18],true);
//translate ([0,0,0]) sphere($fn = 0, $fa = 12, $fs = 2, r = 1);
//translate ([0,0,0]) rotate ([0,0,0]) rounded (15,15,1,1,true);