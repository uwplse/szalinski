/* [Hidden] */
shrinkPCT=.2; //%, PLA
fudge=.02;  //mm, used to keep removal areas non-coincident
shrinkFactor=1+shrinkPCT/100;
nozzleDiameter=.4;
$fn=200;
res=1;  
faces=30; 

/* [Base] */
//Width of the base (all measurements are in mm)
baseWidth=12;
//Length of the base
baseLength=12;
//Thickness of the base
baseThickness=1.5;
//Diameter of the hole for the mounting screws
screwHoleDiameter=2.5;

/* [Rod] */
//Rod width
braceRodWidth=3; 
//Rod length
braceRodHeight=3; 
//Length of the stem holding the rod
stemLength=12;    

/* [Hidden] */
backerHoleDiameter=screwHoleDiameter*0.8; //smaller than screw to allow threads to grab
baseHoleOffset=screwHoleDiameter*0.3;  //screw hole is this far from the edge
rodToleranceFactor=1.085;
stemWallBuffer=0.5;
stemRadius=sqrt(pow((braceRodHeight*rodToleranceFactor)/2,2)+pow((braceRodWidth*rodToleranceFactor)/2,2))+stemWallBuffer;
cleanupHeight=stemRadius*2;      //negative box height to clean up overshoots

module all()
  {
  difference()
    {
    union()
      {
      base(screwHoleDiameter,false);
      stem();
      translate([baseLength+5,0,0])
        {
        base(backerHoleDiameter,true);
        }
      }
    cleanup();
    }
  }

module base(holeDiam, extraGrip)
  {
  difference()
    {
    union()
      {
      minkowski()
        {
        cube([baseLength, baseWidth, baseThickness/2]);
        cylinder(d=holeDiam,h=baseThickness/2);
        }
      if (extraGrip)
        {
        translate([baseHoleOffset,baseHoleOffset,baseThickness])
          {
          sphere(r=holeDiam*.85);
          }
        translate([baseLength-baseHoleOffset,baseWidth-baseHoleOffset,baseThickness])
          {
          sphere(r=holeDiam*.85);
          }
         translate([baseLength-baseHoleOffset,baseHoleOffset,baseThickness])
          {
          sphere(r=holeDiam*.85);
          }
        translate([baseHoleOffset,baseWidth-baseHoleOffset,baseThickness])
          {
          sphere(r=holeDiam*.85);
          }
        }
      }
    translate([baseHoleOffset,baseHoleOffset,-baseThickness/2])
      {
      cylinder(h=holeDiam*3, d=holeDiam);
      }
    translate([baseLength-baseHoleOffset,baseWidth-baseHoleOffset,-baseThickness/2])
      {
      cylinder(h=holeDiam*3, d=holeDiam);
      }
     translate([baseLength-baseHoleOffset,baseHoleOffset,-baseThickness/2])
      {
      cylinder(h=holeDiam*3, d=holeDiam);
      }
    translate([baseHoleOffset,baseWidth-baseHoleOffset,-baseThickness/2])
      {
      cylinder(h=holeDiam*3, d=holeDiam);
      }
   }
  }
  
module stem()
  {
  translate([baseLength/2,baseWidth/2,-1])  // -1 to bury the stem in the base
    {
    rotate(a=[0,45,0])
      {
      difference()
        {
        cylinder(r=stemRadius,h=stemLength+1); // +1 because we bury the stem in the base
        translate([-(braceRodWidth*rodToleranceFactor)/2,-(braceRodHeight*rodToleranceFactor)/2])
          {
          cube([braceRodWidth*rodToleranceFactor,braceRodHeight*rodToleranceFactor,stemLength+1+fudge]);
          }
        }
      }
    }
  }
 
module cleanup()
  {
  translate([-screwHoleDiameter/2,-screwHoleDiameter/2,-cleanupHeight])
    {
    cube([baseLength*2+5+screwHoleDiameter,baseWidth+screwHoleDiameter,cleanupHeight]);
    }
  }
 
  
all();
