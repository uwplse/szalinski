
front_wheel_radius = 30;
back_wheel_radius = 40;
wheel_width = 20;

axe_spacing = 2*(front_wheel_radius+back_wheel_radius);
wheel_spacing = axe_spacing/2;

car_length = axe_spacing + front_wheel_radius+back_wheel_radius + 20;

module wheel(radius, width)
{
	difference()
	{
		cylinder(h=width,r=radius);
		translate([0,0,width-5])
			cylinder(h=width,r=radius-5);
	}
}

module front_wheel()
{
	wheel(front_wheel_radius, wheel_width);
}

module back_wheel()
{
	wheel(back_wheel_radius, wheel_width);
}

module wheel_pair(spacing)
{
	// axe
	rotate([90,0,0]) cylinder(h=spacing,r=1,center=true);
	// left wheel
	translate([0,spacing/2,0]) rotate([-90,0,0]) child();
	// right wheel
	translate([0,-spacing/2,0]) rotate([90,0,0]) child();
}

// car body
translate([-axe_spacing/2,0,wheel_spacing/2+front_wheel_radius/3])
	hull()
	{
		sphere(wheel_spacing/2);
		translate([axe_spacing,0,0]) scale([1,1,1/2]) sphere(wheel_spacing/2);
	}

// front wheels + axe
translate([axe_spacing/2,0,front_wheel_radius]) wheel_pair(wheel_spacing) front_wheel();
// back wheels + axe
translate([-axe_spacing/2,0,back_wheel_radius]) wheel_pair(wheel_spacing) back_wheel();

