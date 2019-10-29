// Parametric Spool Holder v2
// triangular end pieces that support a dowel
// that holds spools of wire, solder...
// Not really meant for big spools of filament

// preview[view:south, tilt:top]

// the width of the support
width = 70;             //[40:300]

// the height of the support
height = 80;            //[40:300]

//  depth of the support
depth = 15;             //[10:5:50]

// wall thickness of the support
wall = 1.75;            //[.5:.25:3.0]

// radius for rounded corners
cornerRadius = 10;      //[2:1:20]

// radius of dowel
dowelRadius = 6.35;

// extra allowance for dowel
slop = .45;             //[.2:.1:1.5]

/* [Hidden] */
$fn = 50;

insideCornerRadius = cornerRadius-wall;

difference() {
   union() {
      difference() {
         hull() {
            translate([-width/2+cornerRadius, 0, 0])
               cylinder(depth, r=cornerRadius, center=true);
            translate([width/2-cornerRadius, 0, 0])
               cylinder(depth, r=cornerRadius, center=true);
            translate([0, height-2*cornerRadius, 0])
               cylinder(depth, r=cornerRadius, center=true);
         }
         hull() {
            translate([-width/2+insideCornerRadius+wall, 0, 0])
               cylinder(depth, r=insideCornerRadius, center=true);
            translate([width/2-insideCornerRadius-wall, 0, 0])
               cylinder(depth, r=insideCornerRadius, center=true);
            translate([0, height-2*insideCornerRadius-wall, 0])
               cylinder(depth+10, r=insideCornerRadius, center=true);
         }
      }
      translate([0, height-dowelRadius-cornerRadius-wall-slop/2, 0])
         cylinder(depth, r=dowelRadius + slop/2 + wall, center=true);
   }
   translate([0, height-dowelRadius-cornerRadius-wall-slop/2, 0])
      cylinder(depth+10, r=dowelRadius + slop/2, center=true);
}