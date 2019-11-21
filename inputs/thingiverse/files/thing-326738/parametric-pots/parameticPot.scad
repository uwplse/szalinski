height = 50;
radius = 30;
drainHole = 5;

$fn=100;

// for the outside of the pot
module outside()
{
	cylinder(height, radius*0.9, radius, false);

	translate([0,0,height])
	cylinder(height*0.3, radius*1.1, radius*1.1,true);
}

// for the inside of the pot
module inside()
{
	translate([0,0,height*0.1])
	cylinder(height*1.2, radius*0.8, radius*0.955, false);
}

//drainage hole
module hole()
{
	translate([0,0,-1])
	cylinder(height*1.2, drainHole, false);
}

// base
module basePlate()
{
	difference()
	{
		cylinder(height*0.2, radius*1.1, radius*1.2, false);
		
		translate([0,0,height*0.1])
		cylinder(height*0.11, radius*1.002, radius*1.05, false);
	}
}

//building the pot
difference()
{
	outside();
	inside();
	hole();
}

translate([radius*2+radius*0.2,0,0])
basePlate();