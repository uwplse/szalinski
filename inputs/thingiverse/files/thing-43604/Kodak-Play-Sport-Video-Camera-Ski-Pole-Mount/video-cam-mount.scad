// mount for video cam

//base

  translate([0,-5.5,0]) cube([65,20,4]);
  difference () {
    union () {
     translate([55,-25, 0]) cube([20,65,4]);
     translate([45,-3,0]) rotate([0,0,45]) cube([38,10,4]);
     translate([45,-3,0]) rotate([0,0,-45]) cube([28,10,4]);
     }
    translate([64,-10,-1]) cylinder (h=10,r=2.1, $fn=30); //mount hole
    translate([64,-10,2]) cylinder (h=3,r=3.6, $fn=30); //mount hole
   }


// Bottom clip
difference () {
   translate([0,-5.5,0]) cube([4,20,23]);
   translate([-2,4.5,15]) rotate ([0,90,0]) cylinder (h=10,r=3.2, $fn=30); //tripod hole
}
translate([8.5,-5.5,0]) rotate([20,0,90]) cube([20,8,4]);

// Right Clip
union () {
translate([55,-25,0]) cube([20,3,24]);
translate([55,-25,22]) cube([20,8,2]);
translate([55,-22,18]) rotate([45,0,0]) cube([20,6,2]);
translate([55,-23,20]) cube([20,3,3]);
translate([55,-24,3]) rotate([-20,0,0]) cube([20,8,4]);
}

// Left Clip
union () {
translate([55,37,0]) cube([20,3,24]);
translate([55,32,22]) cube([20,8,2]);
translate([55,33,22]) rotate([-45,0,0]) cube([20,6,2]);
translate([55,35,20]) cube([20,3,3]);
translate([55,32,0]) rotate([20,0,0]) cube([20,8,4]);
}