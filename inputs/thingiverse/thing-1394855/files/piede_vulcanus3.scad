

module cubo() {
    union() {
union() {
cube([30,20,15]);
    
translate([20,0,15])
rotate([0,90,0])

cube([10,20,50]);
}
translate([0,0,0])
rotate([90,0,0])
cube([20,15,50]);
}
}


 module cubetto() {
     union() {
   translate([15,7,17])
rotate([0,90,0])

cube([10,6,55]);
     
 translate([7,5,7])
rotate([90,0,0])
cube([6,10,55]); 
     }
     
 }
 
  module vite() {
 translate([10,-30,4])
 cylinder(h=30, d=5.5);
  translate([10,-30,-1])
 cylinder(h=7, d=9);
     
 }
 
   module vite_destra() {
       
 translate([-30,10,4])
 cylinder(h=30, d=5.5);
  translate([-30,10,-1])
 cylinder(h=7, d=9);
     
 }
 
 
 module parte_principale() {
     
     union() {
  union () {   
cubo();

cubetto();
  }
   translate([20,0,0])
 cylinder(h=7, r=55);
  }
 }

 
 module viti_pezzo() {
 translate([0,20,0])
 vite();
 
 translate([0,-10,0])
 vite();
 
  translate([60,0,0])
 vite_destra();
 
 
translate([90,0,0])
 vite_destra();
 }
 
 
 difference() {
     
    
   parte_principale();
      viti_pezzo();
 }
 
