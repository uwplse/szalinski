// by Les Hall
// started 4-22-2014
// 



size = [6, 10, 3];
ballDiameter = 10*sqrt(2);
minDetail = sqrt(2);
spacing = (ballDiameter+minDetail)*sqrt(2)/2;
theta = 22.5;


array(size);


module array(size)
{
	for(x=[0:size[0]-1], y=[0:size[1]-1], z=[0:size[2]-1])
	assign(xs=pow(-1, x), ys=pow(-1, y), zs=pow(-1, z))
	translate(spacing*[x, y, z])
	rotate(theta*xs*ys*zs, [1, 1, 1])
	color([x/(size[0]-1), y/(size[1]-1), z/(size[2]-1)])
	ball();
}


module ball()
{
	loop(ballDiameter, minDetail);
	rotate(90, [1, 0, 0])
	loop(ballDiameter, minDetail);
	rotate(90, [0, 1, 0])
	loop(ballDiameter, minDetail);
}


module loop(diameter, detail)
{
	rotate_extrude(convexity=10, $fn=32)
	translate([diameter/2, 0, 0])
	rotate(45, [0, 0, 1])
	circle(r=detail/2, $fn=4);
}