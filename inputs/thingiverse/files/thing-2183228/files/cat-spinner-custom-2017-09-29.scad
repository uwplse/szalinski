// cat spinner
// lucina
// 2017-09-29
/* [cat spinner settings] */
// number of cats for the spinner
cats = 3;  //[2, 3, 4, 5]
// type of weight
whichWeight = "3/8 hex nut";   //[608 bearing, 5/16 hex nut, 3/8 hex nut, 1/2 hex nut, M8 hex nut, M10 16 hex nut, M10 17 hex nut, M12 18 hex nut, M12 19 hex nut, M4 square nut, penny, nickel, dime, quarter, 5/16 ball bearing, 3/8 ball bearing, 1/2 ball bearing, 5/8 ball bearing, none]
// type of center bearing
whichCenterBearing = "608 bearing"; //[608 bearing, other]
// other bearing outside diameter
otherBearingOutsideDiameter = 22;  //[8:1:30]
// other bearing height (thickness)
otherBearingHeight = 7;   //[4:1:10]
// size of cat in mm if type of weight is none
catSize = 21; //[15:1:24]
// rotate each cat 90 degrees
rotateCat = "no";   //[yes, no]

/* [Hidden] */
// horizontal center bearing glue groove
bearingGlueGroove = 0;   //[0, .5, 1.0, 1.5]
// horizontal ray weights glue groove
weightsGlueGroove = 0;   //[0, .5, 1.0, 1.5]

$fn = 60;
x = 0; y = 1; z = 2; id = 3;
thick = 3;
bearing608 = [22, 22, 7, 8];
sae = [.577*25.4, .5 * 25.4, 7]; // 5/16 hex nut
sae38 = [.650*25.4,.562*25.4, 7];	// 3/8 
sae12 = [.866*25.4, .75*25.4, 7];	// 1/2
metric8 = [15, 13, 7];   // M8 hex nut
metric10_16 = [17.77, 16, 7];   // M10 16 hex nut
metric10_17 = [19.6, 17, 7];   // M10 17 hex nut
metric12_18 = [20.03, 18, 7];   // M12 18 hex nut
metric12_19 = [21.9, 19, 7];   // M12 19 hex nut
metric4sq = [7, 7, 3.2];
penny = [19.05, 19.05,1.55];  //x4
nickel = [21.21, 21.21, 1.95]; //x3
dime = [17.91, 17.91, 1.35]; //x5
quarter = [24.26, 24.26, 1.75];  // x4
ball516 = [5/16*25.4, 5/16*25.4, 5/16*25.4];
ball38 = [3/8*25.4, 3/8*25.4, 3/8*25.4];
ball12 = [1/2*25.4, 1/2*25.4, 1/2*25.4];
ball58 = [5/8*25.4, 5/8*25.4, 5/8*25.4];
none = [catSize, catSize, 7];	// no weight

step = 360 / cats;
stop = (cats-1) * step;
weight = (whichWeight == "608 bearing") ? bearing608 :
   (whichWeight == "5/16 hex nut") ? sae :
   (whichWeight == "3/8 hex nut") ? sae38 :
   (whichWeight == "1/2 hex nut") ? sae12 :
   (whichWeight == "M8 hex nut") ? metric8 :
   (whichWeight == "M10 16 hex nut") ? metric10_16 :
   (whichWeight == "M10 17 hex nut") ? metric10_17 :
   (whichWeight == "M12 18 hex nut") ? metric12_18 :
   (whichWeight == "M12 19 hex nut") ? metric12_19 :
   (whichWeight == "M4 square nut") ? metric4sq :
   (whichWeight == "penny") ? penny :
   (whichWeight == "nickel") ? nickel :
   (whichWeight == "dime") ? dime :
   (whichWeight == "quarter") ? quarter :
   (whichWeight == "5/16 ball bearing") ? ball516 :
   (whichWeight == "3/8 ball bearing") ? ball38 :
   (whichWeight == "1/2 ball bearing") ? ball12 :
   (whichWeight == "5/8 ball bearing") ? ball58 : none;
echo(whichWeight, weight[x], weight[y], weight[z]);
resolution = (whichWeight == "5/16 hex nut") ? 6 :
(whichWeight == "3/8 hex nut") ? 6 :
(whichWeight == "1/2 hex nut") ? 6 :
(whichWeight == "M8 hex nut") ? 6 :
(whichWeight == "M10 16 hex nut") ? 6 :
(whichWeight == "M10 17 hex nut") ? 6 :
(whichWeight == "M12 18 hex nut") ? 6 :
(whichWeight == "M12 19 hex nut") ? 6 :
(whichWeight == "M4 square nut") ? 4 :
(whichWeight == "none") ? 0 : 60;
echo("resolution=", resolution);

other = [otherBearingOutsideDiameter,
 otherBearingOutsideDiameter,
 max(4.01, otherBearingHeight)];
bearing = (whichCenterBearing == "608 bearing") ? bearing608 : other;
echo(whichCenterBearing, bearing[x], bearing[y], bearing[z]);

catAngle = (rotateCat == "no") ? -90 : -180;
filRad = 2;
ff = .56;
ff2 = .35;
space = (resolution == 60) ? thick : .75*thick;
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
module cat(wid) {
   difference() {
      union() {
         fcylinder(bearing[z], wid, filRad);
         translate([-(wid/4), wid/3, 0])
            difference() {
               ftriangle(bearing[z], wid*ff, filRad);
               union() {
                  translate([0, 0, bearing[z]/2])
                     linear_extrude(height=2, convexity=10, center=true)
                        circle(d=wid*ff2, $fn=3);
                  translate([0, 0, -bearing[z]/2])
                     linear_extrude(height=2, convexity=10, center=true)
                        circle(d=wid*ff2, $fn=3);
               }
            }
         translate([wid/4, wid/3, 0])
            rotate([0, 0, -60])
            difference() {
              ftriangle(bearing[z], wid*ff, filRad);
              union() {
                  translate([0, 0, bearing[z]/2])
                     linear_extrude(height=2, convexity=10, center=true)
                        circle(d=wid*ff2, $fn=3);
                  translate([0, 0, -bearing[z]/2])
                     linear_extrude(height=2, convexity=10, center=true)
                        circle(d=wid*ff2, $fn=3);
              }
         }
      }
      union() {
         if ( resolution == 0 ) {
            translate([0, -.12*wid, 0])
               whiskers(wid);
            nose(wid);
            eyes(wid);
            mouth(wid);
         }
         else {
            whiskers(wid);
            cylinder(h=bearing[z]*2, d=weight[x], $fn=resolution, center=true);
            if ( weightsGlueGroove > 0 )
               glueGroove(weightsGlueGroove, weight[x], resolution);
         }
      }
   }

}
module nose(wid) {
   translate([0, -.10*wid, bearing[z]/2])
      difference() {
      cylinder(h=2, d=.16*wid, center=true);
         union() {
            translate([-.04*wid, -.07*wid, 0])
               cylinder(h=4, d=.06*wid, center=true);
            translate([.04*wid, -.07*wid, 0])
               cylinder(h=4, d=.06*wid, center=true);
         }
      }
   translate([0, -.10*wid, -bearing[z]/2])
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
module eyes(wid) {
   union() {
      translate([-.15*wid, .08*wid, bearing[z]/2])
         intersection() {
            translate([.05*wid, 0, 0])
            cylinder(h=2, d=.2*wid, center=true);
            translate([-.05*wid, 0, 0])
            cylinder(h=2, d=.2*wid, center=true);
         }
      translate([.15*wid, .08*wid, bearing[z]/2])
         intersection() {
            translate([.05*wid, 0, 0])
            cylinder(h=2, d=.2*wid, center=true);
            translate([-.05*wid, 0, 0])
            cylinder(h=2, d=.2*wid, center=true);
         }
      translate([-.15*wid, .08*wid, -bearing[z]/2])
         intersection() {
            translate([.05*wid, 0, 0])
            cylinder(h=2, d=.2*wid, center=true);
            translate([-.05*wid, 0, 0])
            cylinder(h=2, d=.2*wid, center=true);
         }
      translate([.15*wid, .08*wid, -bearing[z]/2])
         intersection() {
            translate([.05*wid, 0, 0])
            cylinder(h=2, d=.2*wid, center=true);
            translate([-.05*wid, 0, 0])
            cylinder(h=2, d=.2*wid, center=true);
         }
   }
}
module mouth(wid) {
   translate([-.07*wid, -.20*wid, bearing[z]/2])
   difference() {
      cylinder(h=2, d=.18*wid, center=true);
      union() {
         translate([0, .1*wid, 0])
            cube([.22*wid, .2*wid, 4], center=true);
         scale([1.6, 1, 1])
         cylinder(h=2, d=.18*wid-2*1.5, center=true);
      }
   }
   translate([.07*wid, -.20*wid, bearing[z]/2])
   difference() {
      cylinder(h=2, d=.18*wid, center=true);
      union() {
         translate([0, .1*wid, 0])
            cube([.22*wid, .2*wid, 4], center=true);
         scale([1.6, 1, 1])
         cylinder(h=2, d=.18*wid-2*1.5, center=true);
      }
   }
   translate([-.07*wid, -.20*wid, -bearing[z]/2])
   difference() {
      cylinder(h=2, d=.18*wid, center=true);
      union() {
         translate([0, .1*wid, 0])
            cube([.22*wid, .2*wid, 4], center=true);
         scale([1.6, 1, 1])
         cylinder(h=2, d=.18*wid-2*1.5, center=true);
      }
   }
   translate([.07*wid, -.20*wid, -bearing[z]/2])
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
module whiskers(wid) {
   difference() {
      union() {
         translate([0, 0, bearing[z]/2])
            union() {
               cube([wid+2*thick, 1.5, 2], center=true);
               rotate([0, 0, 20])
                  cube([wid+2*thick, 1.5, 2], center=true);
               rotate([0, 0, -20])
                  cube([wid+2*thick, 1.5, 2], center=true);
            }
         translate([0, 0, -bearing[z]/2])
            union() {
               cube([wid+2*thick, 1.5, 2], center=true);
               rotate([0, 0, 20])
                  cube([wid+2*thick, 1.5, 2], center=true);
               rotate([0, 0, -20])
                  cube([wid+2*thick, 1.5, 2], center=true);
            }
      }
      cylinder(h=bearing[z], d=.5*wid, center=true);
   }
}
module glueGroove(grooveHt, diam, res) {
   cylinder(h=grooveHt, d=diam+2*grooveHt, $fn=res, center=true);
   echo("resolution", res);
}

difference() {
   union() {
      fcylinder(bearing[z], bearing[x] + 2*thick, filRad);
      // cats
      step = 360 / cats;
      stop = (cats-1) * step;
      for ( angle = [0 : step : stop] ) {
         rotate([0, 0, angle])
            translate([(weight[x]+bearing[x])/2 + space, 0, 0])
               rotate([0, 0, catAngle])
               cat(weight[x]+thick*2);
      }
   }
   union() {
      cylinder(h=2*bearing[z], d=bearing[x], center=true);
      if ( bearingGlueGroove > 0 )
         glueGroove(bearingGlueGroove, bearing[x], 60);
   }
}

