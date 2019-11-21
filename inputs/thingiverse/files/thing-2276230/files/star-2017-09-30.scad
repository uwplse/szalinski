// lucina
// 2017-09-30

// preview[view:south, tilt:top]

// the number of points
points = 5; //[4,5,6]

// the type of weight
whichWeight = "5/16 hex nut";   //[608 bearing, 5/16 hex nut, 3/8 hex nut, 1/2 hex nut, M8 hex nut, M10 16 hex nut, M10 17 hex nut, M12 18 hex nut, M12 19 hex nut, M4 square nut, 5/16 ball bearing, 3/8 ball bearing, 1/2 ball bearing, 5/8 ball bearing]

// corner roundness in mm; > 0 causes timeout but Create Thing still works
radius = 3;  //[0:.5:3]

// cut out additional triangle adornments
cutouts = "yes";   //[yes, no]

// horizontal center bearing glue groove
bearingGlueGroove = 0;   //[0, .5, 1.0, 1.5]

// horizontal ray weights glue groove
weightsGlueGroove = 0;   //[0, .5, 1.0, 1.5]

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

thick = 3;
space = (cutouts == "yes") ? max(weight[x]/1.4, 10.5) : weight[x]/1.4;
echo("space=",space);

module node(rad, wt) {
   triangle(bearing[z], wt[x]+2*space, rad);
}

module fcylinder(z, x, rad) {
   minkowski() {
      cylinder(h=z-2*rad, d=x-2*rad, center=true);
      sphere(rad);
   }
}
module fcube(c, rad) {
   minkowski() {
   cube([c[x], c[y]-2*rad, c[z]-2*rad], center=true);
      sphere(rad);
   }
}

module triangle(ht, wd, rad) {
   minkowski() {
      cylinder(h=ht-2*rad, d=wd-2*rad, center=true, $fn = 3);
      sphere(rad);
   }
}

module glueGroove(grooveHt, diam, res) {
   rotate([0, 0, 30])
      cylinder(h=grooveHt, d=diam+2*grooveHt, $fn=res);
}

difference() {
   union() {
      fcylinder(bearing[z], bearing[x]+2*thick, radius);
      for ( angle = [0 : step : stop] ) {
         hull() {
            fcylinder(bearing[z], weight[x]+2*space, radius);
            rotate([0, 0, angle])
               translate([(bearing[x]+weight[y])/2+thick, 0, 0])
                  node(radius, weight);
        }
      }
   }

   // holes
   union() {
      cylinder(h=2*bearing[z], d=bearing[x], center=true);
      if ( bearingGlueGroove > 0 ) {
         glueGroove(bearingGlueGroove, bearing[x], 60);
      }
      for ( angle = [0 : step : stop] ) {
         rotate([0, 0, angle])
            union() {
               translate([(bearing[x]+weight[y])/2+thick, 0, 0])
                  union() {
                     rotate([0, 0, 30])
                        cylinder(h=2*bearing[z], d=weight[x], center=true, $fn=resolution);
                     if ( weightsGlueGroove > 0 ) {
                        glueGroove(weightsGlueGroove, weight[x], resolution);
                     }
                  }
               if ( cutouts == "yes" ) {
                  translate([(bearing[x]+weight[y])/2+thick + weight[x]/2+space/3 , 0, 0])
                     cylinder(h=2*bearing[z], d=.66*space, center=true, $fn = 3);
               }
               if ( weightsGlueGroove > 0 ) {
                  glueGroove(weightsGlueGroove, weight[x], resolution);
               }
            }
         if ( cutouts == "yes" ) {
            rotate([0, 0, angle+step/2])
               translate([bearing[x]/2 + thick, 0, 0])
                  scale([1, 2.5, 1])
                     cylinder(h=2*bearing[z], d=.2*space, center=true, $fn = 3);
         }
      } // for
   } // union
} // difference
