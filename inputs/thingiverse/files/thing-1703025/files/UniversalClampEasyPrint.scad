// preview[view:north east, tilt:top diagonal]

// Diameter of tube
d = 18; // [3:0.1:100]

// Length of mount
h = 36; // [3:100]

// Do you want vertical mount?
Vmount = 1; // [1:Yes,0:No]

// Do you want horizontal mount?
Hmount = 1; // [1:Yes,0:No]

/* [Hidden] */
r = d/2;
f = d/7;
t = d/6;
a = 44;
detail = 60;

// Difference will construct a main shape and subtract cut outs
difference() {
    
  //***********
  // Main Shape
  //***********
    
  union(){    
      
    // Main cylinder solid
    translate([0,0,h/2]) {
      cylinder(h, r+t,r+t,true,$fn=detail);
    }
       
   // Horizontal mounting plate  
   if (Hmount == 1) {
   rotate([0,0,0]) {
     translate([-r-t/2,-d*1.5,0]) {
       cube([d+t, d*1.5, t*2], false);
     }
   }
   }
   
   // Vertical mounting plate
   if (Vmount == 1) {
   rotate([0,90,0]) {
     translate([-h,-d*1.5,-t/2]) {
       cube([h, d, t], false);
     }
   }
   }

  } // End union


  //**********  
  // Cut outs
  //**********
  
  // Cut out center cylinder
  translate([0,0,-1]) {
    cylinder(h+2, r, r, false, $fn=detail);
    }
  
     // Cut out right wall
    rotate([0,0,a]) {
      translate([0,r,h/2]) {
        cube([t, d, h+2],true);   
      }
    }

   // Cut out left wall
   rotate([0,0,-a]) {
      translate([0,r,h/2]) {
        cube([t, d, h+2],true);   
      }
    }

    // Cut out center wall
    translate([0,r,h/2]) {
        cube([d/1.18, d, h+2],true);   
      }
    
  } // End difference
  