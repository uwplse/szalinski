/* Open SCAD Name.: med_bottle_sep_v1.scad
*  Copyright (c)..: 2017 www.DIY3DTech.com
*
*  Creation Date..: 02/16/2018
*  Description....: parametric seperator for pill bottle
*
*  Rev 1: Develop Model
*  Rev 2: 
*
*  This program is free software; you can redistribute it and/or modify it under the
*  terms of the GNU General Public License as published by the Free Software
*  Foundation; either version 2 of the License, or (at your option) any later version.
*
*  This program is distributed in the hope that it will be useful, but WITHOUT ANY
*  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
*  PARTICULAR PURPOSE.  See the GNU General Public License for more details.
* 
*  Note: the programing concepts within are shared openly in the hopes of educating
*  and training and can be used commercially.  However the completed object itself
*  created as a result of this code remains the sole intellectual property of Campbell
*  and Company Publishing LLC.  If you have an interested in producing or using the
*  end product in a commercial application, please contact us at info@diy3dtech.com
*  for licensing possibilities.
*
*/ 
/*------------------Customizer View-------------------*/

// preview[view:north, tilt:top]

/*---------------------Parameters---------------------*/

//(1) Diameter of bottle in mm
bot_dia         =   29.0; //[20:0.5:50]

//(2) Seperator height in mm
sep_height      =   53; //[10:1:100]

//(3) Number of compartments
compartments    =    4; //[2:1:6]

//(4) Wall thinkness in mm
wall_thick      =    2; //[1:0.5:5]

//(5) Length of stem above seperator in mm
stem            =    7; //[2:1:15]

//(6) Diameter of stem in mm
stem_dia        =    3; //[1:1:5]

/*-----------------------Execute----------------------*/

main_module();

/*-----------------------Modules----------------------*/

module main_module(){ //create module 
    difference() {
            union() {//start union
                
                //create step variable
                x=360/(compartments); 
                
                //create base
                translate ([0,0,wall_thick/2]) rotate ([0,0,0]) cylinder(wall_thick,bot_dia/2,bot_dia/2,$fn=60,true);
                
                //create center
                translate ([0,0,(sep_height+(stem-1))/2]) rotate ([0,0,0]) cylinder((sep_height+(stem-1)), stem_dia/2,stem_dia/2,$fn=60,true);
                
                //create top
                translate ([0,0,((sep_height+stem)-stem_dia)]) sphere($fn = 60, $fa = 12, $fs = 2, r = stem_dia);
                
                //set up for loop
                for (a =[0:x:360]){//start for loop
                //create compartment
                translate ([0,0,sep_height/2]) rotate ([0,0,a]) cube([bot_dia,2,sep_height],true);
            }//end for loop
                        
                    } //end union
                            
    //start subtraction of difference
                                               
    } //end difference
}//end module

                 
/*----------------------End Code----------------------*/
//translate ([0,0,0]) rotate ([0,0,0]) cylinder(5,3,3,true);
//translate ([0,0,0]) rotate ([0,0,0]) cube([18,18,18],true);
//translate ([0,0,0]) sphere($fn = 0, $fa = 12, $fs = 2, r = 1);
//translate ([0,0,0]) rotate ([0,0,0]) rounded (15,15,1,1,true);