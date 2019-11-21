// lucina
// 2017-09-29

// preview[view:south, tilt:top]

// the number of rays
rays = 3; //[1,2,3,4,5,6]

// the weights per ray
numWeights = 2;   //[1, 2, 3, 4]

// mm to extend ray if only 1 weight per ray
extra = 4;  //[0:1:20]

// the type of weight
whichWeight = "5/16 hex nut";   //[608 bearing, 5/16 hex nut, 3/8 hex nut, 1/2 hex nut, M8 hex nut, M10 16 hex nut, M10 17 hex nut, M12 18 hex nut, M12 19 hex nut, M4 square nut, penny, nickel, dime, quarter, 5/16 ball bearing, 3/8 ball bearing, 1/2 ball bearing, 5/8 ball bearing]

// corner radius in mm; > 0 causes timeout but Create Thing still works
radius = 2;  //[0:.5:3]

// ray style
rayStyle = "tapered";   //[tapered, straight, minimal]

// horizontal center bearing glue groove
bearingGlueGroove = 0;   //[0, .5, 1.0, 1.5]

// horizontal ray weights glue groove
weightsGlueGroove = 0;   //[0, .5, 1.0, 1.5]

/* [Hidden] */
$fn = 60;
x = 0; y = 1; z = 2;
thick = 3;
space = 2;
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
penny = [19.05, 19.05,1.55];  //x4
nickel = [21.21, 21.21, 1.95]; //x3
dime = [17.91, 17.91, 1.35]; //x5
quarter = [24.26, 24.26, 1.75];  // x4
ball516 = [5/16*inch, 5/16*inch, 5/16*inch];
ball38 = [3/8*inch, 3/8*inch, 3/8*inch];
ball12 = [1/2*inch, 1/2*inch, 1/2*inch];
ball58 = [5/8*inch, 5/8*inch, 5/8*inch];

step = 360 / rays;
stop = (rays-1) * step;
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
   (whichWeight == "penny") ? penny :
   (whichWeight == "nickel") ? nickel :
   (whichWeight == "dime") ? dime :
   (whichWeight == "quarter") ? quarter :
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
rotation = (resolution == 6) ? 30 : 0;
echo("rotation=", rotation);
skeleton = [thick + extra, min(weight[x], ball38[x]), bearing[z]];


module node(rad, wt) {
   fcylinder(bearing[z], wt[x]+2*space, rad);
}

module fcylinder(z, x, rad) {
   minkowski() {
      cylinder(h=z-2*rad, d=x-2*rad, center=true);
      sphere(rad);
   }
}
module fcube(cu, rad) {
   minkowski() {
      cube([cu[x]-2*rad, cu[y]-2*rad, cu[z]-2*rad], center=true);
      sphere(rad, center=true);
   }
}
module glueGroove(grooveHt, diam, res) {
   if ( res == 6 )
      rotate([0, 0, 30])
         cylinder(h=grooveHt, d=diam+2*grooveHt, $fn=res, center=true);
   if ( res == 4 )
      cube([diam+2*grooveHt, diam+2*grooveHt, grooveHt], center=true);
   if ( res == 60 )
      cylinder(h=grooveHt, d=diam+2*grooveHt, $fn=res, center=true);
}


difference() {
   union() {
     fcylinder(bearing[z], bearing[x]+2*thick, radius);
      for ( angle = [0 : step : stop] ) {
         rotate([0, 0, angle]) {
            if ( rayStyle == "tapered" ) {
               hull() {
                 fcylinder(bearing[z], bearing[x]+2*thick, radius);
                 for ( n = [0 : 1 : numWeights-1] ) {
                   if ( numWeights == 1 && n == 0) {
                     translate([(bearing[x]+weight[y])/2 + thick + n*(weight[y] + space) + extra, 0, 0])
                        node(radius, weight);
                   }
                   else {
                     translate([(bearing[x]+weight[y])/2 + thick + n*(weight[y] + space), 0, 0])
                        node(radius, weight);
                   }
                 }
               }
            }  //tapered
            if ( rayStyle == "straight" ) {
               hull() {
                  fcylinder(bearing[z], weight[x]+2*thick, radius);
   
                 for ( n = [0 : 1 : numWeights-1] ) {
                   if ( numWeights == 1 && n == 0) {
                     translate([(bearing[x]+weight[y])/2 + thick + n*(weight[y] + space) + extra, 0, 0])
                        node(radius, weight);
                   }
                   else {
                     translate([(bearing[x]+weight[y])/2 + thick + n*(weight[y] + space), 0, 0])
                        node(radius, weight);
                   }
                 }
           }
         }  //minimal
         if ( rayStyle == "minimal" ) {
               union() {
                  if ( (numWeights == 1) && (extra > 0) )
                     translate([(bearing[x]+thick/2+skeleton[x])/2, 0, 0])
                        fcube(skeleton, radius);
                 for ( n = [0 : 1 : numWeights-1] ) {
                   if ( numWeights == 1 && n == 0) {
                     translate([(bearing[x]+weight[y])/2 + thick + n*(weight[y] + space) + extra, 0, 0])
                        node(radius, weight);
                   }
                   else {
                     translate([(bearing[x]+weight[y])/2 + thick + n*(weight[y] + space), 0, 0])
                        node(radius, weight);
                   }
                 }
           }
         }  //minimal
      }
   }
   }
   // holes
   union() {
      if ( bearingGlueGroove > 0 ) {
         glueGroove(bearingGlueGroove, bearing[x], 60);
      }
      cylinder(h=2*bearing[z], d=bearing[x], center=true);
      for ( angle = [0 : step : stop] ) {
         rotate([0, 0, angle]) {
            for ( n = [0 : 1 : numWeights-1] ) {
               if ( numWeights == 1 && n == 0 ) {
                  translate([(bearing[x]+weight[y])/2 + thick + n*(weight[y] + space) + extra, 0, 0]) 
                     union() {
                        if ( resolution == 4 )
                           cube([weight[x], weight[y], 2*bearing[z]], center=true);
                        else
                           rotate([0, 0, rotation])
                              cylinder(h=2*bearing[z], d=weight[x], center=true, $fn=resolution);
                        if ( weightsGlueGroove > 0 ) {
                           glueGroove(weightsGlueGroove, weight[x], resolution);
                        }
                     }
               }
               else {
                  translate([(bearing[x]+weight[y])/2 + thick + n*(weight[y] + space), 0, 0])
                     union() {
                        if ( resolution == 4 )
                           cube([weight[x], weight[y], 2*bearing[z]], center=true);
                        else
                           rotate([0, 0, rotation])
                              cylinder(h=2*bearing[z], d=weight[x], center=true, $fn=resolution);
                        if ( weightsGlueGroove > 0 ) {
                           glueGroove(weightsGlueGroove, weight[x], resolution);
                     }
                  }
               }
            }
         }
      }
   }  //union holes
}  //difference
