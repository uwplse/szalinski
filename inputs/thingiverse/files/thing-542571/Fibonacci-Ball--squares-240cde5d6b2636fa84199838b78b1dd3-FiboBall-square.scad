
ball_size = 30;
squares_size = 4;
twist_factor = 360;
fixation_position = 43;
fixation_size = 5;

// 1, 1, 2, 3, 5, 8, 13, 21
PHI = (1+sqrt(5))/2;

difference()
{
	sphere(ball_size+squares_size);
	sphere(ball_size);
	for (i = [-150:164])
		rotate([0,0,i*twist_factor/PHI])
			rotate([exp(i/120)*45,0,0])
				translate([0,0,ball_size])
					//sphere(squares_size);
					cylinder(
						h=squares_size,
						r1=0,
						r2=sin(exp(i/120)*45)*exp(i/240)*squares_size,
					$fn=4);
}

module fix(size)
{
	rotate([90,0,0])
		rotate_extrude()
			translate([size,0])
				circle(size/2, $fn=36);
	translate([0,0,-4*size])
		cylinder(r=size/2,h=3*size,$fn=36);
}

translate([0,0,fixation_position]) fix(fixation_size);
