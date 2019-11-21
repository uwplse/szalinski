// Created in 2018 by Ryan A. Colyer.
// This work is released with CC0 into the public domain.
// https://creativecommons.org/publicdomain/zero/1.0/
//
// https://www.thingiverse.com/thing:3024647

battery_diam = 18.5;
clearance = 0.4;
rimthick = 2;
basethick = 2;

numx = 2;
numy = 8;

battery_depth = 13;

$fa = 1;
$fs = 0.4;

hole_diam = battery_diam + clearance;

height = battery_depth + basethick;

pitch = hole_diam + rimthick;

squarex = numx*pitch - rimthick - hole_diam + 0.001;
squarey = numy*pitch - rimthick - hole_diam + 0.001;

chamferby = rimthick * 2/5;

echo(squarex, squarey);

difference() {
  linear_extrude(height=height)
    offset(r=rimthick+hole_diam/2)
    square(size = [squarex, squarey]);

  for(y=[0:numy-1])
    for(x=[0:numx-1])
      translate([x*pitch, y*pitch, rimthick])
        union() {
          cylinder(d=hole_diam, h=battery_depth+0.1);
          translate([0, 0, battery_depth+0.1-chamferby])
            cylinder(d1=hole_diam, d2=hole_diam+2*chamferby, h=chamferby);
        }
}

