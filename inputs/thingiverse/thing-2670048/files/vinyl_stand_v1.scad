/* Open SCAD Name.: vinyl_stand_v1.scad
*  Copyright (c)..: 2017 www.DIY3DTech.com
*
*  Creation Date..: 11/26/2017
*  Description....: vinyl roll stand
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


//inter-dia of outer tube in mm
tube_id         =   105; //[100:1:125]

//outer-dia of inter-tube in mm
tube_cen        =   75; //[50:1:75]

//height of holder in mm
tube_tall       =   75; //[50:1:100] 


/*-----------------------Execute----------------------*/

main_module();

/*-----------------------Modules----------------------*/

module main_module(){ //create module
    difference() {
            union() {//start union
                
                //created extended base to prevent tipping
                translate ([0,0,6.35/2]) rotate ([0,0,0]) cylinder(6.35,(tube_id+35)/2,(tube_id+35)/2,$fn=50,true);
                //create main body
                translate ([0,0,(tube_tall+6.35)/2]) rotate ([0,0,0]) cylinder(tube_tall+6.35,(tube_id+3)/2,(tube_id+3)/2,$fn=50,true);
                 
                        
                    } //end union
                    
                //remove center to save plastic and time 
                translate ([0,0,(tube_tall)/2]) rotate ([0,0,0]) cylinder(tube_tall+30,(tube_cen-5)/2,(tube_cen-5)/2,$fn=50,true);
                    
                 //knock out center   
                translate ([0,0,(tube_tall/2)+7]) rotate ([0,0,0]) knock_out(tube_id,tube_cen,tube_tall+1);
            
            //create flower like knockouts with oval    
            translate ([(tube_id/2)-1,0,(tube_tall)+7]) rotate ([0,90,0])    oval(tube_tall,tube_tall/4,5, center = true);
            translate ([-(tube_id/2)+1,0,(tube_tall)+7]) rotate ([0,90,0])    oval(tube_tall,tube_tall/4,5, center = true);
            translate ([0,(tube_id/2)-1,(tube_tall)+7]) rotate ([90,90,0])    oval(tube_tall,tube_tall/4,5, center = true);
            translate ([0,-(tube_id/2)+1,(tube_tall)+7]) rotate ([90,90,0])    oval(tube_tall,tube_tall/4,5, center = true);
                    
                           
    //start subtraction of difference
                                               
    } //end difference
}//end module

module knock_out(ko_od,ko_id,ko_tall){ //create module
    difference() {
            union() {//start union
                
                //create outer shell
                translate ([0,0,0]) rotate ([0,0,0]) cylinder(ko_tall,ko_od/2,ko_od/2,$fn=50,true);
                 
                        
                    } //end union
                            
    //start subtraction of difference
                 
                //create inter knockout
                translate ([0,0,(5/2)]) rotate ([0,0,0]) cylinder(ko_tall+5,ko_id/2,ko_id/2,$fn=50,true);
                                               
    } //end difference
}//end module

module oval(w,h, height, center = true) //create oval
    {
        scale([1, h/w, 1]) cylinder(h=height, r=w, $fn=50,center=center);
    }//end module

                 
/*----------------------End Code----------------------*/
//translate ([0,0,0]) rotate ([0,0,0]) cylinder(5,3,3,true);
//translate ([0,0,0]) rotate ([0,0,0]) cube([18,18,18],true);
//translate ([0,0,0]) sphere($fn = 0, $fa = 12, $fs = 2, r = 1);
//translate ([0,0,0]) rotate ([0,0,0]) rounded (15,15,1,1,true);