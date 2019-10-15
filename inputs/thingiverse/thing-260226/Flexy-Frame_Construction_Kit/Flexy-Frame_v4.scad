// Flexy-Frame v4 by Gyrobot
// http://www.gyrobot.co.uk
//
//Standard Males were generated with the following params :
//
//    type = "male"
//    diameter_of_connection = 4
//    pitch_circle_diameter = 15
//    limb_height = 2
//    limb_thickness = 2
//
//Standard Females were generated with the following params :
//
//    type = "female"
//    diameter_of_connection = 4
//    pitch_circle_diameter = 40
//    limb_height = 2
//    limb_thickness = 3
//
// preview[view:east, tilt:top]

type = "male" ; // [male,female]
number_of_lobes = 3 ;// [2:100]
web_plate_height = 0;
diameter_of_connection = 4 ;
pitch_circle_diameter = 15 ;
male_limb_height = 2 ; // 1mm is automatically added to this for Female limb height
limb_thickness = 2 ;

// Start of Code

n=number_of_lobes ;
ph=web_plate_height ;
d=diameter_of_connection ;
pcd=pitch_circle_diameter ;
h=male_limb_height ;
t=limb_thickness ;
a=360/n ;

if (type == "male")
	male();

if (type == "female")
	female();

$fn=32*1 ;	

module male ()
{
	if (ph > 0)
		assign ($fn=n)
		cylinder (h=ph, r=pcd/2-d) ;

	for (ia = [0:a:360])
	{
		rotate (ia,[0,0,1])
		{
			translate ([0,-t/2,0])
			cube ([pcd/2,t,h]) ;
			translate ([pcd/2,0,0])
			cylinder (h=h, r=d/2) ;

		}
	}
}

module female ()
{
	difference ()
	{
		union ()
		{
			if (ph > 0)
				assign ($fn=n)
				cylinder (h=ph, r=pcd/2+d) ;

			for (ia = [0:a:360])
			{
				rotate (ia,[0,0,1])
				{
					translate ([0,-t/2,0])
						cube ([pcd/2,t,h+1]) ;
					translate ([pcd/2,0,0])
						cylinder (h=h+1, r=d) ;
					linear_extrude (height = h+1, convexity= 3)
						polygon (points=[[pcd/2-d*1.5,t/-2],[pcd/2-d*1.5,t/2],[pcd/2,d],[pcd/2,-d]]);
				}
			}
		}
		for (ia = [0:a:360])
		{
			rotate (ia,[0,0,1])
			{
				translate ([pcd/2,0,1])
					{
						cylinder (h=ph+2, r=d/2) ;
						translate ([0,-d/4,0])
						cube ([pcd/2,d/2,ph+2]) ;
					}
			}
		}
	}
}