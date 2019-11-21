// polygonal planter
// 2018-07-24 Lucina
// preview[view:south east, tilt:top diagonal]
/* [dimensions] */
// planter width (mm)
planterWidth = 100;  //[30:5:300]
// planter height (mm)
planterHeight = 62;  //[30:5:300]
// wall thickness (mm)
wall = 1.2; // [.6:.1:10]
/* [shape] */
// number of sides
numberOfSides = 6;   //[4:1:16]
// ratio of the width of the part between the cylindrical bottom and the polygonal top to the total width
taperWidthPercent = 85;  //[20:5:100]
// ratio of the height of the part between the cylindrical bottom and the polygonal top to the total height
taperHeightPercent = 45;   //[20:5:50]
// ratio of the cylindrical bottom diameter to the total width
bottomDiamPercent = 70;   //[20:5:100]
// planter corner radius (mm)
cornerRad = 1;   //[1:1:20]
/* [thing selection] */
// which model to render: planter or saucer
selection = "planter";   // [planter, saucer, both]
// cut out drain hole
drainHole = "yes";   // [yes, no]
// drain hole (mm)
hole = 8;   //[2:1:15]

/* [hidden] */
$fn = 60;
x = 0; y = 1; z = 2;
allow = 4;
taperWidth = (taperWidthPercent/100)*planterWidth;
taperHeight = (taperHeightPercent / 100)*planterHeight;
bottomDiam = (bottomDiamPercent/100)*planterWidth;
bottomHeight = 1.25*wall;
bottomRad = bottomHeight/2 - .2;
step = 360 / numberOfSides;
last = 360-step;
maxSaucerHeight = min(15, taperHeight);

module rshape(xx, yy, zz, rr) {
   hull() {
      for ( angle = [0:step:last] ) {
         rotate([0, 0, angle])
            translate([xx/2-rr, 0, 0])
               cylinder(h=zz, r=rr);
      }
   }
}

module fcube(xx, yy, zz, rr) {
   translate([-xx/2, -yy/2, rr])
      minkowski() {
         cube([xx-2*rr, yy-2*rr, zz-2*rr]);
         sphere(r=rr);
      }
}
module fcylinder(z, x, rad) {
   translate([0, 0, rad])
      minkowski() {
         cylinder(h=z-2*rad, d=x-2*rad);
            sphere(rad);
      }
}
module planter() {
   difference() {
      union() {
         fcylinder(bottomHeight, bottomDiam, bottomRad);
         hull() {
            translate([0, 0, bottomHeight-bottomRad])
               cylinder(h=bottomRad, d=bottomDiam);
            translate([0, 0, taperHeight - .001])
               rshape(taperWidth, taperWidth, .001, cornerRad);
         }
         hull() {
            translate([0, 0, taperHeight - .001])
               rshape(taperWidth, taperWidth, .001, cornerRad);
            translate([0, 0, planterHeight - .001])
               rshape(planterWidth, planterWidth, .001, cornerRad);
         }
      }
      union() {
         hull() {
            translate([0, 0, bottomHeight])
               cylinder(h=bottomRad, d=bottomDiam-2*wall);
            translate([0, 0, taperHeight - .001])
               rshape(taperWidth-2*wall, taperWidth-2*wall, .001, cornerRad);
         }
         hull() {
            translate([0, 0, taperHeight - .001])
               rshape(taperWidth-2*wall, taperWidth-2*wall, .001, cornerRad);
            translate([0, 0, planterHeight - .001])
               rshape(planterWidth-2*wall, planterWidth-2*wall, .001, cornerRad);
         }
         if ( drainHole == "yes" ) {
            translate([0, 0, -bottomHeight])
               cylinder(h=2*bottomHeight, d=hole);
         }
      }
   }
}
module saucer() {
   fcylinder(bottomHeight, bottomDiam+allow, bottomRad);
   // bumps
   intersection() {
      for ( n = [0:6] ) {
         rotate([0, 0, n*360/6])
            translate([.25*planterWidth, 0, 0])
               sphere(r=wall+2);
      }
      cylinder(h=wall+2, d= planterWidth);
   }
   difference() {
      union() {
         hull() {
            translate([0, 0, bottomHeight-bottomRad])
               cylinder(h=bottomRad, d=bottomDiam+allow);
            translate([0, 0, taperHeight+bottomHeight - .001])
               rshape(taperWidth+2*allow, taperWidth+2*allow, .001, cornerRad);
         }
      }
      union() {
         hull() {
            translate([0, 0, bottomHeight-2*bottomRad])
               cylinder(h=bottomRad, d=bottomDiam+allow-2*wall);
            translate([0, 0, taperHeight+bottomHeight - .001])
               rshape(taperWidth+2*allow-2*wall, taperWidth+2*allow-2*wall, .001, cornerRad);
         }
      }
   }
}
if ( selection == "saucer" ) {
   intersection() {
      saucer();
      cylinder(h=maxSaucerHeight, d=planterWidth+2);
   }
}
if ( selection == "planter" ) {
   planter();
}
if ( selection == "both" ) {
   translate([-planterWidth/2-3, 0, 0])
      intersection() {
         saucer();
         cylinder(h=maxSaucerHeight, d=planterWidth+2);
      }
   translate([planterWidth/2+3, 0, 0])
      planter();
}