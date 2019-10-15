//Enter total height of rocket MM.
height = 62;

// Enable tail fins. If enabled, the rocket will be wider and will not fit in the pod.
fins = 0; // [0,2,3,4,5]

//Enter total width/diameter of rocket POD (not the rocket itself) in MM. Actual width = (width-2)/4-1
width = 27;

w = (width-2)/4-1;
h = height;
f = fins;

module fin()
{
	difference()
	{
		cylinder(r=w/2, h = w);
		translate([0,0,-0.01])cylinder(r=w/2-1, h = w +0.02);
		translate([-w/2,0,-0.01]) cube(w + 0.02);
	}
}

translate([0,0,h-w/2*4])scale([1,1,4])sphere(w/2);
difference()
{
	cylinder(r=w/2, h=h-w/2*4);
	if (f != 0)
	{	
		translate([0,0,-0.1]) difference()
		{
			cylinder(r=w/2+0.05, h = w + 0.1);
			cylinder(r=w/2-1, h = w + 0.1);
		}
	}
}

if (f != 0)
{
for (i= [360/f:360/f:360] )
	rotate([0,0,i])translate([w-2.51,0,0])
		rotate([0,0,25])fin();

}