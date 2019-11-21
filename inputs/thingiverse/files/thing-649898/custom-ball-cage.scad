//
//	Customized Ball(s) in a Cage with a Twist
//		Steve Medwin
//		May 31, 2014
//
//  RPN:January 23, 2015: Corrected ball placement
//			for better vertical printing 
//			(Most printers can't start an object
//			 in mid air.)
$fn=100*1;	// set overall resolution
//
//	Customizing

//How big are the balls (in mm)?
Diameter=20;	//	[10,15,20,25,30]
//How many balls?
Balls=2;	//	[1,2,3,4,5]
//How many degrees of twist in center section?
Twist=90;	//	[0,90,180,270,360]
//Which twist direction?
Direction=-1;	//[-1:Right Hand,1:Left Hand]
//Size of top (multiple of column width)
Top=4;		//	[1:20]
//Size of botton (multiple of column width)
Bottom=4;	//	[1:20]
//Detail in print
Resolution=0.20;	//[0.30:Low,0.20:Standard,0.10:High]

Radius=Diameter/2;
Clearance=Radius*0.05;	// between ball and columns
Width=Radius*0.4;	// column side scales with ball size
Height=Diameter*(Balls+2);	// height of center section

Side=2*cos(45)*(Radius+Clearance+Width/sin(45));
Column=Side/2-Width/2;	//position of column center relative to 0,0
Gap=(Height-(Diameter*Balls+Clearance*(Balls-1)))/2; // center balls

// Define 2D columns
module columns(){
	translate([ Column, Column,0]) square([Width,Width],center = true);
	translate([ Column,-Column,0]) square([Width,Width],center = true);
	translate([-Column, Column,0]) square([Width,Width],center = true);
	translate([-Column,-Column,0]) square([Width,Width],center = true);
	}

//	Make 3D columns
linear_extrude(height = Height, center = false, convexity = 10, twist = Direction*Twist, slices=Height/Resolution)
	columns();

//	Add balls
for (i=[1:Balls])
	{
//		RPN:January 23, 2015:
//		translate([0,0,Gap+Radius+(i-1)*(Diameter+Clearance)]) sphere(r=Radius);
//		For vertical printing, don't center the
//		balls, and don't leave a gap between the
//		balls.
	    translate([0,0,Radius+(i-1)*Diameter]) sphere(r=Radius);
	}

//	Add bottom
rotate(a=[0,180,0]) 
linear_extrude(height = Width*Bottom, center = false, convexity = 10, twist = Direction*Twist*Width*Bottom/Height, slices=(Width*Bottom)/Resolution) 
	square([Side,Side],center=true);

//	Add top
translate([0,0,Height])
linear_extrude(height = Width*Top, center = false, convexity = 10, twist = Direction*Twist*Width*Top/Height, slices=(Width*Top)/Resolution) 
	square([Side,Side],center=true);
