//-------------------------------------------------------------------------------
//                             DESCRIPTION
//-------------------------------------------------------------------------------

/*
 PARAMETRIC GROMMET 

Modifications for molding + model algorithm updates by Michael from EngineerDog.com, Feburary 2018. 

Original grommet calculations by Mark C. 2017, Built using OpenSCAD 2015.03-2

Model to be printed from TPU flexible material, OR to be used a base model for a moldover grommet. 
*/

//-------------------------------------------------------------------------------
//                             PARAMETERS
//-------------------------------------------------------------------------------



Nominal_Grommet_Thickness = 3; // Thickness of all walls of grommet

Cable_Diameter = 4.0 ;// Cable Hole Diameter.(List EXACT cable diameter)

Wall_Hole_Diameter = 15; // Specify hole diameter in the wall the grommet inserts into

Wall_Thickness = 2;// Specify the wall thickness the grommet inserts into

Moldover= true; //Is this model being used to make a moldover grommet? Calculations assume a mold diameter of no more than 60mm.


//-------------------------------------------------------------------------------
//                             HIDDEN PARAMETERS
//-------------------------------------------------------------------------------
Chamfer_Depth = 0;// Adjust the depth of the hole chamfers 
$fn = 200; // STL circular precision

Grommet_Diameter = Wall_Hole_Diameter+Nominal_Grommet_Thickness;// Major outer diameter of grommet.

Grommet_Thickness = 2*Nominal_Grommet_Thickness + Wall_Thickness; // Total height of the grommet


//-------------------------------------------------------------------------------
//                             MAIN CODE
//-------------------------------------------------------------------------------
translate([0,0,-Grommet_Thickness/2]){
    difference(){
       cylinder (h=Grommet_Thickness , d=Grommet_Diameter); // Overall dims
         
       translate([0,0,-.001]){
           cylinder(h=Grommet_Thickness+.001, d=Cable_Diameter); // Cable Hole.
       }
       
       difference(){
            translate([0,0,Grommet_Thickness/2-Wall_Thickness/2]){
                cylinder (h=Wall_Thickness, d=Grommet_Diameter+.01); // Chassis Groove
            }
            translate([0,0,-Grommet_Thickness]){
                cylinder(h=Grommet_Thickness*2+.001, d=Wall_Hole_Diameter); // Chassis Groove Inner Wall
            }
       }
       
       
        /*
        translate([0,0,Grommet_Thickness-4.75+1-Chamfer_Depth]){
            cylinder(h=15,d1=3,d2=15); // Outer Chamfer top.    Removed because it makes it wierd to print& mold
        }
        translate([0,0,-10-1+Chamfer_Depth]){
            cylinder(h=15,d2=3,d1=15); // Outer Chamfer bottom. Removed because it makes it wierd to print& mold
        }
       */
    
    };
    
        if ( Moldover== true){

    translate([0,0,Grommet_Thickness]){
                cylinder (h=Wall_Thickness, d1=Grommet_Diameter, d2=0); // Taper Top
    };
    
        translate([0,0,-Wall_Thickness]){
                cylinder (h=Wall_Thickness, d2=Grommet_Diameter, d1=0); // Taper Bottom
    };
    
    translate([0,0,Grommet_Thickness/2-(60)/2]) cylinder(h=60 , d=Cable_Diameter); // This makes a positive shape of the cable to create a void in the mold positive which leaves room for the actual cable to be placed in the mold for a moldover. Assumes mold diameter will be 3x the grommet thickness.
    }
}
