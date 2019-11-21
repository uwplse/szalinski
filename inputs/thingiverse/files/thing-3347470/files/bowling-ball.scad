// of 8 slices
part = -1; // [-1: no cut, 0, 1, 2, 3, 4, 5, 6, 7]

// Diameter of the ball
ball_d = 218.3; // [215.9 : 0.1 : 218.3]

// Thumb hole diameter
thumb_d = 24.9; // [10 : 0.1 : 40]

// Middle finger hole diameter
middle_d = 19; // [10 : 0.1 : 30]

// Ring finger hole diameter
ring_d = 18; // [10 : 0.1 : 30]

// Distance from center of thumbhole to middle of middle and ring finger holes, measured along the surface.
span = 123; // [100 : 1 : 300]

// Distance between center of middle and ring finger holes, measured along the surface
finger_dist = 31; // [10 : 0.1 : 50]

// Thumb hole depth;
thumb_depth = 75; // [40 : 1 : 100]

// Thumb hole depth;
finger_depth = 37; // [20 : 1 : 100]

/* [Hidden] */
span_ = span / ball_d * 360 / PI;  
finger_dist_ = finger_dist / ball_d * 360 / PI;
$fs = 2;
$fa = 3;


x = [1, 0, 0];
y = [0, 1, 0];
z = [0, 0, 1];



if (part == -1)
    ball();
else
    make_joint(part)
    cut(part)
    ball();


module ball()
{
    rotate(45*z)
    difference()
    {
        sphere(d=ball_d);
        thumb_hole();
        finger_holes();
    }
}

module hole(d=100, h=100)
{
    e = 5;
    translate((ball_d/2+e)*z) mirror(z) cylinder(d=d, h=h+e);
}

module thumb_hole()
{
    hole(thumb_d, thumb_depth);
}

module finger_holes()
{
    rotate(span_*x)
    {
        rotate(finger_dist_ / 2 * y) hole(middle_d, finger_depth);
        rotate(-finger_dist_ / 2 * y) hole(ring_d, finger_depth);
    }
}

module cut(n)
{
    e = 1;
    intersection()
    {
        rotate(90*(n%4)*z)
        rotate(-90*floor(n/4)*x)
        cube((ball_d+e) * [1, 1, 1]);

        children();
    }
}

module make_joint(n)
{
    e = 0.02;
    module joint(female=false)
    {
        margin = female ? 0.3 : 0;
        translate([0, 1, 1]*ball_d/4)
        rotate(-90*y)
        translate(-e*z)
        cylinder(d1=20+margin, d2=10+margin, h=4+margin, $fn=4);
    }
    difference()
    {
        children();

        rotate(90*(n%4-1)*z)
        rotate(-90*floor(n/4)*x)
        joint(female=true);

        if (n < 4)
        rotate(90*(n%4)*z)
        rotate(90*y)
        joint(female=true);
    }
    rotate(90*(n%4)*z)
    rotate(-90*floor(n/4)*x)
    joint();

    if (n >= 4)
    rotate(90*(n%4)*z)
    rotate(90*y)
    joint();
}

