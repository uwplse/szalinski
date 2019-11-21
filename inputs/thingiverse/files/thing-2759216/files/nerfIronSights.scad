module pick(){
  cylinder(d=4,h=8, $fn=20);
  translate([0,0,8]) cylinder(r1=2, r2=0,h=2, $fn=20);
}

translate([0,0,25]) rotate([-90,0,0])
union(){
difference(){
  cube([23,50,8.5],center=true);
  translate([0,0,-2]) cube([13,50,6.5],center=true);
  translate([0,0,0.25]) cube([18.6,50,3],center=true);
}

difference(){
  translate([0,9,17.5])
    minkowski(){
      cube([25,30,25],center=true);
      rotate([0,90,90]) cylinder(r=2,h=1, $fn=50);
    }
  translate([0,9,17.5])
    minkowski(){
      cube([21,31,21],center=true);
      rotate([0,90,90]) cylinder(r=2,h=1, $fn=50);
    }
  translate([0,3,30]) rotate([60,0,0]) cube([30,25,25], center=true);
  translate([0,-5,20]) rotate([20,0,0]) cube([30,25,25], center=true);
}

translate([0,21,5]) pick();
translate([-12.5,21,17.5]) rotate([0,90,0]) pick();
translate([0,21,30]) rotate([0,180,0]) pick();
translate([12.5,21,17.5]) rotate([0,270,0]) pick();
}