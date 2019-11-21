// Wedged Parametric MouthPiece 
// Copyright 2013 Wouter Robers

$fn=15;
RimOuterRadius=[2,2];
RimPlateauWidth=[2,2];
RimInnerRadius=[2,2];
RimHeight=[0,2];
CupDiameter=[16,16];
CupDepth=[10,10];
// [0 (Conical) - 1 (Spherical)] Spherical cups have brighter, more projected tones, while conical cups have less tone definition.
CupSphereFactor=0.5;
ThroatRadius=[2,2]; 
ThroatDiameter=[4,4]; 
BackPipeDiameter=9.8; 
FrontPipeDiameter=BackPipeDiameter+4;
BoreDiameter=BackPipeDiameter-1.5; 
MouthPieceLength=87; 
PrintingFootHeight=1; 
Step=15;


// Function to interpolate parameters
function Interpolate(Parameter,Angle)=Parameter[0]+(Parameter[1]-Parameter[0])*pow(sin(Angle),2);
//Make Curve function
function Curve(X)=CupSphereFactor*sqrt(1-pow(X,2))+(1-CupSphereFactor)*(1-X);

//Make Curve module
module MakeCurve(){
polygon([
[0,0],
[0,Curve(0)],
[0.2,Curve(0.2)],
[0.4,Curve(0.4)],
[0.6,Curve(0.6)],
[0.8,Curve(0.8)],
[0.9,Curve(0.9)],
[0.97,Curve(0.97)],
[1,Curve(1)],
]);
}

// MakeShape
module MakeRim(Angle){
linear_extrude(0.1)
{
// MakeShape Inner Rim
translate([Interpolate(CupDiameter,Angle)/2+Interpolate(RimInnerRadius,Angle),-Interpolate(RimInnerRadius,Angle)+Interpolate(RimHeight,Angle)]) circle(Interpolate(RimInnerRadius,Angle));
// MakeShape Rim Plateau
//translate([Interpolate(CupDiameter,Angle)/2+Interpolate(RimInnerRadius,Angle),-max(Interpolate(RimOuterRadius,Angle),Interpolate(RimInnerRadius,Angle))*2+Interpolate(RimHeight,Angle)]) square([Interpolate(RimPlateauWidth,Angle),max(Interpolate(RimOuterRadius,Angle),Interpolate(RimInnerRadius,Angle))*2]);
// MakeShape Outer Rim
translate([Interpolate(CupDiameter,Angle)/2+Interpolate(RimInnerRadius,Angle)+Interpolate(RimPlateauWidth,Angle),-Interpolate(RimOuterRadius,Angle)+Interpolate(RimHeight,Angle)]) circle(Interpolate(RimOuterRadius,Angle));
}}

module MakeCupOutside(Angle){
linear_extrude(0.1)
{
// MakeShape Cup Outside
translate([Interpolate(ThroatDiameter,Angle)/2+Interpolate(ThroatRadius,Angle),-Interpolate(RimInnerRadius,Angle)+Interpolate(RimHeight,Angle)]) scale([Interpolate(CupDiameter,Angle)/2-Interpolate(ThroatDiameter,Angle)/2-Interpolate(ThroatRadius,Angle)+Interpolate(RimPlateauWidth,Angle)+Interpolate(RimInnerRadius,Angle)+Interpolate(RimOuterRadius,Angle)/2,-Interpolate(CupDepth,Angle)+Interpolate(RimInnerRadius,Angle)-Interpolate(ThroatRadius,Angle)-Interpolate(RimHeight,Angle)]) MakeCurve();
}
}

module MakeCupInside(Angle){
linear_extrude(0.1)
{
// MakeShape Cup Inside
translate([Interpolate(ThroatDiameter,Angle)/2+Interpolate(ThroatRadius,Angle),-Interpolate(RimInnerRadius,Angle)+Interpolate(RimHeight,Angle)]) scale([Interpolate(CupDiameter,Angle)/2-Interpolate(ThroatDiameter,Angle)/2-Interpolate(ThroatRadius,Angle),-Interpolate(CupDepth,Angle)+Interpolate(RimInnerRadius,Angle)-Interpolate(RimHeight,Angle)]) 
{
MakeCurve();
polygon([[-0.1,-0.1],[-0.1,1],[0,1],[1,0],[1,-0.1]]);
}
}

}

module MakePipe(Angle){
linear_extrude(0.1)
{

// MakeShape Throat
translate([Interpolate(ThroatDiameter,Angle)/2+Interpolate(ThroatRadius,Angle),-Interpolate(CupDepth,Angle)-Interpolate(ThroatRadius,Angle)]) circle(Interpolate(ThroatRadius,Angle));
// MakeShape Backpipe
polygon([
[BackPipeDiameter/2,-MouthPieceLength],
[BoreDiameter/2,-MouthPieceLength],
[Interpolate(ThroatDiameter,Angle)/2,-Interpolate(CupDepth,Angle)-Interpolate(ThroatRadius,Angle)],
[FrontPipeDiameter/2,-Interpolate(CupDepth,Angle)]
]);
}}


// Finally assembling the mouthpiece
translate([0,0,MouthPieceLength+PrintingFootHeight]) union(){

// Make Foot
translate([0,0,-MouthPieceLength-PrintingFootHeight]) cylinder(r=CupDiameter[0],h=PrintingFootHeight);

for(i=[0:Step:360])
	{
	hull()
		{
		rotate([0,0,i]) rotate([90,0,0]) MakeRim(i);
		rotate([0,0,i+Step+0.01]) rotate([90,0,0]) MakeRim(i+Step);
		}
	}

for(i=[0:Step:360]){
hull()
	{
	rotate([0,0,i]) rotate([90,0,0]) MakePipe(i);
	rotate([0,0,i+Step]) rotate([90,0,0]) MakePipe(i+Step);
	}
}

difference()
	{
	for(i=[0:Step:360])
		{
		hull()
			{
			rotate([0,0,i]) rotate([90,0,0]) MakeCupOutside(i);
			rotate([0,0,i+Step]) rotate([90,0,0]) MakeCupOutside(i+Step);
			}
		}
	for(i=[0:Step:360])
		{
		hull()
			{
			rotate([0,0,i]) rotate([90,0,0]) MakeCupInside(i);
			rotate([0,0,i+Step]) rotate([90,0,0]) MakeCupInside(i+Step);
			}
		}
	}
}



