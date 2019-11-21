$fn=50;

cube([15,20,8]);
difference () {
  translate([14,10,4])  rotate([0,91.3,0]) cylinder(h=41, r1=4, r2=3);
  translate([45,15,3.2]) rotate([90,0,0]) cylinder(h=10, r=1);
}
