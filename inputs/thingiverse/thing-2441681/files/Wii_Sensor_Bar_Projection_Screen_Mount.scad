wiiSensorBarWidth=53;
wiiSensorBarHeight=21;
projectionScreenBarDiameter=23;
wallThickness=2;
partThickness=10;

union()
{
outerCubeWidth = wiiSensorBarWidth + wallThickness * 2;
outerCubeHeight = wiiSensorBarHeight + wallThickness * 2;

difference()
{
cube([outerCubeWidth, outerCubeHeight, partThickness]);
translate([wallThickness, wallThickness, -1])
cube([wiiSensorBarWidth, wiiSensorBarHeight, partThickness + 2]);
}

difference()
{
outerRadius = (projectionScreenBarDiameter + wallThickness * 2) / 2;
innerRadius = projectionScreenBarDiameter / 2;

translate([outerCubeWidth / 2, outerCubeHeight + innerRadius, 0])
difference()
{
cylinder(r=outerRadius, partThickness);
translate([0, 0, -1])
cylinder(r=innerRadius, partThickness + 2);
}

translate([outerCubeWidth / 2, outerCubeHeight + innerRadius, -1])
rotate([0, 0, 45])
cube([outerRadius+1, outerRadius+1, partThickness + 2]);
}
}