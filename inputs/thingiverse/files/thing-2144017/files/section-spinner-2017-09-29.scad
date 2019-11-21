// section spinner
// lucina
// 2017-09-09
// preview[view:south, tilt:top]

// number of sections for the spinner
sections = 4;  //[1, 2, 3, 4, 5]
// type of weight
whichWeight = "3/8 hex nut";   //[608 bearing, 5/16 hex nut, 3/8 hex nut, 1/2 hex nut, M8 hex nut, M10 16 hex nut, M10 17 hex nut, M12 18 hex nut, M12 19 hex nut, M4 square nut, 5/16 ball bearing, 3/8 ball bearing, 1/2 ball bearing, 5/8 ball bearing]
// edge roundness
radius = 1.5; //[0:.5:3]
/* [Hidden] */
//$fn = 16;    //debug
$fn = 60;
x = 0; y = 1; z = 2;
thick = 3;
bearing = [22, 22, 7]; //608 bearing
sae = [.577*25.4, .5 * 25.4, 7]; // 5/16 hex nut
sae38 = [.650*25.4,.562*25.4, 7];	// 3/8 
sae12 = [.866*25.4, .75*25.4, 7];	// 1/2
metric8 = [15, 13, 7];   // M8 hex nut
metric10_16 = [17.77, 16, 7];   // M10 16 hex nut
metric10_17 = [19.6, 17, 7];   // M10 17 hex nut
metric12_18 = [20.03, 18, 7];   // M12 18 hex nut
metric12_19 = [21.9, 19, 7];   // M12 19 hex nut
metric4sq = [7, 7, 3.2];
ball38 = [3/8*25.4, 3/8*25.4, 3/8*25.4];
ball12 = [1/2*25.4, 1/2*25.4, 1/2*25.4];
ball58 = [5/8*25.4, 5/8*25.4, 5/8*25.4];
weight = (whichWeight == "608 bearing") ? bearing :
   (whichWeight == "5/16 hex nut") ? sae :
   (whichWeight == "3/8 hex nut") ? sae38 :
   (whichWeight == "1/2 hex nut") ? sae12 :
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
space = 16;
a = (weight[x]+space);

module fcylinder(z, x, rad) {
   translate([0, 0, rad-z/2])
      minkowski() {
         cylinder(h=z-2*rad, d=x-2*rad);
         sphere(rad);
      }
}
module ftriangle(z, x, y, rad) {
   rotate([0, 0, -90])
      translate([-rad, 0, 0])
         minkowski() {
            intersection() {
               translate([-(x-2*rad), 0, 0])
                  cylinder(h=z-2*rad, r=x-2*rad, $fn = 3, center=true);
               cylinder(h=z-2*rad, r=x-2*rad, center=true);
            }
            sphere(r=rad, center=true);
         }
}
module section(rad) {
   ftriangle(bearing[z], a, a, rad);
}

difference() {
   union() {
      fcylinder(bearing[z], bearing[x] + 2*thick, radius);
      // sections
      step = 360 / sections;
      stop = (sections-1) * step;
      for ( angle = [0 : step : stop] ) {
         rotate([0, 0, angle])
            rotate([0, 0, -90])
                  section(radius);
      }
   }
   // holes
   union() {
      cylinder(h=2*bearing[z], d=bearing[x], center=true);
      step = 360 / sections;
      stop = (sections-1) * step;
      for ( angle = [0 : step : stop] ) {
         rotate([0, 0, angle])
            translate([(weight[x]+bearing[x])/2+thick, 0, 0])
               cylinder(h=2*bearing[z], d=weight[x], center=true, $fn=resolution);
      }
   }
}
