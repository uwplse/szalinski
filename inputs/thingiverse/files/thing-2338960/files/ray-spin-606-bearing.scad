// lucina
// 2017-05-18

// preview[view:south, tilt:top]

// the number of rays
rays = 3; //[1,2,3,4,5,6]

// the weights per ray
numWeights = 2;   //[1, 2, 3, 4]

// mm to extend ray if only 1 weight per ray
extra = 4;  //[0:1:20]

// the type of weight
whichWeight = "3/8 hex nut";   //[608 bearing, 5/16 hex nut, 3/8 hex nut, 1/2 hex nut, M8 hex nut, M10 hex nut, M12 hex nut, M4 square nut, penny, nickel, dime, quarter, 5/16 ball bearing, 3/8 ball bearing, 1/2 ball bearing, 5/8 ball bearing]

// corner radius in mm; > 0 causes timeout but Create Thing still works
radius = 2;  //[0:.5:3]

// taper the width of the rays with center bearing
taperedRays = "no";   //[yes, no]

// horizontal center bearing glue groove
bearingGlueGroove = 0;   //[0, .5, 1.0, 1.5]

// horizontal ray weights glue groove
weightsGlueGroove = 0;   //[0, .5, 1.0, 1.5]

/* [Hidden] */
$fn = 60;
x = 0; y = 1; z = 2;
thick = 3;
space = 3;

bearing = [17, 17, 6]; //606 bearing
sae = [.577*25.4, .5 * 25.4, 6]; // 5/16 hex nut
sae38 = [.650*25.4,.562*25.4, 6];	// 3/8 
sae12 = [.866*25.4, .75*25.4, 6];	// 1/2
metric = [15, 13, 6];   // M8 hex nut
metric10 = [19.6, 17, 6];   // M10 hex nut
metric12 = [21.9, 19, 7];   // M12 hex nut
metric4sq = [7, 7, 3.2];
penny = [19.05, 19.05,1.55];  //x4
nickel = [21.21, 21.21, 1.95]; //x3
dime = [17.91, 17.91, 1.35]; //x5
quarter = [24.26, 24.26, 1.75];  // x4
ball516 = [5/16*25.4, 5/16*25.4, 5/16*25.4];
ball38 = [3/8*25.4, 3/8*25.4, 3/8*25.4];
ball12 = [1/2*25.4, 1/2*25.4, 1/2*25.4];
ball58 = [5/8*25.4, 5/8*25.4, 5/8*25.4];

step = 360 / rays;
stop = (rays-1) * step;
weight = (whichWeight == "606 bearing") ? bearing :
   (whichWeight == "5/16 hex nut") ? sae :
   (whichWeight == "3/8 hex nut") ? sae38 :
   (whichWeight == "1/2 hex nut") ? sae12 :
   (whichWeight == "M8 hex nut") ? metric :
   (whichWeight == "M10 hex nut") ? metric10 :
   (whichWeight == "M12 hex nut") ? metric12 :
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
(whichWeight == "M10 hex nut") ? 6 :
(whichWeight == "M12 hex nut") ? 6 :
(whichWeight == "M4 square nut") ? 4 : 60;
echo("resolution=", resolution);
rotation = (resolution == 6) ? 30 : 0;
echo("rotation=", rotation);


module node(rad, wt) {
   fcylinder(bearing[z], wt[x]+2*space, rad);
}

module fcylinder(z, x, rad) {
   minkowski() {
      cylinder(h=z-2*rad, d=x-2*rad, center=true);
      sphere(rad);
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
            if ( taperedRays == "yes" )
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
            else
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
   }
}
