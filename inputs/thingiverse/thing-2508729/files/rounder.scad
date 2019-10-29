// Diameter of the hole the plug is plugged into
bottomDiameter = 19;
// Diameter of the top support, make this slightly smaller then the diameter of the circle you are trying to make
topDiameter = 30;
// Inner hole Diameter, adjust this to the dowel you will use for centering your material
holeDiameter = 2.8;
// Height of the top support, increase this if your tool needs more space on the bottom
topHeight = 5;
// Height of the bottom piece of the plug
bottomHeight = 10;

/* [Hidden] */
$fn = 50;
bottomRadius = bottomDiameter / 2;
topRadius = topDiameter / 2;
holeRadius = holeDiameter / 2;

totalHeight = topHeight + bottomHeight;

difference() {
  group() {
    cylinder(h = totalHeight, r = bottomRadius);
    cylinder(h = topHeight, r = topRadius);
  }
  
  cylinder(h = totalHeight + 2, r = holeRadius);
}