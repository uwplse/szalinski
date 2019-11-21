/***************************************************
*                                                  *
*        Designed by Freakazoid 08-25-2016         *
*                                                  *
*  made to work with "USB Flash Drive Cryptex v2"  *
*    http://www.thingiverse.com/thing:1196989      *
*                                                  *
***************************************************/

//Enter values here. give yourself some wiggle room, e.g. +0.2 ... +0.4 

//Width of the circuit board
Circuit_Width = 15.8;
//Length of the circuit board
Circuit_Length = 40;
//Height of the circuit board.
Circuit_Height = 4;     //Don't make too tight! 4-5mm will probably work for you.
//Length offset of the USB plug on the top
Top_Offset = 10; 
//Length offset of the USB plug on the bottom
Bottom_Offset = 2;
//Hole diameter for strap... obviously
Strap_Hole = 2;         

// Which parts would you like to see?
part = "both"; // [top:Top shell only,bottom:Bottom shell only,both:Both shells]

//Press F5 for preview of the STL
//Press F6 for rendering (necessary for STL export)
//Select "File > Export > STL"

/********************** TOP VIEW **********************************
  
                     Circuit_Width
                      |---------| 
          
                       _________   ___
                      |         |   |
                      |         |   |
                      |         |   |
                      |         |   |
                      |         |   |
                      |         |   | Circuit_Length
                      |         |   | 
                      |         |   |
                      |         |   |
               ___    |  _____  |   |
    Top_Offset  |     | |     | |   |
               _|_    |_|     |_|  _|_
                        |[] []|
                        |_____|
                        

********************* BOTTOM VIEW *********************************
          
                       _________   
                      |         |   
                      |         |   
                      |         |   
                      |         |   
                      |         |   
                      |         |   
                      |         |    
                      |         |   
                      |         |   
               ___    |  _____  |        
 Bottom_Offset _|_    |_|     |_|  
                        |     |
                        |_____|

********************* SIDE VIEW ***********************************/

//CONSTRUCTOR

if (part == "both"){
    Bottom_Shell();
    Top_Shell();
}

if (part == "bottom"){
    Bottom_Shell();
}

if (part == "top"){
    Top_Shell();
}

module Bottom_Shell(){
    translate([-(iDia+Part_Offset)/2,0,6])
        rotate([0,-90,90])
            difference(){Make_All();
                translate([0,-oDia/2,0])
                    cube([Width/2,oDia,Length+8]);
            }

}

module Top_Shell(){
translate([(iDia+Part_Offset)/2,0,6])
    rotate([0,90,-90])
        difference(){
            Make_All();
            translate([-Width/2,-oDia/2,0])
                cube([Width/2,oDia,Length+8]);
        }
}



//Global Variables
resolution = 150;
Length = 44;
Width = 12;
iDia = 20;
oDia = 28;
Part_Offset = 5;

module Make_All(){
    difference(){
        union(){
            Body();
            Teeth();
            Latch();
        }
        Cutout();
    }
}

module Tooth(th){
    intersection(){
        cylinder(d=oDia, h=th, $fn = resolution);
        translate([-Width/2,0,0])cube([Width,oDia/2,Length]);
    }
}

module Teeth(){
    Tooth(4.5);
    translate([0,0,10.5])Tooth(4);
    translate([0,0,20.5])Tooth(4);
    translate([0,0,30.5])Tooth(4);
    translate([0,0,40.5])Tooth(3.5);
}


module Body(){
    intersection(){
        cylinder(d=20, h=44, $fn = resolution);
        translate([-6,-10,0])cube([12,20,44]);
    }
}

module Cutout(){
    //Plug-Top
    PTx = 5.1;
    PTy = 12;
    PTz = Bottom_Offset;
    translate([-PTx/2,-PTy/2,0])cube([PTx,PTy,PTz]);
    //Plug-Bottom
    PBx = 0.55;
    PBy = 12;
    PBz = 10;
    PBx_Offset = Circuit_Height/2;
    translate([PBx_Offset,-PBy/2,0])cube([PBx,PBy,PBz]);    
    //Circuit
    Cx = Circuit_Height;
    Cy = 15.8;
    Cz = 40;
    Cz_Offset = Bottom_Offset;
    translate([-Cx/2,-Cy/2,Cz_Offset])cube([Cx,Cy,Cz]);
}

module Latch(){
    translate([0,0,Length]){
        difference(){
            minkowski(){
                sphere(r=2, $fn=50);
                hull(){
                    translate([-4,0,4])rotate([0,90,0])cylinder(r=2, h=8, $fn=resolution/4);
                    translate([-4,-5,-4])cube([8,10,2]);
                }
            }
            translate([-10,-10,-10])cube([20,20,10]);
            translate([-25,0,4])rotate([0,90,0])cylinder(d=Strap_Hole, h=50, $fn=resolution/8);
        }
    }
}