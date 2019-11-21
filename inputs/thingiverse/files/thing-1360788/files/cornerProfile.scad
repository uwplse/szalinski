glassThickness = 4.05;
glassSpacer = 0.5;
wallThickness = 2;
mountLength = 15;

rotatedCornerProfile();

module profile()
{
    difference()
    {
        square(mountLength + wallThickness);
        translate([wallThickness + glassThickness + glassSpacer, wallThickness, 0])
        {
            square([mountLength, glassThickness]);
        }
        translate([wallThickness, wallThickness + glassThickness + glassSpacer, 0])
        {
            square([glassThickness, mountLength]);
        }
        translate([2 * wallThickness + glassThickness, 2 * wallThickness + glassThickness + glassSpacer, 0])
        {
            square([mountLength, mountLength]);
        }
        translate([2 * wallThickness + glassThickness, 0, 0])
        {
            square([mountLength, mountLength]);
        }
        translate([0, 2 * wallThickness + glassThickness, 0])
        {
            square([mountLength, mountLength]);
        }
    }
}

module profileExtrude()
{
    difference()
    {
        linear_extrude(height = mountLength)
        {
            profile();
        }
        translate([wallThickness + glassThickness, wallThickness + glassThickness, wallThickness])
        {
            cube([mountLength, mountLength, glassThickness]);
        }
    }
}

module cornerProfile()
{
    difference()
    {
        union()
        {
            profileExtrude();
            rotate([0, 90, 0])
            {
                rotate([0, 0, 90])
                {
                    profileExtrude();
                }
            }
            rotate([-90, 0, 0])
            {
                rotate([0, 0, -90])
                {
                    profileExtrude();
                }
            }
        }
    }
}

module rotatedCornerProfile()
{
    cutOff = 2 * wallThickness + glassSpacer + 6;
    translate([0, 0, -cutOff / sqrt(3)])
    {
        rotate([atan(1/sqrt(2)), 0, 0])
        {
            rotate([0, -45, 0])
            {
                difference()
                {
                    cornerProfile();
                    polyhedron( points  =   [   [-0.1, -0.1, -0.1],
                                                [cutOff, 0, 0],
                                                [0, cutOff, 0],
                                                [0, 0, cutOff],
                                            ],
                                faces   =   [   [0, 1, 2],
                                                [1, 3, 2],
                                                [2, 3, 0],
                                                [3, 1, 0],
                                            ]
                                );
                }
            }
        }
    }
}