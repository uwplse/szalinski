
/* Open SCAD Name.: 
*  Copyright (c)..: 2016 www.DIY3DTech.com
*
*  Creation Date..:
*  Description....: PSU end covers
*
*  Rev 1: Base design: drcharlesbell@gmail.com
*  Rev 2: Modifcations by http://www.DIY3DTech.com
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

// Parts:
// Inlet Male Power Socket with Fuse Switch 10A 250V 3 Pin IEC320 C14
// http://amzn.to/2aMR5ve
//
// 10pcs Terminal Binding Post Power Amplifier Dual 2-way Banana Plug Jack
// http://amzn.to/2biVSaq

/*------------------Customizer View-------------------*/

// preview[view:north, tilt:top]

/*---------------------Parameters---------------------*/

// height of the PSU (add for plastic expansion)
height = 50.9;
// width of the PSU (add for plastic expansion)
width = 111;  
// depth for power-side cover (leave room for switch)
power_side_depth = 80;  //[1:1:100]
// depth for blank-side cover
blank_side_depth = 27.2;  //[1:1:100]
// length of power block
PWR_Block_len = 47.7;   
// height of power block
PWR_Block_height = 27.6;
// 0 = Round Opening 1 = Single Banna Jack 2 = Double Banna Jack
DC_Type = 2; //[0:Single Hole, 1:One Banna Jack Pair, 2:Two Banna Jack Pair]
// Outlet hole for DC power cord DC_Type = 0
DC_power_diameter = 8.0; //[1:1:10]


/*-----------------------Execute----------------------*/

translate ([0,(height/2)+9,0]) power_side();
translate ([0,-(height/2),0]) blank_side();


/*-----------------------Modules----------------------*/


module power_side() {
    
    difference() { //first order differance to add power block support
      
        union() {//start first union
        //create main unit
            difference() {
                union() {//start union second union
                    cube([width+4,height+4,power_side_depth]); 
        
                    //create feet
                    translate([5,(height-1)+5,0]) rotate([0,0,180]) foot();
                    translate([width-1,(height-1)+5,0]) rotate([0,0,180]) foot(); 

                        } //end second union  
             
            //start subtraction of difference
            translate([2,2,2]) cube([width,height,power_side_depth]);
                        
            // start if tree      
                if(DC_Type==0) translate([((((width/2)/2)-(19/2)+11.5))+(width/2),(height/2),-1]) rotate([0,0,0])  cylinder(6,DC_power_diameter/2,DC_power_diameter/2);
                else if(DC_Type==1)   translate([((((width/2)/2)-(19/2)+11.5))+(width/2),(height/2),-1]) rotate([0,0,0]) dual_banna_jack();
                else if(DC_Type==2)    {translate([((((width/2)/2)-(19/2)+11.5))+(width/2),((height/4)+(11.5/2)),-1]) rotate([0,0,0]) dual_banna_jack(); translate([((((width/2)/2)-(19/2)+11.5))+(width/2),(height/2)+(height/4),-1]) rotate([0,0,0]) dual_banna_jack();}
            // end if tree  

        } //end second difference 
            //create inter-support for power block to keep from moving
            translate([(30-((PWR_Block_len+6)/2)),((PWR_Block_height-6)/2)-4,0]) cube([PWR_Block_len+6,PWR_Block_height+6,17]);

  } //end first union 
       // power block cutout from support as well as primary box
        translate([(30-(PWR_Block_len/2)),(PWR_Block_height/2)-4,-1]) cube([PWR_Block_len,PWR_Block_height,22]); 
  
  } //end first difference 
}//end module power_side

module blank_side() {
  difference() {
      
        union() {//start union
            cube([width+4,height+4,blank_side_depth]);
             //create feet
            translate([5,0,0]) rotate([0,0,0]) foot();
            translate([width-1,0,0]) rotate([0,0,0]) foot();   
             } //end union 
             
    //start subtraction of difference
    //create center opening         
    translate([2,2,2]) cube([width,height,blank_side_depth]);
    //remove extra plastic from cover by making a hole 80% of the opening›         
    translate([(((width+4)/2)-((width*0.8)/2)),((height+4)/2)-((height*0.8)/2),-1]) cube([(width*0.8),(height*0.8),blank_side_depth]);
    
  }//end difference
}//end blank_side module

module foot() {
    //create tabed foot
    difference() {
            union() {//start union
                  translate([0,0,0]) rotate([0,0,0]) cylinder(5,10/2,10/2,$fn=50);
                    } //end union
    //start subtraction of difference
                  translate([-5,0,-2.5]) rotate([0,0,0]) cube([10,10,10]);
    } //end difference
}//end foot

module dual_banna_jack() {
    //create tabed foot
    difference() {
            union() {//start union
                  translate([-9.5,0,0]) rotate([0,0,0]) cylinder(10,11.5/2,11.5/2,$fn=50);
                  translate([9.5,0,0]) rotate([0,0,0]) cylinder(10,11.5/2,11.5/2,$fn=50);
                    } //end union
    //start any subtraction of difference below if needed
                 
    }//end difference
}//end foot
/*----------------------End Code----------------------*/
