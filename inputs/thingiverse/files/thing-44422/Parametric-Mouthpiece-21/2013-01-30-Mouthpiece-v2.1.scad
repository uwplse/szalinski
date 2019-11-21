// (c) 2012 Wouter Robers


// [Trumpet:16, Trombone:21] Larger Cup Diameters are optimized for lower ranges, giving a richer tone. Smaller diameters assist high range playing. 
CupDiameter=16;

// [Trumpet:8, Trombone:16] Shallower cups greatly assist playing in high ranges but do so at the cost of fullness of tone. Deeper cups assist low range flexibility and rich tone.
CupDepth=8;

// [0 (Conical) - 1 (Spherical)] Spherical cups have brighter, more projected tones, while conical cups have less tone definition.
CupSphereFactor=0.5;

// [Trumpet:6 Trombone:8] Wider rim widths reduce the pressure on the lips, allowing greater stamina. It does, however, reduce flexibility.
RimWidth=6; 

// [0 (flat) - 1(round)] Sharper rims reduce stamina but increase control.
RimShape=0.7;
RimRadius=RimShape*RimWidth/2;

// A sharper throat contour gives a more harsh, projected tone and a rounded contour gives a deeper, richer tone, but less definition.
ThroatRadius=3.5; 

// [Trumpet:4, Trombone:5] Larger throat diameters give more volume but less control. 
ThroatDiameter=4; 

// Diameter of the pipe that fits into your instrument. [Trumpet:9.5, Trombone:12]
BackPipeDiameter=9.5; 
FrontPipeDiameter=BackPipeDiameter+3;
BoreDiameter=BackPipeDiameter-1.5; 


// Total length of the mouthpiece [All mouthpieces usually 88]
MouthPieceLength=88; 

//Height of the "foot" that binds the mouthpiece to the platform. Set to 0 for no foot.
PrintingFootHeight=1; 



MakeMouthPiece();

module MakeMouthPiece(){

$fs=1; // set minimum polygonsize
$fa=8; // set minimum circle angle





// ======================

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
}
