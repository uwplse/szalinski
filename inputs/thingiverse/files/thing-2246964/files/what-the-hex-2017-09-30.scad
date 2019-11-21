// lucina
// 2017-09-30

// preview[view:south, tilt:top]

// the number of rays
rays = 3; //[1,2,3,4,5,6]

// the weights per ray
numWeights = 1;   //[1, 2, 3, 4]

// mm to extend ray if only 1 weight per ray
extra = 4;  //[0:1:20]

// the type of weight
whichWeight = "5/16 hex nut";   //[608 bearing, 5/16 hex nut, 3/8 hex nut, 1/2 hex nut, M8 hex nut, M10 16 hex nut, M10 17 hex nut, M12 18 hex nut, M12 19 hex nut, M4 square nut, 5/16 ball bearing, 3/8 ball bearing, 1/2 ball bearing, 5/8 ball bearing]

// corner radius in mm; > 0 causes timeout but Create Thing still works
radius = 2;  //[0:.5:3]

/* [Hidden] */
$fn = 60;
x = 0; y = 1; z = 2;
thick = 3;
space = 2.5;
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

step = 360 / rays;
stop = (rays-1) * step;
filler = ( extra > 0 ) ? [extra, weight[x]/2, bearing[z]] :
 [space, weight[x]/2, bearing[z]];

module node(rad, wt) {
   hfcylinder(bearing[z], wt[x]+2*space, rad);
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

module hfcylinder(ht, wd, rad) {
   minkowski() {
      rotate([0, 0, 30])
         cylinder(h=ht-2*rad, d=wd-2*rad, center=true, $fn = 6);
      sphere(rad);
   }
}

difference() {
   union() {
     fcylinder(bearing[z], bearing[x]+2*thick, radius);
      for ( angle = [0 : step : stop] ) {
         rotate([0, 0, angle]) {
              for ( n = [0 : 1 : numWeights-1] ) {
                if ( numWeights == 1 && n == 0 && extra > 0 ) {
                   hull() {
                     translate([(bearing[x])/2 + thick, 0, 0])
                     fcube(filler, radius);
                    cube(filler, center=true);
                     translate([(bearing[x]+weight[y])/2 + thick + n*(weight[y] + space) + extra, 0, 0])
                        node(radius, weight);
                   }
               }
               else {
                  hull() {
                  translate([(bearing[x]+weight[y])/2 + thick + n*(weight[y] + space), 0, 0])
                     node(radius, weight);
                  translate([(bearing[x])/2 + thick-space/2 + n*(weight[y]+space), 0, 0])
                    cube([space, weight[x]/2, bearing[z]], center=true);
//                     fcube(filler, radius);
                  }
               }
           }
         }
      }
   }
   // holes
   union() {
      cylinder(h=2*bearing[z], d=bearing[x], center=true);
      for ( angle = [0 : step : stop] ) {
         rotate([0, 0, angle]) {
            for ( n = [0 : 1 : numWeights-1] ) {
               if ( numWeights == 1 && n == 0 ) {
                  translate([(bearing[x]+weight[y])/2 + thick + n*(weight[y] + space) + extra, 0, 0])
                     rotate([0, 0, 30])
                        cylinder(h=2*bearing[z], d=weight[x], center=true, $fn=resolution);
               }
               else {
                  translate([(bearing[x]+weight[y])/2 + thick + n*(weight[y] + space), 0, 0])
                     rotate([0, 0, 30])
                        cylinder(h=2*bearing[z], d=weight[x], center=true, $fn=resolution);
               }
            }
         }
      }
   }
}
