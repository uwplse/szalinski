// Pasutx, 7.4.2013
// NFC keyfob
//
// Change these parameters:

CavityDiameter=39;
Part=0; // [0:Case, 1:Lid]
Shape=0;  // [0:Circle, 1:Square]

LidThickness=0.8;
CavityThickness=0.6;
BottomThickness=0.8;

SideWidth=2;
LidSupportWidth=0.7;

RingOutsideDiameter=8.5;
RingHoleDiameter=4.5;

Tolerance=0.15;

//Only relevant for square fobs
RoundingRadius=3; 

// Do NOT change these parameters:
OutsideRadius=CavityDiameter/2+SideWidth;
CavityRadius=CavityDiameter/2;
RingHoleRadius=RingHoleDiameter/2;
RingOutsideRadius=RingOutsideDiameter/2;
TotalThickness=LidThickness+CavityThickness+BottomThickness;
RingThickness=RingOutsideRadius-RingHoleRadius;


// Create a cube([X,Y,Z]) with rounded vertical edges (radius R)
module RoundedBox (X,Y,Z,R)
{
	intersection()
   {
	   minkowski()
		{
		 cube([X-2*R,Y-2*R,Z],center=true);
		 cylinder(r=R,h=Z,$fn=16,center=true);
		}
		cube([2*X,2*Y,Z],center=true);
	}
}

if (Shape==0)
{
	if (Part==0)
	{
		//Show Case
		difference()
		{
			union()
			{
				//main body
				cylinder(r=OutsideRadius,h=TotalThickness,center=true,$fn=50);
				//ring
				translate([OutsideRadius+RingOutsideRadius-SideWidth,0,0])
					cylinder(r=RingOutsideRadius,h=TotalThickness,center=true,$fn=20);
				//ring connection
				translate([OutsideRadius-SideWidth,0,0])
					cube(size=[2*RingOutsideRadius,2*RingOutsideRadius,TotalThickness],center=true);
			}
			//ring hole
			translate([OutsideRadius+RingOutsideRadius-SideWidth,0,0])
				cylinder(r=RingHoleRadius,h=2*TotalThickness,center=true,$fn=20);
			//nfc cavity
			translate([0,0,BottomThickness])
				cylinder(r=CavityRadius,h=TotalThickness,center=true,$fn=50);
			//lid cavity
			translate([0,0,BottomThickness+CavityThickness])
				cylinder(r=CavityRadius+LidSupportWidth,h=TotalThickness,center=true,$fn=50);
		}
	}
	else
	{
		//Show Lid
		cylinder(r=CavityRadius+LidSupportWidth-Tolerance, h=LidThickness);
	}
}
else
{
	if (Part==0)
	{
		//Show Case
		difference()
		{
			union()
			{
				//main body
				RoundedBox (2*OutsideRadius,2*OutsideRadius,TotalThickness,RoundingRadius);
				//ring
				translate([OutsideRadius+RingOutsideRadius-SideWidth,0,0])
					cylinder(r=RingOutsideRadius,h=TotalThickness,center=true,$fn=20);
				//ring connection
				translate([OutsideRadius-SideWidth,0,0])
					cube(size=[2*RingOutsideRadius,2*RingOutsideRadius,TotalThickness],center=true);
			}
			//ring hole
			translate([OutsideRadius+RingOutsideRadius-SideWidth,0,0])
				cylinder(r=RingHoleRadius,h=2*TotalThickness,center=true,$fn=20);
			//nfc cavity
			translate([0,0,BottomThickness])
				RoundedBox(2*CavityRadius,2*CavityRadius,TotalThickness,RoundingRadius);
			//lid cavity
			translate([0,0,BottomThickness+CavityThickness])
				RoundedBox(2*(CavityRadius+LidSupportWidth),2*(CavityRadius+LidSupportWidth),TotalThickness,RoundingRadius);
		}
	}
	else
	{
		//Show Lid
		RoundedBox(2*(CavityRadius+LidSupportWidth-Tolerance),2*(CavityRadius+LidSupportWidth-Tolerance),LidThickness,RoundingRadius);
	}
}


