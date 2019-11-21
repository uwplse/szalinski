// variable description
/*[Number_off_Sticks]*/
Numbers=5; // [2,3,4,5,6]

/*
|========================================
|                          
|Design:          USBstand
|Made by:       Æxperibox                       
|Date:             17/01/2018
|
|========================================
*/

/***************** Basics ******************
Shapes
    cube([0, 0, 0]);        x,y,z
    sphere(r); 
    cylinder(h, r1, r2);

Transformations
    translate([0, 0, 0])    x,y,z
    scale([0, 0, 0])        x,y,z
    rotate([0, 0, 0])       x,y,z

CSG Operations
(Constructive Solid Geometry Operations)
    union() { }
   difference() { }
    intersection() { }

Special variables:
$fa is the minimum angle for a fragment     (default 12)
$fs is the minimum size of a fragment.      (default  2)
$fn is the number of fragments              (default  0)
    If $fn > 0  $fs and $fa are ignored 
    ex: $fn=150;

Functions:            
    Add Rounding:
            minkowski(){
                PlaceObjectHere
                sphere OR cylinder  
            }
            
    Add Text:
            linear_extrude(height = 4) {
            text("MYTEXT", font = "arial", size = 5);
            }
        
*********************************************/

//Parameters

$fn=50;



    Text="Æ";
    USBlength=12.5;
    USBwidth=5;
    BASElength=25;
    BASEwidth=13;

//Renders

      union() {
        difference() { 
            STAND();
                translate([Numbers, 1.3*BASEwidth+6, BASEwidth])
                    rotate([90,0, 0])
                        AE();
        }              
        translate([4*Numbers-BASEwidth, 1.3*BASEwidth, 4])
                rotate([180,0, 0])
                    TEXT();
    }

//Modules

    module STAND(){
         rotate([90, 0, 0]){     
    translate([0,0,-BASEwidth+5])
        RADUIS();

    translate([Numbers*BASEwidth,0,-BASEwidth+5])
        rotate([0, 180, 0])    
            RADUIS();
        
    for (i = [0 :Numbers-1]){
        translate([i*BASEwidth,0, 0])USB();
            translate([i*BASEwidth,0, -BASEwidth*2+5])TOP();
            }
        } 
    }
    
    module USB(){
        difference() { 
            cube([BASEwidth,BASElength,5]);
                translate([0.5*BASEwidth-0.5*USBwidth, 0.5*BASElength-0.5*USBlength, -1]) 
                    cube([USBwidth, USBlength, 7]);
        }
    }

   
    
    module RADUIS(){
        rotate([-90, 0, 0]) 
           union() { 
                rotate([0, 0, 0]){
                    difference() {  
                        cylinder(BASElength, BASEwidth, BASEwidth);
                         translate([0,0,-1])
                            cylinder(BASElength*1.1, BASEwidth-5, BASEwidth-5); 
                                translate([0, -BASEwidth, -BASElength*0.1])  
                                    cube([BASEwidth*2, BASEwidth*2, BASElength*1.2]);
                }   
            } 
        }               
    }

    module TOP(){       
         cube([BASEwidth, BASElength, 5]);
    }
    
      module TEXT(){
  linear_extrude(height = 4) {
        text("USB", font ="Arial", size = 1.35*BASEwidth,  spacing = 0.2*Numbers );
            sphere(1);
    }
} 

  module AE(){
  linear_extrude(height = 10) {
        text(Text, font ="Bradley Hand ITC", size = BASEwidth,  spacing = 1 );
           
    }
} 