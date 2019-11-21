//Determines bevel sizeing around outer edges.
roundness = 0.5;
//Tilts cards forward or backward.
rotate_x = 10;
//Adjusts tilt longways.
rotate_y = -15;
//length of card
length=90;
//height of card (max 65)
card_height=50;


difference()
{
    // The "main"-cube
    minkowski()
    {
        cube([75 - roundness,length - roundness,card_height - roundness]);
        sphere(roundness, $fn = 75);
    }

    // Business cards will be in this cube
    translate([-15, 10, 10])
        cube ([65, 85, 60]);

    // This is the footprint-cube where it will touch the desk
    translate([95, 50, 20])
        rotate([0, rotate_x, rotate_y])
            cube([50, 150, 100], center = true);
}

