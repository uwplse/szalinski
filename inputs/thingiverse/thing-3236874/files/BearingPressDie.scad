// Die for pressing small bearings in and out of fixtures.
$fn = 50;

// Outer diameter of the bearing.
bearing_outer_diameter = 16.0;

// Height of the bearing press (a bit bigger than the bearing width).
press_height = 12.0;

// Clearenence so that the printer parts separate.
clearance = 0.6;

difference()
{
    cylinder(r=(bearing_outer_diameter/2)+5, h=press_height);

    translate([0, 0, -0.1])
        cylinder(r=(bearing_outer_diameter+clearance)/2, h=press_height+0.2);
}

cylinder(r=(bearing_outer_diameter-clearance)/2, h=press_height);
