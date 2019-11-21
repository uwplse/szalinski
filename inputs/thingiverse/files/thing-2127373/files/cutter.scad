$fn = 50;

bladeThickness = 0.4;
bladeWidth = 9;

cutterWidth = 30;
wallThickness = 3;

bladeLength = 25;
cableRadius = 5;
cutDepth = 0.75;

cutterTopDepth = 3;

clearance = 0.2;

cutter();

module cutter()
{
    cutterBottom();
    translate([0, 30, 0])
    {
        cutterTop();
    }
}

module cutterBottom()
{
    difference()
    {
        linear_extrude(height = wallThickness + cableRadius + bladeWidth - cutDepth)
        {
            square([bladeLength + 2 * wallThickness, bladeThickness + 2 * wallThickness], center = true);
        }
        blade(bladeWidth + cableRadius - cutDepth + 0.1);
        translate([0, 0, wallThickness + bladeWidth - cutDepth + cableRadius])
        {
            rotate([90, 0, 0])
            {
                cylinder(r = cableRadius, h = 2 * wallThickness + bladeThickness + 0.2, center = true);
            }
        }
    }
//    color([1, 0, 0])
//    {
//        blade(bladeWidth);
//    }
}

module blade(width)
{
    translate([0, 0, wallThickness])
    {
        linear_extrude(height = width)
        {
            square([bladeLength, bladeThickness], center = true);
        }
    }
}

module cutterTop()
{
    difference()
    {
        linear_extrude(height = 2 * wallThickness + cableRadius)
        {
            square([bladeLength + 4 * wallThickness + 2 * clearance, 4 * wallThickness + bladeThickness + 2 * clearance], center = true);
        }
        translate([0, 0, wallThickness + cableRadius - cutterTopDepth])
        {
            linear_extrude(height = 2 * wallThickness + cableRadius)
            {
                square([bladeLength + 2 * wallThickness + 2 * clearance, 2 * wallThickness + bladeThickness + 2 * clearance], center = true);
            }
        }
        translate([0, 0, 2 * wallThickness + cableRadius])
        {
            rotate([90, 0, 0])
            {
                cylinder(r = cableRadius, h = 4 * wallThickness + 2 * clearance + bladeThickness + 0.2, center = true);
            }
        }
    }
}