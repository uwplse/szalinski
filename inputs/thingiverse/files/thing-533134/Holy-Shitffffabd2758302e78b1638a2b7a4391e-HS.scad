
$fn = 36;

wing_thickness = 4;
wing_size = 10;
wing_position = 30;
shit_size = 12;
fixation = true; // [true: with, false: without]
fixation_hole = 5;

module wing(thickness, size)
{
	linear_extrude(thickness)
	scale(size/10)
	{
		circle(10);
		translate([15,10]) circle(10);
		translate([30,20]) circle(10);
		translate([45,30]) circle(10);
		hull()
		{
			translate([10,30]) circle(10);
			polygon([[-10,0],[0,0],[45,30],[45,40]]);
		}
	}
}

module shit(R)
{
	for (i = [-9:89])
	{
		assign(
			z0 = i<0 ? 0 : R*i/36,       z1 = (i+1)<0 ? 0 : R*(i+1)/36,
			r0 = i<0 ? 3*R : (3-i/36)*R, r1 = (i+1)<0 ? 3*R : (3-(i+1)/36)*R
		)
		hull()
		{
			rotate([0,0,i*10])
				translate([r0,0,z0]) rotate([90,0,0]) cylinder(r=R,h=0.1);
			rotate([0,0,(i+1)*10])
				translate([r1,0,z1]) rotate([90,0,0]) cylinder(r=R,h=0.1);
		}
	}
	translate([0,-3*R,0]) sphere(r=R);
	translate([-R/2,0,2.5*R]) sphere(r=R);
}

module fix(size)
{
	rotate([90,0,0])
		rotate_extrude()
			translate([size,0])
				circle(size/2);
	translate([0,0,-3*size]) cylinder(r=size/2,h=2*size);
}

translate([wing_position,wing_thickness/2,wing_position])
	rotate([90,0,0])
		wing(wing_thickness, wing_size);
translate([-wing_position,-wing_thickness/2,wing_position])
	rotate([-90,180,0])
		wing(wing_thickness, wing_size);

shit(shit_size);

if (fixation)
	translate([0,0,3.5*shit_size+fixation_hole])
		fix(fixation_hole);

