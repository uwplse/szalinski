// Open SCAD Name.:Fab-Mini Z Stabilizer
// Copyright (c)..: 2016 www.DIY3DTech.com
//
// Creation Date..:04/15/2016
// Discription....:Stabilizer for Z Axis on Fab-Mini
//
// Rev 1:Base model design
// Rev 2:
// 

/*------------------Customizer View-------------------*/
// preview[view:north, tilt:top]


/*---------------------Parameters---------------------*/

// Diameter of top retainer (mm)
Top_Retainer_Dia = 15; //[12:1:20]

// Changes the shape of the top
Top_Retainer_Thinkness = 3; //[3:1:10]

// Thinkness of top retainer (mm)
Top_Retainer_Shape = 8; //[4:1:100]

// Diameter of Z Axis opening (mm)
Z_Axis_Hole_Dia = 11; //[5:1:20]

// Thickness of Z Axis opening (mm)
Z_Axis_Hole_Thicknes = 5; //[2:0.5:10]

// Z Axis rod diameter (mm)
Z_Axis_Rod_Dia = 3.4; //[3.0:0.1:5.0]

// Pinch factor rod diameter (0.1 mm)
Pinch_Factor = 0.2; //[0.1:0.1:1]

// Scale Factor typically 0.1 ABS 0.2 PLA
Scale_Factor = 0.2; //[0.1:0.1:0.4]


/*-----------------------Execute----------------------*/
 
 Z_Retain ();

/*-----------------------Modules----------------------*/

module Z_Retain () {
    
    height1 = (Z_Axis_Hole_Thicknes+1);
    height2 = (Top_Retainer_Thinkness+.5);
    
    difference(){
        union() {
        //create pass though section
            cylinder(Z_Axis_Hole_Thicknes+.3,((Z_Axis_Hole_Dia/2)-0.1),((Z_Axis_Hole_Dia/2)+(((Z_Axis_Hole_Dia/2)*Scale_Factor))/2),$fn=60,true);
            
        //create top retainer    
           translate([0,0,(Z_Axis_Hole_Thicknes/2)+(Top_Retainer_Thinkness/2)]) {
            cylinder(Top_Retainer_Thinkness,Top_Retainer_Dia/2,Top_Retainer_Dia/2,$fn=Top_Retainer_Shape,true);
           }//end translate
       
    } //end union
        //create conical shape to retain rod
        union(){
            pinch (0,0,0,height1,Z_Axis_Rod_Dia,Z_Axis_Rod_Dia+Pinch_Factor);
            pinch (0,0,(Z_Axis_Hole_Thicknes/2)+(Top_Retainer_Thinkness/2),height2,Z_Axis_Rod_Dia,Z_Axis_Rod_Dia+Pinch_Factor);
        }//end second union
    } //end differance
} //end module

module pinch(x,y,z,h,d1,d2) {
    
    union(){
        translate ([x,y,z]) {
           cylinder(h,(d1/2)+(((d1/2)*Scale_Factor)),((d2/2)+((d2/2)*Scale_Factor)),$fn=60,true);
        }//end translate
        
        translate ([x,y,z]) {
           cylinder(h,((d2/2)+((d2/2)*Scale_Factor)),((d1/2)+((d1/2)*Scale_Factor)),$fn=60,true);
        }//end translate
    }//end union

}//end module pinch


   
/*----------------------End Code----------------------*/