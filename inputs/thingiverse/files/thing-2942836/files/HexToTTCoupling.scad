hexHeight = 8;
conectorHeight = 10;

translate([0, 0, hexHeight])
{
    motor_connector(conectorHeight);
};

difference()
{
    hexagon (12.2, height = hexHeight );
    hollow_cylinder(height = hexHeight , r_outer=1.3, r_inner = 0);
}

module hexagon(size, height)
{
    r = size / sqrt(3);
    echo(r);
    rotate(a=30, v=[0, 0, 1])
    {
        cylinder(r=r, height, $fn=6);
    }
}

module motor_connector(height)
{
    difference()
    {
        hollow_cylinder(height, r_outer=5, r_inner = 0);
        motor_inner_connector(height, width = 3.6, diameter = 6);
    }
}

module motor_inner_connector(h, width, diameter)
{
    intersection()
    {
        hollow_cylinder(h, r_outer=3, r_inner = 0);
        translate([-(width/2),-(diameter/2),0])
        {
            cube([width, diameter, h]);
        }
    }
}

module hollow_cylinder(height, r_outer, r_inner)
{
    difference()
    {
        cylinder(h=height, r=r_outer, center=false, $fn=100);
        cylinder(h=height, r=r_inner, center=false, $fn=100);
    }
}
