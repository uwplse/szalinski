// Wall thickness
walls = 5;
// Bottom thickness
bottom = 1;
// Height
height = 20;
// Diameter
diameter = 29.4;

/* [Hidden] */
radius = diameter / 2;
totalHeight = bottom + height;
outerRadius = radius + walls;

$fn = 6;

difference() {
  cylinder(r = outerRadius, h = totalHeight);
  translate([0, 0, bottom])
    cylinder(r = radius, h = totalHeight);
}