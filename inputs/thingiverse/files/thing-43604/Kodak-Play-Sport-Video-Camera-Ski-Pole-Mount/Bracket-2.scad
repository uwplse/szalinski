// Pole Mount

difference () {
  union () {
     cube([4,46,12]);
     translate ([7,23,0]) cylinder (h=12,r=12);
    }
  translate ([7,23,-1]) cylinder (h=14, r=10);
  translate ([-10, 6,6]) rotate ([0,90,0]) cylinder (h=15,r=2, $fn=50);
  translate ([-10, 40,6]) rotate ([0,90,0]) cylinder (h=15,r=2, $fn=50);
  translate ([4,5,-1]) cube([15,30,14]);

}