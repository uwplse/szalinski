// heart-hex-gen
// lucina
// 2017-09-29
// preview[view:south, tilt:top]

// the number of hearts
hearts = 3; //[2,3,4,5,6]
// the type of nut
whichWeight = "5/16 hex nut";   //[608 bearing, 5/16 hex nut, 3/8 hex nut, 1/2 hex nut, M8 hex nut, M10 16 hex nut, M10 17 hex nut, M12 18 hex nut, M12 19 hex nut, M4 square nut, 5/16 ball bearing, 3/8 ball bearing, 1/2 ball bearing, 5/8 ball bearing, heart cutout, none]
// corner radius in mm
radius = 2.5;  //[0:.5:2.5]
// cutout size in mm if you want a cutout, instead of space for a weight
cutoutSize = 15;  //[9:1:20]
// solid heart size when weight selection is none
solidSize = 17;  //[14:1:20]
// rotate heart
rotateHeart = "yes"; //[yes, no]

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
cutout = [cutoutSize, cutoutSize, 7];
none = [solidSize, solidSize, 7];
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
   (whichWeight == "1/2 ball bearing") ? ball12 : 
   (whichWeight == "5/8 ball bearing") ? ball58 :
   (whichWeight == "heart cutout") ? cutout : none;
echo(whichWeight, nut[x], nut[y], nut[z]);
resolution = (whichWeight == "5/16 hex nut") ? 6 :
(whichWeight == "3/8 hex nut") ? 6 :
(whichWeight == "1/2 hex nut") ? 6 :
(whichWeight == "M8 hex nut") ? 6 :
(whichWeight == "M10 16 hex nut") ? 6 :
(whichWeight == "M10 17 hex nut") ? 6 :
(whichWeight == "M12 18 hex nut") ? 6 :
(whichWeight == "M12 19 hex nut") ? 6 :
(whichWeight == "M4 square nut") ? 4 :
(whichWeight == "heart cutout") ? 0 : 
(whichWeight == "none") ? -1 : 60;

thick = 4;
space = (rotateHeart=="yes") ? 6.5: 4.5;
nutSpace = (rotateHeart=="yes") ? 6.5: 5;
heartAngle = (rotateHeart=="yes") ? 0 : -90;
nutAngle = (rotateHeart=="yes") ? 30 : 0;
size = (resolution == 6) ? nut[x]+2 : nut[x]+2.5;
step = 360 / hearts;
stop = (hearts-1) * step;

module fcylinder(z, x, rad) {
   minkowski() {
      cylinder(h=z-2*rad, d=x-2*rad, center=true);
      sphere(rad, center=true);
   }
}
module fcube(x, y, z, rad) {
   minkowski() {
      cube([x-2*rad, y-2*rad, z-2*rad], center=true);
      sphere(rad, center=true);
   }
}
module fHeart(size, radius) {
   translate([0, -size/12, 0])
      rotate([0, 0,45])
         union() {
            fcube(size, size, 7, radius);
            translate([0, size/2.6, 0])
               rotate([0, 0, -10])
                  fcylinder(7, size, radius);
            translate([size/2.6, 0, 0])
               rotate([0, 0, 100])
                  fcylinder(7, size, radius);
         }
}
module heart(wid) {
   echo("wid: ", wid);
   translate([0, -wid/12, 0])
      rotate([0, 0, 45])
         union() {
            cube([wid, wid, bearing[z]*2], center=true);
            translate([0, wid/2.6, 0])
               rotate([0, 0, -10])
                  cylinder(h=bearing[z]*2, d=wid, center=true);
            translate([wid/2.6, 0, 0])
               rotate([0, 0, 100])
                  cylinder(h=bearing[z]*2, d=wid, center=true);
         }
}
echo("resolution", resolution);
difference() {
   union() {
      fcylinder(bearing[z], bearing[x]+2*thick, radius);
      for ( angle = [0 : step : stop] ) {
         rotate([0, 0, angle])
            translate([(bearing[x]+size)/2 + space, 0, 0])
               rotate([0, 0, heartAngle])
                  fHeart(size, radius);
      }
   }
   // holes
   union() {
      cylinder(h=2*bearing[z], d=bearing[x], center=true);
      if ( resolution >= 0 )
         for ( angle = [0 : step : stop] ) {
            rotate([0, 0, angle])
               translate([(bearing[x]+size)/2 + nutSpace, 0, 0])
                  if ( resolution == 0 )
                     rotate([0, 0, heartAngle])
                        heart(cutoutSize-thick);
                  else
                     rotate([0, 0, nutAngle])
                        cylinder(h=2*bearing[z], d=nut[x], center=true, $fn=resolution);
         }
      }
}
