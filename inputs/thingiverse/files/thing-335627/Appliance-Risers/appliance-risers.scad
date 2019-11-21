/* [Global] */

// This is the diameter (in mm) of the extsting feet on the appliance. If there's any question, err on the side of a slightly larger value so that the riser fits around the foot.
FOOT_DIAMETER_MM = 18;

// This is how tall (in mm) the existing feet on the appliance are. We'll create a channel in the riser that fits the feet. If there's any question, err on the side of a smaller value, creating a smaller channel for the feet to fit in.
FOOT_HEIGHT_MM = 6;

// Rise height (in mm). This is how much you want to lift the appliance.
RISE_HEIGHT_MM = 2;

// I sometimes find that printing one object at a time yields better results on my printer. You can select if you want the output to have one foot in the file or all four.
FOOT_COUNT = 1; // [1:Single, 4:Four]

/* [Hidden] */
WALL_SIZE = 2;
CYLINDER_RADIUS = FOOT_DIAMETER_MM / 2 + WALL_SIZE;
CYLINDER_HEIGHT = FOOT_HEIGHT_MM + RISE_HEIGHT_MM;
INNER_CYLINDER_RADIUS = FOOT_DIAMETER_MM / 2;
FOUR_UP_DISTANCE = 0.5;
DETAIL = 80;

module riser()
{
    difference()
    {
        cylinder(r = CYLINDER_RADIUS, h = CYLINDER_HEIGHT, $fn = DETAIL);
        translate(v = [0, 0, CYLINDER_HEIGHT - FOOT_HEIGHT_MM])
            cylinder(r = INNER_CYLINDER_RADIUS, h = FOOT_HEIGHT_MM + 1, $fn = DETAIL);
    }
}

if (1 == FOOT_COUNT)
{
    // Single
    riser();
} else {
    // Multiple
    translate(v = [CYLINDER_RADIUS + FOUR_UP_DISTANCE, CYLINDER_RADIUS + FOUR_UP_DISTANCE, 0])
        riser();
    translate(v = [CYLINDER_RADIUS + FOUR_UP_DISTANCE, -1 * CYLINDER_RADIUS - FOUR_UP_DISTANCE, 0])
        riser();
    translate(v = [-1 * CYLINDER_RADIUS - FOUR_UP_DISTANCE, CYLINDER_RADIUS + FOUR_UP_DISTANCE, 0])
        riser();
    translate(v = [-1 * CYLINDER_RADIUS - FOUR_UP_DISTANCE, -1 * CYLINDER_RADIUS - FOUR_UP_DISTANCE, 0])
        riser();
    }
