// 
// Spoked Wheel Too
//
//	Some additions to the original 
// Spoked Wheel
// Cathal Garvey (cathalgarvey@gmail.com)
// Creative Commons Attribution, Sharealike License
//
// Modified by BrianM
// 
// ======================================
// Parameters:
// $fn is a global OpenSCAD variable determining the number of faces to divide a curved surface into. Higher gives more detailed circular structures (Which is everything in this model).
// OuterRadius is the measure from the centre of the wheel to the outer edge.
// InnerRadius is the measure from the centre of the wheel to the inner edge.
// EdgeThickness is how thick the rim of the wheel is.
// HubRadius is the measure of the central wheel hub, from the centre to its edge.
// HubThickness is how thick the hub is.
// Axle is a 1/0 boolean to determine whether there is an axle-hole desired.
// AxleRadius is the radius of the WheelAxle, if it is set to 1 above.
// SpokeNumber is how many wheel spokes to include.
// SpokeRadius is the radius of each cylindrical Spoke.
// SpokeAngle is the angle in degrees of the spokes for a dished wheel, 0 degrees for a strights wheel
//  SpokeStyle 
//		1 = Round ,uses SpokeRadius
//		2 = Square ,uses SpokeTenonHeight and Width 
//		3 = Square to round
//  WheelType 
//		0 = Full Wheel, may need support while printing
//		1 = Half Wheel, that is print two, and stick them, together for a full wheel 
//		2 = Split wheel, chops off the back of the while to give a flat back for printing without support
//		Note: 1 and 2 do not work for angled spokes.

$fn = 40;
OuterRadius = 25;
InnerRadius = 22;
RimThickness = 4;
HubRadius =8;
HubThickness =4;
AxleRadius = 1;
SpokeRadius = 1.2;
SpokeAngel =0;
SpokeTenonHeight = 3;
SpokeTenonWidth =2;
SpokeStyle = 3;
WheelType = 0;

// Note: Axle is Boolean, and Spokenumber is absolute, not relative to size or proportion of other parts.
Axle = 1;
SpokeNumber = 14;

// AngledRim will angle the rim to the spoke angle, 
// 		Set to 0 the running face of the rim will be paralled to axle
//		Set to 1 the running face will be at the spoke angle and the axle will need to be 
//  		angled in relation to the ground for correct running
AngeledRim =0;

// For SpokeStyle 3, Guide to how much of the spoke should be Square vs Round , 0 = more round, 1 = more square
SqrRound = .3;  



if (WheelType == 0 ) {
	Wheel(); 
	}
if (WheelType == 1 ) {
	 HalfWheel();
	}
if (WheelType == 2 ) {
	 SplitWheel();
	}

//module Rim(Edge,Outer,Inner){
module Rim(){
	
	if ( AngeledRim == 1)	{
		translate ([0 ,0,-RimThickness /2]) 
		rotate_extrude($fn=100) 
		translate ([HubRadius ,0,0])  
		rotate ([0,0, SpokeAngel]) 	

		translate ([InnerRadius - HubRadius ,0,0]) 
			square([OuterRadius - InnerRadius,RimThickness]);

		} else {
		translate ([0,0,(InnerRadius - HubRadius) * sin(SpokeAngel)])
		translate ([0 ,0,-RimThickness /2]) 
		rotate_extrude($fn=100) 
		translate ([HubRadius ,0,0])  
//		rotate ([0,0, SpokeAngel]) 	

		translate ([InnerRadius - HubRadius ,0,0]) 
			square([OuterRadius - InnerRadius,RimThickness]);

		}
}


module Hub(HubR,HubW,AxleDesired,AxleR){
	difference(){
		translate([0,0,-HubW/2])
			cylinder(HubW,HubR,HubR);
		if(AxleDesired==1){translate([0,0,-HubW/2 -0.5]) cylinder(HubW + 1,AxleR,AxleR);}
	}
}

module Spokes(AxleR,RimR,SpokeN,SpokeR){
echo( sin(SpokeAngel));
for(i=[0:SpokeN-1]){

		rotate([i*360/SpokeN,90 ,0]) 
		if (SpokeStyle == 1) {

			translate([0,0, HubRadius - ((SpokeR/2) * sin(SpokeAngel) )]) 
			rotate ([0,-SpokeAngel,0]) 
			cylinder (h =  (  InnerRadius + ( (SpokeTenonHeight  ) * sin(SpokeAngel)) - HubRadius) ,r1 =SpokeR,r2=SpokeR);
	
		} else { if (SpokeStyle == 2) {

			translate([0,0, HubRadius - ((SpokeR/2) * sin(SpokeAngel) )]) 
			rotate ([0,-SpokeAngel,0]) 
			translate ([ - SpokeTenonHeight/2 / cos(SpokeAngel),-SpokeTenonWidth/2,0]) 
			cube ([ SpokeTenonHeight,
					SpokeTenonWidth, 
					( InnerRadius + ( (SpokeTenonHeight  ) * sin(SpokeAngel)) - HubRadius) ]);

		} else { if (SpokeStyle == 3) {

			translate([0,0, HubRadius -1 - ((SpokeTenonHeight / 2 ) * sin(SpokeAngel) )]) 
			rotate ([0,-SpokeAngel,0]) 
			hull () {
				hull () {
 				translate ([ - SpokeTenonHeight/2 ,-SpokeTenonWidth/2,0]) 
						cube ([SpokeTenonHeight ,
							SpokeTenonWidth, 
							.1 + SpokeTenonHeight / 2 * ( sin(SpokeAngel)) ]);
				translate ([0,0,( RimR / cos(SpokeAngel)  - AxleR ) * SqrRound])
				hull (){
					translate ([-(SpokeTenonHeight /2 - SpokeR  ),0,0])cylinder (h=.1,r=SpokeR);
					translate ([(SpokeTenonHeight /2 - SpokeR  ),0,0])cylinder (h=.1,r=SpokeR);
					}
				}
				if ( AngeledRim == 1)	{
					translate ([0,0,( InnerRadius + ( (SpokeTenonHeight  ) * sin(SpokeAngel)) - HubRadius )])
						cylinder (h=.1,r=SpokeR);
				} else {
					translate ([0,0,( (InnerRadius  / cos(SpokeAngel)) + ( (SpokeRadius * 2  ) * sin(SpokeAngel)) - HubRadius + 1 )])
						cylinder (h=.1,r=SpokeR);
				}

			}

		}}}

	}
}


module Wheel() {
union(){
color ("blue") Hub(HubRadius,HubThickness,Axle,AxleRadius);
color ("red") Rim(RimThickness,OuterRadius,InnerRadius);
Spokes(AxleRadius,InnerRadius,SpokeNumber,SpokeRadius);
}
}

module HalfWheel() {
difference () {
	union(){
		Wheel();
		}
		translate ([-(1 + OuterRadius * 2) /2, -(1 + OuterRadius * 2)/2 ,  -(1 + OuterRadius * 2) ])
		cube ( [1 + OuterRadius * 2, 1 + OuterRadius * 2, 1 + OuterRadius * 2 ]);
	}
}


module SplitWheel() {
difference () {
	union(){
		Wheel();
		}
	if (SpokeStyle == 1) 	{
		translate ([0, 0 ,  - SpokeRadius ])
		translate ([-(1 + OuterRadius * 2) /2, -(1 + OuterRadius * 2)/2 ,  -(1 + OuterRadius * 2) ])
		cube ( [1 + OuterRadius * 2, 1 + OuterRadius * 2, 1 + OuterRadius * 2 ]);
	} else { if (SpokeStyle == 2) {
			translate ([0, 0 ,  - SpokeTenonHeight /2 ])
			translate ([-(1 + OuterRadius * 2) /2, -(1 + OuterRadius * 2)/2 ,  -(1 + OuterRadius * 2) ])
			cube ( [1 + OuterRadius * 2, 1 + OuterRadius * 2, 1 + OuterRadius * 2 ]);
			}
	} 	if (SpokeStyle == 3) 	{
		translate ([0, 0 ,  - SpokeRadius ])
		translate ([-(1 + OuterRadius * 2) /2, -(1 + OuterRadius * 2)/2 ,  -(1 + OuterRadius * 2) ])
		cube ( [1 + OuterRadius * 2, 1 + OuterRadius * 2, 1 + OuterRadius * 2 ]);
	}

	}
}


