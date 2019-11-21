////////////////////////////////////////////////////////////////
// PARAMETERS //////////////////////////////////////////////////

baseDiameter = 53;  // in millimiters
baseHeight = 6;
topDiameter = 65;
topHeight = 20;
wall = 2;
bladeThickness = 1.1;
bladeCount = 6;
bladeAngle = 30;

leveller();

module leveller() {
  difference() {
    cylinder(d = baseDiameter, h = baseHeight, $fn = 150);
    translate([0, 0, -1])  // translation for cleaner look on preview
      cylinder(d = baseDiameter - 2*wall, h = baseHeight + 2, $fn=150); // taller for cleaner look on preview
  }
  translate([0, 0, baseHeight])
  difference() {
    cylinder(d1 = baseDiameter, d2 = topDiameter, h = topHeight, $fn=150);
    translate([0, 0, -1])  // translation for cleaner look on preview
      cylinder(d1 = baseDiameter - 2*wall -0.6, d2 = topDiameter-2*wall, h = topHeight + 2, $fn=150);
  }
  
  for (a = [0 : bladeCount - 1]) {
    angle = a * 360 / bladeCount;
    //translate(radius * [sin(angle), -cos(angle), 0])
    rotate([0, 0, angle])
      blade();
  }

}

module blade() {
  difference() {
    rotate(bladeAngle, [1, 0, 0])
      translate([0, -wall/2, -baseHeight])
       cube([baseDiameter/2 - bladeThickness/2, bladeThickness, 2*baseHeight]);
    translate([-baseDiameter/2, -baseDiameter/2, -topHeight])
      cube([baseDiameter, baseDiameter, topHeight]);
    // cut out blade top corner if blade angle and base are "high"
    difference() {
      cylinder(d = baseDiameter * 2, h = topHeight);
      cylinder(d = baseDiameter, h = topHeight);
    }
  }
}