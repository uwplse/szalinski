//William Wartman

//BEGIN CUSTOMIZER

/* [Snowman Parameters] */

//Personality
Personality=0;	// [1:Angry, 0:Happy]

//Render Detail
Render_Detail=30; // [30:LOW, 60:MED, 80:HIGH]

//Model view
View=0; //[0:Assembled, 1:Print]

//END CUSTOMIZER
/* [Hidden] */


scary=Personality;
$fn=Render_Detail;
print=View;

//Body 
snowmanHeight=100;
baseSph=30;
midSph=23;
headSph=16;


module body()
	{
	union()
		{
		translate([0,0, baseSph*4/5])
			{
			sphere(r=baseSph, center=true);
			}
		translate([0,0, (baseSph+snowmanHeight-headSph)/2])
			{
			sphere(r=midSph, center=true);
			}
		translate([0,0,snowmanHeight-headSph])
			{
			sphere(r=headSph, center=true);
			}
		}
	}



//Arms
armSegLength=midSph*1.5;
armThickness=midSph/8;

module arms()
	{
	//Left arm
	translate([0,midSph*4/5, (baseSph+snowmanHeight-headSph)/2])
		{
		union()
			{
			rotate([-30, 0,0])
				{
				cylinder(r1=armThickness, r2=armThickness, h=armSegLength);
				}
			if(scary)//Add the scary half of the arm
				{
				translate([0, armSegLength*sin(30), armSegLength*cos(30)])
					{
					sphere(r=armThickness, center=true);
					rotate([0, 105, 0])
						{
						cylinder(r1=armThickness, r2=armThickness, h=armSegLength);
						}
					}
				}
			}
		}
	//Right arm
	translate([0, -midSph*4/5, (baseSph+snowmanHeight-headSph)/2])
		{
		union()
			{
			rotate([30, 0, 0])
				{
				cylinder(r1=armThickness, r2=armThickness, h=armSegLength);
				}
			if(scary)//Add the scary half of the arm
				{
				translate([0, armSegLength*sin(-30), armSegLength*cos(-30)])
					{
					sphere(r=armThickness, center=true);
					rotate([0, 105, 0])
						 {
						cylinder(r1=armThickness, r2=armThickness, h=armSegLength);
						}
					}
				}
			}
		}
	}





//Face
noseMin=0; 
noseMax=headSph/6;
noseLength=scary?headSph*1.5:headSph;

module face()
	{
	//Nose
	translate([headSph-2, 0, snowmanHeight-headSph])
		{
		rotate([0, 90, 0])
			{
			cylinder(r1=noseMax, r2=noseMin, h=noseLength);
			}
		}
	//Left (from POV of snowman) eye
	translate([headSph*2/3, headSph/3, snowmanHeight-headSph/2])
		{
		rotate([scary? 20 : -20, 0, 0])
			{
			cube([7,headSph/6,headSph/6], center=true);
			}
		}
	//Right eye
	translate([headSph*2/3, -headSph/3, snowmanHeight-headSph/2])
		{
		rotate([scary? -20: 20, 0,0])
			{
			cube([7,headSph/6, headSph/6], center=true);
			}
		}
	}

//Mouth
module mouth()
	{
	translate([0, 0, snowmanHeight-headSph])
		{
		for(j=[-8:0])
			{
			//Move to each block place/sphere cutout
			translate([ (scary ? headSph*sin(11.25*-j +45) : headSph*sin(11.25*-j+45)-headSph/15), headSph*cos(11.25*j-45), (headSph/2)*sin(22.5*j)])
				{
				rotate([0,0,11.25*j+45])
					{
					if(scary)
						sphere(r=headSph/4, center=true);
					else
						cube([headSph/6, headSph/6, headSph/6], center=true);
					}
				}
			}
		}
	}


//Accessory
module accessory()
	{
	translate([headSph/2*sin(11.25*5.5+45), headSph/2*cos(11.25*(5.5)-45), snowmanHeight-headSph+(headSph/2)*sin(-22.5*5.5)]) 
		{
		union()
			{
			if(print)
				translate([0,0,-4])	
					cylinder(r1=4, r2=1, h=3.01);
			rotate([0,90,25])
				{
				cylinder(r1=1, r2=1, h=headSph);
				}
			}
		//PRINTING SUPPORT
			//Two very thin pieces of plastic to stop the head of the pipe from being a 90-deg overhang - should snap off without damaging pipe
		translate([(headSph-2.0)*cos(25), (headSph-2.0)*sin(25), 0])
			{
			rotate([0, 0, 25])
				{
				difference()
					{
					cube([4, 0.20, 4], center=true);
					for(j=[2,-2])
						{
						translate([0, 0, j])
							{
							rotate([0, 90, 25])
								{
								cylinder(r1=1, r2=0.01, h=4.01, center=true);
								}
							}
						}
					}
				}
			}  
		//END PRINTING SUPPORT
		translate([(headSph+1.5)*cos(25), (headSph+1.5)*sin(25), 0])
			{
			difference()
				{
				cylinder(r1=2, r2=2, h=4, center=true);
				translate([0,0,0.5])
					{
					cylinder(r1=1.5, r2=1.5, h=4, center=true);
					}
				}
			}
		}
	}

module Snowman()
	{	
	difference()
		{
		if(scary)
			{
			union()
				{
				difference()
					{
					union()
						{
						body();
						arms();
						face();
						}
					mouth();
					if(print)
						accessory();
					}
				if(print==0)
					accessory();
				}
			}
		else
			{
			difference()
				{
				union()
					{
					body();
					arms();
					face();
					mouth();
					if(print==0)//Using this 2-pt if statement should hopefully avoid manifold errors...
						accessory();
					}
				if(print)
					accessory();
				}
			}
		translate([0,0,-50])
			{
			cube([100,100,100], center=true);
			}
		}
	}
module split()
	{
	difference()
		{
		union()//The snowman, cut vertically behind the arms and laid flat
			{
			translate([100,-50, 23/8])
				{
				rotate([0, -90, 0])
					{
					Snowman();
					}
				}
			translate([0, 50, -23/8])
				{
				rotate([0,90,0])
					{
					Snowman();
					}
				}
			translate([0,0,-(snowmanHeight-headSph+(headSph/2)*sin(-22.5*5.5))+2])
				{
				rotate([0,0,-25])
					{
					accessory();
					}
				}
			} 
		translate([0,0, -50])
			{
			cube([500, 500, 100], center=true);
			}
		}
	}
 
if(print)
	{
	split();
	}
else
	{
	Snowman();
	}

