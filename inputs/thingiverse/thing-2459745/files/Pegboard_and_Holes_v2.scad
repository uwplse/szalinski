/* Open SCAD Name.: PegboardandHoles_v2.scad
*  Copyright (c)..: 2017 www.DIY3DTech.com
*
*  Creation Date..: July-2017
*  Description....: Code to create pegboard or pegboard holes
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

//board width in mm
board_width         =   90; //[1:1:500]

//board height in mm
board_height        =   90; //[1:1:500]

//board thickness in mm
board_thick         =     3; //[1:0.5:10]

//hole offset (1 inch or 25.6mm is standard)
hole_offset         =    25.60;//[10:0.1:30]

//hole diamiter (standard is 1/4 inch or 6.25mm)
hole_dia            =     6.25; //[5:0.25:8]

//Peg height for export 
hole_height         =     6.0; //[1:1:30]

//chamfer of of the board corners (will add to width)
chamfer             =     3; //[1:0.5:5]

//Pegboard = 1 Pegs Only = 0
type                =     1; //[0:1:1]

/*-----------------------Execute----------------------*/

main_module();

/*-----------------------Modules----------------------*/

module main_module(){ //create module
    difference() {
            union() {//start union
                

    if (type ==1) {
                    translate ([((board_width/2)-((board_width-(round((board_width-(hole_offset-(hole_dia/2)))/hole_offset))*hole_offset)/2)),((board_height/2)-((board_height-(round((board_height-(hole_offset-(hole_dia/2)))/hole_offset))*hole_offset)/2)),0]) rotate ([0,0,0]) rounded(board_width,board_height,board_thick,chamfer,true);
                }else{
                    for (i=[0:round((board_width-(hole_offset-(hole_dia/2)))/                        hole_offset)])
                                for (j=[0:round((board_height-(hole_offset-(hole_dia/2)))/                            hole_offset)])translate ([i*hole_offset,j*hole_offset,0]) rotate ([0,0,0]) cylinder(hole_height,hole_dia/2,hole_dia/2,$fn=50,true);

            }; //end if union if tstaement
                
                
                        
                    } //end union
                            
    //start subtraction of difference
                     if (type ==1) {
                            for (i=[0:round((board_width-hole_offset)/                        hole_offset)])
                                for (j=[0:round((board_height-hole_offset)/                            hole_offset)])
                                    
                                {translate ([i*hole_offset,j*hole_offset,0]) rotate ([0,0,0]) cylinder(hole_height,hole_dia/2,hole_dia/2,$fn=50,true);
                   }
                                    
                }
             else{


                }; //end of diff if statement
                                               
    } //end difference
}//end module

module rounded(x,y,z,c,center) {

    // c = Chamfer amount this will add (in mm) to each axis
    
     //create overlapping cubes
        //cube one overlapps in the X axis with chamfer "c" being doubled
        cube ([x+(c*2),y,z],true);
        //cube two overlapps in the Y axis with chamfer "c" being doubled
        cube ([x,y+(c*2),z],true);
     //end overlapping cubes
        
     //create corner circles
        translate ([-(x/2),-(y/2),0]) { cylinder( z,c,c,$fn=50,true);
        }
        translate ([-(x/2),(y/2),0]) { cylinder( z,c,c,$fn=50,true);
        }
        translate ([(x/2),-(y/2),0]) { cylinder( z,c,c,$fn=50,true);
        }
        translate ([(x/2),(y/2),0]) { cylinder( z,c,c,$fn=50,true);
        }
     //end coner circle
    
} //end module
                                       
/*----------------------End Code----------------------*/
//translate ([0,0,0]) rotate ([0,0,0]) cylinder(5,3,3,true);
//translate ([0,0,0]) rotate ([0,0,0]) cube([18,18,18],true);
//translate ([0,0,0]) sphere($fn = 0, $fa = 12, $fs = 2, r = 1);
//translate ([0,0,0]) rotate ([0,0,0]) rounded (15,15,1,1,true);