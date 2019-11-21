// Cutomizable cable fastener by Timoi Jan 18th 2017
// Customisable parameters for Thingverse
cable_diameter = 12; // [4:32]
min_part_thickness = 3; // [1:6]
screw_hat_thicknes = 2; // [0:4]  
screw_hat_witdh = 7; // [2:12] 
screw_hole_size = 4; // [2:8]
number_of_fasteners = 1; // [1,2,4,6,8,10,12,14,16,18,20]

// Hidden options not visible at Thingsverse
hidden_option_cableR   = cable_diameter/2*1;
hidden_option_minT = min(min_part_thickness, hidden_option_cableR )*1;
hidden_option_tol = 0.6*1;
hidden_option_screwL    =  40*1;
$fn = 60*1;


// Calculation of intermediate parameters (complicated refactoring)

screwW    = screw_hole_size/2+hidden_option_tol;
screwHatW = max(screw_hat_witdh/2+hidden_option_tol, screwW);
screwHatH = screw_hat_thicknes+hidden_option_tol;

cableRingT = max(hidden_option_cableR/5, hidden_option_minT);
screwHoleTol = screwHatH/2;
screwToCableL = screwHatW*1.5+1*hidden_option_cableR+hidden_option_minT;
ringR = hidden_option_cableR + cableRingT;
ringW = screwHatW*3;
plateL = ringW; //screwToCableL; //3*screwHatW;

halfspaceA = ringW*5;
gridGap = min_part_thickness*1;
gridZ = cable_diameter+gridGap+min_part_thickness;
gridX = gridZ+plateL*2+min_part_thickness+gridGap;


// Creating 3D model
// Secong union is removed from the one resulting ready parts
module screw(){

    // Screw which size is made larger by tol
    cylinder(screwHatH+hidden_option_tol,screwHatW++hidden_option_tol,screwHatW);
    cylinder(hidden_option_screwL,screwW,screwW);
  }

module fastener() {
    
difference() {
    
    // Creating wanted shape and a bit more which is removed with boolean operations
    union() {
        // Outer half ring as cylinder
        cylinder(ringW,ringR,ringR);
        
        // Lower vertical part
        translate([-ringR,0,0]) { cube([ringR*2,ringR,ringW]);}
        //translate([0,0,0]) { cube([ringR,ringR-min_part_thickness,ringW]);}
        
        // Lower vertical part on screw side
        translate([-plateL-ringR,+ringR-2*cableRingT-screwHatH,0]) { 
                cube([plateL,cableRingT+screwHatH,ringW]);}  
    }
     
    // Creating shape to remove unwanted part from aboe
    union() {
        
        // Screw made larger by tol and placed correctly
        translate([-screwToCableL,hidden_option_cableR-cableRingT-screwHatH*1.1,ringW/2]) { 
            rotate(270, [1,0,0]) { screw(); }
          }
               
        // Half space i.e. wall
          translate([-halfspaceA/2, hidden_option_cableR, -halfspaceA/2+ringW/2]) { 
              cube([halfspaceA,halfspaceA,halfspaceA]);}
          
         translate([0,ringR-min_part_thickness*1-hidden_option_tol,-ringR/2]) { 
             cube([2*ringR,ringR,ringW*2]);}
          
        // Place where cable would be  
        translate([-hidden_option_cableR,0,-ringW/2]) { cube([hidden_option_cableR*2,ringW*2,2*ringW]);}
        translate([0,0,-ringW/2]) { cylinder(ringW*2,hidden_option_cableR, hidden_option_cableR);}
   }
}
}



module column_of_fasteners()  { 
    for (a =[1:number_of_fasteners/2]) { 
        translate([0,-a*gridZ,0]) { fastener();}
    } 
}

if (number_of_fasteners>1) { 
    column_of_fasteners();
    mirror([1,0,0]) { translate([gridX,0,0]) { column_of_fasteners();}}
} else {
    fastener();
}