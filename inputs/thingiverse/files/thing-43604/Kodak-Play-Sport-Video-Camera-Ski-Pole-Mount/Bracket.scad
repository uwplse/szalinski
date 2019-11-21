// Pole Mount

difference () {
  hull () {
     cube([6,46,12]);
     translate ([-15,18,0]) cube([15,10,12]);
    }
  translate ([7,23,-1]) cylinder (h=14, r=10);
  translate ([-10, 6,6]) rotate ([0,90,0]) cylinder (h=20,r=2, $fn=50);
  translate ([1, 2,10]) rotate ([0,90,0]) cube([9,9,3]);
  translate ([-10, 40,6]) rotate ([0,90,0]) cylinder (h=20,r=2, $fn=50);
  translate ([1, 35,10]) rotate ([0,90,0]) cube([9,9,3]);
  translate ([-25, 23,6]) rotate ([0,90,0]) cylinder (h=25,r=2, $fn=50);
  translate ([-10, 19,10]) rotate ([0,90,0]) cube([9,9,3]);
}