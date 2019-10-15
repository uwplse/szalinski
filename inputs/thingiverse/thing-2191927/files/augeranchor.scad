// Created in 2017 by Ryan A. Colyer.
// This work is released with CC0 into the public domain.
// https://creativecommons.org/publicdomain/zero/1.0/
//
// http://www.thingiverse.com/thing:2191927

use <threads.scad>  // v2 or greater, http://www.thingiverse.com/thing:1686322

diam = 20;
holediam = 3.2;
roddiam = 8;
straightlen = 19.0;
angledlen = 9.6;
thread_pitch = 6;
cap_extra = 2;
cap_diam = diam + cap_extra;
cap_angle = 35;
holetopdiam = 1;
slit_width = 0.5;
nonslit_height = 12;
height = straightlen + angledlen;
slit_height = height - nonslit_height;

phillips_width = 7;
phillips_thick = 2.5;
phillips_straightdepth = 3.5;

quantity=6;


module AugerAndCap() {
  //angled_extra = angledlen / (roddiam/holetopdiam - 1);
  difference() {
    AugerThread(diam, roddiam, height,
      thread_pitch, tip_height=angledlen);
  }
  cylinder(r1=cap_diam/2, r2=roddiam/2,
    h=(((cap_diam-roddiam)/2)*tan(cap_angle)));
}


module AugerAnchor() {
  PhillipsTip(phillips_width, phillips_thick, phillips_straightdepth)
    difference() {
      AugerAndCap();

      translate([0,0,-0.01])
        cylinder(r=holediam/2, h=straightlen+0.02, $fs=0.02, $fa=1);
      translate([0,0,straightlen-0.01])
        cylinder(r1=holediam/2, r2=holetopdiam/2,
          h=angledlen+0.02, $fs=0.02, $fa=1);
      translate([-diam, -slit_width/2, height - slit_height])
        cube([diam*2, slit_width, slit_height]);
    }
}


// This creates an array of the specified number its children, arranging them
// for the best chance of fitting on a typical build plate.
module MakeSet(quantity=1, x_len=30, y_len=30) {
  bed_yoverx = 1.35;
  x_space = ((x_len * 0.2) > 15) ? (x_len * 0.2) : 15;
  y_space = ((y_len * 0.2) > 15) ? (y_len * 0.2) : 15;
  function MaxVal(x, y) = (x > y) ? x : y;
  function MaxDist(x, y) = MaxVal((x_len*x + x_space*(x-1))*bed_yoverx,
    y_len*y + y_space*(y-1));
  function MinExtentX(x) = ((x >= quantity) ||
    (MaxDist(x+1, ceil(quantity/(x+1))) > MaxDist(x, ceil(quantity/x)))) ?
    x : MinExtentX(x+1);
  colmax = MinExtentX(1);

  for (i=[1:quantity]) {
    translate([(x_len + x_space)*((i-1)%colmax),
      (y_len + y_space)*floor((i-1)/colmax), 0])
      children();
  }
}


MakeSet(quantity, diam, diam)
AugerAnchor();

