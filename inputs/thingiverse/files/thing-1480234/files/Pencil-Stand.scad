// Open SCAD Name.: Apple Pencil Stand
// Copyright (c)..: 2016 www.DIY3DTech.com
//
// Creation Date..: 04/11/2016
// Discription....: Stand for Apple Pencil
//
// Rev 1:
// Rev 2:
// 

/*------------------Customizer View-------------------*/
// preview[view:north, tilt:top]


/*---------------------Parameters---------------------*/

// Diameter of stand base (mm)
Base_Dia = 50; //[40:1:100]

// Height of base bottom (mm)
Base_Height = 4; //[3:1:10]

// Bottom Diameter of Vase (mm)
Vase_Base = 15; //[15:1:30]

// Top Diamter of Vase (mm)
Vase_Top = 30; //[30:1:60]

// Vase Hieght (mm)
Vase_Height = 40; //[25:1:60]

//Scale Pencil Size for Material (mm)
Pencil_Scale = 9.1; //[8.7:0.1:9.9]

/*-----------------------Execute----------------------*/

difference() {
   
    Base();
    translate([0,0,3]) {
        Pencil();
    } //End translate
    
} //End Differance
 
/*-----------------------Modules----------------------*/

// Form Pencil
module Pencil() {
    union() {
        translate([0,0,8]){cylinder (Vase_Height+15,Pencil_Scale/2   ,Pencil_Scale/2,$fn=60,false);}
        cylinder (9.4,0,Pencil_Scale/2,$fn=60,false);
        } //End module Pencil
    } //End Union

// Form Base
module Base(){
    union() {
    //Base of stand
    cylinder (Base_Height,Base_Dia/2,Base_Dia/2,$fn=60,false);
    cylinder (Vase_Height,Vase_Base/2,Vase_Top/2,$fn=60,false);
        
    //Create torus for base
    rotate_extrude(convexity = 10, $fn = 100)
    translate([Base_Dia/2, Base_Height/2, 0])
    circle(r = (Base_Height/2), $fn = 100);
        
     //Create torus for top
    rotate_extrude(convexity = 10, $fn = 100)
    translate([(Vase_Top/2)-1, Vase_Height, 0])
    circle(r = (Base_Height/2)-1, $fn = 100);
        
    } //End Union
} //End module Base
   
/*----------------------End Code----------------------*/