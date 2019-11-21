$fn = 100;
PI = 3.141592 * 1;

lidHeight = 21.4;
lidDiameter = 75.64;
lidWallThickness = 2.7;

union() {
  difference() {
    union() {
      // Main body
      difference() {
        cylinder(d = lidDiameter, h = lidHeight);
        translate([0, 0, -0.01]) cylinder(d = lidDiameter - lidWallThickness * 2, h = lidHeight - lidWallThickness + 0.01);
      }

      // Grip "things"
      for (i = [1 : 1 : 20]) rotate([0, 0, (360 / 20) * i]) hull() {
        translate([-1, lidDiameter / 2 + 0.5, 0]) cube([2, 0.01, lidHeight]);
        translate([-1.5, lidDiameter / 2 - 0.5, 0]) cube([3, 0.01, lidHeight]);
      }
    }

    // Smooth edges
    translate([0, 0, lidHeight - 3]) color([1, 0, 1]) difference() {
      translate([0, 0, 0.01]) cylinder(d = lidDiameter + 4, h = 5);
      hull() {
        translate([0, 0, 0]) cylinder(d = lidDiameter + 3, h = 0.01);
        translate([0, 0, 3]) cylinder(d = lidDiameter - 3, h = 0.01);
      }
    }
    translate([0, 0, 3]) rotate([180, 0, 0]) color([1, 0, 1]) difference() {
      translate([0, 0, 0.01]) cylinder(d = lidDiameter + 4, h = 5);
      hull() {
        translate([0, 0, 0]) cylinder(d = lidDiameter + 3, h = 0.01);
        translate([0, 0, 3]) cylinder(d = lidDiameter - 3, h = 0.01);
      }
    }
  }

  // Screw threads
  difference() {
    difference() {
      cylinder(d = lidDiameter, h = lidHeight - lidWallThickness);
      intersection() {
        screw_thread(lidDiameter - lidWallThickness * 2 + 2.2, lidHeight / 3, 55, lidHeight, PI / 3);
        cylinder(d = lidDiameter - lidWallThickness * 2, h = lidHeight);
      }
    }
    union() {
      translate([0, 0, 21.4]) cylinder(d = lidDiameter * 1.1, h = 10);
      translate([0, 0, 0]) cylinder(d = lidDiameter * 1.1, h = 4.15);
      translate([0, 0, -9]) cylinder(d = lidDiameter * 1.1, h = 10);
    }
  }
}

/*
 *    polyScrewThread_r1.scad    by aubenc @ Thingiverse
 *
 * This script contains the library modules that can be used to generate
 * threaded rods, screws and nuts.
 *
 * http://www.thingiverse.com/thing:8796
 *
 * CC Public Domain
 */
module screw_thread(od,st,lf0,lt,rs,cs) {
  or=od/2;
  ir=or-st/2*cos(lf0)/sin(lf0);
  pf=2*PI*or;
  sn=floor(pf/rs);
  lfxy=360/sn;
  ttn=round(lt/st+1);
  zt=st/sn;

  intersection() {
    if (cs >= -1) {
      thread_shape(cs,lt,or,ir,sn,st);
    }
    full_thread(ttn,st,sn,zt,lfxy,or,ir);
  }
}

module thread_shape(cs,lt,or,ir,sn,st) {
  if ( cs == 0 ) {
    cylinder(h=lt, r=or, $fn=sn, center=false);
  } else {
    union() {
      translate([0,0,st/2])
        cylinder(h=lt-st+0.005, r=or, $fn=sn, center=false);

      if ( cs == -1 || cs == 2 ) {
        cylinder(h=st/2, r1=ir, r2=or, $fn=sn, center=false);
      } else {
        cylinder(h=st/2, r=or, $fn=sn, center=false);
      }

      translate([0,0,lt-st/2])
        if ( cs == 1 || cs == 2 ) {
          cylinder(h=st/2, r1=or, r2=ir, $fn=sn, center=false);
        } else {
          cylinder(h=st/2, r=or, $fn=sn, center=false);
        }
    }
  }
}

module full_thread(ttn,st,sn,zt,lfxy,or,ir) {
  if(ir >= 0.2) {
    for(i=[0:ttn-1]) {
      for(j=[0:sn-1]) {
        pt = [
          [0,                  0,                  i*st-st            ],
          [ir*cos(j*lfxy),     ir*sin(j*lfxy),     i*st+j*zt-st       ],
          [ir*cos((j+1)*lfxy), ir*sin((j+1)*lfxy), i*st+(j+1)*zt-st   ],
          [0,0,i*st],
          [or*cos(j*lfxy),     or*sin(j*lfxy),     i*st+j*zt-st/2     ],
          [or*cos((j+1)*lfxy), or*sin((j+1)*lfxy), i*st+(j+1)*zt-st/2 ],
          [ir*cos(j*lfxy),     ir*sin(j*lfxy),     i*st+j*zt          ],
          [ir*cos((j+1)*lfxy), ir*sin((j+1)*lfxy), i*st+(j+1)*zt      ],
          [0,                  0,                  i*st+st            ]
        ];
        polyhedron(points=pt, faces=[
          [1,0,3], [1,3,6], [6,3,8], [1,6,4], [0,1,2], [1,4,2], [2,4,5],
          [5,4,6], [5,6,7], [7,6,8], [7,8,3], [0,2,3], [3,2,7], [7,2,5]
        ]);
      }
    }
  } else {
    echo("Step Degrees too agresive, the thread will not be made!!");
    echo("Try to increase de value for the degrees and/or...");
    echo(" decrease the pitch value and/or...");
    echo(" increase the outer diameter value.");
  }
}

