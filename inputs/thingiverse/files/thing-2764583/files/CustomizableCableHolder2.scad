// ************* Credits part *************

// "Customizable Cable Holder" 

// Programmed by Fryns - September 2014

// Optimized for Customizer 

// ************* Declaration part *************

/* [Dimensions] */
// Width of hanger in mm
Width=4;
NailDiameter=1.6; // Nail or Screw Diameter
CableDiameter=6.0;
Thickness=1;

/* [Advanced] */
CutLengthBottom=0.1; // from -Thickness to CableDiameter
CutLengthSide=1; // from 0 to CableDiameter
Resolution=100; //[20:Draft,50:Medium,100:Fine, 200:very fine]
Geometry=8; //[8:Obey rule of 45,100:Fine, 200:very fine]

/* [Countersink] */
NailHeadDiameter=2.5;
CountersinkDepth=1.2;
Countersink="Normal"; // [Normal,No Countersink,Angle]

/* [Hidden] */
Manifoldfix=0.1;

// ************* Executable part *************
translate([0,0,Width/2])
rotate(a=[90,0,0])
difference(){
	BaseVolume();
	CutVolume();
	if (Countersink=="Angle") CountersinkAngle();
	if (Countersink=="Normal") Countersink();
}

// ************* Module part *************

module BaseVolume(){
//Base ensuring plane top
   translate([(NailDiameter/2+CableDiameter/2+Thickness)/2,0,0])
		cube(size = [NailDiameter/2+CableDiameter/2+Thickness,Width,CableDiameter+2*Thickness], center = true);

//Base head for Nail
	rotate(a=[0,0,360/(Geometry*2)])
		cylinder(h = CableDiameter+2*Thickness, r = Width/2/cos(360/(Geometry*2)),$fn=Geometry, center = true);

//Base for cable
   translate([NailDiameter/2+CableDiameter/2+Thickness,0,0])
		rotate(a=[90,0,0])
			cylinder(h = Width, r = (CableDiameter+2*Thickness)/2,$fn=Resolution, center = true);
}

module CutVolume(){
// cut-cylinder for Nail
	rotate(a=[0,0,360/(8*2)])
		cylinder(h = CableDiameter+2*Thickness+Manifoldfix, r = NailDiameter/2/cos(360/(Geometry*2)),$fn=Geometry, center = true);

// cut-cylinder for cable
   translate([NailDiameter/2+CableDiameter/2+Thickness,0,0])
		rotate(a=[90,0,0])
		cylinder(h = Width+2*Manifoldfix, r = (CableDiameter)/2,$fn=Resolution, center = true);

// cut-cube Bottom
   translate([(Width+CableDiameter+2*Thickness)/2-Width/2-Manifoldfix,0,CutLengthBottom+Thickness-(CableDiameter+2*Thickness)])
		cube(size = [Width+CableDiameter+2*Thickness,Width+Manifoldfix,CableDiameter+2*Thickness], center = true);

// cut-cube Side
   translate([NailDiameter/2+(CableDiameter-CutLengthSide)/2+Thickness,0,-(CableDiameter+2*Thickness)/2])
		cube(size = [CableDiameter-CutLengthSide,Width+Manifoldfix,CableDiameter+2*Thickness], center = true);
}

module Countersink(){	// Normal countersink for nail head
   translate([0,0,(CableDiameter+2*Thickness)/2-CountersinkDepth+Manifoldfix])
		rotate(a=[0,0,360/(Geometry*2)])
			cylinder(h = CountersinkDepth, r = NailHeadDiameter/2/cos(360/(Geometry*2)),$fn=Geometry, center = false);
}

module CountersinkAngle(){ // Angle countersink for screw head
   translate([0,0,(CableDiameter+2*Thickness)/2-(NailHeadDiameter/2-NailDiameter/2)+Manifoldfix])
		cylinder(h = NailHeadDiameter/2-NailDiameter/2, r1 = NailDiameter/2,r2 = NailHeadDiameter/2,$fn=Resolution, center = false);
}