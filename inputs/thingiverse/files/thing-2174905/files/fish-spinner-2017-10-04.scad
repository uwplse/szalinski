// fish spinner
// lucina
// 2017-10-04
// preview[view:south, tilt:top]
/* [fish spinner settings] */
// number of fish for the spinner
fishes = 3;  //[2, 3, 4]
// type of weight
whichWeight = "3/8 hex nut";   //[608 bearing, 5/16 hex nut, 3/8 hex nut, 1/2 hex nut, M8 hex nut, M10 16 hex nut, M10 17 hex nut, M12 18 hex nut, M12 19 hex nut, M4 square nut, 4 pennies, 3 nickels, 5 dimes, 4 quarters, 5/16 ball bearing, 3/8 ball bearing, 1/2 ball bearing, 5/8 ball bearing]
// edge roundness (> 0 might cause a time out, but "Create it" still works!
radius = 2.5; //[0:.5:3]
/* [Hidden] */
$fn = 60;
x = 0; y = 1; z = 2;
thick = 3;
inch = 25.4;

bearing = [22, 22, 7]; //608 bearing
sae = [.577*inch, .5 * inch, 7]; // 5/16 hex nut
sae38 = [.650*inch,.562*inch, 7];	// 3/8 
sae12 = [.866*inch, .75*inch, 7];	// 1/2
metric8 = [15, 13, 6.5];   // M8 hex nut
metric10_16 = [18.48, 16, 8.4];   // M10 16 hex nut
metric10_17 = [19.63, 17, 8];   // M10 17 hex nut
metric12_18 = [20.78, 18, 10.8];   // M12 18 hex nut
metric12_19 = [21.94, 19, 10];   // M12 19 hex nut
metric4sq = [7, 7, 3.2];
penny = [19.05, 19.05, 4*1.55];  //x4
nickel = [21.21, 21.21, 3*1.95]; //x3
dime = [17.91, 17.91, 5*1.35]; //x5
quarter = [24.26, 24.26, 4*1.75];  // x4
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
   (whichWeight == "4 pennies") ? penny :
   (whichWeight == "3 nickels") ? nickel :
   (whichWeight == "5 dimes") ? dime :
   (whichWeight == "4 quarters") ? quarter :
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
space = 8.5;
a = (weight[x]+space);
eye = a/7.5;
echo("Eye:", eye);
module fcylinder(z, x, rad) {
   translate([0, 0, rad-z/2])
      minkowski() {
         cylinder(h=z-2*rad, d=x-2*rad);
         sphere(rad);
      }
}
module fish(ht, di, rad) {
   diam = di - 2*rad;
   height = ht - 2*rad;
   difference() {
      union() {
         difference() {
            union() {
               minkowski() {
                  union() {
                     // body
                     hull() {
                     scale([1.2, 1, 1])
                        cylinder(h = height, d = diam, center=true);
                        translate([1.2/2 * diam, 0, 0])
                           cylinder(h = height, d = diam/5, center=true);
                     }
                     hull() {
                        translate([-1.2/1.75 * diam, diam/3.5, 0])
                           cylinder(h = height, d = diam/4.5, center=true);
                        translate([-1.2/2 * diam, 0, 0])
                           cylinder(h = height, d = diam/5, center=true);
                     }
                     hull() {
                        translate([-1.2/1.75 * diam, -diam/3.5, 0])
                           cylinder(h = height, d = diam/4.5, center=true);
                        translate([-1.2/2 * diam, 0, 0])
                           cylinder(h = height, d = diam/5, center=true);
                     }
                  }
                  sphere(r=rad, center=true);
               }
            }
              
            union() {
               // eye
               translate([.45 * di, .143*di, 0])
                  cylinder(h=ht*3, d=eye, center=true);
               // mouth
               translate([.77*di, 0, 0])
                  difference() {
                     cylinder(h=ht*3, d=di, center=true);
                     union() {
                        cylinder(h=ht*3, d=di-weight[x]/6.5, center=true);
                        translate([di/2, 0, 0])
                           cube(di, center=true);
                        translate([0, di/2, 0])
                           cube(di, center=true);
                     }
                  }
            }
         }
         cylinder(h=bearing[z], d=weight[x]+3.0, center=true, $fn=resolution);
      }
      cylinder(h=2*bearing[z], d=weight[x], center=true, $fn=resolution);
   }
}
union() {
   difference() {
      fcylinder(bearing[z], bearing[x] + 2*thick, radius);
      cylinder(h=2*bearing[z], d=bearing[x], center=true);
   }
   // fishes
   step = 360 / fishes;
   stop = (fishes-1) * step;
   for ( angle = [0 : step : stop] ) {
      rotate([0, 0, angle])
         translate([(bearing[x]+a)/2+thick/3.5, 0, 0])
            rotate([0, 0, -90])
               fish(bearing[z], a, radius);
   }
}
