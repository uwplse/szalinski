
diamLower = 10;
diamUpper = 5;
lenLower = 10;
lenUpper = 10;
layerThickness = 0.2;
circleEdges = 48;

FN = circleEdges;

difference()
{
  translate([0, 0, (lenLower+lenUpper) / 2])
    cube([diamLower+5, diamLower+5, lenLower+lenUpper], true);
  union()
  {
    difference()
    {
      translate([0, 0, -1])
      cylinder(lenLower + layerThickness+1, diamLower/2, diamLower/2, $fn = FN);
      translate([0, 0, lenUpper+layerThickness])
        difference()
        {
          cube([diamLower+1, diamLower+1, 2*layerThickness], true);
          cube([diamLower+2, diamUpper, 2*layerThickness+1], true);
        }
    }
    translate([0, 0, lenLower + layerThickness])
      cylinder(lenUpper - layerThickness+1, diamUpper/2, diamUpper/2, $fn = FN);
    translate([0, 0, lenLower + layerThickness*1.5])
      cube([diamUpper, diamUpper, layerThickness], true);
  }
}