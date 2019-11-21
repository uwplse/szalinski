//Leg count
legCount=13 ;//[2:15]
//Pie Cutter radius

pieCutterRadius = 80; //[15:80]

//Pie Cutter thickness
pieCutterthickness=6; //[2:10]

//Center  radius
centerRadius = 15; //[5:20]

main();

module main()
{
	difference()
	{
		union ()
		{
				for ( i = [1 :legCount])
				{
					rotate([0,0,i * (360/ legCount) ])
						leg(	x=pieCutterthickness,
								y=pieCutterRadius,
								z=pieCutterthickness);	
				}
				cylinder(r=centerRadius,h=pieCutterthickness);
		}
		translate([0,0,-pieCutterthickness/2]) 
				cylinder(	r=centerRadius-pieCutterthickness,
								h=2*pieCutterthickness);
	}
}

module leg(x,y,z)
{
	translate([-x/2,0,0] )
	difference()
	{ 
		cube([x,y,z]);
		translate([ x/3,2 *y/3 ,-1]) cube([x/3, y/3 +1 ,z+2]);
	}	
}

