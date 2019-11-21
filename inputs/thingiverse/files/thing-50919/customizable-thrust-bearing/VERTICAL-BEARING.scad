// radius of the circle of balls (average between external and internal radiuses)
R = 25; 
// number of balls
N = 10;
//walls width (mm) 
W = 0.5; 

r = R*sin(180/N);

//difference()
//{
//	cylinder(h=8, r=20, center=true);
//	cylinder(h=8, r=10, center=true);
//}
difference()
{
	cylinder(h=R*sin(180/N)+2*W, r=R+r+W, center=true,$fn=50);
	for(i=[1:N])
  {
		rotate( i * 360 / N, [0, 0, 1])
		translate([0, R, 0])
    sphere(r = r,$fn=50);
	}
	cylinder(h=R*sin(180/N)+2*W, r=R-r-W, center=true,$fn=50);
}

	for(i=[1:N])
  {
		rotate( i * 360 / N, [0, 0, 1])
		translate([0, R, 0])
    sphere(r = r-W,$fn=50);
	}