/* Open SCAD Name.: Universal_Base_Designer_v1.scad
*  Copyright (c)..: 2017 www.DIY3DTech.com
*
*  Creation Date..: 11/26/2017
*  Description....: Universal Base Designer
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

//x dim of holes (center to center) in mm
x_dim           =   34.0; //[10:0.5:50]
//y dim of holes (center to center) in mm
y_dim           =   44.5; //[10:0.5:50]
//stand off OD dia in mm
standoff_dia    =   10.0; //[3:1:15]
//hole for bolt or screw in mm
standoff_hole   =    2.3; //[1:0.1:5]
//height of standoff over base in mm
standoff_height =    5.0; //[3:1:10]
//head recess dia in mm
recess_dia      =    6.0; //[3:1:10]
//head recess height in mm
recess_height   =    3.0; //[2:1:5]
//over all base dia in mm
base_dia        =   75.0; //[25:2:120]
//height of base in mm
base_height     =    5.0; //[3:1:10]
//number of sides of base to change shape
base_sides      =    6.0; //[3:1:60]
//rotate base in degrees to align base
base_rotate     =    0.0; //[0:1:45]


/*-----------------------Execute----------------------*/

main_module();

/*-----------------------Modules----------------------*/

module main_module(){ //create module
    
    standoff_heighta = standoff_height + base_height;
    difference() {
            union() {//start union
                
               //create base
                translate ([0,0,-base_height/2]) rotate ([0,0,base_rotate]) cylinder(base_height,base_dia/2,base_dia/2,$fn=base_sides ,true);
                
               //create vibration stand offs
                //front
                translate ([(x_dim/2),(y_dim/2),0]) rotate ([0,0,0]) cylinder(standoff_heighta,standoff_dia/2,standoff_dia/2,$fn=50,true);
                translate ([-(x_dim/2),(y_dim/2),0]) rotate ([0,0,0]) cylinder(standoff_heighta,standoff_dia/2,standoff_dia/2,$fn=50,true);
                //back
                translate ([(x_dim/2),-(y_dim/2),0]) rotate ([0,0,0]) cylinder(standoff_heighta,standoff_dia/2,standoff_dia/2,$fn=50,true);
                translate ([-(x_dim/2),-(y_dim/2),0]) rotate ([0,0,0]) cylinder(standoff_heighta,standoff_dia/2,standoff_dia/2,$fn=50,true);
                 
                    } //end union
                            
    //start subtraction of difference
               //create vibration stand holes
                //front
                translate ([(x_dim/2),(y_dim/2),0]) rotate ([0,0,0]) cylinder(standoff_heighta+2,standoff_hole/2,standoff_hole/2,$fn=50,true);
                translate ([-(x_dim/2),(y_dim/2),0]) rotate ([0,0,0]) cylinder(standoff_heighta+2,standoff_hole/2,standoff_hole/2,$fn=50,true);
                //back
                translate ([(x_dim/2),-(y_dim/2),0]) rotate ([0,0,0]) cylinder(standoff_heighta+2,standoff_hole/2,standoff_hole/2,$fn=50,true);
                translate ([-(x_dim/2),-(y_dim/2),0]) rotate ([0,0,0]) cylinder(standoff_heighta+2,standoff_hole/2,standoff_hole/2,$fn=50,true);
                    
              //create hear recess holes
                //front
                translate ([(x_dim/2),(y_dim/2),-(standoff_heighta/2)+(recess_height/2)]) rotate ([0,0,0]) cylinder(recess_height,recess_dia/2,recess_dia/2,$fn=50,true);
                translate ([-(x_dim/2),(y_dim/2),-(standoff_heighta/2)+(recess_height/2)]) rotate ([0,0,0]) cylinder(recess_height,recess_dia/2,recess_dia/2,$fn=50,true);
                //back
                translate ([(x_dim/2),-(y_dim/2),-(standoff_heighta/2)+(recess_height/2)]) rotate ([0,0,0]) cylinder(recess_height,recess_dia/2,recess_dia/2,$fn=50,true);
                translate ([-(x_dim/2),-(y_dim/2),-(standoff_heighta/2)+(recess_height/2)]) rotate ([0,0,0]) cylinder(recess_height,recess_dia/2,recess_dia/2,$fn=50,true);
                                               
    } //end difference
}//end module



                 
/*----------------------End Code----------------------*/
//translate ([0,0,0]) rotate ([0,0,0]) cylinder(5,3,3,true);
//translate ([0,0,0]) rotate ([0,0,0]) cube([18,18,18],true);
//translate ([0,0,0]) sphere($fn = 0, $fa = 12, $fs = 2, r = 1);
//translate ([0,0,0]) rotate ([0,0,0]) rounded (15,15,1,1,true);