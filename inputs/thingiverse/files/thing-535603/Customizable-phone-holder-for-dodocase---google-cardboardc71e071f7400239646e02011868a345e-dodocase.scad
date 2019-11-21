//Size of phone, default iphone 4
height = 58.6;
width = 115.2;

depth = 1*20;//9.3;
//iPhone 4 : 115.2 mm (4.54 in) H; 58.6 mm (2.31 in) W; 9.3 mm (0.37 in) D
//iPhone 5 : 123.8 mm (4.87 in) H; 58.6 mm (2.31 in) W; 7.6 mm (0.30 in) D


module dodocase()
{
	difference() {
		//outer frame
		union()	{	translate([-140/2,-75/2,-8/2]) cube([140,75,8]);
			translate([-140/2,-75/2,8/2]) cube([3,75,5]); //side left
			translate([140/2-3,-75/2,8/2]) cube([3,75,5]); //site right
		}
		//phone
		{
			translate([-width/2,-height/2,-depth/2]) cube([width,height,depth]);	
		}
	}
}

dodocase();