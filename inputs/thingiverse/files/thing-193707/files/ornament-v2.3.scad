use <write/Write.scad> ;
/* [Text] */

// Or any message
nameText = "MakerBot"; 

// May need to adjust this to make nameText fit nicely
nameTextScale = 7; 

/* [Snowmen] */

// Adjust for family size
numberOfSnowmen = 5; // [0:5]

// Largest Snowman 
snowmanOneGender = 1; // [1:Man,0:Woman]

snowmanTwoGender = 0; // [1:Man,0:Woman]

snowmanThreeGender = 0; // [1:Man,0:Woman]

snowmanFourGender = 1; // [1:Man,0:Woman]

// Smallest Snowman 
snowmanFiveGender = 0; // [1:Man,0:Woman]

/* [PrintSettings] */

// You may need if you arn't printing with generated support (That's how I printed)
enableSupport = "Yes"; // [Yes,No]

/* [Year] */
yearText = 2015;


/* [Hidden] */

// Going to upload a dualstrusion version sometime.
//enableDualPrint = 0; [0:No,1:Yes];

// A few different things to toggle on and off when playing with dual extrusion
// Set the colors to 1 that you want on, and to 0 to subtract the items
// Note, if you place scene objects overlapping, the colors may not subtract correctly causing an overlap
// (eg. if you embedded one present into another and turn off primary scene color or ribbon color)

// I think main body,ribbon, and year text in a bright color, with the rest being in an off white looks great!
color1 = 1; // Main body
color2 = 1; // Globe text (Text on out side of globe)
color3 = 1; // Snowmen hats and buttons
color4 = 1; // primary scene color
color5 = 1; // Presents ribbon
color6 = 1; // Tree
color7 = 1; // Scene text  (Text that's part of teh scene)

print_ornament();

module print_ornament()
{

scale(1.5)
{

difference()
{
	translate([0,0,28])
	{
		//difference()
		{
			union()
			{
				if(color1)
				{
					hoop();
					globe();
			
					if(enableSupport == "Yes")
					{
						translate([14.3,14.3,-28]) cylinder(r1=4,r2=0,h=7);
						translate([-14.3,14.3,-28]) cylinder(r1=4,r2=0,h=7);
						translate([14.3,-14.3,-28]) cylinder(r1=4,r2=0,h=7);
						translate([-14.3,-14.3,-28]) cylinder(r1=4,r2=0,h=7);
					}
			
				}
	
				if(color4)
				{
					color("white")
					difference()
					{
						sphere(r=28);
						translate([-50,-50,-17]) cube([100,100,100]);
					}
				}
		
				translate([0,0,-17])
				{

					if(numberOfSnowmen > 0) 
						translate([10,0,1]) scale(1.2) rotate([0,0,-30]) snowman(man=snowmanOneGender);
					if(numberOfSnowmen > 1) 
						translate([18,0,.9]) rotate([0,0,21]) snowman(man=snowmanTwoGender);
					if(numberOfSnowmen > 2) 
						translate([9,6,0]) scale(.6) rotate([0,0,-40]) snowman(man=snowmanThreeGender);
					if(numberOfSnowmen > 3) 
						translate([18,6,0]) scale(.7) rotate([0,0,40]) snowman(man=snowmanFourGender);
					if(numberOfSnowmen > 4) 
						translate([14,5,0]) scale(.4) rotate([0,0,0]) snowman(man=snowmanFiveGender);
					
					if(color6)
					{
						scale(2) tree();
					}
			
					translate([-17,-1,3]) present();
					scale(.9) translate([-15,5,0]) present();
					translate([-16,-3,0]) present();
					scale(1.2) translate([-10,0,0]) present();
					translate([-18,0,0]) present();
					scale(1.3) translate([-9,-6,0]) present();
			
					if(color7)
					{
						translate([0,-12,(9/2)-.5]) rotate([90,0,0]) 
						union()
						{
							write(str(yearText),t=3,h=9,center=true,font="write/knewave.dxf", space=.8);
							if(enableSupport == "Yes")
							{
								for ( i = [-10 : 0.7 : 11] )
								{
									translate([i,-5,-1.5]) cube([.2,10,3]);
								}

//								translate([-8.1,-5,-1.5]) cube([.2,10,3]);
//								translate([-8.5,-5,-1.5]) cube([.2,7,3]);
//								translate([-7.6,-5,-1.5]) cube([.2,7,3]);
//								translate([6.8,-5,-1.5]) cube([.2,7,3]);
//								translate([6.3,-5,-1.5]) cube([.2,7,3]);
//								translate([7.3,-5,-1.5]) cube([.2,7,3]);
							}
						}
						translate([0,12,1]) rotate([10,0,180]) 
							write(nameText,h=nameTextScale,center=true,font="write/knewave.dxf", space=.8);
						translate([0,12,0]) rotate([10,0,180]) 
							write(nameText,h=nameTextScale,center=true,font="write/knewave.dxf", space=.8);
 				}
			
				}
			}

			if(color4 == 1 && color7 == 0)
			{
				translate([0,0,-17])
				{
						translate([0,-12,(9/2)-.5]) rotate([90,0,0]) 
						union()
						{
							write(str(yearText),t=3,h=9,center=true,font="write/knewave.dxf", space=.8);
								for ( i = [-10 : 0.7 : 11] )
								{
									translate([i,-5,-1.5]) cube([.2,10,3]);
								}

						}
						translate([0,12,1]) rotate([10,0,180]) 
							write(nameText,h=nameTextScale,center=true,font="write/knewave.dxf", space=.8);
						translate([0,12,0]) rotate([10,0,180]) 
							write(nameText,h=nameTextScale,center=true,font="write/knewave.dxf", space=.8);
				}
			}
		}

		if(color2)
		{
			//render() 
            writesphere(text="Merry Christmas", where=[0,0,0], radius=30, east=180, north=55, rounded = true);
			//render() 
            writesphere(text="Merry Christmas", where=[0,0,0], radius=30,  east=0, north=55, rounded = true);
		}
	}

	if(color2 == 0)
	{
		translate([0,0,28])
		{
			//render() 
            writesphere(text="Merry Christmas", where=[0,0,0], radius=30, east=180, north=55, rounded = true);
			//render() 
            writesphere(text="Merry Christmas", where=[0,0,0], radius=30,  east=0, north=55, rounded = true);
		}
	}
	translate([-50,-50,-100]) cube([100,100,100]);
}

}
}

module hoop()
{
difference()
{	
	translate([0,0,32])
	rotate([90,0,0])
	rotate_extrude()
	translate([7,0,0])
	circle(r = 3);
	sphere(r=28);
}
}

module globe()
{
	window_distance = 22; // from center line

	difference()
	{
		sphere(r=30,$fn=60);

		sphere(r=28);
		translate([-50,window_distance,-50]) cube([100,100,100]);
		translate([-50,-100 - window_distance,-50]) cube([100,100,100]);
		translate([window_distance,-50,-50]) cube([100,100,100]);
		translate([-100 - window_distance,-50,-50]) cube([100,100,100]);
		
	}
}

module snowman(man=1)
{
//	render()
	{
		if(color3)color("black")
		{
			coal(man);
		}
	
//		if(color4)
//		{
//			color("white") difference()
//			{
//				union()
//				{
					translate([0,0,6.7]) sphere(r=1.5,$fn=20);
					translate([0,0,3.9]) sphere(r=2.3,$fn=25);
//					difference()
//					{
						sphere(r=3,$fn=20);
//						translate([-5,-5,-11]) cube([10,10,10]);
//					}
//				}
//				coal(man);
//			}
//		}
	}
}

module coal(man=1)
{
		// eyes
		translate([.5,1.4,7.2]) eye_coal();
		translate([-.5,1.4,7.2]) eye_coal();

		// nose
		translate([0,1.9,6.9]) rotate([90,0,0])
			cylinder(r1=0,r2=.2,h=.5,$fn=30);

		// mouth
		translate([-.6,1.4,6.45]) mouth_coal();
		translate([-.3,1.4,6.3]) mouth_coal();
		translate([0,1.4,6.2]) mouth_coal();
		translate([.3,1.4,6.3]) mouth_coal();
		translate([.6,1.4,6.45]) mouth_coal();

		// buttons
		translate([0,2.2,3.2]) button_coal();
		translate([0,2.3,4.2]) button_coal();
		translate([0,1.9,5.2]) button_coal();

		// hat
		if(man==1)
		{
			translate([-.7,0,0])rotate([1,6,0])
			{
				translate([0,0,7.8]) cylinder(r=1,h=1.5,$fn=20);
				translate([0,0,7.8]) cylinder(r=1.5,h=.2,$fn=20);
				translate([0,0,7.4]) cylinder(r1=.5,r2=1.5,h=.4,$fn=20);
			}
		}
		else
		{
			translate([-.7,0,0])rotate([1,6,0])
			{
				translate([0,0,7.8]) sphere(r=1,$fn=40);
				translate([0,0,7.8]) cylinder(r=1.5,h=.2,$fn=40);
				translate([0,0,7.4]) cylinder(r1=.5,r2=1.5,h=.4,$fn=40);
			}
		}
}

module mouth_coal()
{
    sphere(r=.15,$fn=10);
}

module eye_coal()
{
    sphere(r=.2,$fn=10);
}

module button_coal()
{
    sphere(r=.3,$fn=10);
}

module tree()
{
	color("green")
	{
		translate([0,0,8]) cylinder(r1=2,r2=.3,h=3,$fn=20);
		translate([0,0,6]) cylinder(r1=2.5,r2=.5,h=4,$fn=20);
		translate([0,0,4]) cylinder(r1=3,r2=1,h=4,$fn=20);
		translate([0,0,2]) cylinder(r1=3.5,r2=1.5,h=4,$fn=20);
		cylinder(r1=4,r2=2,h=4,$fn=40);
	}
}

module ribbon()
{
	translate([1,-.1,-.11]) cube([1,3.2,3.2]);	
	translate([-.1,1,-.11]) cube([3.2,1,3.2]);	
}

module present()
{
	if(color5)	{ribbon();}
	if(color4)
	{
//		difference()
		{
			cube([3,3,3]);	
//			if(color5 == 0)	{ribbon();}
		}
	}
}
