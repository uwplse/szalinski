/* 
*  Open SCAD Name.: flange_model_v3.scad
*  Copyright (c)..: 2017 www.DIY3DTech.com
*
*  Creation Date..:12/24/2017
*  Discription....: general flange model
*
*  Rev 1: Developed Model
*  Rev 2: Multi-shaped flange
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
*
*  If used commercially attribution is required (OpenSCAD.DIY3DTech.com)
*
*/ 

/*------------------Customizer View-------------------*/
// preview[view:north, tilt:top]


/*---------------------Parameters---------------------*/

// outer flange shape
flange_shape_outside    =    4;      //[4:1:60]
// outer flange shape
flange_shape_inside     =   60;      //[4:1:60]
// outer diameter in (mm)
flange_OD               =  150;      //[50:1:300]
// inter diameter in (mm)
flange_ID               =   75;      //[25:1:200]
// flange height in (mm)
flange_height           =    3;      //[3:1:10]
// tube center height
center_height           =   25;      //[3:1:50]
// opening diameter in (mm)
bolt_ID                 =    6;      //[3:1:12]
// center to center spread of retaining bolts (mm)
bolt_spread             =   95;      //[25:1:250]
// number of bolts in flange
bolt_count              =    4;      //[2:1:24]

/*-----------------------Execute----------------------*/

flange();

/*-----------------------Modules----------------------*/

module flange() {
    difference(){
        //create flange
         union() {
            cylinder(flange_height,flange_OD/2,flange_OD/2,$fn=flange_shape_outside,true);
            translate([0, 0,center_height/2]) cylinder(center_height,(flange_ID+flange_height)/2,(flange_ID+flange_height)/2,$fn=flange_shape_inside,true);
         }
        //remove center
        translate([0, 0,center_height/2]) cylinder(center_height*2,flange_ID/2,flange_ID/2,$fn=flange_shape_inside,true);
        
        
        //create circle pattern    
        for (i=[0:(360/bolt_count):360]) {
            //theta is degrees set by for loop from 0 to 360 (degrees)
            theta=i;
            //this sets the x axis point based on the COS of the theta
            x=0+(bolt_spread/2)*cos(theta);
            //this sets the y axis point based on the sin of the theta
            y=0+(bolt_spread/2)*sin(theta);
            //this creates the circle or other obect at the x,y point
            translate([x,y,0]) cylinder(flange_height+2,bolt_ID/2,bolt_ID/2,$fn=60,true);;
        }//end for loop for circle creation
    
    }//end differance
}//end module

/*---------------------End Program--------------------*/