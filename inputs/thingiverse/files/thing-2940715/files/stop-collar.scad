// Split Stop Collar by Hans Loeblich
// License CC0, public domain

// This part is designed to tighten onto a round shaft to prevent parts from sliding along it.
// Also known as a drill stop, can be used to set a specific depth for a drill bit.

// Inner Diameter
ID = 8;
// Outer Diameter
OD = 22;
// Height
H = 10;
// Gap between halves
gap = 0.5;
// Bolt diameter
boltD = 3.2;
// Thickness of solid plastic under bolt head and nut
boltPadding = 3; 
// Nut diameter across flats
nutD = 5.5;
// Bolt head diameter
headD = 5.6;
// If enabled, then bolt holes will be halfway between ID and OD.  Otherwise they will be spaced away from the shaft by the given "margin" on each side.
autocenter = true;
// Minimum distance between the bolt hole edges and the shaft diameter
margin = 1;

/* [Hidden] */
$fs = 0.25;
$fa = 0.1;
err = 0.002; // small correction for extending negative parts beyond surface


split_collar(ID, OD, H, gap);
rotate(180) split_collar(ID, OD, H, gap);


function to_internal(r,n) = r / cos (180 / n);

module split_collar(ID, OD, H, gap) {
  boltSpacing = autocenter == true ? (ID + OD) / 2 : ID + boltD + margin*2;

  difference() {

    linear_extrude(H, convexity=2)
      difference() {
        circle(d=OD);
        circle(d=ID);
        translate([-OD+gap/2,0]) square([OD*2,OD*2], center=true);
      }

    translate([gap/2+boltPadding,boltSpacing/2, H/2]) 
      rotate([0,90,0]) { 
        linear_extrude(OD) circle(d=headD);
        translate([0,0,-OD+err]) cylinder(d=boltD,h=OD);
      }
    
    translate([gap/2+boltPadding,-boltSpacing/2, H/2]) 
      rotate([0,90,0]) {
        linear_extrude(OD) 
          circle(d=to_internal(nutD,6), $fn=6);
        translate([0,0,-OD+err]) cylinder(d=boltD,h=OD);
      }

  }
}

 