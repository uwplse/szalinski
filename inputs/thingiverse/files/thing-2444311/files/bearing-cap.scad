// customizable bearing cap
// lucina
// 2017-07-03
// preview[view:north, tilt:bottom]
/* [bearing cap settings] */
// number of cats for the spinner
choice = "deboss text";   //[deboss text, emboss text, cat, paw, heart, star, yin-yang]
text = "LPM";
scaleText = 1; // [.1:.1:2.5]

/* [hidden] */
$fn = 60;
x = 0; y = 1; z = 2; id = 3;
thick = 3;
weight = [18, 18, 2];
bearing608 = [22, 22, 7, 8];
resolution = 60;
diskH = 2.5;
diskD = 18.5;
spacerH = 1;
postH = 8/2;

bearing = bearing608;
filRad = .75;
//ff = .56;
ff = .7;
//ff2 = .35;
ff2 = .42;

ffpaw = .21;
ff2paw = .28;
ffx = .75;
pos = [60, 21, -21, -60];
off = [.28, .29, .29, .28];

font = "Open Sans:style=ExtraBold";

module fcylinder(z, x, rad) {
   translate([0, 0, rad-z/2])
      minkowski() {
         cylinder(h=z-2*rad, d=x-2*rad);
         sphere(rad);
      }
}
module ftriangle(z, x, rad) {
   translate([0, 0, rad-z/2])
      minkowski() {
         cylinder(h=z-2*rad, d=x-2*rad, $fn = 3);
         sphere(rad);
      }
}
 module embossText(txt, ht, fontSize) {
   difference() {
      fcylinder(ht, diskD, filRad);
      translate([0, 0, ht/2])
         linear_extrude(ht, center=true)
            text(str(txt), font = font, size = fontSize, halign="center", valign="center");
   }
}
 module debossText(txt, ht, fontSize) {
   difference() {
      fcylinder(ht, diskD, filRad);
      translate([0, 0, ht/2])
         fcylinder(ht, diskD*.9, filRad);
   }
   linear_extrude(ht, center=true)
       text(str(txt), font = font, size = fontSize, halign="center", valign="center");
 }
module cat(wid, ht) {
   difference() {
      union() {
         fcylinder(ht, wid, filRad);
         translate([-(wid/4), wid/3, 0])
            difference() {
               ftriangle(ht, wid*ff, filRad);
               union() {
                  translate([0, 0, ht/2])
                     linear_extrude(height=2, convexity=10, center=true)
                        circle(d=wid*ff2, $fn=3);
               }
            }
         translate([wid/4, wid/3, 0])
            rotate([0, 0, -60])
               difference() {
                 ftriangle(ht, wid*ff, filRad);
                 union() {
                     translate([0, 0, ht/2])
                        linear_extrude(height=2, convexity=10, center=true)
                           circle(d=wid*ff2, $fn=3);
                 }
            }
      }
      union() {
            translate([0, -.12*wid, 0])
               whiskers(wid, ht);
            nose(wid, ht);
            eyes(wid, ht);
            mouth(wid, ht);
         }
   }

}
module nose(wid, ht) {
   translate([0, -.10*wid, ht/2])
      difference() {
      cylinder(h=2, d=.16*wid, center=true);
         union() {
            translate([-.04*wid, -.07*wid, 0])
               cylinder(h=4, d=.06*wid, center=true);
            translate([.04*wid, -.07*wid, 0])
               cylinder(h=4, d=.06*wid, center=true);
         }
      }
}
module eyes(wid, ht) {
   union() {
      translate([-.15*wid, .08*wid, ht/2])
         intersection() {
            translate([.05*wid, 0, 0])
               cylinder(h=2, d=.2*wid, center=true);
            translate([-.05*wid, 0, 0])
               cylinder(h=2, d=.2*wid, center=true);
         }
      translate([.15*wid, .08*wid, ht/2])
         intersection() {
            translate([.05*wid, 0, 0])
               cylinder(h=2, d=.2*wid, center=true);
            translate([-.05*wid, 0, 0])
               cylinder(h=2, d=.2*wid, center=true);
         }
   }
}
module mouth(wid, ht) {
   translate([-.07*wid, -.20*wid, ht/2])
   difference() {
      cylinder(h=2, d=.18*wid, center=true);
      union() {
         translate([0, .1*wid, 0])
            cube([.22*wid, .2*wid, 4], center=true);
         scale([1.6, 1, 1])
            cylinder(h=2, d=.18*wid-2*1.5, center=true);
      }
   }
   translate([.07*wid, -.20*wid, ht/2])
      difference() {
         cylinder(h=2, d=.18*wid, center=true);
         union() {
            translate([0, .1*wid, 0])
               cube([.22*wid, .2*wid, 4], center=true);
            scale([1.6, 1, 1])
            cylinder(h=2, d=.18*wid-2*1.5, center=true);
         }
      }
}
module whiskers(wid, ht) {
   difference() {
      union() {
         translate([0, 0, ht/2])
            union() {
               cube([wid+2*thick, 1.5, 2], center=true);
               rotate([0, 0, 20])
                  cube([wid+2*thick, 1.5, 2], center=true);
               rotate([0, 0, -20])
                  cube([wid+2*thick, 1.5, 2], center=true);
            }
      }
      cylinder(h=ht, d=.5*wid, center=true);
   }
}
module solidPaw(wid, ht) {
   echo("solidPaw", wid, ht);
   union() {
      for (a=[0:1:3]) {
         rotate([0, 0, pos[a]]) {
            translate([0, off[a]*wid, 0])
               scale([ffx, 1, 1])
                  cylinder(ht, d=wid*ffpaw, center=true);
         }
     }
      translate([0, -.07*wid, 0])
         cylinder(h=ht, d=1.3*wid*ff2paw, center=true);
      hull() {
         translate([-wid*ff2paw/2.1, -.9*wid*ffpaw, 0])
            cylinder(h=ht, d=wid*ff2paw, center=true);
         translate([wid*ff2paw/2.1, -.9*wid*ffpaw, 0])
            cylinder(h=ht, d=wid*ff2paw, center=true);
     }
  }
}

module deboss(wid, ht) {
   height = ht;
   difference() {
      fcylinder(height, wid, filRad);
      translate([0, 0, height/2])
         cylinder(h=height, d=wid*.9, center=true);
   }
   solidPaw(wid, height);
}

module heart(w, ht) {
   wid = w*.45;
   difference() {
      fcylinder(ht, w, filRad);
      translate([0, 0, ht/2])
         cylinder(h=ht, d=w*.9, center=true);
   }
   translate([0, -.2*wid, 0])
      rotate([0, 0, 45])
         union() {
            cube([wid, wid, ht], center=true);
            translate([0, .52*wid, 0])
               rotate([0, 0, -10])
                  cylinder(h=ht, d=wid, center=true);
            translate([.52*wid, 0, 0])
               rotate([0, 0, 100])
                  cylinder(h=ht, d=wid, center=true);
         }
}
module star(wid, ht) {
   difference() {
      fcylinder(ht, wid, filRad);
      translate([0, 0, ht/2])
         cylinder(h=ht, d=wid*.9, center=true);
   }
   linear_extrude(height = ht, center = true, convexity=10)
      star2d(5, wid*.85/2, wid*.35/2);
}
module star2d(points, outer, inner, ht) {
	// polar to cartesian: radius/angle to x/y
	function x(r, a) = r * cos(a);
	function y(r, a) = r * sin(a);
	// angular width of each pie slice of the star
	increment = 360/points;
	union() {
		for (p = [0 : points-1]) {
			// outer is outer point p
			// inner is inner point following p
			// next is next outer point following p
			x_outer = x(outer, increment * p);
			y_outer = y(outer, increment * p);
			x_inner = x(inner, (increment * p) + (increment/2));
			y_inner = y(inner, (increment * p) + (increment/2));
			x_next  = x(outer, increment * (p+1));
			y_next  = y(outer, increment * (p+1));
         polygon(points = [[x_outer, y_outer], [x_inner, y_inner], [x_next, y_next], [0, 0]], paths  = [[0, 1, 2, 3]]);
			}
		}
}
module yin(wid, ht) {
   outerR = wid/2*.9;
   difference() {
      fcylinder(ht, wid, filRad);
      union() {
         doYin(wid, ht);
         translate([0, -outerR/2, ht/2])
            cylinder(h = ht, r = outerR/2*.3, center=true);
      }
   }
   translate([0, outerR/2, 0])
      cylinder(h = ht, r = outerR/2*.3, center=true);
}
module doYin(wid, ht) {
   outerR = wid/2*.9;
   translate([0, 0, ht/2])
      union() {
         difference() {
            cylinder(h = ht, r = outerR, center = true);
            union() {
               translate([0, -(outerR/2), 0])
                  cylinder(h = ht*3, r = outerR/2, center=true);
               translate([outerR/2, 0, 0])
                  cube([outerR, 2*outerR, ht*3], center=true);
            }
         }
         translate([0, outerR/2, 0])
            cylinder(h = ht, r = outerR/2, center=true);
      }
}  

if ( choice == "cat" )
   translate([0, 0, -diskH/2])
      rotate([0, 180, 0])
         cat(diskD, diskH);
if ( choice == "paw" )
   translate([0, 0, -diskH/2])
      rotate([0, 180, 0])
         deboss(diskD, diskH);
if ( choice == "heart" )
   translate([0, 0, -diskH/2])
      rotate([0, 180, 0])
         heart(diskD, diskH);
if ( choice == "star" )
   translate([0, 0, -diskH/2])
      rotate([0, 180, 0])
         star(diskD, diskH);
if ( choice == "yin-yang" )
   translate([0, 0, -diskH/2])
      rotate([0, 180, 0])
         yin(diskD, diskH);
if ( choice == "emboss text" )
   translate([0, 0, -diskH/2])
      rotate([0, 180, 0])
         embossText(text, 3, scaleText*5);
if ( choice == "deboss text" )
   translate([0, 0, -diskH/2])
      rotate([0, 180, 0])
         debossText(text, 3, scaleText*5);
// spacer
translate([0, 0, spacerH/2])
   cylinder(h=spacerH, d=10, center=true);
// post
translate([0, 0, bearing[z]/4+spacerH])
   cylinder(h=bearing[z]/2, d=bearing[id], center=true);

