// lucina
// 2017-09-29

// preview[view:south, tilt:top]

// the number of blades
blades = 3; //[2, 3, 4, 5, 6]

// the type of weight
whichWeight = "3/8 hex nut";   //[608 bearing, 5/16 hex nut, 3/8 hex nut, 1/2 hex nut, M8 hex nut, M10 16 hex nut, M10 17 hex nut, M12 18 hex nut, M12 19 hex nut, M4 square nut, 5/16 ball bearing, 3/8 ball bearing, 1/2 ball bearing, 5/8 ball bearing, 1 inch ball bearing]
// blade rotation in degrees
bladeRotation = 20;  //[0:1:45]
// blade offset from center (smaller=more compact)
bladeOffset = .6; //[.55:.05:1.2]
// number of beveled edges
edges = "double"; //[single, double]

/* [Hidden] */
$fn = 60;
inch = 25.4;
x = 0; y = 1; z = 2;
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
ball1 = [inch, inch, inch];

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
   (whichWeight == "1/2 ball bearing") ? ball12 :
   (whichWeight == "5/8 ball bearing") ? ball58 : ball1;
echo(whichWeight, weight[x], weight[y], weight[z]);
resolution = (whichWeight == "5/16 hex nut") ? 6 :
(whichWeight == "3/8 hex nut") ? 6 :
(whichWeight == "1/2 hex nut") ? 6 :
(whichWeight == "M8 hex nut") ? 6 :
(whichWeight == "M10 16 hex nut") ? 6 :
(whichWeight == "M10 17 hex nut") ? 6 :
(whichWeight == "M12 18 hex nut") ? 6 :
(whichWeight == "M12 19 hex nut") ? 6 :
(whichWeight == "M4 square nut") ? 4 : 40;

step = 360 / blades;
stop = (blades-1) * step;
bladeWidth = 22 * weight[x] / sae38[x];
bladeThick = bearing[z];
bladeEdge = 4;
offset = bladeOffset * sae38[x] / weight[x];
rotation = -bladeRotation;
cutOffset = (edges == "double") ? 3.5 : 1;

module blade(th, rad) {
   translate([offset*bladeWidth, 0, 0])
      rotate([0, 0, rotation])
         difference() {
            hull() {
               cylinder(h=th, r=rad, center=true);
               cylinder(h=.5, r=rad+bladeEdge, center=true);
            }
            // cut out  blade
            if ( edges == "single")
               translate([0, weight[x]+bladeEdge+cutOffset*weight[x]/sae38[x], 0])
                  cylinder(h=th*2, r=rad, center=true);
            if ( edges == "double")
               translate([0, weight[x]+bladeEdge+cutOffset*weight[x]/sae38[x], 0])
               union() {
                  hull() {
                     cylinder(h=.25, r=rad, center=true);
                     translate([0, 0, 3.5])
                        cylinder(h=.001, r=rad+bladeEdge, center=true);
                  }
                  hull() {
                     cylinder(h=.25, r=rad, center=true);
                     translate([0, 0, -3.5])
                        cylinder(h=.001, r=rad+bladeEdge, center=true);
                  }
                  }
               }
}
module fcylinder(z, x, rad) {
   minkowski() {
      cylinder(h=z-2*rad, d=x-2*rad, center=true);
         sphere(rad, center=true);
   }
}

difference () {
   union() {
      fcylinder(bearing[z], bearing[x] + 5, 2);
      for ( angle = [0 : step : stop] )
         rotate([0, 0, -angle])
         blade(bladeThick, bladeWidth);
   }
   union() {
      // center hole
      cylinder(h=7*2, d=22, center=true);
         for ( angle = [0 : step : stop] )
            rotate([0, 0, -angle])
               // weight hole
               translate([offset*bladeWidth, 0, 0])
                  rotate([0, 0, rotation])
                     translate([.42*bladeWidth, -bladeWidth+weight[x]/2+weight[x]/sae38[x]*4.2, 0])
                        cylinder(h=bearing[z]*4, d=weight[x], $fn=resolution, center=true);
   }
}