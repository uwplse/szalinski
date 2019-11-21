// Ball Diameter
ball_d = 60;  // [20:90]
// Stylus Length
stylus = 96;  // [20:230]
// Surface Smoothing
smooth = 30;  // [30:100]

$fn = smooth;
ball = ball_d/2;
union()
{
cylinder (h=stylus/3, r1=ball*sin(acos((ball-5)/ball)), r2=3.5);
difference()
{
translate([0,0,-ball+5])
sphere(ball);
translate([-ball, -ball, -ball*4+10])
cube(ball*2);
}
difference()
{
cylinder (h=stylus, r1=3.5, r2=3.5);
translate([0,0,stylus-9])
cylinder (h=9, r1=2.5, r2=2.5);
}
}