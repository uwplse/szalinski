

// plate diameter 80mm works fine for me
plate_diameter=80; 

// 20 degree seems to be perfect, you may try other values
notch_degree=20;   

difference()
{
	union()
	{
		ball();
		translate([0,-plate_diameter/4,0]) plate();
	}
	notch();
}

module notch()
{
	translate([0,0,11])
	rotate([-notch_degree,0,0])
	hull()
	for(x=[+7.5,-7.5],z=[-5,20])
	translate([x,0,z])
	sphere(r=11.5/2,$fn=30);
}

module ball()
{
	intersection()
	{
		cylinder(r=70/2,h=50,$fn=4);

		translate([0,0,10])
		sphere(r=30/2,$fn=50);
	}
}

module plate()
{
	$fn=50;
	intersection()
	{
		cylinder(r=plate_diameter/2,h=25);
	
		translate([0,0,-plate_diameter/14])
		scale([1,1,.3])
		sphere(r=plate_diameter/.7/2);
	}
}


