/* [Hidden] */
in = 25.4;

/* [Settings] */
// Thickness of the base disc that pad attaches to
baseThickness = 2;
// Outer diameter of base disc that pad attaches to
baseOD = 40;
// Outer diameter of shank that will go into drill chuck etc.
shankOD = 9.5;
// Number of sides on shank, default 6, hex shank for drill chuck, set to 100 for circular shank
shankSides = 6;
// Length of straight part of shank
shankLength = 40;
// Height used for fillet between base disc and shank
transitionHeight = 15;

drillDisk(baseThickness, baseOD, shankOD, shankSides, shankLength, transitionHeight);

module drillDisk(baseThickness, baseOD, shankOD, shankSides, shankLength,transitionHeight) {
  rshank = shankOD / 2;
  rBase = baseOD / 2;
  rFillet = rBase - rshank;

  rotate_extrude($fn=shankSides)
    square([rshank,shankLength+transitionHeight+baseThickness]);

  rotate_extrude($fn=100)
  difference() {
    square([rBase, baseThickness+transitionHeight]);
    translate([rshank+rFillet, baseThickness+transitionHeight]) 
      scale([1,transitionHeight/rFillet]) 
        circle(r=rFillet,$fn=200);
  }
}