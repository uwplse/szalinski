$fn=64;
difference() {
   union() {
      cylinder(r=28,h=20);translate([0,0,-3]) cylinder(r=30,h=3);
      translate([0,0,-8]) cylinder(r1=8,r2=30,h=5);
   }
   cylinder(r=4,h=60,center=true);
}

