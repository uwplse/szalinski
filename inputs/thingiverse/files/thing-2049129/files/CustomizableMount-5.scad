//Hollow mount 

/* [Main] */
// Precision of the model
precision = 200;
// Cut in half for easy 3D printing?
cutInHalf = "true"; //[true, false]
//Rod inner diameter(mm)
innerDia = 30; //0-
//Rod outer diameter(mm)
outerDia = 38; //0-
//Rod length (at center point in mm)
Length = 90;
 
/* [Bottom base] */
//Bottom diameter (mm)
bottomDiameter = 70;
//Bottom thikness (mm)
bottomThickness = 8;
//Bottom tilt angle (mm)
bottomBaseAngle = 0;
//Bottom slope (mm)
bottomBaseSlope = 2;
//Bottom Y axis offset (for tilted base in mm)
bottomBaseOffset = 0;
//Bottom holes type 
bottomHoleType = "hexnut"; //[screw , hexnut]
//Bottom holes count
bottomHoleCount = 3;
//Bottom holes angle offset
bottomHoleOffset = 0;
//Bottom holes diameter from center (mm)
bottomHoleDia = 56.6;
//Bottom Scew/Nut thread diameter(mm)
bottomThreadDia = 4.5;
//Bottom Scew/Nut max. head diameter
bottomHeadDia =8;
//Bottom Scew/Nut max. head height(mm) for cuntersink
bottomHeadHeight = 3.2;

 
/* [Top base] */

//Top diameter (mm)
topDiameter = 70;
//Top thikness (mm)
topThickness = 8;
//Top tilt angle (mm)
topBaseAngle = 30;
//Top slope (mm)
topBaseSlope = 2;
//Top Y axis offset (for tilted base in mm)
topBaseOffset = 5;
//Top holes type 
topHoleType = "screw"; //[screw , hexnut]
//Top holes count
topHoleCount = 3;
//Top holes angle offset
topHoleOffset = 0;
//Top holes diameter from center (mm)
topHoleDia = 56.6;
//Top Scew/Nut thread diameter(mm)
topThreadDia = 4;
//Top Scew/Nut max. head diameter
topHeadDia =8.2;
//Top Scew/Nut max. head height(mm) for cuntersink
topHeadHeight = 4;
 
    

/* [Hidden] */   
wallThickness = outerDia-innerDia;
$fn=precision;

Mount();
//joint();

module Mount(){
difference()
{
    union()
    {
     {
        rotate([bottomBaseAngle,0,0]){
         translate([0,bottomBaseOffset,(bottomThickness/2)])
         Base(bottomDiameter, bottomThickness,bottomBaseSlope,bottomHoleType, bottomHoleCount,bottomHoleDia/2,bottomHoleOffset,bottomHeadHeight,bottomHeadDia,bottomThreadDia);
        };
        };
     translate([0,0,Length])
        {   
        rotate([180+topBaseAngle,0,0]){
        translate([0,topBaseOffset,(topThickness/2)])       
          Base(topDiameter, topThickness,topBaseSlope,topHoleType, topHoleCount,topHoleDia/2,topHoleOffset,topHeadHeight,  topHeadDia,topThreadDia);
        };
        };
      //rod
      translate([0,0,-bottomDiameter])
      {
       cylinder(Length+bottomDiameter+topDiameter,outerDia/2,outerDia/2);
      };
    };
  translate([0,0,-bottomDiameter])
      {  
       cylinder(Length+bottomDiameter+topDiameter,innerDia/2,innerDia/2);  
      };
   //bottomCutOff
 {
         union()
                   {
                  rotate ([bottomBaseAngle, 0, 0])
                   translate([0,0,-bottomDiameter]){
                   cube([bottomDiameter*2,bottomDiameter*2,bottomDiameter*2],true);
                  }
                  translate([0,bottomBaseOffset,bottomThickness/2]){
                      rotate ([bottomBaseAngle, 0, 0])
                     if (bottomHoleType == "screw")
                     {
                      screws(bottomHoleCount,bottomHoleDia/2,bottomHoleOffset,bottomHeadHeight, bottomHeadDia,bottomThreadDia  ,bottomThickness);
                     }
                      else
                      {
                        hexNuts(bottomHoleCount,bottomHoleDia/2, bottomHoleOffset, bottomHeadDia, bottomThreadDia,bottomThickness); 
                      };
                    };
               
              };
  };
   //bottom joint
  if (cutInHalf =="true"){
      dd= outerDia/2-wallThickness/4;
       translate([-5,dd,5+(dd*tan(bottomBaseAngle))]){
        rotate([0,90,0]){  
                    joint();    
                     };
                 };
                };
   //topCutOff
   {
   translate([0,0,Length])
         {
             rotate ([topBaseAngle, 0, 0]){
             union()
                 {   
                 translate([0,-1*topBaseOffset,topDiameter]){
                 cube([topDiameter*2,topDiameter*2,topDiameter*2],true);
                 };
                translate([0,-1*topBaseOffset,-topThickness/2]){
                    rotate([0,180,0]){
                     if (topHoleType == "screw")
                     {
                      screws(topHoleCount,topHoleDia/2,topHoleOffset,topHeadHeight, topHeadDia,topThreadDia ,topThickness);
                     }
                      else
                      {
                        hexNuts(topHoleCount,topHoleDia/2, topHoleOffset, topHeadDia, topThreadDia,topThickness); 
                      };
                  };
                    }; 
             
                };   
         };
      }; 
  };
  //top Joint
  if (cutInHalf =="true"){
      dd= outerDia/2-wallThickness/4;
       translate([-5,-dd,-5+Length-(dd*tan(topBaseAngle))]){
        rotate([0,90,0]){  
                    joint();    
                     };
                 };
                };
                
  if (cutInHalf =="true")
  {
    translate([topDiameter,0,topDiameter])
    cube([topDiameter*2,topDiameter*2,Length*2],true);
  }
};
};
module Base(Diameter, Thickness, BaseSlope, HoleType, HoleCount, HoleRadius, HoleOffset, HeadHeight, HeadDia, ThreadDia )
{
   difference  ()
    {
    hull()
       {
        cylinder(d=Diameter,h=Thickness,center=true); 
        translate([0,0,((Thickness/2)*BaseSlope)*0.9])
           {
             cylinder((Thickness/2)*BaseSlope,(Diameter/2)*0.9,0);
            };
       };
     
      
    };
};

module joint()
{
    union(){
      cylinder(10,(1.75*1.2)/2,(1.75*1.2)/2); 
      translate([0,0,4]){  
         union(){
          cylinder(1.2,1,1.5); 
          translate([0,0,2.3]){         
           rotate([0,180,0]){
             cylinder(1.2,1,1.5);
            }
         }
         translate([0,0,1]){         
           cylinder(0.2,1.5,1.5);
            }
         
         }
         }
      }
};

module screws(Count, Radius, Offset, HeadHeight,  TopDia,BottomDia, Thickness)
{
    for (i=[0:Count])
    {  
    rotate([0,0,i*(360/Count)+Offset])
    { 
        translate ([0,Radius,0])
        {
            union()
            {
                cylinder(HeadHeight,BottomDia/2,TopDia/2);
                //bottom
                translate([0,0,-1*HeadHeight-20])
                    {
                    cylinder(Thickness-HeadHeight+20,BottomDia/2,BottomDia/2);
                    };
                //top
                translate([0,0,HeadHeight])
                    {
                    cylinder(Thickness*2,TopDia/2,TopDia/2);
                    };
            };
       };
     };
    };
};

module hexNuts (Count,Radius, Offset, HeadDia, ThreadDia ,Thickness)
{
   for (i=[0:Count])
    {  
    rotate([0,0,i*(360/Count)+Offset])
    { 
        translate ([0,Radius,0])
        {
         union()
           {
              translate([0,0,Thickness*0.8])
               {
                hull()
                {
                  for (j=[0:5])
                  {
                    rotate([0,0,60*j])  
                      {
                    cube([0.1,HeadDia*1.1,Thickness*2],true);
                      };
                  };
                };
              };
             cylinder(Thickness*2,ThreadDia/2,ThreadDia/2,true);
          };
       };
     };
    };
};

