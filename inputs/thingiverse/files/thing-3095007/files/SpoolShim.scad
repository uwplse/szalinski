spoolWidth = 80;
outerDiameter = 73;
innerDiameter = 45;
chamferLength = 10;
chamferOffset = 5;
facets = 250;
module positive()
{
    $fn = facets;
   cylinder(
    h=spoolWidth
    -2*chamferLength,   r1=outerDiameter,   r2 = outerDiameter,center = true);

   translate([0,0,
    spoolWidth/2-   chamferLength])cylinder(h=chamferLength, r1 = outerDiameter, r2 = outerDiameter - chamferOffset);
   translate([0,0,- spoolWidth/2])cylinder(h=chamferLength, r1 = outerDiameter - chamferOffset, r2 = outerDiameter);
}
module negative()
{
    $fn = facets;
    cylinder(
    h=spoolWidth
    -2*chamferLength,   r1=innerDiameter,   r2 = innerDiameter,center = true);
    translate([0,0,
    spoolWidth/2-   chamferLength])cylinder(h=chamferLength, r1 = innerDiameter, r2 = innerDiameter + chamferOffset);
    translate([0,0,- spoolWidth/2])cylinder(h=chamferLength, r1 = innerDiameter + chamferOffset, r2 = innerDiameter);
}
difference()
{
    positive();
    negative();
}