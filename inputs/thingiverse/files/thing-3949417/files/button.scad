// Created in 2019 by Ryan A. Colyer.
// This work is released with CC0 into the public domain.
// https://creativecommons.org/publicdomain/zero/1.0/
//
// https://www.thingiverse.com/thing:3949417


diam = 19;
thick = 2;
holepos = -1; // -1 is auto
holediam = 2.0;
holecount = 4;
rim = 0.5;
smoothby = 0.8;

$fa = 1;
$fs = 0.4;

module Button(diam, thick=2, holepos=-1, holediam=2.0, holecount=4,
    rim=0.5, smoothby=0.8) {
  holepos_automin = 1.5*holediam/sqrt(pow(1-cos(360/holecount),2) +
    pow(sin(360/holecount),2));
  holepos_use = holepos >= 0 ? holepos :
    diam/8 < holepos_automin ? holepos_automin : diam/8;
  rounded = smoothby < thick/2-0.001 ? smoothby : thick/2-0.001;
  
  difference() {
    rotate_extrude()
    intersection() {
      square([diam, thick+rim]);
      translate([0, rounded])
        offset(-rounded)
        offset(2*rounded)
        {
          square([diam/2-rounded, thick-2*rounded]);
          if (rim > 0) {
            translate([diam/2-rounded-rim, thick-2*rounded-0.001])
              square([rim, rim+0.001]);
          }
        }
    }
    for (a=[0:360/holecount:359.999]) {
      rotate([0, 0, a])
        translate([holepos_use, 0, -1])
        cylinder(d=holediam, h=thick+2);
    }
  }
}


Button(diam, thick, holepos, holediam, holecount, rim, smoothby);

