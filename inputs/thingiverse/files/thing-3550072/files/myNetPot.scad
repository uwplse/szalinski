plateDiameter=35; // diameter of top plate
plateHeight=1; // height of top plate

insetDiameter=21; // needed diameter for your inset
insetHeight=28; // needed height for your inset

wallThickness=1.2; // thickness of walls

additionalRingDiameter=29; // if your inset has a significant smaller diameter than your hole, you can use this additional ring to increase the stability. has to be at least greater than insetDiameter+2*wallThickness
additionalRingHeight=2; // height of additional ring

// stop editing here

$fn=64;

difference() {
  union() {
    cylinder(d=plateDiameter, h=plateHeight);
    translate([0, 0, plateHeight]) cylinder(d=insetDiameter+2*wallThickness, h=insetHeight);
    if ( additionalRingDiameter > insetDiameter+2*wallThickness ) {
      difference() {
        translate([0, 0, plateHeight]) cylinder(d=additionalRingDiameter+2*wallThickness, h=additionalRingHeight);
        translate([0, 0, plateHeight]) cylinder(d=additionalRingDiameter, h=additionalRingHeight);
      }
    }
  }

  cylinder(d=insetDiameter, h=plateHeight+insetHeight-insetHeight/10);
  translate([0, 0, plateHeight+insetHeight-insetHeight/10]) cylinder(d1=insetDiameter, d2=insetDiameter*0.75, h=insetHeight/10);

  outCuts(0);
  outCuts(45);
  outCuts(90);
  outCuts(135);
}

module outCuts(angle) {
    translate([0, 0, plateHeight+insetHeight/2]) rotate([0, 0, angle]) minkowski() {
    cube([insetDiameter+2*wallThickness, 0.1, insetHeight*0.6], true);
    rotate([0, 90, 0]) cylinder(d=insetDiameter/4.5, h=0.1);
  }
}