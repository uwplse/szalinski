/* Open SCAD Name.: Pipe_Holder_v1.scad
*  Copyright (c)..: 2016 www.DIY3DTech.com
*
*  Creation Date..: 11/17/2016
*  Description....: Pipe Holder (1.5 inch)
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

//Outer Dia of housing in mm
od_dia = 75;        // [1:1:200]
//Inter Dia of tube in mm
id_dia =50;         // [1:0.5:190]
//Height of holder in mm
holder_h = 75;      // [1:1:150]
//Support length in mm (from ID)
support_len = 140;  // [1:1:200]
//Support heights in mm
support_h = 10;     // [1:1:20]
//Support width in mm
support_w = 50;     // [1:1:200]
//Zip Strip tickenss in mm
zip_t = 4;          // [1:1:10]
//Zip Strip height in mm
zip_h = 7;          //[1:1:10]
//Holder offset in mm (adjust for snap fit)
holder_offset = 10; //[1:1:100]
//Race opeining in mm
race_open = 8;      //[1:0.5:30]


/*-----------------------Execute----------------------*/

holder_module();

/*-----------------------Modules----------------------*/

module holder_module(){ //create module
    difference() {
            union() {//start union
                
                //create outer cylinder
                translate ([0,0,0]) cylinder(holder_h,od_dia/2,od_dia/2,$fn=50, true);
                //create oblong bracket
                translate ([0,(support_len/2)+(id_dia/2),-(holder_h/2)+(support_h/2)]) oblong(support_w,support_len,support_h,race_open,true);
                
                    } //end union
                            
    //start subtraction of difference
                     //remove center of holder by diff-ing another cylinder
                     translate ([0,0,0]) cylinder(holder_h+2,id_dia/2,id_dia/2,$fn=50, true);
                    
                     //create cube to diff on par of the holder
                     translate ([0,-((od_dia/2)+holder_offset),0]) cube([od_dia+5,od_dia+5,holder_h+5], true);
                    
                     //create top zip strip pass though
                     translate ([0,0,(((holder_h-(holder_h*0.25))/2)-(zip_h/2))]) zip_strip (((id_dia+((od_dia-id_dia)/2))+(zip_t/2)),((id_dia+((od_dia-id_dia)/2))-(zip_t/2)),zip_h,zip_w,true);
                    
                     //create top zip strip pass though
                     translate ([0,0,-(((holder_h-(holder_h*0.25))/2)-(zip_h/2))]) zip_strip (((id_dia+((od_dia-id_dia)/2))+(zip_t/2)),((id_dia+((od_dia-id_dia)/2))-(zip_t/2)),zip_h,zip_w,true);
                                               
    } //end difference
}//end module

module oblong(dia,len_r,tall,hole_1,center){
    difference() {
        union() {//start union
            //create base oblong structure
            cube([dia,len_r,tall], center);
            translate ([0,len_r/2,0]) cylinder(tall,dia/2,dia/2,$fn=50, center);
                } //end union
        
     //remove hole and create race   
            translate ([0,len_r/2,-1]) cylinder(tall+3,hole_1/2,hole_1/2,$fn=50, center);
            translate ([0,0,-1]) cube([hole_1,len_r,tall+3], center);
        
    } //end differance
}//end module

module zip_strip (zip_od,zip_id,zip_z,center){
    difference() {
        union() {
             translate ([0,0,0]) cylinder(zip_z,zip_od/2,zip_od/2,$fn=50, center);
        } //end union
             translate ([0,0,-1]) cylinder(zip_z+2,zip_id/2,zip_id/2,$fn=50, center);
    } //end differance
    
}//end module

                                       
/*----------------------End Code----------------------*/