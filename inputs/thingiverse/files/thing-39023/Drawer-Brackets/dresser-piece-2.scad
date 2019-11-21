difference() {
    cube ([16,55,3]);
    translate([10,12,-1]) cylinder (h=5,r=2);
    translate([10,43,-1]) cylinder (h=5,r=2);
}
difference() {
   translate([14,0,0]) cube ([27,55,13]);
   translate([22,13,-1]) cube ([10,30,21]);
   translate([31,21.5,-1]) cube ([15,13,21]);
   translate([22,13,-1]) cube ([15,2,10.5]);
   translate([35,13,-1]) cube ([2,6,10.5]);
   translate([22,41,-1]) cube ([15,2,10.5]);
   translate([35,37,-1]) cube ([2,6,10.5]);
}

