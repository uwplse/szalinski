//            *********************************************
//            *  Fin Alignment Tools for Model Rockets    *
//            *  Blair Thompson (aka Justblair)           *
//            *  www.justblair.co.uk                      *
//            *  modified by Doug Cullen aka dcullen      *
//            *  15 Apr 2016                              *
//            *********************************************
 
 
// Parametric
tube_diameter  = 24.8  ;// mm measured tube outer diameter
flange_thickness = 2   ;// mm thickness of lower flange around tube
fin_width      =  2.64 ;// mm measured fin width
fin_number     =  4    ;// Number of fins
jig_height     = 30    ;// mm height of jig
jig_fin_width  = 38    ;// mm Fin span
wall_thickness =  4    ;// mm desired wall thickness
glue_clearance =  4    ;// mm inner gap to prevent glue sticking to jig
$fn            =150    ; // Changes the smoothness of the curves
  
difference(){
  // Create the solid shapes
       union(){
         cylinder (r = (tube_diameter/2) + 10, h = flange_thickness);
         cylinder (r = (tube_diameter/2) + wall_thickness, h =jig_height);
            for (i = [0:fin_number - 1]){
// Fin holders
     rotate( i * 360 / fin_number, [0, 0, 1])
     translate (-[(fin_width + wall_thickness * 2) / 2, 0, 0])
     cube([fin_width + wall_thickness * 2, jig_fin_width + tube_diameter/2,jig_height]);
                                               
// End Ties
     rotate( i * 360 / fin_number, [0, 0, 1])
     translate ([-(fin_width + wall_thickness * 2) / 2, 0, 0])
     cube([fin_width + wall_thickness * 2, jig_fin_width + tube_diameter/2 + wall_thickness, 4]);
                                                                               
// Inner gap       
    rotate( i * 360 / fin_number, [0, 0, 1])
    translate ([0, tube_diameter/2, 0])
    cylinder (r = glue_clearance + wall_thickness, h =jig_height);
              }
     }
               
// Create the cutout shapes
               
// Rocket tube body
      translate ([0,0,-0.5])
      cylinder (r=tube_diameter/2, h = jig_height + 1);
           for (i = [0:fin_number - 1]){
               
// Fin cutouts
     rotate( i * 360 / fin_number, [0, 0, 1])
     translate ([-fin_width/2, 0, -0.5])
     cube([fin_width, jig_fin_width + tube_diameter/2, jig_height + 1]);
                                                               
// Inner gap                       
     rotate( i * 360 / fin_number, [0, 0, 1])
     translate ([0, tube_diameter/2, -0.5])
     cylinder (r = glue_clearance, h = jig_height + 1);
           }
   }
 