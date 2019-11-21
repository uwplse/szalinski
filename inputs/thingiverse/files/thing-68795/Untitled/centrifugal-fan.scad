// USER-DEFINED VARIABLES (IN MILLIMETERS)
FAN_WIDTH = 40;
FAN_HEIGHT = 13;
RING_HEIGHT = 2;
RING_WIDTH = 4;
BLADE_COUNT = 35;
BLADE_WIDTH = 1;
BLADE_ANGLE = -45;	// Degrees
SHAFT_DIAMETER = 2;

// CALCULATED VALUES (DO NOT CHANGE)
bottomRadius = FAN_WIDTH / 2;
topRadius = bottomRadius * 0.25;
ringCenterRadius = bottomRadius - RING_WIDTH;
shaftRadius = SHAFT_DIAMETER / 2;

// CONE
difference()
{
	cylinder(r1 = bottomRadius, r2 = topRadius, h = FAN_HEIGHT, $fn = 100);
	cylinder(r1 = shaftRadius, r2 = shaftRadius, h = FAN_HEIGHT, $fn = 100);
}

// TOP RING
translate([0, 0, FAN_HEIGHT - RING_HEIGHT])
difference()
{
	cylinder(r1 = bottomRadius, r2 = bottomRadius, h = RING_HEIGHT, $fn = 100);
	cylinder(r1 = ringCenterRadius, r2 = ringCenterRadius, h = RING_HEIGHT, $fn = 100);
}

// BOTTOM RING
difference()
{
	cylinder(r1 = bottomRadius, r2 = bottomRadius, h = RING_HEIGHT, $fn = 100);
	cylinder(r1 = ringCenterRadius, r2 = ringCenterRadius, h = RING_HEIGHT, $fn = 100);
}

// BLADES
rotate( 90, [0, 1, 0] )
for ( i = [0 : BLADE_COUNT - 1] )
{
    rotate(i * 360 / BLADE_COUNT, [1, 0, 0])
    translate([-FAN_HEIGHT, bottomRadius - RING_WIDTH, 0])
	 rotate(BLADE_ANGLE, [1, 0, 0])
    cube([FAN_HEIGHT, RING_WIDTH, BLADE_WIDTH], center = false);
}