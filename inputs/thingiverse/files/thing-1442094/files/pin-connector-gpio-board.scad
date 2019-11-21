/*
 *  pin-connector-gpio-board.scad
 *  2016 by http://www.thingiverse.com/roha/
 */

pins = 20; // [1:100]
rows = 2; // [1:100]
hight = 6; // [1:20]
hole = 75; // [50:200]
wall = 3; // [1:30]

difference() {
  translate([-wall/10,-wall/10,0])
  cube([2.54*pins+2*wall/10,2.54*rows+2*wall/10,hight]);
  union() {
    for (iR = [1:rows]) {
      for (iP = [1:pins]) {
        color("red")
        translate([-2.54/2+2.54*iP,-2.54/2-hole/100/3+2.54*iR,0])
        cylinder(hight,hole/100,hole/100,$fs=0.1);
        color("green")
        translate([-2.54/2+2.54*iP,-2.54/2+hole/100/3+2.54*iR,0])
        cylinder(hight,hole/100,hole/100,$fs=0.1);
      }
    }  
  }
}
