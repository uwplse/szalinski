// Overall cup width (2 x radius)
width = 80;
// Overall height
height = 100;
bottomThickness = 2;
topRingHeight = 4;
wallThickness = 2;
twistDegrees = 90;
spokesCount = 16;
spokesStart = 2; // [1: The same place, 2: Next to each other, 3: The same distance]
spokesShape = 1; // [1: Circular, 2: Square]
bottomRing = 1; // [1: Yes, 0: No]
// Not needed if no bottom ring
bottomRingHeight = 4;

/* [Hidden] */
$fa = 1;
$fs = 0.5;

module bottom()
{
    cylinder(r = width / 2, h = bottomThickness);
}

module topRing()
{
    translate([0, 0, height - bottomThickness - topRingHeight])
        difference()
        {
            cylinder(r = width / 2, h = topRingHeight);
            translate([0, 0, -1])
                cylinder(r = width / 2 - wallThickness, h = topRingHeight + 2);
        }
}

module spokesSide(twist)
{
    for(i = [1 : spokesCount])
    {
        rotate([0, 0, (i * (360 / spokesCount))])
            spokeSideRotate(twist);
    }
}

module spokeSide(twist)
{
    translate([0, 0, bottomThickness + (bottomRing ? bottomRingHeight : 0)])
        linear_extrude(height = height - bottomThickness - topRingHeight - (bottomRing ? bottomRingHeight : 0), twist = twist)
            translate([0, width / 2 - wallThickness / 2, 0])
                circle(r = wallThickness / 2, $fn = (spokesShape == 2 ? 4 : $fn));
}

module spokeSideRotate(twist)
{
    if(spokesStart == 2 && twist > 0)
        // arc length simplified to wallThickness value
        rotate([0, 0, -(360 * wallThickness) / (2 * PI * (width / 2 - wallThickness / 2))])
            spokeSide(twist);
    else if(spokesStart == 3 && twist > 0)
        rotate([0, 0, -360 / spokesCount / 2])
            spokeSide(twist);
    else
        spokeSide(twist);
}

module spokes()
{
    spokesSide(twistDegrees);
    spokesSide(-twistDegrees);
}

module bottomRing()
{
    translate([0, 0, bottomThickness])
        difference()
        {
            cylinder(r = width / 2, h = bottomRingHeight);
            translate([0, 0, -1])
                cylinder(r = width / 2 - wallThickness, h = bottomRingHeight + 2);
        }
}

bottom();
topRing();
spokes();
if(bottomRing && bottomRingHeight < height - 2 * bottomThickness)
    bottomRing();
