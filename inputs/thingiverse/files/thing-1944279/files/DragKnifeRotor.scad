// preview[view:north, tilt:top]
/* [Axle] */
// Diameter of the holder axle in mm
AxleDiameter=8;
// Length of the holder axle in mm
AxleLength=22;
// Diameter for the axle stop in mm
AxleStopDiameter=11;
// Axle stop length in mm
AxleStopLength=8;

/* [Knife] */
// Knife blade hight in mm
KnifeHeight=19;
// Knife blade length in mm
KnifeBladeLength=51.5;
// Knife upper length in mm
KnifeUpperLength=28.5;
// Knife thickness in mm
KnifeThickness=0.5;

// Knife bump position from center in mm  +/-
KnifeBumpPositionFromCenter=0;
// Knife bump width in mm
KnifeBumpWidth=3.4;
// Knife bump depth in mm
KnifeBumpDepth=4.0;

// Knife clearance (cutting part) in mm
KnifeClearance=5;
// Knife offset from center in mm
KnifeOffsetFromCenter=4;

/* [Clamp] */
// Clamp screw diameter in mm
ClampScrewDiameter=3;
// Clamp thickness in mm
ClampThickness=4;

/* [Export] */
// 1 flattens the back to print without support
WithoutSupport=1;//[0,1]

// 1 rotates to x axes for printer output
RotateForExport=1;//[0,1]


/* [Hidden] */
$fn=40;

//calculate triangle
a=(KnifeBladeLength/2)-(KnifeUpperLength/2);
b=KnifeHeight;
c=sqrt(pow(a,2)+pow(b,2));
echo(c);
alpha=90-asin(a/c);
echo(alpha);
//gamma
gamma=180-2*alpha;
echo(gamma);
//
triangleSide=(KnifeBladeLength/sin(gamma/2))/2;
echo(triangleSide);
//
pointBalpha=90-alpha;
echo(pointBalpha);
pointBa=sin(pointBalpha)*KnifeBladeLength;
echo(pointBa);
pointBb=sqrt(pow(KnifeBladeLength,2)-pow(pointBa,2));
echo("PointBb ",pointBb);

//Knife
module Knife(){
Knife0=[[0,0],[KnifeBladeLength,0],[KnifeUpperLength+a,KnifeHeight],[a,KnifeHeight]];
Knife0Path=[0,1,2,3];
KnifeBump0=[[a+(KnifeUpperLength/2)+(KnifeBumpWidth/2)+KnifeBumpPositionFromCenter,KnifeHeight],[a+(KnifeUpperLength/2)+(KnifeBumpWidth/2)+KnifeBumpPositionFromCenter,KnifeHeight-KnifeBumpDepth+KnifeBumpWidth/2],[a+(KnifeUpperLength/2)-(KnifeBumpWidth/2)+KnifeBumpPositionFromCenter,KnifeHeight-KnifeBumpDepth+KnifeBumpWidth/2],[a+(KnifeUpperLength/2)-(KnifeBumpWidth/2)+KnifeBumpPositionFromCenter,KnifeHeight]];
KnifeBump0Path=[4,5,6,7];
//KnifeBump1=
KnifeBump1Path=[8,9,10,11,12,13,14,15,16,17,18,19];
Knife=concat(Knife0,KnifeBump0);
KnifePath=[Knife0Path,KnifeBump0Path];
translate([-KnifeOffsetFromCenter,-KnifeThickness/2,AxleLength+AxleStopLength+cubeHeigth+triangleSide])
rotate([-90,90-alpha,0])
linear_extrude(height=AxleStopDiameter)
difference(){
polygon(Knife,KnifePath);
translate([a+(KnifeUpperLength/2)+KnifeBumpPositionFromCenter,KnifeHeight-KnifeBumpDepth+KnifeBumpWidth/2,0]) circle(KnifeBumpWidth/2,$fn12);
}
//#polygon(points=[[0,0],[KnifeBladeLength,0],[KnifeUpperLength+a,KnifeHeight],[a+(KnifeUpperLength/2)+(KnifeBumpWidth/2),KnifeHeight],[a+(KnifeUpperLength/2)+(KnifeBumpWidth/2),KnifeHeight-KnifeBumpDepth],[a+(KnifeUpperLength/2)-(KnifeBumpWidth/2),KnifeHeight-KnifeBumpDepth],[a+(KnifeUpperLength/2)-(KnifeBumpWidth/2),KnifeHeight],[a,KnifeHeight]]);
}

cubeHeigth=0;

//Axle
module Axle(){
cylinder(r=AxleDiameter/2,h=AxleLength);
translate([0,0,AxleLength])
cylinder(r=AxleStopDiameter/2,h=AxleStopLength);
translate([0,0,AxleLength+AxleStopLength+(cubeHeigth+triangleSide-KnifeClearance)/2])
minkowski(){
cube([AxleStopDiameter-2,AxleStopDiameter-2,cubeHeigth+triangleSide-KnifeClearance],center=true);
translate([0,0,0])
cylinder(r=1,h=1);
}}
//KnifeHolder
module KnifeHolder(){
translate([-KnifeOffsetFromCenter,AxleStopDiameter/2,AxleLength+AxleStopLength+cubeHeigth])
rotate([90,0,0])
union(){
translate([pointBb-AxleStopDiameter/2+2,triangleSide-pointBa,AxleStopDiameter/2])
*sphere(r=AxleStopDiameter/2);
linear_extrude(height=AxleStopDiameter)
polygon(points=[[0,0],[pointBb,triangleSide-pointBa],[0,triangleSide]]);
}}

//KnifeClamp
module KnifeClamp(){
clampZPosition=AxleLength+AxleStopLength+(cubeHeigth+triangleSide-KnifeClearance)-12;
clampThickness=AxleStopDiameter/2;
clampHeight=12;
clampWidth=41-clampHeight;
clampXPosition=-4-KnifeOffsetFromCenter;
difference(){
    union(){
        translate([clampXPosition,-clampThickness,clampZPosition])
            cube([clampWidth,AxleStopDiameter/2,clampHeight]);
        translate([clampXPosition,0,clampZPosition+clampHeight/2])
            rotate([90,0,0])
            cylinder(r=clampHeight/2,h=clampThickness);
        translate([clampWidth+clampXPosition,0,clampZPosition+clampHeight/2])
            rotate([90,0,0])
            cylinder(r=clampHeight/2,h=clampThickness);}
    translate([clampXPosition,0,clampZPosition+clampHeight/2])
            rotate([90,0,0])
            cylinder(r=ClampScrewDiameter/2+0.2,h=clampThickness+1);
    translate([clampWidth+clampXPosition,0,clampZPosition+clampHeight/2])
            rotate([90,0,0])
            cylinder(r=ClampScrewDiameter/2+0.2,h=clampThickness+1);
}
}
module KnifeClamp2(){
    translate([0,-AxleStopDiameter/2+ClampThickness,(AxleLength+AxleStopLength+(cubeHeigth+triangleSide-KnifeClearance)-12)*2+40])
    mirror([0,0,1])
    resize([0,ClampThickness,0])
        KnifeClamp();
}
module DragKnifeRotor(){
union(){
difference(){
union(){
    Axle();
    KnifeHolder();
    KnifeClamp();
}
Knife();
translate([0,AxleStopDiameter/2,0]) KnifeClamp();
//cutout for printing without support (flatten the back)
if (WithoutSupport){translate([-100,-AxleDiameter/2,0])
rotate([90,0,0])
cube([200,200,AxleStopDiameter]);}
//cutout for freeing knife tip
translate([0,0,12]) KnifeClamp();
translate([0,AxleStopDiameter/2,12]) KnifeClamp();
}

if (WithoutSupport){translate([0,(AxleStopDiameter-AxleDiameter)/2,0])
KnifeClamp2();
}
else{KnifeClamp2();}
}
}
if(RotateForExport){rotate([-90,180,0])
DragKnifeRotor();
}
else {DragKnifeRotor();}
