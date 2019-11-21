/* Open SCAD Name.: 608ZZ_Spool_Holder.scad
*  Copyright (c)..: 2017 www.DIY3DTech.com
*
*  Creation Date..: 10/30/2017
*  Description....: Spool holder based upon 608zz bearings
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

// minium spool opening dia im mm
min_dia     =   25;     // [20:1:50]

// maxium spool opening dia im mm
max_dia     =   63;     // [50:1:80]

// maxium cylinder length im mm
max_len     =   15;     // [20:1:60]

// bolt dia im mm (1/4 inch ~6.4)
bolt_dia    =   6.6;    // [2:0.1:12]

// bearing dia im mm (608zz ~22.1)
bar_dia     =   22.1;   // [10:0.1:30]

// bearing depth im mm (608zz ~6.9)
bar_dep     =   6.9;    // [4:0.1:12]

// bearing ID im mm (608zz ~8.0)
bar_id      =   8.0;    // [4:0.1:12]

// bearing race OD im mm (608zz ~11.5)
bar_race    =   11.5;   // [4:0.1:15]

/*-----------------------Execute----------------------*/

main_module();

/*-----------------------Modules----------------------*/

module main_module(){ //create module
    difference() {
            union() {//start union
             //create cone
             translate ([0,0,0]) rotate ([0,0,0]) cylinder(max_len,max_dia/2,min_dia/2,$fn=60,false);   
             //create bushing base   
             translate ([0,max_dia,0]) rotate ([0,0,0]) cylinder(2,bar_dia/2,bar_dia/2,$fn=60,false);
             //create bushing base   
             translate ([0,max_dia,2]) rotate ([0,0,0]) cylinder(2,bar_race/2,bar_race/2,$fn=60,false);    
             //create bushing pass though  
             translate ([0,max_dia,2]) rotate ([0,0,0]) cylinder(bar_dep,bar_id/2,(bar_id-.1)/2,$fn=60,false);       
                        
                    } //end union
                            
    //start subtraction of difference
                    //create bolt opening
                    translate ([0,0,0]) rotate ([0,0,0]) cylinder(max_len*2,(bolt_dia+0.5)/2,(bolt_dia+0.5)/2,,$fn=60,false);
                    
                    //creat second bolt opening in bushing
                    translate ([0,max_dia,0]) rotate ([0,0,0]) cylinder(max_len*2,bolt_dia/2,bolt_dia/2,,$fn=60,false); 
                    //create bearing opening
                    translate ([0,0,-0.1]) rotate ([0,0,0]) cylinder(bar_dep+4.1,(bar_dia+.4)/2,bar_dia/2,,$fn=60,false);
                    
                    //create bearing race opening
                    translate ([0,0,.5]) rotate ([0,0,0]) cylinder(bar_dep+4,(bar_dia-2)/2,(bar_dia-2)/2,,$fn=60,false);  
                                               
    } //end difference
}//end module

                 
/*----------------------End Code----------------------*/
//translate ([0,0,0]) rotate ([0,0,0]) cylinder(5,3,3,true);
//translate ([0,0,0]) rotate ([0,0,0]) cube([18,18,18],true);
//translate ([0,0,0]) sphere($fn = 0, $fa = 12, $fs = 2, r = 1);
//translate ([0,0,0]) rotate ([0,0,0]) rounded (15,15,1,1,true);