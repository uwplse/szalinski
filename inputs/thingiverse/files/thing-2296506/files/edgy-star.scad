// edgy star
// lucina
// 2017-09-30
// preview[view:south, tilt:top]

// the number of points for the star
points = 5;  //[3,4,5,6]
// the type of weight
whichWeight = "5/16 hex nut";   //[608 bearing, 5/16 hex nut, 3/8 hex nut, 1/2 hex nut, M8 hex nut, M10 16 hex nut, M10 17 hex nut, M12 18 hex nut, M12 19 hex nut, M4 square nut, 5/16 ball bearing, 3/8 ball bearing, 1/2 ball bearing, 5/8 ball bearing]
// the y to x aspect ratio for the star points
yAspect = 1.2;  //[1.:0.1:2]
// beveled or rounded edges
edge = "beveled";   //[beveled, rounded]
// edge rounding or beveling in mm
edgeWidth = 3;   //[0:1:7]
// cutouts
cutouts = "yes";  //[yes, no]

/* [Hidden] */
$fn = 60;
x = 0; y = 1; z = 2;
inch = 25.4;
bearing = [22, 22, 7]; //608 bearing
sae = [.577*inch, .5 * inch, 7]; // 5/16 hex nut
sae38 = [.650*inch,.562*inch, 7];	// 3/8 
sae12 = [.866*inch, .75*inch, 7];	// 1/2
metric8 = [15, 13, 7];   // M8 hex nut
metric10_16 = [17.77, 16, 7];   // M10 16 hex nut
metric10_17 = [19.6, 17, 7];   // M10 17 hex nut
metric12_18 = [20.03, 18, 7];   // M12 18 hex nut
metric12_19 = [21.9, 19, 7];   // M12 19 hex nut
metric4sq = [7, 7, 3.2];
ball516 = [5/16*inch, 5/16*inch, 5/16*inch];
ball38 = [3/8*inch, 3/8*inch, 3/8*inch];
ball12 = [1/2*inch, 1/2*inch, 1/2*inch];
ball58 = [5/8*inch, 5/8*inch, 5/8*inch];
weight = (whichWeight == "608 bearing") ? bearing :
   (whichWeight == "5/16 hex nut") ? sae :
   (whichWeight == "3/8 hex nut") ? sae38 :
   (whichWeight == "1/2 hex nut") ? sae12 :
   (whichWeight == "M8 hex nut") ? metric8 :
   (whichWeight == "M10 16 hex nut") ? metric10_16 :
   (whichWeight == "M10 17 hex nut") ? metric10_17 :
   (whichWeight == "M12 18 hex nut") ? metric12_18 :
   (whichWeight == "M12 19 hex nut") ? metric12_19 :
   (whichWeight == "M4 square nut") ? metric4sq :
   (whichWeight == "5/16 ball bearing") ? ball516 :
   (whichWeight == "3/8 ball bearing") ? ball38 :
   (whichWeight == "1/2 ball bearing") ? ball12 : ball58;
echo(whichWeight, weight[x], weight[y], weight[z]);
resolution = (whichWeight == "5/16 hex nut") ? 6 :
(whichWeight == "3/8 hex nut") ? 6 :
(whichWeight == "1/2 hex nut") ? 6 :
(whichWeight == "M8 hex nut") ? 6 :
(whichWeight == "M10 16 hex nut") ? 6 :
(whichWeight == "M10 17 hex nut") ? 6 :
(whichWeight == "M12 18 hex nut") ? 6 :
(whichWeight == "M12 19 hex nut") ? 6 :
(whichWeight == "M4 square nut") ? 4 : 60;
echo("resolution=", resolution);

step = 360 / points;
stop = (points-1) * step;
thick = 2.5;
eWidth = ( edge=="rounded") ? min(edgeWidth, 3) : edgeWidth;
space = (eWidth == 0) ? .6 * weight[x] : .49 * weight[x];
yHoleOffset = .3*weight[x] + .5*eWidth;
notchHole = .24*(weight[x]+space);
notchOffset = bearing[x]/2 + (weight[x]+2*space+2*eWidth)*yAspect*.48 + thick -eWidth/2;
cornerHole = (weight[x]+2*space + eWidth) / points * .75;
cornerHoleOffset = bearing[x]/2+thick+ cornerHole/2;

module fcylinder(z, x, rad) {
   minkowski() {
      cylinder(h=z-2*rad, d=x-2*rad, center=true);
         sphere(rad, center=true);
   }
}
module ftriangle(z, x, y, rad) {
   minkowski() {
      scale([y/x, 1, 1])
         cylinder(h=z-2*rad, d=x-2*rad, $fn = 3, center=true);
      sphere(rad, center=true);
   }
}
module pointedTriangle(z, x, y, rad) {
   hull() {
      scale([y/x, 1, 1]) 
         cylinder(h=z, d=x, $fn = 3, center=true);
      scale([y/x, 1, 1]) 
         cylinder(h=.5, d=x+2*rad, $fn = 3, center=true);
   }
}

module point(wid, rad) {
   if ( edge == "beveled" )
      pointedTriangle(bearing[z], wid, yAspect*wid, rad);
   else
      ftriangle(bearing[z], wid, yAspect*wid, rad);
}

difference() {
   union() {
      fcylinder(bearing[z], bearing[x] + 2*thick, 2);
      // points
      for ( angle = [0 : step : stop] ) {
         rotate([0, 0, angle])
            translate([bearing[x]/2 + (weight[x]+2*space)*yAspect*.28+eWidth/2, 0, 0])
               point(weight[x]+ 2*space, eWidth);
      }
   }
   // holes
   union() {
      cylinder(h=2*bearing[z], d=bearing[x], center=true);
      for ( angle = [0 : step : stop] ) {
         rotate([0, 0, angle])
            translate([bearing[x]/2 + (weight[x]+2*space)*yAspect*.28+eWidth/2, 0, 0])
               cylinder(h=2*bearing[z], d=weight[x], center=true, $fn=resolution);
         if ( cutouts == "yes" ) {
            rotate([0, 0, angle-step/2])
               translate([bearing[x]/2+thick+ 4*yAspect*cornerHole/2, 0, 0])
                  scale([4*yAspect, 1, 1])
                     cylinder(h=3*bearing[z], d=cornerHole, center=true);
            rotate([0, 0, angle])
               translate([notchOffset, yHoleOffset, 0])
                  cylinder(h=2*bearing[z], d=notchHole, center=true);
            rotate([0, 0, angle])
               translate([notchOffset, -yHoleOffset, 0])
                  cylinder(h=2*bearing[z], d=notchHole, center=true);
         }

      }
   }
}
