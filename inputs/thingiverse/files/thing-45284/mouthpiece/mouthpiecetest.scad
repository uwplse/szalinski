 

//Larger Cup Diameters are optimized for lower ranges, giving a richer tone. Smaller diameters assist high range playing
CupDiameter=12; // [10:20] 

//Shallower cups greatly assist playing in high ranges but do so at the cost of fullness of tone. Deeper cups assist low range flexibility and rich tone.
CupDepth=6; // [4:10] 

//Larger Cup Diameters are optimized for lower ranges, giving a richer tone. Smaller diameters assist high range playing. Spherical cups have brighter, more projected tones, while conical cups have less tone definition. 0 (Conical) - 100 (Spherical)
Cup_Sphere_Factor=75;// [0:100] 

//Wider rim widths reduce the pressure on the lips, allowing greater stamina. It does, however, reduce flexibility.
RimWidth=6; // [4:10] 

//Lower rim radius reduce stamina but increase control. More smoothed rims are commonly found on deeper cups. Never more than RimWidth/2]
Rim_Radius=23;

//In spherical cups, a sharper throat contour gives a more harsh, projected tone and a rounded contour gives a deeper, richer tone. Conical cups with a smooth throat have less definition.
Throat_Radius=35;

// Larger throat diameters give more volume but less control. Smaller diameters have much more control but significant volume limitations.
Throat_Diameter=35;

//More conical backbores give a richer tone, while more cylindrical ones give a brighter, more projected tone.
Bore_Diameter=8; 

//Trumpet ~13
FrontPipeDiameter=13;

//Trumpet ~95
Back_Pipe_Diameter=95;

// Trumpet ~87
MouthPieceLength=87;  

//Height of the "foot" that binds the mouthpiece to the platform. Set to 0 for no foot.
PrintingFootHeight=0; 

 // set minimum polygonsize
$fs=1;

// set minimum circle angle
$fa=8;

// ======================
CupSphereFactor=Cup_Sphere_Factor/100;
BackPipeDiameter=Back_Pipe_Diameter/10;
RimRadius=Rim_Radius/10;
ThroatRadius=Throat_Radius/10;
ThroatDiameter=Throat_Diameter/10;
BoreDiameter=Bore_Diameter;

//Making the cup shape 

CupBottom=[ThroatDiameter/2+ThroatRadius*(0.17+CupSphereFactor*0.3),CupDepth+ThroatRadius*(0.43-CupSphereFactor*0.3)];
CupTop=[CupDiameter/2+RimRadius*0.02,RimRadius-RimRadius*.2];

Cup45Deg=(0.5+CupSphereFactor*.15);
Cup30Deg=(0.25+CupSphereFactor*.1);
Cup60Deg=(0.75+CupSphereFactor*.1);

CupshapePoint1=[Cup30Deg*CupTop[0]+Cup60Deg*CupBottom[0],Cup30Deg*CupTop[1]+Cup60Deg*CupBottom[1]];

CupshapePoint2=[Cup45Deg*CupTop[0]+Cup45Deg*CupBottom[0],Cup45Deg*CupTop[1]+Cup45Deg*CupBottom[1]];

CupshapePoint3=[Cup60Deg*CupTop[0]+Cup30Deg*CupBottom[0],Cup60Deg*CupTop[1]+Cup30Deg*CupBottom[1]];



// Putting the moutpiece on the platform
translate([0,0,MouthPieceLength+PrintingFootHeight])

// Turning the Mouthpiece backside down
rotate ([180,0,0])

// Rotating-extruding the mouthpiece shape around the Z-axis
rotate_extrude() 
difference(){
union() {

//Mouthpiece shape
polygon( [
CupTop,
[CupDiameter/2+RimRadius,0],
[CupDiameter/2+RimWidth-RimRadius,0],
[CupDiameter/2+RimWidth,RimRadius],
[CupTop[0]+RimWidth/2,CupTop[1]+RimWidth],
[CupshapePoint3[0]+RimWidth/2,CupshapePoint3[1]+RimWidth*2],
[CupshapePoint2[0]+RimWidth/2,CupshapePoint2[1]+RimWidth*2],
[CupshapePoint1[0]+RimWidth/2,CupshapePoint1[1]+RimWidth*2],
[FrontPipeDiameter/2,CupDepth+RimWidth*2],
[BackPipeDiameter/2,MouthPieceLength],
[BoreDiameter/2,MouthPieceLength],
[ThroatDiameter/2,CupDepth+ThroatRadius],
CupBottom,
CupshapePoint1,
CupshapePoint2,
CupshapePoint3,
]);

//Rim rouding
translate([CupDiameter/2+RimRadius,RimRadius, 0])circle(RimRadius);

//Rim rouding
translate([CupDiameter/2+RimWidth-RimRadius,RimRadius, 0])circle(RimRadius);

//Throat rouding
translate([ThroatDiameter/2+ThroatRadius,CupDepth+ThroatRadius,0])circle(ThroatRadius);

//Printing base
translate([BoreDiameter/2,MouthPieceLength,0]) square([10,PrintingFootHeight]);

}

//decorative rims on the outside
translate([FrontPipeDiameter/1.4,CupDepth+RimWidth*2.5, 0])circle(RimRadius*1.5);
translate([FrontPipeDiameter/1.5,CupDepth+RimWidth*3.5, 0])circle(RimRadius*1.3);
translate([FrontPipeDiameter/1.6,CupDepth+RimWidth*4.5, 0])circle(RimRadius*1.1);
}


