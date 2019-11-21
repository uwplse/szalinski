// ************* Credits part *************

// Programmed by Fryns - November 2014

// Optimized for Customizer 

// ************* Declaration part *************

/* [General] */
Height=20; //Total height minus thickness
Thickness=2;
CirclesBottom=5;
CirclesTop=2;
GratingSpace=3; //Space

/* [Radians] */
RadiansBottom=8;
RadiansTop=16;
SideGratingNumber=20;

/* [Finish] */
OverhangFix=0.2;// Larger or equal to print resoltion when printing upside down without support
Resolution=50; //[20:Draft,50:Medium,100:Fine, 200:very fine]
FirstCircle=1;
FirstCircleFullHeight = "Yes"; // [Yes,No]

/* [Hidden] */
Manifoldfix=0.1;
FirstCircleHeight = (FirstCircleFullHeight=="Yes") ? Height : 0;
CircleSpacing=GratingSpace+Thickness;

echo("Bottom diameter =", CircleSpacing*CirclesBottom*2);
echo("Top diameter =", CircleSpacing*(CirclesTop+CirclesBottom)*2);
echo("Inner circle diameter =", (CircleSpacing*FirstCircle-Thickness)*2);
echo("Total height =", Thickness+Height);


// ************* Executable part *************


// top grating
translate([0,0,Height]){
	Circles(Cstart=CirclesBottom,Cend=CirclesBottom+CirclesTop,Height=Thickness);
	Radians(Radiannr=RadiansTop,Length=CirclesTop*CircleSpacing,Lstart=CirclesBottom*CircleSpacing-Thickness/2,Angle=0,Width=Thickness,Height=Thickness);
}

// sides
difference(){
	Circles(Cstart=CirclesBottom,Cend=CirclesBottom,Height=Height);
	Radians(Radiannr=SideGratingNumber,Length=CirclesBottom*CircleSpacing,Lstart=0,Angle=0,Width=CircleSpacing-Thickness,Height=Height);
}

// bottom grating
Circles(Cstart=FirstCircle,Cend=CirclesBottom,Height=Thickness);
Radians(Radiannr=RadiansBottom,Length=(CirclesBottom-FirstCircle)*CircleSpacing,Lstart=FirstCircle*CircleSpacing-Thickness/2,Angle=0,Width=Thickness,Height=Thickness+OverhangFix); // raised by OverhangFix to ensure best printing for overhang without support

// Inner circle grating
Circles(Cstart=FirstCircle,Cend=FirstCircle,Height=Thickness+FirstCircleHeight);

// Bottom outer circle
Circles(Cstart=CirclesBottom,Cend=CirclesBottom,Height=Thickness+OverhangFix*2); //raised by 2*OverhangFix to ensure best printing for overhang without support

// ************* Module part *************

module Radians(Radiannr,Length,Lstart,Angle,Width,Height){ // Sticks in bottom
	for ( i = [1 : Radiannr] ){
			translate([0,0,Height/2])
		rotate(a=[Angle,0,360/(Radiannr)*i])
			translate([Length/2+Lstart,0,0])
				cube(size = [Length,Width,Height], center = true);
	}
}

module Circles(Cstart,Cend,Height){ // circles in bottom
	for ( i = [Cstart : Cend] ){
		difference(){
			cylinder(h = Height, r = i*CircleSpacing, $fn=Resolution, center = false);
			translate([0,0,-Manifoldfix/2])
			cylinder(h = Height+Manifoldfix, r = i*CircleSpacing-Thickness, $fn=Resolution, center = false);
		}
	}
}
