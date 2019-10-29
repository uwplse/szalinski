//  original drwing by dybde - 6mm
// reworked by Paxy

/*Customizer Variables*/
outerDiameter=16;//[1:0.5:50]
shoulderLength=7;//[1:0.5:50]
bladeLength=15;//[1:1:80]
pocketDepth=9;//[1:1:80]
pocketFaces=3;//[3:1:15]
pocketSegments = 10;
pocketCorners = 3;

/* [Hidden] */
$fn=50;

// SHOULDER AND BLADE
difference() {
  union() {
    translate([0,0,-bladeLength])  
      cylinder(r=outerDiameter/2,h=bladeLength);
    hull() {
      cylinder(r=outerDiameter/2,h=shoulderLength);
      translate([0,0,shoulderLength+2.5]) cube([6,15,5],center=true);
      translate([0,-7.5,shoulderLength+2.5]) cylinder(r=3,h=shoulderLength/2,center=true);
      translate([0, 7.5,shoulderLength+2.5]) cylinder(r=3,h=shoulderLength/2,center=true);
    }
  }
  translate([0,0,-0.1-bladeLength]) {

// POCKET
    difference() {
      triangleSide = pocketSegments + 2*pocketCorners;
      triangleRadius = (triangleSide * sqrt(3))/3;
      pocketRadius = (pocketCorners * sqrt(3))/3;
      pocketOffset = triangleRadius - pocketRadius;
      cylinder(r=triangleRadius, h=pocketDepth, center=true, $fn=pocketFaces);
      translate([pocketOffset,0,0]) cylinder(r=pocketRadius, h=pocketDepth, center=true, $fn=pocketFaces);
      rotate([0,0,120]) translate([pocketOffset,0,0]) cylinder(r=pocketRadius, h=pocketDepth, center=true, $fn=pocketFaces);
      rotate([0,0,240]) translate([pocketOffset,0,0]) cylinder(r=pocketRadius, h=pocketDepth, center=true, $fn=pocketFaces);
    } // difference
  } // translate
} // difference

// GRIP
difference() {
	hull() {
		translate([0,0,shoulderLength+3.5]) cube([6,15,15],center=true);
		translate([0,12,shoulderLength+12.5]) cylinder(r=3,h=5,center=true);
		translate([0,12,shoulderLength+6]) sphere(r=3,center=true);
		translate([0,12,shoulderLength+15]) sphere(r=3,center=true);

		translate([0,-12,shoulderLength+12.5]) cylinder(r=3,h=5,center=true);
		translate([0,-12,shoulderLength+6]) sphere(r=3,center=true);
		translate([0,-12,shoulderLength+15]) sphere(r=3,center=true);

		translate([0,-7.5,shoulderLength+2.5]) cylinder(r=3,h=5,center=true);
		translate([0, 7.5,shoulderLength+12.5]) cylinder(r=3,h=5,center=true);
	}
	translate([-5,10,22]) rotate([0,90,0]) cylinder(r=1.5,h=10);
}
