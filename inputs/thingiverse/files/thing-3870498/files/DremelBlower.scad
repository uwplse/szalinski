$fn=72;

FanTopDiameter=15;
FanBottomDiameter=17;
FanCoreDiameter=8;
FanHeight=10;
FlapsNumber=4; //For type 4 the number of flaps for odd number will be double this value.
FlapsPitch=120;  //For type 0 and 1 is from 0 to 90 degrees, for type 2 is the total degrees for 1 turn (360 will result in a flap going all around the core). Using negative values invert the pitch direction.
FlapsThickness=3;
ToolShaftDiameter=3.37;//Give about 0.2mm more to fit the bits or give the right value and drill it later to the correct size.
FanType=5;
Type2FlapsRatio=6;

intersection()
{
	if(FanType==0)
		difference()
		{
			union()
			{
				cylinder(d=FanCoreDiameter,h=FanHeight,center=true);

				if(FanTopDiameter>=FanBottomDiameter)
					translate([0,0,0])
						for(a=[0:360/FlapsNumber:359])
							rotate([0,0,a])
								translate([0,FanTopDiameter/2,0])
									rotate([0,FlapsPitch,0])
										cube([FlapsThickness,FanTopDiameter,FanHeight*10],center=true);

				if(FanTopDiameter<FanBottomDiameter)
					translate([0,0,0])
						for(a=[0:360/FlapsNumber:359])
							rotate([0,0,a])
								translate([0,FanBottomDiameter/2,0])
									rotate([0,FlapsPitch,0])
										cube([FlapsThickness,FanBottomDiameter,FanHeight*10],center=true);

			}

			cylinder(d=ToolShaftDiameter,h=FanHeight*2,center=true);

			translate([0,0,FanHeight])
				cylinder(d=FanTopDiameter*2,h=FanHeight,center=true);
			translate([0,0,-FanHeight])
				cylinder(d=FanBottomDiameter*2,h=FanHeight,center=true);
		}

	if(FanType==1)
		difference()
		{
			union()
			{
				cylinder(d=FanCoreDiameter,h=FanHeight,center=true);

				if(FanTopDiameter>=FanBottomDiameter)
					translate([0,0,0])
						for(a=[0:360/FlapsNumber:359])
							rotate([0,0,a])
								translate([0,FanTopDiameter/2,0])
									rotate([0,90+FlapsPitch,0])
										scale([1,2,1])
											cylinder(d=FanTopDiameter/2,h=FlapsThickness,center=true);

				if(FanTopDiameter<FanBottomDiameter)
					translate([0,0,0])
						for(a=[0:360/FlapsNumber:359])
							rotate([0,0,a])
								translate([0,FanBottomDiameter/2,0])
									rotate([0,90+FlapsPitch,0])
										scale([1,2,1])
											cylinder(d=FanBottomDiameter/2,h=FlapsThickness,center=true);

			}

			cylinder(d=ToolShaftDiameter,h=FanHeight*2,center=true);

			translate([0,0,FanHeight])
				cylinder(d=FanTopDiameter*2,h=FanHeight,center=true);
			translate([0,0,-FanHeight])
				cylinder(d=FanBottomDiameter*2,h=FanHeight,center=true);
		}

	if(FanType==2)
		difference()
		{
			union()
			{
				cylinder(d=FanCoreDiameter,h=FanHeight,center=true);

				for(a=[0:360/FlapsNumber:359])
				{
					if(FanTopDiameter==FanBottomDiameter)
						rotate([0,0,a])
							translate([0,0,0])
								linear_extrude(height=FanHeight,twist=FlapsPitch,center=true)
									translate([0,FanTopDiameter/4,0])
										rotate([a,0,0])
											scale([1,Type2FlapsRatio])
												circle(d=FlapsThickness);

					if(FanTopDiameter!=FanBottomDiameter)
						rotate([0,0,a])
							translate([0,0,0])
								linear_extrude(height=FanHeight,twist=FlapsPitch,center=true,scale=FanBottomDiameter/FanTopDiameter)
									translate([0,FanTopDiameter/4,0])
										rotate([0,0,0])
											scale([1,Type2FlapsRatio])
												circle(d=FlapsThickness);
				}

			}

			cylinder(d=ToolShaftDiameter,h=FanHeight*2,center=true);

			translate([0,0,FanHeight])
				cylinder(d=FanTopDiameter*2,h=FanHeight,center=true);
			translate([0,0,-FanHeight])
				cylinder(d=FanBottomDiameter*2,h=FanHeight,center=true);


		}

	if(FanType==3)
		difference()
		{
			union()
			{
				cylinder(d=FanCoreDiameter,h=FanHeight,center=true);

				for(a=[0:360/FlapsNumber:359])
				{
					rotate([0,0,a])
						translate([0,0,0])
							linear_extrude(height=FanHeight,twist=FlapsPitch,center=true)
								translate([0,FanTopDiameter/4-2,0])
									rotate([0,0,0])
										scale([1,(((FanTopDiameter+FanBottomDiameter)/2)/FlapsThickness)/2])
											circle(d=FlapsThickness);
				}

			}

			cylinder(d=ToolShaftDiameter,h=FanHeight*2,center=true);

			translate([0,0,FanHeight])
				cylinder(d=FanTopDiameter*2,h=FanHeight,center=true);
			translate([0,0,-FanHeight])
				cylinder(d=FanBottomDiameter*2,h=FanHeight,center=true);


		}

	if(FanType==4)
		difference()
		{
			union()
			{
				cylinder(d=FanCoreDiameter,h=FanHeight,center=true);

				for(a=[0:360/FlapsNumber:359])
				{
					rotate([0,0,a])
						translate([0,0,0])
							linear_extrude(height=FanHeight,twist=FlapsPitch,center=true)
								translate([0,0,0])
									rotate([0,0,0])
										scale([1,((FanTopDiameter+FanBottomDiameter)/2)/FlapsThickness])
											circle(d=FlapsThickness);
				}

			}

			cylinder(d=ToolShaftDiameter,h=FanHeight*2,center=true);

			translate([0,0,FanHeight])
				cylinder(d=FanTopDiameter*2,h=FanHeight,center=true);
			translate([0,0,-FanHeight])
				cylinder(d=FanBottomDiameter*2,h=FanHeight,center=true);


		}

	if(FanType==5)
		difference()
		{
			union()
			{
				cylinder(d=FanCoreDiameter,h=FanHeight,center=true);

				for(a=[0:360/FlapsNumber:359])
				{
					if(FanTopDiameter<FanBottomDiameter)
					rotate([0,0,a])
						translate([0,0,0])
							linear_extrude(height=FanHeight,twist=FlapsPitch,center=true,slices=200)
								translate([0,0,0])
								{
									square([1,FanBottomDiameter]);

									translate([0,FanBottomDiameter/2-2,0])
										square([20,2]);
								}
					if(FanTopDiameter>FanBottomDiameter)
					rotate([0,0,a])
						translate([0,0,0])
							linear_extrude(height=FanHeight,twist=FlapsPitch,center=true,slices=200)
								translate([0,0,0])
								{
									square([1,FanTopDiameter]);

									translate([0,FanTopDiameter/2-2,0])
										square([20,2]);
								}
				}

			}

			cylinder(d=ToolShaftDiameter,h=FanHeight*2,center=true);

			translate([0,0,FanHeight])
				cylinder(d=FanTopDiameter*2,h=FanHeight,center=true);
			translate([0,0,-FanHeight])
				cylinder(d=FanBottomDiameter*2,h=FanHeight,center=true);


		}

cylinder(d1=FanTopDiameter,d2=FanBottomDiameter,h=FanHeight,center=true);
}
