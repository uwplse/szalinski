//Trefoil Knot Balls

//CUSTOMIZER VARIABLES

knot_high = 20; //[10:100]
ball_radius = 10; //[4:50]

//CUSTOMIZER VARIABLES END

module null ()
{
//For stop read as customizer variable
}

l = knot_high/2;
radius = ball_radius;
steps = 45;

translate ([0,0,l+radius])
union () {
for (t = [0:steps])
{
	translate([l*(sin(t/steps*720)+2*sin(2*t/steps*720)),l*(cos(t/steps*720)-2*cos(2*t/steps*720)),-l*sin(3*t/steps*720)])
    sphere(r=radius);
}
}
