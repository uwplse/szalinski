/*
Author: Avp (Alexander Purikov)
Design is based on  http://www.thingiverse.com/thing:30328
Lisense is CC-BY-SA 3.0 (Creative commons Attribution-ShareAlike)

Avp:
 Code is rewritten almost completely -- only general part idea has retained. 
 Part is redisigned
  -- to be much easier to print
  -- to be possible to clamp rods with different diameter
  -- to avoid skewness.
 
*/

/*[Customizer Variables]*/

//Which part would you like to render?
part			=	"both"; //[part1:Part1, part2:Part2, both:Both]

//Diameter of Rod 1
Rod1Diameter = 12; //[6:20]

//Diameter of Rod 2
Rod2Diameter = 8; //[3:20]

//Screw type
NutName			=	"M4"; //[M3:M3, M4:M4, M6:M6]

/*[hidden]*/

CreateRidge = true;
Wall=3;
Gap=1;
ScrewSeparation=1;
Bevel = 3;
BevelAngle=30; //Too high angle is hard to print

M3=[5.5, 2.4, 3.0];
M4=[7.0, 3.2, 4.0];
M5=[7.0, 4.7, 5.0];
M6=[10.0, 5.2, 6.0];
M8=[13.0, 6.8, 8.0];
M10=[17.0, 8.4, 10.0];

UsedNut=( NutName == "M3" ) ? M3 : (( NutName == "M4" ) ? M4 : M6);

Clearance=0.2;
NutClearance=0.3;
o=0.05; // Little value, used to shift parts to avoid zero-width walls
MembraneThickness=0.2;

$fs=1;$fa=6;

function GetClampRadius () = max ( Rod1Diameter, Rod2Diameter) + Clearance + (UsedNut[2]+NutClearance)/2 + ScrewSeparation + Wall;

output();

module output()
{
	if (part == "part1") {
		ClampPart1();
	} else if (part == "part2") {
		ClampPart2();
	} else if (part == "both") {
		ClampPart1();
		translate([GetClampRadius()*2+5,0,0])
		ClampPart2();
	} 
}

module ClampPart1 ()
	{
	ClampPart ( Rod1Diameter+Clearance, max ( Rod1Diameter, Rod2Diameter)+Clearance );
	}
	
module ClampPart2 ()
	{
	ClampPart ( Rod2Diameter+Clearance, max ( Rod1Diameter, Rod2Diameter)+Clearance, CreateHexNut = false );
	}

	
module ClampPart( RodDiameter, MaxRodDiameter, CreateHexNut = true )
	{
	  OctagonInnerRadius = MaxRodDiameter + (UsedNut[2]+NutClearance)/2 + ScrewSeparation + Wall;
	  OctagonOuterRadius = OctagonInnerRadius/cos(180/8);
	  HWall=UsedNut[1]+MembraneThickness;
	  
	  difference() {
		
		  rotate([0,0,45/2])
			{
			// Main body
			translate([0,0,Bevel])
				cylinder(r=OctagonOuterRadius, h=RodDiameter+UsedNut[1]-Bevel-Gap, $fn=8);
				
			// Beveled body part	
			cylinder(r=OctagonOuterRadius-Bevel*tan(BevelAngle), r2=OctagonOuterRadius, h=Bevel, $fn=8);
				
			}
		
		// Rod slot
		translate([(RodDiameter+(UsedNut[2]+NutClearance)+ScrewSeparation)/2,0,UsedNut[1]+RodDiameter/2])
			{
			rotate ([90,0,0])
			cylinder(r=RodDiameter/2, h=80, center=true);
			translate([0,0,RodDiameter/2])
				{
				cube([RodDiameter, 100,RodDiameter], center=true);
				}
			}
		
		// Screw hole
		translate ([0,0,CreateHexNut ? UsedNut[1]+MembraneThickness+NutClearance*2 : -o] )	// Shift is made to leave a membrane above hex-slot to
			cylinder(r=(UsedNut[2]+NutClearance)/2 , h = 100 );		  						// make our thing easier to print.
		
		// Nut slot
		if ( CreateHexNut )
			{
			translate ([0,0,-o])
				NutSlot (UsedNut);
			}
		}

	  // Little (equal to Gap) ridge, parallel and symmetric to rod
	  if (CreateRidge)
		{
		translate ([0,0,RodDiameter+HWall-Gap])
		intersection ()
			{
			translate ([0,0,-Gap])
				rotate([0,0,45/2])
					cylinder(r=OctagonInnerRadius/cos(180/8), h=Gap*2, $fn=8);
			translate ([-(RodDiameter+(UsedNut[2]+NutClearance)+ScrewSeparation)/2,OctagonInnerRadius,0])
				rotate ([90,0,0])
					cylinder (r=Gap,h=OctagonInnerRadius*2);
		
			}
		}
	}

module NutSlot (Slot, SideOpen=false)
	{
	cylinder (r=(Slot[0]/2+NutClearance)*2/sqrt(3), h=Slot[1]+NutClearance*2, $fn=6);
	if ( SideOpen )
		translate ([0,-(Slot[0]+NutClearance*2)/2,0])
			cube ([Slot[0]+NutClearance*2+4,Slot[0]+NutClearance*2,Slot[1]+NutClearance*2]);
	}

