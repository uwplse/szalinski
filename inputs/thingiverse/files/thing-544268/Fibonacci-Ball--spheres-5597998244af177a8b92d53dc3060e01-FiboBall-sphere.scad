
ball_size = 30;
spheres_size = 7;
twist_factor = 360;
fixation_position = 43;
fixation_size = 5;

// 1, 1, 2, 3, 5, 8, 13, 21
PHI = (1+sqrt(5))/2;

module semi_sphere(size)
{
	difference()
	{
		sphere(size);
        translate([0,0,-size]) cube(2*size,center=true);
	}
}

	for (i = [-150:164])
		rotate([0,0,i*twist_factor/PHI])
			rotate([exp(i/120)*45,0,0])
				translate([0,0,ball_size])
					cylinder(
						h=spheres_size/2,
						r1=spheres_size,
						r2=0
					);
					//semi_sphere(spheres_size);

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
