// (c) 2012 Wouter Robers
// Version 2.2 (Added moustache)


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
//PrintingFootHeight=1; 

MustacheSize=100;

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
//translate([0,0,MouthPieceLength+PrintingFootHeight])

// Turning the Mouthpiece backside down
//rotate ([180,0,0])

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
//translate([BoreDiameter/2,MouthPieceLength,0]) square([10,PrintingFootHeight]);

}

//decorative rims on the outside
translate([FrontPipeDiameter/1.4,CupDepth+RimWidth*2.5, 0])circle(RimRadius*1.5);
translate([FrontPipeDiameter/1.5,CupDepth+RimWidth*3.5, 0])circle(RimRadius*1.3);
translate([FrontPipeDiameter/1.6,CupDepth+RimWidth*4.5, 0])circle(RimRadius*1.1);
}
}

//Mustache
translate([0,CupDiameter/2+RimWidth-RimRadius,0])
scale([MustacheSize,MustacheSize,MustacheSize]/120)
translate([0,-6,0])
polyhedron(
triangles=[[0,1,2], [3,4,5], [6,3,5], [7,3,6], [7,8,9], [10,8,7], [6,10,7], [6,11,10], [6,12,11], [12,13,14], [11,12,14], [15,12,6], [16,17,18], [16,6,17], [16,15,6], [19,18,20], [17,6,21], [20,18,17], [6,1,22], [6,23,21], [6,22,23], [24,1,0], [24,22,1], [25,24,0], [2,25,0], [26,1,6], [15,27,12], [8,10,28], [29,6,5], [29,26,6], [2,1,26], [29,30,26], [25,2,31], [2,26,31], [25,32,24], [31,32,25], [30,33,34], [34,33,35], [34,35,32], [24,32,22], [32,35,22], [33,36,37], [37,35,33], [38,35,37], [38,39,35], [39,23,35], [23,22,35], [39,21,23], [19,20,40], [18,41,42], [16,18,42], [40,41,19], [41,18,19], [41,40,43], [41,43,44], [44,43,45], [44,45,46], [44,46,47], [16,42,27], [15,16,27], [42,41,44], [42,44,48], [48,44,47], [12,49,13], [14,13,49], [50,11,14], [10,51,28], [52,8,28], [52,9,8], [9,52,7], [3,7,53], [54,3,53], [54,4,3], [55,4,54], [5,4,55], [5,55,56], [5,56,29], [32,31,34], [36,33,30], [38,57,39], [39,57,21], [40,20,58], [40,58,43], [48,47,59], [49,50,14], [10,50,51], [11,50,10], [47,46,60], [47,60,59], [59,60,61], [59,61,51], [61,28,51], [50,59,51], [62,28,61], [52,63,7], [7,63,53], [55,64,56], [56,64,65], [30,56,65], [36,30,65], [56,30,29], [31,30,34], [26,30,31], [21,57,17], [49,59,50], [49,48,59], [48,49,27], [42,48,27], [27,49,12], [62,52,28], [54,64,55], [38,37,57], [57,66,17], [17,66,58], [20,17,58], [43,58,45], [54,65,64], [57,37,66], [58,66,46], [58,46,45], [60,62,61], [67,52,62], [67,63,52], [67,68,63], [63,68,53], [65,54,53], [60,67,62], [65,53,69], [36,69,37], [37,69,66], [46,66,67], [69,53,68], [68,66,69], [66,68,67], [46,67,60], [36,65,69]],
points = [[-58.584091,28.197536,0.000000],[-52.402328,20.506527,0.358841],[-54.800526,17.841995,0.784564],[-2.501032,24.170961,0.015048],[-9.552012,26.627146,0.017661],[-31.154655,19.643610,0.056052],[-44.969563,17.125895,0.016061],[0.000000,21.608608,0.004536],[9.176403,26.642111,0.021504],[2.581123,24.216633,0.016562],[31.159174,19.659206,0.130380],[45.120594,17.133677,0.066386],[54.991936,17.056479,0.194453],[58.584091,28.197536,0.000000],[51.291359,19.966629,0.156079],[49.738537,9.989874,0.000463],[43.278549,4.272926,0.009120],[-0.008242,7.004466,0.209614],[27.192152,0.793691,0.045869],[7.471235,2.503072,0.133520],[2.212253,4.728950,0.346563],[-2.146399,4.782774,0.295524],[-27.192234,0.780368,0.045171],[-7.369259,2.513148,0.046471],[-43.278549,4.272926,0.009121],[-49.810093,9.879161,0.126356],[-47.162132,16.298798,1.529032],[49.784290,10.898610,1.232523],[10.741753,25.962414,1.879541],[-42.937698,16.678349,1.332302],[-41.689590,11.881547,3.436377],[-50.267471,12.405128,1.511218],[-43.140366,5.042169,1.658040],[-28.532618,7.175683,4.583108],[-42.933926,7.437732,2.836552],[-27.605600,2.075034,2.597941],[-7.985993,14.311512,6.152612],[-6.474453,9.613080,5.521743],[-7.452224,5.137392,3.761260],[-6.295128,3.312337,1.773837],[6.465118,3.385351,1.955972],[27.227238,1.939077,2.386184],[43.342510,5.222044,1.810563],[7.736251,5.082082,3.731648],[28.051895,5.904336,4.304694],[6.974583,8.923686,5.317905],[6.558849,12.365727,5.993841],[26.977474,11.160126,5.102334],[42.999367,8.874681,3.112731],[50.156013,16.614939,1.554570],[45.755207,16.255020,1.356992],[30.981188,18.785643,2.009778],[3.500952,24.358774,1.895301],[-2.548270,23.113472,2.539699],[-7.130406,25.382286,2.418850],[-12.033466,25.573273,2.032217],[-31.717640,18.094902,2.627007],[-2.435404,6.976079,3.294168],[3.227587,6.781414,3.575889],[42.141052,13.963333,2.850352],[8.560343,18.462833,5.848720],[11.693113,22.998571,4.199893],[6.927012,23.504366,3.809480],[-0.000000,21.090641,1.418737],[-11.822267,22.579479,4.305679],[-9.060463,19.881535,5.513857],[-0.003193,11.637861,3.475341],[1.729550,18.091600,4.430985],[0.001450,18.014307,3.166783],[-2.453690,17.291109,4.794230]]
);

