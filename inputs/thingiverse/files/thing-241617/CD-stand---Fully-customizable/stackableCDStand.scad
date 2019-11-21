/* [General] */
partToMake = 0; //[0:CD Holder, 1:Foot]
tolerance = 1.05;
resolution = 50; //[4:100]

/* [Stackable] */
baseHeight = 25; //[10:100]
baseWidth = 7; //[3:20]

topHeight = 8; //[2:20]
topWidth = 5; //[2:20]
topConeHeight = 10; //[0:20]

/* [Foot] */
feetNum = 5; //[3:10]
feetWidth = 3; //[1:10]
feetLength = 22; //[5:50]
footHeight = 5; //[1:10]
footWidth = 11; //[0:40]

/* [Shaft] */
shaftLength = 70; //[30:200]
shaftWidth = 5; //[2:20]

/* [CD holder] */
cdPoleRadius = 7.2;
cdPoleHeight = 15; //[5:50]
cdPoleHatHeight = 4; //[0:10]
cdBaseWidth = 10; //[0:30]
cdBaseHeight = 8; //[0:50]

/* [Hidden] */
$fn = resolution;

module top()
{
	//Create top cylinder
	
	cylinder(h=topHeight, r=topWidth);
	
	//Create a cone at the very top
	translate([0, 0, topHeight])
		cylinder(topConeHeight, topWidth);
}

module stackable()
{
	difference()
	{
		cylinder(h=baseHeight, r=baseWidth); //Base-cylinder

		scale(tolerance, tolerance, tolerance) //Scale the top-hole using tolerance
			top(); //Cut a top-shaped hole in the base
	}

	translate([0, 0, baseHeight]) top(); //Add the top, on top of the base
}

module foot()
{
	stackable();
	
	for(i = [0:feetNum])
	{
		rotate(i*(360/feetNum), [0, 0, 1])
		{
			translate([feetLength/2+topWidth, 0, feetWidth/2])
				cube([feetLength, feetWidth, feetWidth], center = true);
			
			translate([feetLength+topWidth, 0, 0])
				cylinder(footHeight, footWidth);
		}
	}
}

module shaft()
{
	difference()
	{
		translate([0, 0, -shaftWidth/2])
			rotate(45, [1, 0, 0])
				cube([shaftLength, shaftWidth, shaftWidth], center = true);
				
		translate([0, 0, -shaftWidth])
			rotate(45, [1, 0, 0])
				cube([shaftLength, shaftWidth, shaftWidth], center = true);
		
		translate([0, 0, -shaftWidth])
			cube([shaftLength, shaftWidth*2, shaftWidth], center = true);
	}
	
}

module cdPole()
{	
	difference()
	{
		cylinder(cdBaseHeight, cdBaseWidth, cdPoleRadius); //CD base cone
		scale(0.9, 0.9, 0.9) cylinder(cdBaseHeight, cdBaseWidth, cdPoleRadius); //CD base cone
	}
	
	cylinder(h=cdPoleHeight, r=cdPoleRadius); //CD pole
	
	translate([0, 0, cdPoleHeight])
		cylinder(cdPoleHatHeight, cdPoleRadius); //CD top cone
}


if( partToMake == 1 )
{
	foot();
}
else
{
	stackable();
	translate([shaftLength/2+topWidth*tolerance, 0, shaftWidth/2]) shaft();
	translate([shaftLength, 0, 0]) cdPole();
}
