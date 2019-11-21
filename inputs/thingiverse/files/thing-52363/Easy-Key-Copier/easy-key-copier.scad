/*
*Name: Keytar Copier
*Author: Andrew Ireland
*Date: 18-Feb-2013
*Description: Permits the custom design and copying of different types of working keys.
*/

use <write/Write.scad> 

// preview[view:south, tilt:side]

/************************************************************************
* 		PARAMETERS
*************************************************************************/
//Key type
key_type=1; //[0:Schlage SC1,1:Kwikset KW1,2:C4B,3:LW4]

//Shape of grip/head
head_grip_type=0; //[0:Circle,1:Square,2:Heart,3:Flying V,4:Stratocaster,5:Les Paul]

//Text on key (Excludes guitar keys. Max about 10 Characters) 
grip_text="DO NOT COPY :) "; 

//Notch closest to tip
notch_height1= 6; //[0:9]

//
notch_height2= 4; //[0:9]

//
notch_height3= 5; //[0:9]

//
notch_height4= 1; //[0:9]

//
notch_height5= 2; //[0:9]

//Notch closest to grip/head
notch_height6= 1; //[0:9]

//Rotate key flat for printing
rotate_flat=0; //[0:No,1:Yes]



if (rotate_flat==1){
	chooseKey(key_type);
} else {
	rotate([-90,0,-180]) chooseKey(key_type);
}



/************************************************************************
* 		MODULES
*************************************************************************/

//Chooses the key type to create based on parametric input
module chooseKey(keyType)
{
	if(keyType==0)createKey_SC1();
	if(keyType==1)createKey_KW1();
	if(keyType==2)createKey_C4B();
	if(keyType==3)createKey_LW4();
}



//*********************************************  KEY TYPE - SC1  *********************************************//
//Create and cut key - SC1 type
module createKey_SC1()
{
	shaft_length=31;
	shaft_height=8;
	key_width=2;
	grip_radius=15;
	shaft_to_grip=5;
	notchCutterWidth=2;
	notchCutterSpacer=2.2;
	notchCutterOffsetX=5;
	endCutterWidth=8;
	notchCutterOffsetHeightZ=0.5;
	notchCutterBaseHeightZ=-0.40;
	notchCutterAngle=45;

	createHeadGrip(shaft_length, shaft_height, key_width, grip_radius, shaft_to_grip);		

	difference() 
	{
		createKeyShaftWithGrooves_SC1();

		//Make the end of the key pointy
		rotate([0,0,0]) cutter(0,-4.8,endCutterWidth,notchCutterAngle);
		rotate([180,0,0]) cutter(0,-2.2,endCutterWidth,notchCutterAngle);
		translate([-7.49,0,0]) cube([15,15,15], center=true);

		//Cut the notches based on parametric input
		cutter(1 + notchCutterSpacer + notchCutterOffsetX,notchCutterBaseHeightZ + (notch_height1*notchCutterOffsetHeightZ),notchCutterWidth,notchCutterAngle);
		cutter(1 + (notchCutterSpacer*3) + notchCutterOffsetX,notchCutterBaseHeightZ + (notch_height2*notchCutterOffsetHeightZ),notchCutterWidth,notchCutterAngle);
		cutter(1 + (notchCutterSpacer*5) + notchCutterOffsetX,notchCutterBaseHeightZ + (notch_height3*notchCutterOffsetHeightZ),notchCutterWidth,notchCutterAngle);
		cutter(1 + (notchCutterSpacer*7) + notchCutterOffsetX,notchCutterBaseHeightZ + (notch_height4*notchCutterOffsetHeightZ),notchCutterWidth,notchCutterAngle);
		cutter(1 + (notchCutterSpacer*9) + notchCutterOffsetX,notchCutterBaseHeightZ + (notch_height5*notchCutterOffsetHeightZ),notchCutterWidth,notchCutterAngle);
		cutter(1 + (notchCutterSpacer*11) + notchCutterOffsetX,notchCutterBaseHeightZ + (notch_height6*notchCutterOffsetHeightZ),notchCutterWidth,notchCutterAngle);

	}
}


//Create blank key ready for notch cutting - SC1
module createKeyShaftWithGrooves_SC1()
{
	shaftLength=31;
	tumblerCount=6;
	shaftWidth=1.5;
	shaftHeight=8;
	shaft_tip_offset_y=0;
	shaft_tip_offset_z=5;
	gXOffset = 0;

	difference()
	{
		createShaft(shaftLength,tumblerCount, shaftWidth, shaftHeight, shaft_tip_offset_y, shaft_tip_offset_z);
		groove("diagL", 3.5, -2, gXOffset, -3.9, 0.5, shaftHeight,shaftWidth,shaftLength,0);
		groove("/top", 1.7, 0.9, gXOffset, -0.9, 1, shaftHeight,shaftWidth,shaftLength);
		groove("square", 1.5, 4, gXOffset, 14.5, shaftWidth+1.7, shaftHeight,shaftWidth,shaftLength);
	}
}


//*********************************************  KEY TYPE - KW1  *********************************************//
//Create and cut key - KW1 type
module createKey_KW1()
{
	shaft_length=29;
	shaft_height=8;
	key_width=2.2;
	grip_radius=15;
	shaft_to_grip=5;
	notchCutterWidth=2;
	notchCutterSpacer=1.905;
	endCutterWidth=8;
	notchCutterOffsetX=7;
	notchCutterOffsetHeightZ=0.48;
	notchCutterBaseHeightZ=0;
	notchCutterAngle=45;

	createHeadGrip(shaft_length, shaft_height, key_width, grip_radius, shaft_to_grip);		

	difference() 
	{
		createKeyShaftWithGrooves_KW1();

		//Make the end of the key pointy
		rotate([0,0,0]) cutter(0,-3,endCutterWidth,notchCutterAngle+25);
		rotate([180,0,0]) cutter(0,-2.4,endCutterWidth,notchCutterAngle);
		translate([-7.49,0,0]) cube([15,15,15], center=true);

		//Cut the notches based on parametric input
		cutter(1 + notchCutterSpacer + notchCutterOffsetX,notchCutterBaseHeightZ + (notch_height1*notchCutterOffsetHeightZ),notchCutterWidth,notchCutterAngle);
		cutter(1 + (notchCutterSpacer*3) + notchCutterOffsetX,notchCutterBaseHeightZ + (notch_height2*notchCutterOffsetHeightZ) ,notchCutterWidth,notchCutterAngle);
		cutter(1 + (notchCutterSpacer*5) + notchCutterOffsetX,notchCutterBaseHeightZ + (notch_height3*notchCutterOffsetHeightZ),notchCutterWidth,notchCutterAngle);
		cutter(1 + (notchCutterSpacer*7) + notchCutterOffsetX,notchCutterBaseHeightZ + (notch_height4*notchCutterOffsetHeightZ),notchCutterWidth,notchCutterAngle);
		cutter(1 + (notchCutterSpacer*9) + notchCutterOffsetX,notchCutterBaseHeightZ + (notch_height5*notchCutterOffsetHeightZ),notchCutterWidth,notchCutterAngle);
//		cutter(1 + (notchCutterSpacer*11) + notchCutterOffsetX,notchCutterBaseHeightZ + (notch_height6*notchCutterOffsetHeightZ),notchCutterWidth,notchCutterAngle);

	}
}



//Create blank key ready for notch cutting - KW1
module createKeyShaftWithGrooves_KW1()
{
	shaftLength=29;
	tumblerCount=6;
	shaftWidth=2.1;
	shaftHeight=8.3;
	shaft_tip_offset_y=0;
	shaft_tip_offset_z=5;
	gXOffset=0;

	difference()
	{
		createShaft(shaftLength,tumblerCount, shaftWidth, shaftHeight, shaft_tip_offset_y, shaft_tip_offset_z);
		groove("square",1.5,0.6, gXOffset,2,1.2, shaftHeight,shaftWidth,shaftLength);
		groove("\_/",1.5,1.1, gXOffset,-2.5,0.9, shaftHeight,shaftWidth,shaftLength);
		groove("/bottom",1.5,4, gXOffset,8.4,1, shaftHeight,shaftWidth,shaftLength);
	}

}



//*********************************************  KEY TYPE - LW4  *********************************************//
//Create and cut key - LW4 type
module createKey_LW4()
{
	shaft_length=28;
	shaft_height=8;
	key_width=2;
	grip_radius=15;
	shaft_to_grip=5;
	notchCutterWidth=2.1;
	notchCutterSpacer=2.3;
	notchCutterOffsetX=3;
	endCutterWidth=8;
	notchCutterOffsetHeightZ=0.45;
	notchCutterBaseHeightZ=0;
	notchCutterAngle=45;

	createHeadGrip(shaft_length, shaft_height, key_width, grip_radius, shaft_to_grip);		

	difference() 
	{
		createKeyShaftWithGrooves_LW4();

		//Make the end of the key pointy
		rotate([0,0,0]) cutter(0,-4.5,endCutterWidth,notchCutterAngle);
		rotate([180,0,0]) cutter(0,-2.5,endCutterWidth,notchCutterAngle);
		translate([-7.49,0,0]) cube([15,15,15], center=true);

		//Cut the notches based on parametric input
		cutter(1 + notchCutterSpacer + notchCutterOffsetX,notchCutterBaseHeightZ + (notch_height1*notchCutterOffsetHeightZ),notchCutterWidth,notchCutterAngle);
		cutter(1 + (notchCutterSpacer*3) + notchCutterOffsetX,notchCutterBaseHeightZ + (notch_height2*notchCutterOffsetHeightZ),notchCutterWidth,notchCutterAngle);
		cutter(1 + (notchCutterSpacer*5) + notchCutterOffsetX,notchCutterBaseHeightZ + (notch_height3*notchCutterOffsetHeightZ),notchCutterWidth,notchCutterAngle);
		cutter(1 + (notchCutterSpacer*7) + notchCutterOffsetX,notchCutterBaseHeightZ + (notch_height4*notchCutterOffsetHeightZ),notchCutterWidth,notchCutterAngle);
		cutter(1 + (notchCutterSpacer*9) + notchCutterOffsetX,notchCutterBaseHeightZ + (notch_height5*notchCutterOffsetHeightZ),notchCutterWidth,notchCutterAngle);
//		cutter(1 + (notchCutterSpacer*11) + notchCutterOffsetX,notchCutterBaseHeightZ + (notch_height6*notchCutterOffsetHeightZ),notchCutterWidth,notchCutterAngle);
	}
}


//Create blank key ready for notch cutting - LW4
module createKeyShaftWithGrooves_LW4()
{
	shaftLength=31;
	tumblerCount=6;
	shaftWidth=1.5;
	shaftHeight=8;
	shaft_tip_offset_y=0;
	shaft_tip_offset_z=5;
	gXOffset=0;

	difference()
	{
		createShaft(shaftLength,tumblerCount, shaftWidth, shaftHeight, shaft_tip_offset_y, shaft_tip_offset_z);
		groove("square",1.5,0.6, gXOffset, 2, 1, shaftHeight,shaftWidth,shaftLength);
		groove("/top",1.5,0.6, gXOffset,-2.7,0.9, shaftHeight,shaftWidth,shaftLength);
		groove("/bottom",1.5,4, gXOffset, 8.4,0.9, shaftHeight,shaftWidth,shaftLength);
	}

}




//*********************************************  KEY TYPE - C4B  *********************************************//
//Create and cut key - C4B type
module createKey_C4B()
{
	shaft_length=31;
	shaft_height=8;
	key_width=2;
	grip_radius=15;
	shaft_to_grip=5;
	notchCutterWidth=2;
	notchCutterSpacer=2.2;
	notchCutterOffsetX=4;
	endCutterWidth=8;

	notchCutterOffsetHeightZ=0.43;
	notchCutterBaseHeightZ=0.3;
	notchCutterAngle=45;

	createHeadGrip(shaft_length, shaft_height, key_width, grip_radius, shaft_to_grip);		

	
	difference() 
	{
		createKeyShaftWithGrooves_C4B();

		//Make the end of the key pointy
		rotate([0,0,0]) cutter(0,-4.5,endCutterWidth,notchCutterAngle);
		rotate([180,0,0]) cutter(0,-2.5,endCutterWidth,notchCutterAngle);
		translate([-7.49,0,0]) cube([15,15,15], center=true);


		//Cut the notches based on parametric input
		cutter(1 + notchCutterSpacer + notchCutterOffsetX,notchCutterBaseHeightZ + (notch_height1*notchCutterOffsetHeightZ),notchCutterWidth,notchCutterAngle);
		cutter(1 + (notchCutterSpacer*3) + notchCutterOffsetX,notchCutterBaseHeightZ + (notch_height2*notchCutterOffsetHeightZ),notchCutterWidth,notchCutterAngle);
		cutter(1 + (notchCutterSpacer*5) + notchCutterOffsetX,notchCutterBaseHeightZ + (notch_height3*notchCutterOffsetHeightZ),notchCutterWidth,notchCutterAngle);
		cutter(1 + (notchCutterSpacer*7) + notchCutterOffsetX,notchCutterBaseHeightZ + (notch_height4*notchCutterOffsetHeightZ),notchCutterWidth,notchCutterAngle);
		cutter(1 + (notchCutterSpacer*9) + notchCutterOffsetX,notchCutterBaseHeightZ + (notch_height5*notchCutterOffsetHeightZ),notchCutterWidth,notchCutterAngle);
		cutter(1 + (notchCutterSpacer*11) + notchCutterOffsetX,notchCutterBaseHeightZ + (notch_height6*notchCutterOffsetHeightZ),notchCutterWidth,notchCutterAngle);
	}
	
}



//Create blank key ready for notch cutting - C4B
module createKeyShaftWithGrooves_C4B()
{
	shaftLength=31;
	tumblerCount=6;
	shaftWidth=1.5;
	shaftHeight=8;
	shaft_tip_offset_y=0;
	shaft_tip_offset_z=0;
	gXOffset = 0;

	difference()
	{
		createShaft(shaftLength,tumblerCount, shaftWidth, shaftHeight, shaft_tip_offset_y, shaft_tip_offset_z);
		groove("square", 1.5, 0.6, gXOffset, 2, 1, shaftHeight,shaftWidth,shaftLength);
		groove("/top", 1.5, 0.6, gXOffset, -2.7, 0.9, shaftHeight,shaftWidth,shaftLength);
		groove("/bottom", 1.5, 4, gXOffset, 8.4, 0.9, shaftHeight,shaftWidth,shaftLength);
	}
}




//*********************************************  HELPER FUNCTIONS  *********************************************//

//########### Creates the head/grip of the key
module createHeadGrip(shaft_length, shaft_height, key_width, grip_radius, shaft_to_grip)
{

	grip_radius_a = grip_radius * 1.5;

	//Circle head shape
	if(head_grip_type==0)
	{
		difference()
		{
			union()
			{
				//Create the grip head - Round
				translate([grip_radius+shaft_length+shaft_to_grip,0,key_width/2]) rotate(a=[0,0,0]) cylinder(h=key_width, r=grip_radius, center=true);

				//Create the spacer between the head and shaft
				translate([shaft_length+7,0,key_width/2]) shaftToGripSpacer(shaft_to_grip, key_width, shaft_height+4 );
			}//union
	
			//Put a hole in the handle of key
			translate([grip_radius+shaft_length+shaft_to_grip+6,0,0]) rotate(a=[0,0,90]) cylinder(h=key_width+4, r=2, center=true, $fn=30);

		}//difference

		writeCustomText(grip_radius,shaft_length,shaft_to_grip,key_width);
	}


	//Square head shape
	if(head_grip_type==1)
	{
		difference()
		{
			union()
			{
				translate([grip_radius+shaft_length+shaft_to_grip,0,key_width/2]) rotate(a=[0,0,0]) 
				minkowski()
				{	
					cube([grip_radius,grip_radius, key_width/2], center=true);
					cylinder(h=key_width/2, r=6, center=true);
				}

				//Create the spacer between the head and shaft
				translate([shaft_length+7,0,key_width/2]) shaftToGripSpacer(shaft_to_grip, key_width, shaft_height+4 );
			}//union

			//Put a hole in the handle of key
			translate([grip_radius+shaft_length+shaft_to_grip+6,0,0]) rotate(a=[0,0,90]) cylinder(h=key_width+4, r=2, center=true, $fn=30);
		}//difference

		writeCustomText(grip_radius,shaft_length,shaft_to_grip,key_width);
	}


	//Heart head shape
	if(head_grip_type==2)
	{
		difference()
		{
			union()
			{
				translate([grip_radius+shaft_length+shaft_to_grip,grip_radius*1.44,0]) 
				rotate([0,0,-135])
				linear_extrude(height = key_width,convexity =10, twist =0 )
				{
					polygon(points=[[0,0],[grip_radius_a,0],[grip_radius_a,grip_radius_a/2],[grip_radius_a/2,grip_radius_a],[0,grip_radius_a]], paths=[[0,1,2,3,4]]);
					translate([grip_radius_a,grip_radius_a/2,0]) circle(r=grip_radius_a/2, h=key_width);
					translate([grip_radius_a/2,grip_radius_a,0]) circle(r=grip_radius_a/2, h=key_width);
				} //linear
			}//union
			
			//Put a hole in the handle of key
			translate([grip_radius+shaft_length+shaft_to_grip+12,grip_radius-18,0]) rotate(a=[0,0,90]) cylinder(h=key_width+4, r=2, center=true, $fn=30);
		} //difference

		translate([0,1,0]) writeCustomText(grip_radius-2,shaft_length-1,shaft_to_grip-2,key_width);
	}


	//Guitar head shape - Gibson V
	if(head_grip_type==3)
	{
		difference()
		{
			translate([grip_radius+shaft_length+shaft_to_grip-1.3,0,0]) 
			rotate([0,0,180])
			scale(1.2)
			{
				difference(){
					linear_extrude(height = key_width,convexity =10, twist =0 )
					{
						polygon(points=[[0,0],[-11.9,9.3],[-11,13],[15,5],[15,-5],[-11,-13],[-11.9,-9.3],[0,0]], paths=[[0,1,2,3,4,5,6,7]]);
						translate([-11,11,0]) circle(r=1.9, h=key_width, $fn=30);
						translate([-11,-11,0]) circle(r=1.9, h=key_width, $fn=30);
						translate([-1.5,0,0]) circle(r=2, h=key_width, $fn=30);
					} //Linear

					translate([0,0,-1]) translate([-3.6,0,0]) cylinder(r=2.2, h=key_width+5, $fn=30);
				} //Difference
	
				translate([2,0,2]) cube([3,7,3], center=true);
				translate([10,0,2]) cube([3,7,3], center=true);
				translate([2,-6,2]) cylinder(r=1.5, h=3, center=true, $fn=20);
				translate([-2,-7.5,2]) cylinder(r=1.5, h=3, center=true, $fn=20);
				translate([-6,-9,2]) cylinder(r=1.5, h=3, center=true, $fn=20);

			} //Scale
			//Put a hole in the handle of key
			translate([grip_radius+shaft_length+shaft_to_grip+6,-9.5,0]) rotate(a=[0,0,90]) cylinder(h=key_width+4, r=2, center=true, $fn=30);
		} //Difference

	}//If



	//Guitar head shape - Strata
	if(head_grip_type==4)
	{
		translate([grip_radius+shaft_length+shaft_to_grip-4,0,0]) 
		rotate([0,0,180])
		union()
		{
			difference()
			{
				union()
				{
					hull() //Butt
					{	
						translate([-12.7,5.5,0]) cylinder(r=9.7, h=key_width, $fn=30);
						translate([-12.7,-5.5,0]) cylinder(r=9.7, h=key_width, $fn=30);

						translate([0,3,0]) cylinder(r=7, h=key_width, $fn=40);
						translate([0,-3,0]) cylinder(r=9, h=key_width, $fn=40);
					}

					hull()
					{
						translate([-2,0,0]) cylinder(r=11, h=key_width, $fn=40);
						translate([8.7,7.4,0]) cylinder(r=5.2, h=key_width, $fn=40);
						translate([5,-7.4,0]) cylinder(r=5.2, h=key_width, $fn=40);
					} //hull

				}//Union
			
				translate([12,6,-1]) cylinder(r=4, h=key_width+2, $fn=40);
				translate([9,-5,-1]) cylinder(r=4, h=key_width+2, $fn=40);

				translate([0.9,24,-1]) cylinder(r=13.3, h=key_width+2, $fn=40);
				translate([-1.2,-25.2,-1]) cylinder(r=13.5, h=key_width+2, $fn=40);

				//Put a hole in the handle of key
				translate([-17.5,-7.5,0]) rotate(a=[0,0,90]) cylinder(h=key_width+4, r=2, center=true, $fn=30);
			}//difference

			translate([8,0,1]) cube([grip_radius,shaft_height, key_width], center=true);		
			translate([14,0,2]) cube([3,7,key_width+1], center=true);
			translate([6,0,2]) cube([3,7,key_width+1], center=true);
			translate([-2,0,2]) rotate([0,0,-15]) cube([3,7,key_width+1], center=true);
			translate([-10,0,2]) cube([5,7,key_width+1], center=true);
			translate([-6,-6,2]) cylinder(r=1.5, h=key_width+1, center=true, $fn=20);
			translate([-9.5,-9,2]) cylinder(r=1.5, h=key_width+1, center=true, $fn=20);
			translate([-13.5,-11,2]) cylinder(r=1.5, h=key_width+1, center=true, $fn=20);
		}//union

	} //If Strata






	//Guitar head shape - Les Paul
	if(head_grip_type==5)
	{
		translate([grip_radius+shaft_length+shaft_to_grip-4.5,0,0]) 
		rotate([0,0,180])
		union()
		{
			difference()
			{
				union()
				{
					hull() //Butt
					{	
						translate([-12.7,5.5,0]) cylinder(r=9.7, h=key_width, $fn=30);
						translate([-12.7,-5.5,0]) cylinder(r=9.7, h=key_width, $fn=30);

						translate([0,3,0]) cylinder(r=7, h=key_width, $fn=40);
						translate([0,-3,0]) cylinder(r=9, h=key_width, $fn=40);
					}

					hull()
					{
						translate([-2,0,0]) cylinder(r=11, h=key_width, $fn=40);
						translate([8.7,7.4,0]) cylinder(r=5.2, h=key_width, $fn=40);
						translate([5,-7.4,0]) cylinder(r=5.2, h=key_width, $fn=40);
					} //hull

				}//Union
			
				translate([9,-5,-1]) cylinder(r=4, h=key_width+2, $fn=40);

				translate([0.9,24,-1]) cylinder(r=13.3, h=key_width+2, $fn=40);
				translate([-1.2,-25.2,-1]) cylinder(r=13.5, h=key_width+2, $fn=40);

				//Put a hole in the handle of key
				translate([-17.5,7.5,0]) rotate(a=[0,0,90]) cylinder(h=key_width+4, r=2, center=true, $fn=30);
			}//difference

			translate([7,0,1]) cube([grip_radius,shaft_height, key_width], center=true);		
			translate([13.2,0,2]) cube([3,7,key_width+1], center=true);
			translate([8.2,0,2]) cube([3,7,key_width+1], center=true);
			translate([-2,0,2]) cube([3,7,key_width+1], center=true);
			translate([-7,0,2]) cube([3,7,key_width+1], center=true);
			translate([-12,-5,2]) cylinder(r=1.5, h=key_width+1, center=true, $fn=20);
			translate([-8,-9,2]) cylinder(r=1.5, h=key_width+1, center=true, $fn=20);
			translate([-13.5,-11,2]) cylinder(r=1.5, h=key_width+1, center=true, $fn=20);
			translate([-17.5,-7,2]) cylinder(r=1.5, h=key_width+1, center=true, $fn=20);
			translate([9.9,2,0]) cube([4,6.5,key_width]);
		}//union

	} //If Les Paul


}


//########### Creates a blank key shaft
module createShaft(shaftLength,tumblerCount, shaftWidth, shaftHeight, shaft_tip_offset_y, shaft_tip_offset_z)
{
	shaft_length=shaftLength+5;
	shaft_tip_offset_x=shaft_length/2;

	translate([shaft_tip_offset_x,shaft_tip_offset_y,shaftWidth/2]) cube(size=[shaft_length,shaftHeight,shaftWidth], center=true);
}


//########### Creates grooves along the key shaft
module groove(grooveType, groove_width, groove_height, xOffset, yOffset, zOffset, shaft_height, shaft_width, shaft_length, isMirrored)
{
	shaft_to_grip=shaft_length+5;
	corner_radius=0.5;

	//Square groove
	if(grooveType=="square")
	{
		translate([shaft_to_grip/2, groove_height*2-corner_radius + shaft_height/2 - yOffset, groove_width/2 + corner_radius + shaft_width - zOffset])
		minkowski()
		{
			 cube([shaft_to_grip, groove_height, groove_width], center=true);
			 rotate([0,90,0]) cylinder(r=corner_radius,h=groove_width,center=true, $fn=50);
		}
	}


	//Angled groove - angle towards top - Defaults to the underside/back of the shaft
	if(grooveType=="/top")
	{
		translate([shaft_to_grip/2, shaft_height/2 + yOffset-0.05,zOffset-groove_width/2-0.05])
		rotate([0,0,180])
		hull()
		{	
			 translate([0,(groove_height),0]) rotate([45,0,0]) cube([shaft_to_grip, groove_height, groove_width], center=true);
			 rotate([-20,0,0]) cube([shaft_to_grip, groove_height, groove_width], center=true);
		}
	}


	//Angled groove - angle equal both sides - Defaults to the underside/back of the shaft
	if(grooveType=="\_/")
	{
		translate([shaft_to_grip/2, shaft_height/2 + yOffset-0.05,zOffset-groove_width/2-0.05])
		rotate([0,0,180])
		hull()
		{	
			 translate([0,(groove_height),0]) rotate([35,0,0]) cube([shaft_to_grip, groove_height, groove_width], center=true);
			 rotate([-35,0,0]) cube([shaft_to_grip, groove_height, groove_width], center=true);
		}
	}



	//L shaped diagonal groove - Defaults to the underside/back of the shaft
	if(grooveType=="diagL")
	{
		translate([0,yOffset+shaft_height/2,zOffset])
		rotate([0,90,0])
		linear_extrude(height=shaft_length+0.7,convexity =10, twist =0 )
		{
			if(isMirrored != 1){
				mirror(){
					polygon(points=[[0,0],[groove_width+groove_height,0],[groove_width+groove_height,groove_width]], paths=[[0,1,2]]);
				}
			} else {
				polygon(points=[[0,0],[groove_width+groove_height,0],[groove_width+groove_height,groove_width]], paths=[[0,1,2]]);
			}
		}

	}


	//Angled groove - angle towards bottom
	if(grooveType=="/bottom")
	{
		translate([shaft_to_grip/2, groove_height+0.5 - yOffset, groove_width/2 + shaft_width - zOffset])
		rotate([270,0,0])
		hull()
		{	
			 translate([0,-3/2,(3+0.5)]) rotate([45,0,0]) cube([shaft_to_grip, groove_width, 3], center=true);
			 translate([0,0,groove_width]) cube([shaft_to_grip, groove_width, groove_height], center=true);
		}
	}
}


//########### Create the spacer between the head/grip and shaft
module shaftToGripSpacer(shaftToGrip, keyWidth, shaftHeight)
{
	minkowski()
	{
		 cube([shaftToGrip+4, shaftHeight, keyWidth/2], center=true);
		 rotate([0,0,0]) cylinder(r=2,h=keyWidth/2,center=true);
	}
}


//########### Cuts a notch in the key for the tumblers to fall into
module cutter(lposition, hposition, tumbler_width, cutterAngle)
{
	cutter_wedge_height=15;

	translate([lposition-tumbler_width,-15/2-hposition,2])
	hull()
	{
		translate([0,-1*cutter_wedge_height,0]) rotate([0,90,0]) cube([cutter_wedge_height,1,tumbler_width+cutterAngle], center=true);
		cube([tumbler_width,cutter_wedge_height,cutter_wedge_height], center=true);
	}
}


//########### Write custom text on key
module writeCustomText(grip_radius,shaft_length,shaft_to_grip,key_width)
{
	translate([shaft_length+shaft_to_grip*2+grip_radius/2+3, 0 ,0])
	rotate([0,0,90])
	scale(1.2)
	{
		writecircle(grip_text,[0,0,key_width+0.5],grip_radius-6, t=key_width, font="write/Letters.dxf");
	}
}


//########### Echo coords
module out(x,y,z)
{
	echo("######## xyz=",x,y,z);
}









