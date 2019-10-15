/* [General] */
// Offset from one side
sideLeft = 30.5;
// Offset from the other side
sideRight = 28;

/* [Fine tuning] */
// Thickness of the bottom piece
bottomThickness = 3;
// Thickness of the angle pieces
topThickness = 1.6;
// Wall thickness
wall = 3;
// Margin cutout to align item
margin = 25;
// Corner cutout
radius = 2;
// Margin for inner cutout
cutoutMargin = 5;

/* [Hidden] */
$fn = 180;
thickness = bottomThickness + topThickness;

difference() {
  cube([sideLeft + margin + wall, sideRight + margin + wall, thickness]);
  
  translate([wall, wall, topThickness])
    cube([sideLeft + margin + wall, sideRight + margin + wall, thickness]);
  
  translate([sideLeft + wall, sideRight + wall, - 1])
    cube([sideLeft + margin + wall, sideRight + margin + wall, thickness + 2]);
  
  translate([sideLeft + wall, sideRight + wall, - 1])
    cylinder(r = radius, h = thickness + 2);
  
  translate([-1, -1, topThickness])
    cube([margin, margin, thickness]);
  
  difference() {
    translate([wall + cutoutMargin, wall + cutoutMargin, - 1])
      cube([sideLeft + margin - cutoutMargin * 2, sideRight + margin - cutoutMargin * 2, thickness + 2]);
  
    translate([sideLeft + wall - cutoutMargin, sideRight + wall - cutoutMargin, - 1])
      cube([sideLeft + margin + wall, sideRight + margin + wall, thickness + 2]);
   
    translate([-cutoutMargin / 2, 0, -1])
      rotate([0, 0, -45])
        cube([cutoutMargin, sideRight + margin + wall, thickness + 2]);
  }
}