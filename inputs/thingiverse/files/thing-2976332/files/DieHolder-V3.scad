// Cubic Dice Holder

//Size of die in mm
DieSize=12;
//Normally want to give the die some room to slide in and out easily but maybe you have a different idea
Fit=0.5; //[0:Tight,0.25:Snug,0.5:Loose]
//Mark the bottom of the well with the die size?
Tagged=0; //[0:No,1:Yes]
// Put logo of origonal author
Branded=0; //[0:No,1:Yes]
//Thickness of the wall at the top of the die holder.
WallThickness=3;
//Add an arrow to the south side as an indicator.
ArrowType=1; //[0:None,1:Style 1, 2:Style 2]
// Hard or rounded corners
CornerStyle=1;//[0:Round,1:Hard]

// Number of dice to hold
NumberOfDice = 2; //[1,2,3,4]
// How much wider it is at the bottom of the base relative to the top. (in mm)
ExtraBaseWidth = 4;

// How tall do you want it to be relative to the dice size? BaseHeight = DieSize/HeightFactor+WallThickness
HeightFactor=3;

/*
 * End of Config
 */

DieCutoutSize=DieSize+Fit;


// Dimenions of the base.
BaseEvenX = NumberOfDice >= 2 ? DieCutoutSize * 2 + WallThickness : DieCutoutSize;
BaseEvenY = NumberOfDice >= 4 ? DieCutoutSize * 2 + WallThickness : DieCutoutSize;
BaseHeight = DieSize/HeightFactor+WallThickness;
BaseOddX = DieCutoutSize;
BaseOddY = DieCutoutSize;
BaseOffsetY = NumberOfDice >= 4 ? (DieCutoutSize + WallThickness)/2 : 0;
ExtrudeScale = (BaseEvenY + ExtraBaseWidth) / BaseEvenY; // Used to get consistent results from linear extrude chamfers

function from_polar(r=1,theta=60) = [r*cos(theta),r*sin(theta)];

module star_5(radius=10,inner=0.4){
 polygon([
  from_polar(radius,0),
  from_polar(radius*inner,36),
  from_polar(radius,72),
  from_polar(radius*inner,72+36),
  from_polar(radius,72*2),
  from_polar(radius*inner,72*2+36),
  from_polar(radius,72*3),
  from_polar(radius*inner,72*3+36),
  from_polar(radius,72*4),
  from_polar(radius*inner,72*4+36)]
 );
}

module CCTag2D(Size=20, Border=true){
 BorderWidth=(Size>=20)&&Border?Size/20:0;
 ESize=Size-4*BorderWidth;
 StarSize=ESize/5;
 ChevronWidth=ESize/5;
 ChevronAngle=35;
 
 intersection(){
  union(){
   // actual tag elements:
   translate([0,-ESize/2+StarSize,0]) rotate([0,0,90]) star_5(StarSize);
   translate([-ESize/2+StarSize,ESize/2-StarSize,0]) rotate([0,0,90]) star_5(StarSize);
   translate([ESize/2-StarSize,ESize/2-StarSize,0]) rotate([0,0,90]) star_5(StarSize);
   translate([0,ChevronWidth,0]) for (i=[0,1]) mirror([i,0,0]) rotate([0,0,-ChevronAngle]) translate([0,-ChevronWidth]) square([ESize,ChevronWidth]);
  }
  square(ESize,center=true);
 }
 if (BorderWidth){
  difference(){
   square(Size,center=true);
   square(Size-BorderWidth*2,center=true);
  }
 }
}

module cutout() {
 linear_extrude(height=DieCutoutSize) 
  if (CornerStyle){
   offset(delta=Fit, chamfer=true) square(DieSize,center=true);
  } else {
   offset(r=Fit, chamfer=true) square(DieSize,center=true);
  }
  if (Tagged) translate([0,0,WallThickness]) linear_extrude(height=1, center=true) text(str(round(DieSize)), size=DieSize/16*10, halign="center", valign="center");
  if (Branded) translate([0,-DieSize/2-Fit,DieSize/HeightFactor/2+WallThickness]) rotate([90,0,0]) linear_extrude(height=0.5,center=true) CCTag2D(DieSize/HeightFactor); 
}

module base(XLength, YLength) {
 if (CornerStyle){
  offset(delta=WallThickness,chamfer=true) square([XLength, YLength],center=true);
 } else {
  offset(r=WallThickness,chamfer=true) square([XLength, YLength],center=true);
 }
}

module arrow() {
 if (ArrowType==1)
  intersection(){
   linear_extrude(height=DieCutoutSize,scale=0) 
    translate([0,-DieCutoutSize/2-WallThickness-ExtraBaseWidth,0])
     rotate([0,0,-90]) scale([1,1.5,1]) 
      circle(r=WallThickness,$fn=3); 
   cube([DieCutoutSize*2,DieCutoutSize*3,DieCutoutSize], center=true);
  } 
  if (ArrowType==2)
   translate([0,-DieCutoutSize/2-WallThickness*1.5,0]) 
    linear_extrude(height=BaseHeight, scale=ExtrudeScale)
     rotate([0,0,-90]) scale([1,1.5,1]) circle(r=WallThickness,$fn=3);
}


$fn=30;
difference(){
 union(){
  translate([0,BaseOffsetY,BaseHeight])
   rotate([180,0,180])
    linear_extrude(height=BaseHeight, scale=ExtrudeScale){
     base(BaseEvenX, BaseEvenY);
     if (NumberOfDice == 3) {
         translate([0,DieCutoutSize+WallThickness,0]) base(BaseOddX, BaseOddY);
     } 
    }
    arrow();
 }
 //Cutouts:
 CutoutOffsetX = (DieCutoutSize+WallThickness)/2; // Only used for side by side dice
 CutoutOffsetY = DieCutoutSize+ WallThickness; // Only used for dice in the seocnd row
 if (NumberOfDice <= 1) {
  translate([0,0,WallThickness]) cutout();
 } else if (NumberOfDice == 2) {
  translate([CutoutOffsetX,0,WallThickness]) cutout();
  translate([-CutoutOffsetX,0,WallThickness]) cutout();
 } else if (NumberOfDice == 3) {
  translate([CutoutOffsetX,0,WallThickness]) cutout();
  translate([-CutoutOffsetX,0,WallThickness]) cutout();
  translate([0,CutoutOffsetY,WallThickness])  cutout();
 } else if (NumberOfDice >= 4) {
  translate([CutoutOffsetX,0,WallThickness]) cutout();
  translate([-CutoutOffsetX,0,WallThickness]) cutout();
  translate([CutoutOffsetX,CutoutOffsetY,WallThickness]) cutout();
  translate([-CutoutOffsetX,CutoutOffsetY,WallThickness]) cutout();
 }
}



