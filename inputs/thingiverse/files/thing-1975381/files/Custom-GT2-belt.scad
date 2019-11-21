$fn = 25 * 1;
PI = 3.14 * 1;

p = 2 * 1;
R1 = 0.15 * 1;
R2 = 1 * 1;
R3 = 0.555 * 1;
b = 0.4 * 1;
H = 1.38 * 1;
h = 0.75 * 1;
i = 1.2 * 1;
PLD = 0.254 * 1;

thickness = 7;
teethAmount = 141;

actualRadius = teethAmount * p / (2 * PI);

circularBelt(teethAmount);

module circularBelt(teethAmount)
{
    linear_extrude(height = thickness)
    {
        union()
        {
            for(j = [0:teethAmount - 1])
            {
                rotate([0, 0, j * 360 / teethAmount])
                {
                    translate([0, -i + PLD - actualRadius, 0])
                    {
                        tooth();
                    }
                }
            }
            difference()
            {
                circle(r = sqrt(pow((i - PLD + actualRadius), 2) + pow(p / 2, 2)), $fn = teethAmount);
                circle(r = - PLD + actualRadius, $fn = 2 * teethAmount);
            }
        }
    }
}

module belt()
{
    union()
    {
        for(i = [0:teethAmount - 1])
        {
            translate([i * p, 0, 0])
            {
                tooth();
            }
        }
    }
}

module tooth()
{
    union()
    {
        centerSquareX([p, i]);
        translate([0, i + h - R3, 0])
        {
            circle(r = R3);
        }
        translate([-b, i, 0])
        {
            partR2();
        }
        translate([-b + sqrt(pow(R2, 2) - pow(R1, 2)) + R1, i + R1, 0])
        {
            quarterR1();
        }
        mirror()
        {
            translate([-b, i, 0])
            {
                partR2();
            }
            translate([-b + sqrt(pow(R2, 2) - pow(R1, 2)) + R1, i + R1, 0])
            {
                quarterR1();
            }
        }
    }
}

module centerSquareX(dim)
{
    translate([-dim[0] / 2, 0, 0])
    {
        square(dim);
    }
}

module partR2()
{
    xa = -b;
    ya = 0;
    xb = 0;
    yb = h - R3;
    ra = R2;
    rb = R3;
    
    d = sqrt(pow((xb - xa), 2) + pow((yb - ya), 2));
    K = sqrt((d + ra + rb) * (-d + ra + rb) * (d - ra + rb) * (d + ra -rb)) / 4;
    
    x = (xb - xa) / 2 + (xb - xa) * (pow(ra, 2) - pow(rb, 2)) / pow(d, 2) / 2 + 2 * (yb - ya) * K / pow(d, 2);
    
    y = (yb + ya) / 2 + (yb - ya) * (pow(ra, 2) - pow(rb, 2)) / pow(d, 2) / 2 + 2 * (xb - xa) * K / pow(d, 2);
    
    intersection()
    {
        circle(r = R2);
        square([4 * R2, y]);
    }
}

module quarterR1()
{
    difference()
    {
        translate([-R1, -R1, 0])
        {
            square(R1);
        }
        circle(r = R1);
    }
}