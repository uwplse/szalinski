slitWidth = 18;
slitLength = 80;
taperWidth = 15;
length = 100;
height = 30;

puller();

module puller()
{
    difference()
    {
        base();
        translate([-slitWidth / 2, -0.1, -0.1])
        {
            linear_extrude(height = height + 0.2)
            {
                square([slitWidth, slitLength + 0.1]);
            }
        }
    }
}

module base()
{
    width = slitWidth + 2 * taperWidth;
    translate([width / 2, 0, 0])
    {
        rotate([0, -90, 0])
        {
            linear_extrude(height = width)
            {
                polygon(    points  =   [
                                            [0, 0],
                                            [0, length],
                                            [height, length],
                                        ]
                        );
            }
        }
    }
}