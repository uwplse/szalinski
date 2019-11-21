/* [dimensions] */
// planter width in mm
planterWidth = 100;  //[50:10:300]
// planter height in mm
planterHeight = 80; //[50:10:300]
// wall thickness in mm
wall = 1.2; //[.9:.1:6]
/* [shape] */
// number of sides (before chopped in half)
numberOfSides = 16;   //[4:1:16]
// corner radius in mm
cornerRadius = 4; //[1:1:10]
// ratio of width of part between cylindrical bottom and polygonal top to planter width
taperWidthPercent = 80;   //[25:5:100]
// ratio of height of part between cylindrical bottom and polygonal height to planter height
taperHeightPercent = 50;  //[20:5:80]
// ratio of pottom diameter to planterHeight
bottomDiameterPercent = 60;   //[25:5:100]
/* [holes] */
// planter drain hole: yes or no
drainHole = "yes";   //[yes, no]
// planter drain hole diameter
holeDiameter = 6; //[4:1:15]
// hanging string hole: yes or no
stringHole = "yes";   //[yes, no]
// string hole diameter in mm
stringDiameter = 3;   //[2:1:8]

/* [hidden] */
$fn = 60;
x = 0; y = 1; z = 2;
allow = 4;
step = 360 / numberOfSides;
last = 360-step;
bottomHeight = max(wall, 1.8);
bottomRadius = (bottomHeight/2-.001);
bottomDiam = planterWidth*bottomDiameterPercent/100.;
taperWidth = planterWidth*taperWidthPercent/100.;
taperHeight = planterHeight*taperHeightPercent/100.;

module rshape(xx, yy, zz, rr) {
   hull() {
      for ( angle = [0:step:last] ) {
         rotate([0, 0, angle])
            translate([xx/2-rr, 0, 0])
               cylinder(h=zz, r=rr);
      }
   }
}
module fcylinder(z, x, rad) {
   translate([0, 0, rad])
      minkowski() {
         cylinder(h=z-2*rad, d=x-2*rad);
            sphere(rad, center=true);
      }
}
module planter() {
   difference() {
      solidPlanter();
      union() {
         // bottom and taper
         hull() {
            translate([0, 0, bottomHeight-bottomRadius])
               cylinder(h=bottomRadius, d=bottomDiam-2*wall);
            translate([0, 0, taperHeight - .001])
               rshape(taperWidth-2*wall, taperWidth-2*wall, .001, cornerRadius);
         }
         // bottom and taper
         hull() {
            translate([0, 0, taperHeight - .001])
               rshape(taperWidth-2*wall, taperWidth-2*wall, .001, cornerRadius);
            translate([0, 0, planterHeight - .001])
               rshape(planterWidth-2*wall, planterWidth-2*wall, .001, cornerRadius);
         }
         translate([-planterWidth/2, 0, 0])
            cube([planterWidth, 2*planterWidth, planterHeight]);
      }
   }
   back();
}
module solidPlanter() {
   fcylinder(bottomHeight, bottomDiam, bottomRadius);
      union() {
         // bottom and taper
         hull() {
            translate([0, 0, bottomHeight-bottomRadius])
               cylinder(h=bottomRadius, d=bottomDiam);
            translate([0, 0, taperHeight - .001])
               rshape(taperWidth, taperWidth, .001, cornerRadius);
         }
         // taper and top
         hull() {
            translate([0, 0, taperHeight - .001])
               rshape(taperWidth, taperWidth, .001, cornerRadius);
            translate([0, 0, planterHeight - .001])
               rshape(planterWidth, planterWidth, .001, cornerRadius);
         }
      }
}
module back() {
   intersection() {
      solidPlanter();
      translate([-planterWidth/2, -wall, 0])
         cube([planterWidth, wall, planterHeight]);
   }
}
// centroid = 4r/3pi
pi = 3.14159;
//centroid = (4*planterWidth/2) / (3*pi);
centroid1 = (4*((planterWidth+taperWidth)/2)/2) / (3*pi);
centroid2 = (4*((taperWidth+bottomDiam)/2)/2) / (3*pi);
centroid = ((taperHeightPercent/100*centroid2) + ((100-taperHeightPercent)/100*centroid1))/2;
echo("centroid", centroid);
difference() {
   planter();
   union() {
      if ( stringHole == "yes" ) {
         translate([-planterHeight, -centroid, planterHeight-stringDiameter])
            rotate([0, 90, 0])
               cylinder(h=2*planterHeight, d=stringDiameter);
      }
      if ( drainHole == "yes" ) {
         translate([0, -bottomDiam/4, -wall])
            cylinder(h=3*wall, d=holeDiameter);
      }
   }
}
