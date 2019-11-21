// ninja star hex spinner
// lucina
// 2017-09-29
// preview[view:south, tilt:top]

// the number of points for the star
points = 3;  //[3,4,5,6]
// the y to x aspect ratio for the star points
yAspect = 1.7;   //[1.3:0.1:2.1]
// the type of nut
whichWeight = "5/16 hex nut";   //[608 bearing, 5/16 hex nut, 3/8 hex nut, 1/2 hex nut, M8 hex nut, M10 16 hex nut, M10 17 hex nut, M12 18 hex nut, M12 19 hex nut, M4 square nut, 5/16 ball bearing, 3/8 ball bearing, 1/2 ball bearing, 5/8 ball bearing]
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
nut = (whichWeight == "608 bearing") ? bearing :
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
echo(whichWeight, nut[x], nut[y], nut[z]);
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
thick = 4;
filRad = 2;
space = 7.5;
cornerHole = 2 + (7-points) * 1.25;
yHoleOffset = points * 2 + 7;
//angleOffset = 4 + 9/yAspect;
xOffset = nut[x]+thick*2+space * yAspect;

module fcylinder(z, x, rad) {
   translate([0, 0, rad-z/2])
      minkowski() {
         cylinder(h=z-2*rad, d=x-2*rad);
         sphere(rad);
      }
}
module ftriangle(z, x, y, rad) {
   translate([0, y/4, 0])
   rotate([0, 0, 90])
      minkowski() {
         scale([y/x, 1, 1])
         cylinder(h=z-2*rad, d=x-2*rad, $fn = 3, center=true);
         sphere(rad, center=true);
      }
}
module point(wid) {
   ftriangle(bearing[z], wid, yAspect*wid, filRad);
}

difference() {
   union() {
      cylinder(h=bearing[z], d=bearing[x] + 2*thick, center=true, $fn=20);
      // points
      step = 360 / points;
      stop = (points-1) * step;
      for ( angle = [0 : step : stop] ) {
         rotate([0, 0, angle])
            translate([(bearing[x])/2-1, 0, 0])
               rotate([0, 0, -90])
                  point(nut[x]+thick*2+space);
      }
   }
   // holes
   cornerHoleOffset = 1.7 * points;
   union() {
      cylinder(h=2*bearing[z], d=bearing[x], center=true);
      step = 360 / points;
      stop = (points-1) * step;
      for ( angle = [0 : step : stop] ) {
         rotate([0, 0, angle])
            translate([(bearing[x]+nut[x])/2+thick/2, 0, 0])
               cylinder(h=2*bearing[z], d=nut[x], center=true, $fn=resolution);
         rotate([0, 0, angle-step/2])
            translate([bearing[x]/2+cornerHoleOffset, 0, 0])
               cylinder(h=2*bearing[z], d=cornerHole, center=true);
         rotate([0, 0, angle])
            translate([xOffset, 4.5, 0])
               cylinder(h=2*bearing[z], d=5, center=true);
         rotate([0, 0, angle])
            translate([xOffset, -4.5, 0])
               cylinder(h=2*bearing[z], d=5, center=true);

      }
   }
}