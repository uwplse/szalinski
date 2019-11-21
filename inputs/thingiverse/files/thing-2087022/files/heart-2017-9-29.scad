// heart-hex-gen
// lucina
// 2017-09-29
//
// the number of hearts
hearts = 3; //[2,3,4,5,6]
// the type of nut
whichWeight = "5/16 hex nut";   //[608 bearing, 5/16 hex nut, 3/8 hex nut, 1/2 hex nut, M8 hex nut, M10 16 hex nut, M10 17 hex nut, M12 18 hex nut, M12 19 hex nut, M4 square nut, 5/16 ball bearing, 3/8 ball bearing, 1/2 ball bearing, 5/8 ball bearing]
// corner radius in mm
radius = 2.5;  //[0:.5:3]

/* [Hidden] */
$fn = 40;
x = 0; y = 1; z = 2;
inch = 25.4;
thick = 4;
space = 3;
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
(whichWeight == "M4 square nut") ? 4 : 40;
echo("resolution=", resolution);

size = weight[x]+2;
step = 360 / hearts;
stop = (hearts-1) * step;

module fcylinder(z, x, rad) {
   translate([0, 0, rad-z/2])
      minkowski() {
         cylinder(h=z-2*rad, d=x-2*rad);
         sphere(rad);
      }
}
module fcube(x, y, z, rad) {
   translate([rad-x/2, rad-y/2, rad-z/2])
      minkowski() {
         cube([x-2*rad, y-2*rad, z-2*rad]);
         sphere(rad);
      }
}

module filletedHeart(sz, rad) {
rotate([0, 0, 45])
   union(){
      fcube(sz, sz, 7, rad);
      translate([0, sz*.44, 0])
         fcylinder(7, sz, rad);
      translate([sz*.44, 0, 0])
         rotate([0, 0, -90])
            fcylinder(7, sz, rad);
   }
}
difference() {
   union() {
      fcylinder(bearing[z], bearing[x]+2*thick, radius);
      for ( angle = [0 : step : stop] ) {
         rotate([0, 0, angle])
            translate([(bearing[x]+size)/2 + thick, 0, 0])
               rotate([0, 0, -90])
                  filletedHeart(size, radius);
      }
   }
   // holes
   union() {
      cylinder(h=2*bearing[z], d=bearing[x], center=true);
      for ( angle = [0 : step : stop] ) {
         rotate([0, 0, angle])
            translate([(bearing[x]+size)/2 + thick + 2, 0, 0])
               rotate([0, 0, 30])
                  cylinder(h=2*bearing[z], d=weight[x], center=true, $fn=resolution);
      }
   }
}
