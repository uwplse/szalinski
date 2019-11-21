/* Open SCAD Name.: 123-Block_v2.scad
*  Copyright (c)..: 2016 www.DIY3DTech.com
*
*  Creation Date..: 01/04/2017
*  Description....: Machine Fixture Creation
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

//bolt opening diameter in mm
bolt_dia    =  6.2; //[2:.1:12]
//number of bolt holes in the X axis
x_grid      =  4; //[2:1:10]
//number of bolt holes in the Y axis
y_grid      =  4; //[2:1:10]
//number of bolt holes in the Z axis
z_grid      =  4; //[1:1:10]
//on center seperation of bolt holes
on_center   = 10; //[2:1:50]

/*-----------------------Execute----------------------*/

fixture_module();

/*-----------------------Modules----------------------*/

module fixture_module(){ //create module
    difference() {
            union() {//start union
                    translate ([((on_center*x_grid)+(on_center))/2,((on_center*y_grid)+(on_center))/2,((on_center*z_grid)+(on_center))/2]) rotate ([0,0,0]) cube([(on_center*x_grid)+(on_center),(on_center*y_grid)+(on_center),(on_center*z_grid)+(on_center)],true); 
                    } //end union
                            
    //start subtraction of difference
        for (z=[1:z_grid]){
            
                   for (y=[1:y_grid]) for (x=[1:x_grid]) translate ([(x*on_center),(y*on_center),(((on_center*z_grid)+(on_center))/2)]) rotate ([0,0,0]) cylinder(((on_center*z_grid)+(on_center)),bolt_dia/2,bolt_dia/2,$fn=60,true);
                       
                   for (x=[1:x_grid])  translate ([(x*on_center),((on_center*y_grid)+(on_center))/2,(z*on_center)]) rotate ([90,0,0]) #cylinder(((on_center*y_grid)+(on_center)),bolt_dia/2,bolt_dia/2,$fn=60,true);
      
                   for (y=[1:y_grid])  translate ([(((on_center*x_grid)+(on_center))/2),(y*on_center),(z*on_center)]) rotate ([0,90,0]) cylinder(((on_center*x_grid)+(on_center)),bolt_dia/2,bolt_dia/2,$fn=60,true);
                       
                   }//END OF Z FOR LOOP           
                        
                                               
    } //end difference
}//end module
                                       
/*----------------------End Code----------------------*/
//translate ([0,0,0]) rotate ([0,0,0]) cylinder(5,3,3,true);
//translate ([0,0,0]) rotate ([0,0,0]) cube([18,18,18],false);