// preview[view:north east, tilt:top]

// Shape
shape = 1; // [1:Square,0:Round]

// Size of bottom
bottom = 60; // [30:1:150]

// Size of top
top = 75; // [30:1:150]

// Height of flower pot
height = 75; // [30:1:150]

// How thick do you want the flower pot?
t = 1.5; // [1:0.1:5]

// Do you want perforation in the bottom?
holes = 1; // [1:Yes,0:No]

// Do you want a perforated wall?
perforate = 0; // [1:Yes,0:No]

// Do you want a brim?
brim = 0; // [1:Yes,0:No]

// Do you want feet? (NB! Experimental, need support when printing)
feet = 0; // [1:Yes,0:No]

/* [Hidden] */
detail = 10;
sqr2 = sqrt(2);

// Difference will construct a main shape and subtract cut outs
difference() {
  //***********
  // Main Shape
  //***********
    
  union(){    
    // Flower pot cup
    difference() {      
      
      // Flower pot solid
      union(){
          
        // Brim
        if (brim == 1) {
          translate([0,0,height-1]) {
            if (shape == 1) {
                cylinder(d1=top*sqr2+3,d2=top*sqr2+8,h=2,$fn=4);
              //}
            }
        
            if (shape == 0) {
              cylinder(d1=top+3,d2=top+8,h=2,$fn=60);
            }   
          }
        }
        
        // Main shape
        translate([0,0,0]) {
          if (shape == 1) {
            cylinder(d1=bottom*sqr2,d2=top*sqr2,h=height,$fn=4);
              
          if (feet == 1) {
            translate([bottom*sqr2/2-5,0,-5]) {
              cylinder(d1=10,d2=10,h=5,$fn=4);
            }
            
            translate([0,bottom*sqr2/2-5,-5]) {
              cylinder(d1=10,d2=10,h=5,$fn=4);
            }

            translate([-bottom*sqr2/2+5,0,-5]) {
              cylinder(d1=10,d2=10,h=5,$fn=4);
            }

            translate([0,-bottom*sqr2/2+5,-5]) {
              cylinder(d1=10,d2=10,h=5,$fn=4);
            }
            
            translate([0,0,-5]) {
              cylinder(d1=10,d2=10,h=5,$fn=4);
            }
            
            }

          }
          
          if (shape == 0) {
            cylinder(d1=bottom,d2=top,h=height,$fn=60);
              
             if (feet == 1) {
            translate([bottom/2-5,0,-5]) {
              cylinder(d1=10,d2=10,h=5,$fn=40);
            }
            
            translate([0,bottom/2-5,-5]) {
              cylinder(d1=10,d2=10,h=5,$fn=40);
            }

            translate([-bottom/2+5,0,-5]) {
              cylinder(d1=10,d2=10,h=5,$fn=40);
            }

            translate([0,-bottom/2+5,-5]) {
              cylinder(d1=10,d2=10,h=5,$fn=40);
            }
            
            translate([0,0,-5]) {
              cylinder(d1=10,d2=10,h=5,$fn=40);
            }
            
            }
              
          }
        }
        
        
        
      } // End Union
      
      union(){ // Union cut outs
          
      // Flower pot cut out
      translate([0,0,t]) {
        if (shape == 1) {
          cylinder(d1=bottom*sqr2-t*2,d2=top*sqr2-t*2,h=height-t,$fn=4);
          translate([0,0,height-t-0.1]) {
            cylinder(d1=top*sqr2-t*2,d2=top*sqr2-t*2,h=t*2+5,$fn=4);
          }
        }
        
        if (shape == 0) {
          cylinder(d1=bottom-t*2,d2=top-t*2,h=height-t,$fn=60);
          translate([0,0,height-t-0.1]) {
            cylinder(d1=top-t*2,d2=top-t*2,h=t*2+5,$fn=60);
          }
        }
        
      }
      
     //  translate([0,0,height-t]) {
     //    cylinder(d1=top*sqr2-t,d2=top*sqr2-t,h=t*2+5,$fn=4);
     //  }
      
      if (perforate == 1) {
      for (rotation =[0:600/bottom:360]) {
            rotate([0,0,rotation]) {
                translate([bottom/3,0,t+5]) {
                    rotate([0,0,0]) {
                        // Draw blades
                        cube([top,2,height/2-10],false);
                    } // End rotate
                } // End translate       
            } // End rotate
        } // End for spaceW
        
          for (rotation =[0:600/top:360]) {
            rotate([0,0,rotation]) {
                translate([top/3,0,height/2+2.5]) {
                    rotate([0,0,0]) {
                        // Draw blades
                        cube([top,2,height/2-10],false);
                    } // End rotate
                } // End translate       
            } // End rotate
        } // End for spaceW
        }
      
      // Holes in the bottom Part 1
      if (holes == 1) {
          for (spaceW =[-bottom:6:bottom]) {
            translate([2.5,-spaceW,-1]) {
              cube([bottom,2,t+3],false);
            } // End translate
          } // End for spaceW
      
      // Holes in the bottom Part 2
          for (spaceW =[-bottom:6:bottom]) {
            translate([-bottom-2.5,-spaceW,-1]) {
              cube([bottom,2,t+3],false);
            } // End translate
          } // End for spaceW
      } // End if holes
      
      } // End union cut outs
    } // End difference flower pot
  } // End union
} // End difference  
