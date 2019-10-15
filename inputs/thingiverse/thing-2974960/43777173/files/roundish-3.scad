// preview[view:south, tilt:top]
/* [simple settings] */
// width of barrel in mm
barrelWidth = 63; //[30:5:300]
// height of barrel in mm
barrelHeight = 75;   //[30:5:300]
// wall thickness in mm
wall = 1.2; //[.6:.1:10]
// vertical roundness
roundness = 55;   //[20:80]
// drain hole
drainHole = "yes";   //[yes, no]
// drain hole diameter in mm
hole = 10;  //[8:1:25]
// barrel hoops
barrelHoops = "yes"; //[yes, no]
// barrel hoop thickness in mm
hoopWall = .9; //[.2:.1:5]
// pot or saucer
potOrSaucer = "pot"; //[pot, saucer, both]


/* [hidden] */
x = 0; y = 1; z = 2;
pot =[barrelWidth, barrelWidth, barrelHeight];
elongate = 1. - roundness/100.;
hoop = [pot[x]+2*hoopWall, pot[x]+2*hoopWall, barrelHeight/10];
yy = [1,2,4,5,7,8];
lores = 80;
hires = 80;
$fn = hires;
allow = ( barrelHoops == "yes" ) ? 4 + 2* hoopWall : 4;
minSaucer = 12;
dish = [pot[x]+allow, pot[x]+allow, max(pot[z]/10, minSaucer)];

module barrel(xx, zz, res) {
   difference() {
      translate([0, 0, zz/2])
      scale([1, 1, (zz/xx)*(1+elongate)])
         sphere(d=xx, $fn=res);
      union() {
         translate([-xx/2, -xx/2, -zz*elongate/2])
            cube([xx, xx, zz*elongate/2]);
         translate([-xx/2, -xx/2, zz])
            cube([xx, xx, zz*elongate/2]);
      }
   }
}
module pot() {
   difference() {
      // main
      union() {
         barrel(pot[x], pot[z]+wall, lores);
         // hoops
         if ( barrelHoops == "yes" ) {
            difference() {
               barrel(hoop[x], pot[z]+wall, hires);
               union() {
                  for ( i=[0:1:len(yy)-1] ) {
                     translate([-hoop[x]/2, -hoop[x]/2, yy[i]*hoop[z]])
                        cube([hoop[x], hoop[x], hoop[z]]);
                  }
               }
            }
         }
      }
      // hollow and drain hole
      union() {
         translate([0, 0, wall])
            barrel(pot[x]-2*wall, pot[z]-wall, lores);
         translate([-pot[x]/2, -pot[x]/2, pot[z]-.0001])
            cube([pot[x], pot[x], 2*wall]);
         translate([0, 0, -1.5*wall])
            cylinder(h=3*wall, d=hole);
      }
   }
}
module saucer() {
   difference() {
      // main
      barrel(dish[x], pot[z], hires);
      // hollow
      union() {
         translate([0, 0, wall])
            barrel(dish[x]-2*wall, pot[z]-wall, hires);
         translate([-dish[x]/2, -dish[x]/2, dish[z]])
            cube([dish[x], dish[x], pot[z]]);
      }
   }
   // ring
   translate([0, 0, wall])
      difference() { 
         cylinder(h=wall, d=.5*dish[x]);
         union() {
            cylinder(h=2*wall, d=.5*dish[x]-2*wall);
            for ( angle = [0:45:135] ) {
               rotate([0, 0, angle])
                  cube([wall, dish[x], 2*wall], center=true);
            }
         }
      }
}
if ( potOrSaucer == "pot" ) {
   pot();
}
else if ( potOrSaucer == "saucer" ){
   saucer();
}
else if ( potOrSaucer == "both" ){
   pot();
   translate([(pot[x]+dish[x])/2+3, 0, 0])
      saucer();
}
