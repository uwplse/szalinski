roundness = 0.5;  //[0.5:0.5:15]
rotate_x = 10; //[0:0.5:10]
rotate_y = -15; //[-15:0.5:15]

difference()
{
    // The "main"-cube
    minkowski()
    {
        cube([75 - roundness,90 - roundness,50 - roundness]);
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

