// lucina
// 2017-04-11

// preview[view:south, tilt:top]

// the number of faces
faces = 4; //[2,3,4,5,6]

// the type of weight
whichWeight = "3/8 hex nut";   //[5/16 hex nut, 3/8 hex nut, M8 hex nut, M10 16 hex nut, M10 17 hex nut, M4 square nut, 5/16 ball bearing, 3/8 ball bearing, 1/2 ball bearing, 5/8 ball bearing]

// corner radius in mm; > 0 causes timeout but Create Thing still works
radius = 2;  //[0:.5:3]

/* [Hidden] */
$fn = 60;
x = 0; y = 1; z = 2;
thick = 2.5;
offset = 22;
inch = 25.4;

bearing = [22, 22, 7]; //608 bearing
sae = [.577*inch, .5 * inch, 7]; // 5/16 hex nut
sae38 = [.650*inch,.562*inch, 7];	// 3/8 
metric8 = [15, 13, 6.5];   // M8 hex nut
metric10_16 = [18.48, 16, 8.4];   // M10 16 hex nut
metric10_17 = [19.63, 17, 8];   // M10 17 hex nut
metric4sq = [7, 7, 3.2];
ball516 = [5/16*inch, 5/16*inch, 5/16*inch];
ball38 = [3/8*inch, 3/8*inch, 3/8*inch];
ball12 = [1/2*inch, 1/2*inch, 1/2*inch];
ball58 = [5/8*inch, 5/8*inch, 5/8*inch];
weight = (whichWeight == "608 bearing") ? bearing :
   (whichWeight == "5/16 hex nut") ? sae :
   (whichWeight == "3/8 hex nut") ? sae38 :
   (whichWeight == "M8 hex nut") ? metric8 :
   (whichWeight == "M10 16 hex nut") ? metric10_16 :
   (whichWeight == "M10 17 hex nut") ? metric10_17 :
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
   (whichWeight == "M4 square nut") ? 4 : 60;
echo("resolution=", resolution);

step = 360 / faces;
stop = (faces-1) * step;
enlarge = 1.8;

module surprise(rad, wt) {
   diam = wt[x]*enlarge;
   eye = diam / 7.5;
   rotate([0, 0, -90])
      difference() {
         fcylinder(bearing[z], diam, rad);
         union() {
            translate([-diam/7.5, diam/4, 0])
               scale([1, 1.2, 1])            
                  cylinder(bearing[z]*2, d=eye, center=true);
            translate([diam/7.5, diam/4, 0])
               scale([1, 1.2, 1])            
                  cylinder(bearing[z]*2, d=eye, center=true);
            translate([0, -diam/7.75, 0])
               cylinder(bearing[z]*2, d=wt[x], center=true, $fn = resolution);
         }
      }
}

module fcylinder(z, x, rad) {
   translate([0, 0, rad-z/2])
      minkowski() {
         cylinder(h=z-2*rad, d=x-2*rad, center=true);
         sphere(rad);
      }
}

difference() {
   union() {
      for ( angle = [0 : step : stop] ) {
         rotate([0, 0, angle]) {
            fcylinder(bearing[z], bearing[x]+2*thick, radius);
            translate([(bearing[x]+ weight[x]*enlarge)/2+thick/3, 0, 0])
               surprise(radius, weight);
         }
      }
   }
   // bearing hole
   cylinder(h=2*bearing[z], d=bearing[x], center=true);
}
