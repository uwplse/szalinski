$fn = 50;

width = 15;
length = 30;
height = 20;
extraBaseWidth = 13;

wallThickness = 5;
slitWidth = 1.5;

screwRadius = 1.5;

miter();

module miter()
{
    difference()
    {
        union()
        {
            centerCube(width + 2 * wallThickness, length, wallThickness + height);
            centerCube(width + 2 * wallThickness + 2 * extraBaseWidth, length, wallThickness);
        }
        translate([0, 0, wallThickness])
        {
            centerCube(width, length + 0.1, height + 0.1);
            for(i = [-1:1:1])
            {
                rotate([0, 0, i * 45])
                {
                    centerCube(width + length + 2 * wallThickness + 0.1, slitWidth, height + 0.1);
                }
            }
        }
        for(i = [-1:2:1])
        {
            for(j = [-1:2:1])
            {
                translate([i * (width / 2 + wallThickness + extraBaseWidth / 2), j * (length / 2 - extraBaseWidth / 2), -0.1])
                {
                    cylinder(r = screwRadius, h = wallThickness - screwRadius + 0.1);
                    translate([0, 0, wallThickness - screwRadius + 0.1 - 0.001])
                    {
                        cylinder(r1 = screwRadius, r2 = 2 * screwRadius, h = screwRadius + 0.002);
                    }
                }
            }
        }
    }
}

module centerCube(x, y, z)
{
    translate([-x / 2, -y / 2, 0])
    {
        cube([x, y, z]);
    }
}