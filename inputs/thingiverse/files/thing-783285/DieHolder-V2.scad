// Cubic Dice Holder

//Size of die in mm
Size=16;
//Normally want to give the die some room to slide in and out easily but maybe you have a different idea
Fit=0.5; //[0:Tight,0.25:Snug,0.5:Loose]
//Mark the bottom of the well with the die size?
Tagged=1; //[0:No,1:Yes]
//Thickness of the wall at the top of the die holder.
WallThickness=3;
//Add an arrow to the south side as an indicator.
Arrow=2; //[0:None,1:Style 1, 2:Style 2]
// Hard or rounded corners
CornerStyle=0;//[0:Round,1:Hard]

DieSize=Size+Fit;

/*
difference(){
 union(){
  linear_extrude(height=DieSize*2,scale=0) {
   union(){
    intersection(){
     square(DieSize+4*WallThickness,center=true);
     rotate([0,0,45]) square((DieSize+6*WallThickness)*1.0, center=true);
    }
    if (Arrow==2){
     translate([0,-DieSize/2-WallThickness*2.5,0]) rotate([0,0,-90]) scale([1,1.5,1]) circle(r=WallThickness,$fn=3); 
    }
   }
  }
  if (Arrow==1){
   linear_extrude(height=DieSize,scale=0) translate([0,-DieSize/2-WallThickness*2.5,0]) rotate([0,0,-90]) scale([1,1.5,1]) circle(r=WallThickness,$fn=3); 
  }
 }
 translate([0,0,DieSize/2+WallThickness]) cube(DieSize, center=true);
 translate([0,0,DieSize*1.33+WallThickness]) cube(DieSize*2,center=true);
 if (Tagged) translate([0,0,WallThickness]) linear_extrude(height=1, center=true) text(str(Size), size=Size/16*10, halign="center", valign="center");
}
*/

HeightFactor=3;

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

$fn=30;
difference(){
 union(){
  translate([0,0,DieSize/HeightFactor+WallThickness])
   rotate([180,0,180])
    linear_extrude(height=DieSize/HeightFactor+WallThickness, scale=1.25){
     if (CornerStyle){
      offset(delta=WallThickness,chamfer=true) square(DieSize,center=true);
     }
     else {
      offset(r=WallThickness,chamfer=true) square(DieSize,center=true);
     }
     if (Arrow==2)
      translate([0,-DieSize/2-WallThickness*1.5,0]) rotate([0,0,-90]) scale([1,1.5,1]) circle(r=WallThickness,$fn=3); 
    }
   if (Arrow==1){
    intersection(){
     linear_extrude(height=DieSize,scale=0) translate([0,-DieSize/2-WallThickness*2.5,0]) rotate([0,0,-90]) scale([1,1.5,1]) circle(r=WallThickness,$fn=3); 
     cube([DieSize*2,DieSize*3,DieSize], center=true);
    }
   }
  }

 //Cutouts:
 translate([0,0,WallThickness]) linear_extrude(height=DieSize) 
  if (CornerStyle){
   offset(delta=Fit, chamfer=true) square(Size,center=true);
  }
  else{
   offset(r=Fit, chamfer=true) square(Size,center=true);
  }
  if (Tagged) translate([0,0,WallThickness]) linear_extrude(height=1, center=true) text(str(round(Size)), size=Size/16*10, halign="center", valign="center");
  translate([0,-Size/2-Fit,Size/HeightFactor/2+WallThickness]) rotate([90,0,0]) linear_extrude(height=0.5,center=true) CCTag2D(Size/HeightFactor);
}



