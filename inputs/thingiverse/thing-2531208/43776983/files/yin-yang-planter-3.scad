// lucina
// 2017-09-08

// preview[view:south, tilt:top]
/* [yin-yang dimensions] */
// outer circle diameter in mm
outerD = 80;   //[50:5:200]
// height in mm
height = 40;      //[20:5:200]
// wall thicknessin mm
wall = 1.2;  //[.9:.1:6]
// bottom drain hole
drainHole = "yes"; //[yes, no]
// bottom drain hole diameter in mm
drainHoleD = 8; //[5:1:15]
// select planter, saucer, or frame
selection = "planter"; //[planter, saucer, frame]
// saucer or frame height in mm
saucerHeight = 7; //[5:1:20]
// saucer or frame wall thickness in mm
saucerWall = .9; //[.9:.1:6]

/* [Hidden] */
$fn = 50;
x = 0; y = 1; z = 2;
outerR = outerD/2;
innerR = outerR-wall;
module yin(w) {
   union() {
      difference() {
         cylinder(h = height, r = outerR, center = true);
         union() {
            translate([0, -(outerR/2), 0])
               cylinder(h = height*2, r = outerR/2, center=true);
            translate([outerR/2, 0, 0])
               cube([outerR, 2*outerR, 2*height], center=true);
         }
      }
      translate([0, outerR/2, 0])
         cylinder(h = height, r = outerR/2, center=true);
   }
}
module yang(w) {
      union() {
         difference() {
            cylinder(h = height, r = innerR, center = true);
            union() {
               translate([-w/2, -outerR/2, 0])
                  cylinder(h = height*2, r = outerR/2+w, center=true);
               translate([innerR/2, 0, 0])
                  cube([innerR, 2*innerR, 2*height], center=true);
            }
         }           
         translate([0, innerR/2+w/2, 0])
            cylinder(h = height, r = innerR/2-w/2, center=true);
         if ( drainHole == "yes" )
            translate([0, outerR/2, 0])
               cylinder(h = height*2, d=drainHoleD, center=true);
      }
}
module yinYang() {
   difference() {
      yin(wall);
      translate([0, 0, wall])
         yang(wall);
   }
}

module saucer(hh, dd, tt) {
   allow = 2.5;
   taper = 5;
   union() {
      difference() {
         hull() {
            translate([0, 0, hh-.001])
               cylinder(h=.001, d=dd+2*tt+allow+taper);
            cylinder(h=.001, d=dd+2*tt+allow);
         }
         union() {
            translate([0, 0, tt])
               hull() {
                  translate([0, 0, hh-.001])
                     cylinder(h=.001, d=dd+allow+taper);
                  cylinder(h=.001, d=dd+allow);
               }
            if ( selection == "frame" ) {
               translate([0, 0, -tt])
                  cylinder(h=3*tt, d=.9*dd);
            }
         }
      }
      if ( selection == "frame" )
         interHexGrid(dd*.90, 12, tt);
   }
}
sin60 = sin(60);
cos60 = cos(60);
module hex(hole, wall, thick){
   difference(){
      rotate([0, 0, 30])
         cylinder(d = (hole + wall), h = thick, $fn = 6);
      translate([0, 0, -0.1])
         rotate([0, 0, 30])
            cylinder(d = hole, h = thick + 0.2, $fn = 6);
    }
}
// first arg is vector that defines the bounding box, length, width, height
// second arg in the 'diameter' of the holes. In OpenScad, this refers to the corner-to-corner diameter, not flat-to-flat
// this diameter is 2/sqrt(3) times larger than flat to flat
// third arg is wall thickness.  This also is measured that the corners, not the flats. 
module hexgrid(box, holediameter, wallthickness) {
    a = (holediameter + (wallthickness/2))*sin60;
   for(x = [holediameter/2: a: box[x]]) {
      for(y = [holediameter/2: 2*a*sin60: box[y]]) {
         translate([x, y, 0])
            hex(holediameter, wallthickness, box[z]);
         translate([x + a*cos60, y + a*sin60, 0])
            hex(holediameter, wallthickness, box[z]);
      }
   }
}
module interHexGrid(gridDiam, hexDiam, zz) {
   intersection() {
      translate([-gridDiam/2, -gridDiam/2, 0])
         hexgrid([gridDiam, gridDiam, zz], hexDiam, zz);
      cylinder(h=zz, d=gridDiam+2*zz);
   }
}

if ( selection == "planter" ) {
   yinYang();
//   translate([wall, 0, 0])
//      rotate([0, 0, 180])
//         yinYang();
}
if ( selection == "saucer" ) {
   saucer(saucerHeight, outerD, wall/2);
}
if (selection == "frame" ) {
      saucer(saucerHeight, outerD, wall/2);
}