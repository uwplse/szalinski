// Created in 2016 by Ryan A. Colyer.
// This work is released with CC0 into the public domain.
// https://creativecommons.org/publicdomain/zero/1.0/
//
// http://www.thingiverse.com/thing:1686365


use <threads.scad>


thick = 8;
botxlen = 35;
topxlen = 35-8;
ylen = 20+12;
roundby = 4;

mountdiam = 5;
mounty = 10;
mountx1 = 1.5*mountdiam;
mountx2 = botxlen - mountx1;
mountscrewlen = 12;
extruded_depth = 6;
mountthick = mountscrewlen - extruded_depth + 0.3;

smoothbarx = botxlen-19;
smoothbary = 20+5.5;
smoothbardiam = 8;
smooth_tolerance = 0.2;

coverx = 0;
covery = 20;
coverxlen = topxlen;
coverylen = ylen - covery;


module YEndBracket() {
  RecessedClearanceHole(mountdiam, thick, [mountx1,mounty,0],
    recessed_height=(thick-mountthick))
  RecessedClearanceHole(mountdiam, thick, [mountx2,mounty,0],
    recessed_height=(thick-mountthick))
  
  ClearanceHole(smoothbardiam, thick, [smoothbarx,smoothbary,0])

  union() {
    translate([0,covery,thick])
      cube([coverxlen, coverylen-roundby, thick]);
    minkowski() {
      translate([roundby,roundby,0])
        cylinder(h=thick/2, r=roundby, $fn=24*roundby);
      union() {
        cube([botxlen-2*roundby, covery-2*roundby, thick/2]);
        cube([topxlen-2*roundby, ylen-2*roundby, thick/2]);
        translate([coverx,covery,thick/2])
          cube([coverxlen-2*roundby, coverylen-2*roundby, thick]);
      }
    }
  }
}


module LeftYEndBracket() {
  scale([-1,1,1])
    rotate([0,-90,180])
    YEndBracket();
}


module RightYEndBracket() {
  translate([0,30,0])
    rotate([0,-90,0])
    YEndBracket();
}


//YEndBracket();
LeftYEndBracket();
RightYEndBracket();

