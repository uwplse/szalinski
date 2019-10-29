// heart-planter
// lucina
// 2019-02-08
/* [planter settings] */
// which part
whichPart = "planter";  //[planter, saucer, both]
// height in mm
height = 70;  //[20:5:200]
// bottom width in mm
bottom = 60;   //[20:5:200]
// top width in mm
top = 80;   //[20:5:200]
// wall size in mm
wall = 1.2; //[.6:.1:3]
// drain hole size in mm (0=no hole)
hole = 6;   //[0:1:10]
// slant top angle
slant = 0; // [0:40]
// saucerHeight in mm
saucerHeight = 8;  //[8:30]

/* [Hidden] */
$fn = 50;
x = 0; y = 1; z = 2;
bb = .66667 * bottom;
tt = .66667 * top;

module fcube(x, y, z, rad) {
   translate([rad-x/2, rad-y/2, rad-z/2])
      minkowski() {
         cube([x-2*rad, y-2*rad, z-2*rad]);
         sphere(rad);
      }
}
module taperHeart(t, b, hh) {
   union() {
      hull() {
         cube([b, b, .001], center=true);
         translate([0, 0, hh])
            cube([t, t, .001], center=true);
      }
      hull() {
         translate([0, b/2.0, 0])
            cylinder(h=.001, d=b);
         translate([0, t/2.0, hh])
            cylinder(h=.001, d=t);
      }
      hull() {
         translate([b/2, 0, 0])
            cylinder(h=.001, d=b);
         translate([t/2, 0, hh])
            cylinder(h=.001, d=t);
      }
   }
}
module heart(size, hh) {
//   translate([-.25*size, -.25*size, 0])
   union() {
      cube([size, size, hh]);
      translate([0, size/2.0, 0])
         cylinder(h=hh, d=size);
      translate([size/2.0, 0, 0])
         cylinder(h=hh, d=size);
   }
}
module slantedPlanter() {
   // planter
   rotate([0, 0, -45])
   translate([0, .57*top, height])
      rotate([slant, 0, 0])
         difference() {
            rotate([-slant, 0, 0])
             translate([0, -.57*top, -height])
               rotate([0, 0, 45])
                 // hollow and drain hole
                 difference() {
                     taperHeart(tt, bb, height);
                     union() {
                        translate([0, 0, wall])
                           taperHeart(tt-2*wall, bb-2*wall, height);
                        translate([.125*bb, .125*bb, -wall])
                           cylinder(h=3*wall, d=hole);
                     }
                  }
            // for slanting
            translate([0, 0, height/2])
            cube([1000, 1000, height], center=true);
         }      
}
module planter() {
  difference() {
      taperHeart(tt, bb, height);
      union() {
         translate([0, 0, wall])
            taperHeart(tt-2*wall, bb-2*wall, height);
         translate([.125*bb, .125*bb, -wall])
            cylinder(h=3*wall, d=hole);
      }
   }
   // top band
   translate([0, 0, height-4])
      difference() {
         taperHeart(tt, tt, 4);
         translate([0, 0, -2])
            taperHeart(tt-2*wall, tt-2*wall, 8);
      }
}
module saucer() {
   intersection() {
      cylinder(h=saucerHeight, d=max(top, bottom)*3);
      difference() {
         taperHeart(tt+4, bb+4, height);
         translate([0, 0, wall])
            taperHeart((tt+4)-2*wall, (bb+4)-2*wall, height);
      }
   }
}
module doPlanter() {
   if ( slant == 0 )
      planter();
   else
      slantedPlanter();
}
if ( whichPart == "planter" ) {
   doPlanter();
}
if ( whichPart == "saucer" )
   saucer();
if ( whichPart == "both" )
   union() {
      doPlanter();
      translate([max(top, bottom)+3, 0, 0])
         saucer();
   }
if ( whichPart == "stick" ) {
   heart = [40, 40, 3];
   stick = [4, 80, 3];
   rr = heart[z]/2 - .0001;
   
   rotate([0, 0, -135])
      minkowski() {
         heart(heart[x]*.6667-2*rr, heart[z]-2*rr);
         sphere(rr);
      }
   translate([0, -stick[y]/2-heart[y]+8, 0])
      fcube(stick[x], stick[y], stick[z], stick[z]/2-.0001);
}
