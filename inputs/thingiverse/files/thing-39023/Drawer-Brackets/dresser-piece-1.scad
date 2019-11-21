difference() {
   cube([27,23,4]);
   translate([10,11.5,-1]) cylinder (h=17,r=2);
   translate([10,11.5,-1]) sphere (h,r=4);
}

hull() {
translate([20,0,0]) cube([6,23,4]);
translate([26,4,0]) cube([25,15,4]);
}

difference() {
   translate([0,6.5,2]) cube ([20,10,12]);
   translate([10,11.5,-1]) cylinder (h=17,r=2);
}
translate([20,10,3]) rotate([90,270,180])  linear_extrude(height = 4) polygon(points=[[0,0],[0,31],[10,0]]);