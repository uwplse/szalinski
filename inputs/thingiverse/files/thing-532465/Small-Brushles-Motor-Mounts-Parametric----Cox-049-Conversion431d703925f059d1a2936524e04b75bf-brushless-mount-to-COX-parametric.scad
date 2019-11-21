//Brushless-cox mount.
//Parametric.
//Oktay Gülmez, 6/11/2014.
//GNU_GPL_V3


//Parameters:
//-45 degree motor mount holes distance(16 or 19).
a=16;
//+45 degree motor mount holes distance(16 or 19).
b=19; 
//Block height(10 to 30).
height=15; 


$fn=20;

difference(){
  union(){
    minkowski(){
      translate([-9.92,-13.5,0]) cube([19.84,27,4]);
        cylinder(r=3.5);
    }

   translate([0,0,0]) cylinder(h=height-5, r=14.5, $fn=64);
   translate([0,0,height-5]) cylinder(h=5, r1=14.5, r2=13, $fn=64);

   
  }
   translate([0,0,-1]) cylinder(h=50, r=5, $fn=36);

   translate([0,0,0]) rotate([atan(13/height),0,0]) cylinder(h=height+20, r=4, $fn=36);

   translate([-9.92,-13.5,-1]) cylinder(h=10, r=1.8); 
   translate([9.92,-13.5,-1]) cylinder(h=10, r=1.8); 
   translate([-9.92,13.5,-1]) cylinder(h=10, r=1.8); 
   translate([9.92,13.5,-1]) cylinder(h=10, r=1.8);

   translate([-9.92,-13.5,5]) cylinder(h=50, r=3.5); 
   translate([9.92,-13.5,5]) cylinder(h=50, r=3.5); 
   translate([-9.92,13.5,5]) cylinder(h=50, r=3.5); 
   translate([9.92,13.5,5]) cylinder(h=50, r=3.5);

   rotate([0, 0, 45])
    translate([0, a/2, -1])
    cylinder(h=50, r=1.8);
   rotate([0, 0, 45])
    translate([0, a/2, -1])
    cylinder(h=4, r=3);

  rotate([0, 0, 135])
    translate([0, b/2, -1])
    cylinder(h=50, r=1.8);
  rotate([0, 0, 135])
    translate([0, b/2, -1])
    cylinder(h=4, r=3);

  rotate([0, 0, 225])
    translate([0, a/2, -1])
    cylinder(h=50, r=1.8);
  rotate([0, 0, 225])
    translate([0, a/2, -1])
    cylinder(h=4, r=3);

   rotate([0, 0, 315])
    translate([0, b/2, -1])
    cylinder(h=50, r=1.8);
   rotate([0, 0, 315])
    translate([0, b/2, -1])
    cylinder(h=4, r=3);

}
