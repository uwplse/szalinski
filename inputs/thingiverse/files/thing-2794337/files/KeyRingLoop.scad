/* KeyRingLoop.scad by Alex Bruski on 2/14/2018
 *
 */
 FN=360; // Facet Number for resolution.
 RR=20; // Ring Radius in mm.
 CCR=3; // Cross Cord Radius in mm.
 GAP=0.1; // Ring separation GAP in mm.
 difference()
 {
 rotate_extrude($fn=FN,convexity=5)
   translate([RR,0])circle(r=CCR,$fn=FN);
   connection();
   difference()
   {
     cube([2*(RR+CCR),2*(RR+CCR),GAP],center=true);   
     translate([RR,0,0])
       cube([3*CCR,6*CCR,CCR],center=true);
   }
 }
 module connection()
 {
   rotate([0,0, 30])translate([RR,0, CCR])
     cube([3*CCR,2*CCR,2*CCR],center=true);
   rotate([0,0,-30])translate([RR,0,-CCR])
     cube([3*CCR,2*CCR,2*CCR],center=true);
 }