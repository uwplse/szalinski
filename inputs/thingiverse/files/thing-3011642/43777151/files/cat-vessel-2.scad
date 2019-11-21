// cat vessel
// 2018-07-19 Lucina
// preview[view:north, tilt:top]
/* [simple settings] */
// width of barrel in mm
catWidth = 100; //[30:5:300]
// wall thickness in mm
wall = 1.8; //[.6:.1:10]
// drain hole
drainHole = "yes";   //[yes, no]
// drain hole diameter in mm
hole = 10;  //[8:1:25]
// pot or saucer
vesselOrSaucer = "vessel"; //[vessel, saucer, both]
// render mode
renderMode = "normal";  //[normal, lo-poly]

/* [hidden] */
x = 0; y = 1; z = 2;
// vertical roundness
// height of barrel in mm
barrelHeight = .85*catWidth;   //[30:5:300]
pot =[catWidth, catWidth, barrelHeight];
roundness = 70;   //[20:80]
elongate = 1. - roundness/100.;
lores = 16;
hires = 80;
reso = ( renderMode == "normal" ) ? hires : lores;
$fn = reso;
eyeRes = ( renderMode == "lo-poly" ) ? reso/2 : reso;
allow = 4;
minSaucer = 12;
dish = [pot[x]+allow+2*wall, pot[x]+allow+2*wall, max(pot[z]/10, minSaucer)];
earHeight= .25*pot[z];
actualHole = min(.5*.7*pot[x], hole);
echo("actualHole", actualHole);

module barrel(xx, zz) {
   difference() {
      translate([0, 0, zz/2])
      scale([1, 1, (zz/xx)*(1+elongate)])
         sphere(d=xx, $fn=reso);
      union() {
         translate([-xx/2, -xx/2, -zz*elongate/2])
            cube([xx, xx, zz*elongate/2]);
         translate([-xx/2, -xx/2, zz])
            cube([xx, xx, zz*elongate/2]);
      }
   }
}
module vessel() {
   difference() {
      // main
      union() {
         scale([1, .7, 1])
            barrel(pot[x], pot[z]+wall);
         nose(pot[x]);
         eyes(pot[x]);
         whiskers(pot[x]);
      }
      // hollow and drain hole
      union() {
         translate([0, 0, wall])
      scale([1, .7, 1])
            barrel(pot[x]-2*wall, pot[z]-wall);
         translate([-pot[x]/2, -pot[x]/2, pot[z]-.0001])
            cube([pot[x], pot[x], 2*wall]);
         translate([0, 0, -1.5*wall])
            cylinder(h=3*wall, d=actualHole, $fn=hires);
         translate([0, 0, pot[z]-earHeight])
            earCutout(pot[x], pot[x], earHeight);
      }
   }
}
module earCutout(xx, yy, zz) {
   bottom = xx*.5;
   top = xx*.7;
   difference() {
      hull() {
         translate([-bottom/2, -yy/2, 0])         
            cube([bottom, yy, .0001]);
         translate([-top/2, -yy/2, zz-.0001])
            cube([top, yy, .0001]);
      }
   translate([0, 0, -.5*zz])
      rotate([90, 0, 0])
      scale([1, .6, 1])
      cylinder(h=2*yy, d=top, center=true);
   }
}
module saucer() {
   difference() {
      // main
      scale([1, .7, 1])
         barrel(dish[x], pot[z]);
      // hollow
      union() {
         translate([0, 0, wall])
         scale([1, .7, 1])
            barrel(dish[x]-2*wall, pot[z]-wall, lores);
         translate([-dish[x]/2, -dish[x]/2, dish[z]])
            cube([dish[x], dish[x], pot[z]]);
      }
   }
   // ring
   translate([0, 0, wall])
      difference() { 
         scale([1, .7, 1])
            cylinder(h=wall, d=.5*dish[x], $fn=hires);
         union() {
            scale([1, .7, 1])
               cylinder(h=2*wall, d=.5*dish[x]-2*wall, $fn=hires);
            for ( angle = [0:45:135] ) {
               rotate([0, 0, angle])
                  cube([wall, dish[x], 2*wall], center=true);
            }
         }
      }
}
module nose(xx) {
   if ( renderMode == "lo-poly" ) {
      intersection() {
         translate([0, 0, .25*xx])
            rotate([90, 90, 0])
               fcylinder(xx*.72, xx*.15, xx*.05);
         scale([1, .7, 1])
            barrel(pot[x]*1.05, pot[z]+wall);
      }
   }
   else {
      translate([0, 0, .25*xx])
         rotate([90, 90, 0])
            fcylinder(xx*.72, xx*.15, xx*.05);
   }
}
module eyes(xx) {
   intersection() {
      union() {
         translate([.2*xx, 0, .37*xx])
         union() {
            rotate([90, 0, 0])
               difference() {
                  cylinder(h=xx*.70, d=xx*.12, center=true, $fn=eyeRes);
                  translate([0, -.3*xx*.18, 0])
                     cylinder(h=xx*.70, d=xx*.12, center=true, $fn=eyeRes);
               }
         }
         translate([-.2*xx, 0, .37*xx])
            union() {
               rotate([90, 0, 0])
                  difference() {
                     cylinder(h=xx*.70, d=xx*.12, center=true, $fn=eyeRes);
                     translate([0, -.3*xx*.18, 0])
                        cylinder(h=xx*.70, d=xx*.12, center=true, $fn=eyeRes);
                  }
            }
      }
      scale([1, .7, 1])
      barrel(pot[x]+2*wall, pot[z]+wall);
   }
}
module whiskers(xx) {
   intersection() {
      difference() {
         translate([0, 0, .18*xx])
            union() {
               cube([xx*.7, xx*.68, xx*.02], center=true);
               rotate([0, 17, 0])
                  cube([xx*.7, xx*.68, xx*.02], center=true);
               rotate([0, -17, 0])
                  cube([xx*.7, xx*.68, xx*.02], center=true);
            }
            translate([0, 0, .18*xx])
               rotate([90, 90, 0])
                  cylinder(h=xx*.74, d=xx*.15, center=true);
      }
   
      scale([1, .7, 1])
      barrel(pot[x]+2*wall, pot[z]+wall);
   }
}
module fcylinder(zz, xx, rr) {
   translate([0, 0, rr-zz/2])
      minkowski() {
         cylinder(h=zz-2*rr, d=xx-2*rr, $fn=3);
         sphere(rr, $fn=eyeRes);
      }
}

if ( vesselOrSaucer == "vessel" ) {
   vessel();
}
else if ( vesselOrSaucer == "saucer" ){
   saucer();
}
else if ( vesselOrSaucer == "both" ){
   vessel();
   translate([(pot[x]+dish[x])/2+3, 0, 0])
      saucer();
}
