include <../hextile/symkeys.scad>

module holder() {
  hextile(36);
  translate([-6,-10,0])
    difference() {  
      cube([12,20,12.5]);
      translate([0,10.5,12.5])
        rotate([0,90,0])      
          cylinder(h=12, r=10.5);    
    }
  translate([6,0,12.5])
    rotate([0,-90,0])
      import("./files/Improved_Sewing_Bobbin_Clip.stl");
}

difference() {
    holder();    
translate([-15,9.6,19])
  cube([30,60,30]);
translate([-15,-69.6,19])
  cube([30,60,30]);
}
