//:P snaxxus code

//The number of facets on the circles. 
$fn=60;
//displays a fake idler and drive wheel. Only for visualization. Leave this off for final tendering
ShowRollers=0;//[1:true, 0:false] 

FilamentDia=1.75;
//Amount to allow for the filament sinking into the teeth of the drive wheel. This is a guess, I Don't really know this. It will shift the filament channel toward the drive wheel a bit.
FilamentInterference=0.3;

//The Diameter of the filament drivewheel
DriveWheelDia=10.95;
//The Width of the toothed part of the filament drivewheel
DriveWheelWidth=7.1;
//The Diameter of the mounting flange of the filament drive wheel. The part with the set/grub screw.
DriveWheelFlangeDia=9;
//The width of the mounting flange of the filament drive wheel. The part with the set/grub screw.
DriveWheelFlangeWidth=3.75;
DriveWheelClearance=0.4;

//The Width of the channel so you can fit an allen wrench to tighten the drive wheel's set screw.
WrenchChannelWidth=3;
//The direction in degrees to send a channel so you can fit an allen wrench to tighten the drive wheel's set screw.
WrenchChannelDirection=-20;

//The spacing between the NEMA17 mounting screws
NemaHoleSpacing=31.0;
//The Diameter of the circle flange on the front of the NEMA17.
NemaCircleDia=22.0;
//The Thickness of the circle flange in the NEMA17.
NemaCircleHeight=2.0;
//The Clearance to allow so our part won't bind in the NEMA17 circle flange. 
NemaClearance=0.3;

//The outer diameter of the threads of the mounting screws
PivotScrewDia=3.0;
//The Thickness of the cone of the countersunk mounting screw.
PlateScrewConeHeight=2;
//The outer Diameter of the cone on the countersink for the mounting screw.
PlateScrewConeOD=6;
//The amount to countersink the screw holding the plate to the NEMA17.
PlateScrewExtraDepth=0.3;

//The Idler's outer Diameter
IdlerOD=12.02;
//The thickness of the Idler wheel. 
IdlerThickness=4.08;
//The width the V shaped groove in the idler.
IdlerVeeWidth=2.6;
//The Diameter of the bottom of the V shaped groove in the idler.
IdlerVeeBottomDia=10;
//The Diameter of the hole in the bearing of the idler.
IdlerID=3;
//The distance from the pivot of the lever to the center of the idler.
IdlerRockerRadius=16.15;
//The Offset distance from that circle in the corner that the lever mounts on to the close edge of the idler wheel.
IdlerToBasePlateOffset=2.14;
//There's a little circle of plastic on the lever that holds the idler. This makes room for that.
IdlerHolderDia=9.8;
//Sets the clearance of the tight cut around the idler.
IdlerCutScale=1.09;

//Lets you see what the IdlerCutScale 's effect is on the tight cut around the idler.
echo((IdlerCutScale*IdlerOD-IdlerOD)/2);

//The Thickness of that circle in the corner that the lever mounts on. Yeah I know...
BasePlateThickness=5.55;
//The gap you allow between the lever to the baseplate.
BasePlateClearance=1.0;
//See those radiused corners? Yes, it's those.
BasePlateCornerRadius=6.0;
//The total thickness of the this part from the NEMA17 outward.
BaseBlockThickness=15.1;
//The distance form the Cold Block to the flat part the lever will hit then fully compressed.
LeverCompressedMinToCoolBlock=17.6;
//The littlt rounded corner at the top edge of the idler. This makes room for lever motion.
BasePlateToLeverCutRadius=9.5;
//The distance from the top of the cold block to the bottom of the lever spring.
SpringToCoolingBlockOffset=10.3;
//The width of the little pocket holding the lever spring.
SpringHolderWidth=9.7;
//The width of the outer rib next to the lever spring. 
SpringSideRibWidth=2.3;
//The diameter of the ball that holds the lever spring in place.
SpringRetainerBallDiameter=6.0;


//The diameter of the filiment channel.
FilamentChannelDia=2;//clean it with a drill
//The top diameter of the first bit of the filiment channel. To help guide the filiment during loading.
FilamentChannelFunnelDia=3.5;


//The thickness of the Cold Block toward and awayfrom the NEMA17 stepper.
CoolBlockThickness=15;
//The distance from the holeedge to flat top side of the aluminum cold block plus half of the throgh Screw Hole diameter. This gives us the distance from the bottom NEMA17 screw holes to the top of the cold block
CoolBlockScrewHoleOffset=4.145; 



module IdlerDraw(){

translate([0,0,(IdlerThickness-IdlerVeeWidth)/2+IdlerVeeWidth]){
cylinder(h=(IdlerThickness-IdlerVeeWidth)/2, d=IdlerOD+0.001);
}
cylinder(h=(IdlerThickness-IdlerVeeWidth)/2, d=IdlerOD+0.001);

translate([0,0,(IdlerThickness-IdlerVeeWidth)/2]){
cylinder(h=IdlerVeeWidth/2, d1=IdlerOD+0.001
  , d2=IdlerVeeBottomDia+0.001);
}
translate([0,0,(IdlerThickness-IdlerVeeWidth)/2+IdlerVeeWidth/2]){
cylinder(h=IdlerVeeWidth/2, d1=IdlerVeeBottomDia+0.001, d2=IdlerOD+0.001);
}
  
}


rotate([90,90,0]){ //print this way with supports+ redrill filament hole
//begin Baseplate
color("green"){
difference(){
union(){
hull(){
translate([-NemaHoleSpacing/2,NemaHoleSpacing/2,0]){
  cylinder(h=BasePlateThickness-BasePlateClearance,r=BasePlateCornerRadius);
translate([NemaHoleSpacing,0,0]){
  cylinder(h=BasePlateThickness-BasePlateClearance,r=BasePlateCornerRadius);
translate([-BasePlateCornerRadius,-NemaHoleSpacing+CoolBlockScrewHoleOffset,0]){
  cube([2*BasePlateCornerRadius,2*BasePlateCornerRadius,BasePlateThickness-BasePlateClearance]);
translate([-NemaHoleSpacing,0,0]){
  cube([2*BasePlateCornerRadius,2*BasePlateCornerRadius,BasePlateThickness-BasePlateClearance]);
}}}}}
cylinder(h=BaseBlockThickness,d=DriveWheelDia+DriveWheelClearance+1.8);


//Cornerpivot
translate([-NemaHoleSpacing/2,NemaHoleSpacing/2,0]){
  cylinder(h=BasePlateThickness,r=BasePlateCornerRadius);
}

translate([-(NemaHoleSpacing+2*BasePlateCornerRadius)/2,-NemaHoleSpacing/2+CoolBlockScrewHoleOffset,0]){
cube([NemaHoleSpacing+2*BasePlateCornerRadius,LeverCompressedMinToCoolBlock,BaseBlockThickness]);
}}
translate([NemaHoleSpacing/2+BasePlateCornerRadius-SpringHolderWidth-SpringSideRibWidth,0,BasePlateThickness-BasePlateClearance]){
difference(){  
cube([SpringHolderWidth,LeverCompressedMinToCoolBlock,BaseBlockThickness+0.001]);
translate([SpringHolderWidth/2,0,(BaseBlockThickness-BasePlateThickness+BasePlateClearance)/2]){
sphere(d=SpringRetainerBallDiameter);
}
}}
//Nema Cut
cylinder(d=NemaCircleDia+NemaClearance,h=NemaCircleHeight+NemaClearance);

cylinder(h=BaseBlockThickness+0.001,d=2*DriveWheelClearance+DriveWheelDia);
rotate([0,0,WrenchChannelDirection]){
translate([0,-WrenchChannelWidth/2,BaseBlockThickness+0.001-DriveWheelFlangeWidth]){
cube([NemaHoleSpacing,WrenchChannelWidth,DriveWheelFlangeWidth]);
}}
//PivotScrew Cut
translate([-NemaHoleSpacing/2,NemaHoleSpacing/2,0]){
cylinder(h=10,d=PivotScrewDia); 
}
translate([NemaHoleSpacing/2,NemaHoleSpacing/2,0]){
cylinder(h=10,d=PivotScrewDia);
translate([0,0,BasePlateThickness-BasePlateClearance-PlateScrewConeHeight-PlateScrewExtraDepth]){
cylinder(h=PlateScrewConeHeight,d1=PivotScrewDia,d2=PlateScrewConeOD); 
  
}
translate([0,0,BasePlateThickness-BasePlateClearance-PlateScrewExtraDepth]){
cylinder(h=PlateScrewExtraDepth+0.001,d=PlateScrewConeOD); 
  
}}
//FilamentChannelCut
translate([-DriveWheelDia/2-FilamentDia/2+FilamentInterference,0,BasePlateThickness+IdlerToBasePlateOffset+IdlerThickness/2]){
rotate([90,0,0]){
translate([0,0,-NemaHoleSpacing]){
  cylinder(h=2*NemaHoleSpacing,d=FilamentChannelDia);
}}}
translate([-DriveWheelDia/2-FilamentDia/2+FilamentInterference,-NemaHoleSpacing/2+CoolBlockScrewHoleOffset+LeverCompressedMinToCoolBlock,BasePlateThickness+IdlerToBasePlateOffset+IdlerThickness/2]){
rotate([90,0,0]){
translate([0,0,0]){
  cylinder(h=2,d1=FilamentChannelFunnelDia,d2=FilamentChannelDia);
}}}

//tight trim
difference(){
translate([-NemaHoleSpacing/2-BasePlateCornerRadius,0,BasePlateThickness-BasePlateClearance]){  
cube([NemaHoleSpacing/2+BasePlateCornerRadius,NemaHoleSpacing/2-BasePlateCornerRadius,BaseBlockThickness-BasePlateThickness+BasePlateClearance]);
}
translate([0,0,BasePlateThickness-BasePlateClearance]){  
cylinder(r=BasePlateToLeverCutRadius,h=BaseBlockThickness-BasePlateThickness+BasePlateClearance);
}
}

translate([-NemaHoleSpacing/2-BasePlateCornerRadius,-NemaHoleSpacing/2+CoolBlockScrewHoleOffset,BasePlateThickness-BasePlateClearance]){  
cube([NemaHoleSpacing/2+BasePlateCornerRadius-10,LeverCompressedMinToCoolBlock,BaseBlockThickness-BasePlateThickness+BasePlateClearance]);
}

  //law of cosines
a=sqrt(2.0)*NemaHoleSpacing/2;
b=IdlerRockerRadius;
c=(IdlerOD+DriveWheelDia)/2;
IdlerAng=-45-acos( (pow(a,2)+pow(b,2)-pow(c,2))/(2*a*b) );

x=-NemaHoleSpacing/2+IdlerRockerRadius*cos(IdlerAng); 
y=NemaHoleSpacing/2+IdlerRockerRadius*sin(IdlerAng); 
translate([x,y,BasePlateThickness-BasePlateClearance]){
cylinder(h=BaseBlockThickness-BasePlateThickness+BasePlateClearance,d=IdlerHolderDia);
}

translate([x,y,BasePlateThickness+IdlerToBasePlateOffset]){
scale([IdlerCutScale,IdlerCutScale,1]){
  IdlerDraw();
}
translate([0,0,-(IdlerCutScale*IdlerThickness-IdlerThickness)/2]){
scale([IdlerCutScale,IdlerCutScale,IdlerCutScale]){
  IdlerDraw();
}}
}

}}
//end BasePlate



if (ShowRollers){
//DriveWheel
translate([0,0,BasePlateThickness+IdlerThickness/2+IdlerToBasePlateOffset-DriveWheelWidth/2]){
cylinder(h=DriveWheelWidth,d=DriveWheelDia);
translate([0,0,DriveWheelWidth-0.001]){
cylinder(h=DriveWheelFlangeWidth,d=DriveWheelFlangeDia);
}}

//Idler Begin
  //law of cosines
a=sqrt(2.0)*NemaHoleSpacing/2;
b=IdlerRockerRadius;
c=(IdlerOD+DriveWheelDia)/2;
IdlerAng=-45-acos( (pow(a,2)+pow(b,2)-pow(c,2))/(2*a*b) );

x=-NemaHoleSpacing/2+IdlerRockerRadius*cos(IdlerAng); 
y=NemaHoleSpacing/2+IdlerRockerRadius*sin(IdlerAng); 

translate([x,y,BasePlateThickness+IdlerToBasePlateOffset]){
IdlerDraw();

}
//End Idler
}
}
