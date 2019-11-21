$fn=30;

//BEGIN CUSTOMIZER VARIABLES  
/*[Base Setup]*/
//Set tolarance for tightness.  .3 is a good start, bigger the number looser.
RodTolerance = .3;
//in MM.   Radius of connecting rod.
RodRadius = 2;
//in MM.   Socket base height.
RodSocketHeight = 10;
//Depth as a percentage deep for the rod hole. 
RodDepthPercent = .80;  //[.10:.10:.90]
//in MM.   
RodSocketWallThickness = 2;

/*[Eye Hole Setup]*/
//Angle of Eye Hole.  90 is straght up.
EyeAngle = 90;  //[45:5:90]
//in MM.  Center hole radius.
EyeHoleRadius = 2;
//in MM.  Depth of wall around center hole.
EyeWallThickness = 2;
//in MM.  Offset of 0 is a good start.  Lets you slide around the eye.  Used mostly for angled eyes.
EyeOffsetX = 0;
//in MM (up/dn).  Offset of 0 is a good start.  Lets you slide around the eye. Used mostly for angled eyes.
EyeOffsetZ = 0;
/*[Extras]*/
//END CUSTOMIZER VARIABLES


module eye() {
  cAngleOffset = ((90 - EyeAngle)* .06)+EyeOffsetZ;
  echo("cAngleOffset = ", cAngleOffset);
    
  cEyeHeight = ((RodSocketHeight+RodSocketHeight*.25)+EyeWallThickness)-cAngleOffset;
    
  cylinder(h=RodSocketHeight,r=RodRadius+RodSocketWallThickness);
  translate([0,0,RodSocketHeight]) {
    cylinder(h=RodSocketHeight*.25,r1=RodRadius+RodSocketWallThickness, r2=(RodRadius+RodSocketWallThickness)/1.5);
  }

//   translate([-5,0,14]) {
  translate([((RodSocketWallThickness+RodRadius)*-1)+EyeOffsetX,0,cEyeHeight]) {
    rotate(a=EyeAngle, v=[0,1,0]) {
        difference() {
          cylinder(h=(RodRadius+RodSocketWallThickness)*2,r=EyeHoleRadius+EyeWallThickness);
          cylinder(h=(RodRadius+RodSocketWallThickness)*2,r=EyeHoleRadius);
        }
    }
  }
}


difference() {
  eye();
  cylinder(h=RodSocketHeight*RodDepthPercent,r=RodRadius+RodTolerance);  
}