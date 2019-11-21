union() {
  translate([0,0,-25.3/2])
    cylinder(d=25.3, h=25, $fn=45);

  translate([0,0,25.3/2])
    resize([0,0,7])
      sphere(d=25.3, $fn=45);
    
  translate([0,0,-25.3/2])
    resize([0,0,7])
      sphere(d=25.3, $fn=45);
  }    
    
translate ([25,40,-11])
  difference() {
    hull() {
      cube([45,12,22]);  
  
      translate ([0,0,-1.5])
        cube([6,12,1.5]);
      
      translate ([6,6,-1.5])
        cylinder(d=12,h=1.5, $fn=45);

      translate ([0,0,22])
        cube([6,12,1.5]);
      
      translate ([6,6,22])
        cylinder(d=12,h=1.5, $fn=45);
      }
    translate([-1,-1,3])  
      cube([47,6,16]);
    translate([36,15,11])
      rotate([90,0,0])
        cylinder(d=5.2, h=20, $fn=90); 
   }
  
difference() {
  rotate([0,0,58])  
    translate([0,-6,-12.5])
      cube([57,12,25]);      
    
  rotate([0,0,58])  
    translate([0,-7,-7])
      cube([30,14,14]);  
}
 