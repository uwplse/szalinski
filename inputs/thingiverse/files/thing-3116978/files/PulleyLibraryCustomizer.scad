//Customizable Step Pulley 
include <write/Write.scad> 


/* [Pulley Common Settings] */
//How nicely rounded should it be?
RoundingQuality = 60; // [60:Draft,180:Good,270:Better,360:Best]
//In Inches, 1/4" to 10" in 1/16" steps
beltWidth  = .5;  // [.25:.0625:10]
//In Inches, 1/4" to 2" in 1/16" steps
beltHeight = .3125;  // [.25:.0625:10]
//In degrees 1 to 90
BeltAngle  = 40; // [1:90]
//Diameter of the Axle, in inches 1 to 6 in 1/4" steps
arborOuterDiameter = .5; // [.25:.25:6]
//If the Axle has a key, set the key depth (0 for none)
axleKey = .125; //[0:.125:1]
PulleyEdge = "true"; //["true":Flat/Wide edge, "false":Sharp/Narrow edge]

/* [Pulley Diameter and Set Screw] */
//Set the Diameter for each pulley, in 1/4" increments (0 for no pulley). MUST BE LARGER THAN THE ARBOR DIAMETER!
Pulley1Diameter = 5; // [.25:.25:15]
Pulley2Diameter = 0; // [0:.25:15]
Pulley3Diameter = 0; // [0:.25:15]
Pulley4Diameter = 0; // [0:.25:15]
Pulley5Diameter = 0; // [0:.25:15]
Pulley6Diameter = 0; // [0:.25:15]
IncludeSetScrew = 0; // [0:No Set Screw,1:Pulley 1,2: Pulley 2]

module DrawErrorFlag(stepList, stepCount) {
  FlagSize = max(max(stepList),20)*25.4;
  translate([-FlagSize/2,-FlagSize/2,-2])
    #cube([FlagSize,FlagSize,2]);
  translate([-FlagSize/2,-FlagSize/2,0])
    text("ERROR",size=FlagSize*.25);
}
print_part();

module print_part() {
  CustomStepPulley ( beltWidth
                   , beltHeight
                   , BeltAngle
                   , dia1=Pulley1Diameter
                   , dia2=Pulley2Diameter
                   , dia3=Pulley3Diameter
                   , dia4=Pulley4Diameter
                   , dia5=Pulley5Diameter
                   , dia6=Pulley6Diameter
                   , arborD = arborOuterDiameter
                   , key=axleKey
                   , res=RoundingQuality
                   , padding=(PulleyEdge == "true")
                   , screwStep=IncludeSetScrew
                   );  
}

//======================================
// Calls customPulley to make the stack
// of 1 or more pulleys.
//======================================
module CustomStepPulley (beltB, beltH, beltangle, dia1=0, dia2=0, dia3=0, dia4=0, dia5=0, dia6=0, arborD, key=.125, res=60, padding=true,screwStep=2){

  //beltB = beltWidth
  //beltH = belt height
  //beltangle = manufacturer supplied angle

  //belt calculations
  theta=(180-beltangle)/2;
  x=beltH/(tan(theta)); //also height of pulley wall
  beltb=beltB-(2*x);
  padV = padding ? (2*x) : 0;
    
  //Calculate Steps (should be at least 1)
  stepCount = dia6 > 0 ? 6 
            : dia5 > 0 ? 5
            : dia4 > 0 ? 4
            : dia3 > 0 ? 3
            : dia2 > 0 ? 2
            : dia1 > 0 ? 1 : 0;  
  stepList = concat(dia1,dia2,dia3,dia4,dia5,dia6); //ok if some are 0
  
  //Run a quick error check on the parameters
  //unfortunately, we cannot abort with the error, so we just add a 
  //big red flag to the output.
  if (screwStep > 0 && screwStep > stepCount) {
     write(str("ERROR: Set screw requested for pulley ", screwStep
               , " of "
               , stepCount
               , " pulleys"
              )
           );
      DrawErrorFlag(stepList, stepCount);
  }
  for(step = [0:stepCount-1]){
    if (stepList[step] == 0) {
      write(str("ERROR: The diameter of pulley ", step+1, " is 0"
               , stepCount > 1 ? " for a stepped pulley." : ""
          ));
      DrawErrorFlag(stepList, stepCount);
    }
    if (arborD >= stepList[step] && stepList[step] > 0) {
      write(str("ERROR: The Arbor exceeds the diameter of pulley "
               , stepCount > 1 ? step+1 : ""
              )
          );
      DrawErrorFlag(stepList, stepCount);
    }
  }
  
  for(step = [0:stepCount-1]) {
    translate([0,0,step*(beltB+padV)*25.4]) 
      custompulley(beltB,beltH,beltangle,stepList[step],arborD,key,res,padding,screw = (screwStep == step+1) ? true : false);   
  }   
}

//======================================
// This module does all the work for
// generating a single pulley of the 
// specified dimensions.
// beltB = belt width
// beltH = belt height
// beltangle = manufacturer supplied angle
//======================================
module custompulley(beltB, beltH, beltangle, definedD, arborD, key=.125, res=60, padding=true, screw=false){

//Pulley diameters
  innerD=definedD -(2*beltH);

//belt calculations
  theta=(180-beltangle)/2;
  x=beltH/(tan(theta)); //also height of pulley wall
  beltb=beltB-(2*x);

  scale([25.4,25.4,25.4])
  difference(){
    union(){    
    translate ([0,0,x/2+beltb/2]) 
      cylinder(h=x, d1=innerD,d2=definedD, $fn=res, center=true);
      cylinder(h=beltb, d=innerD, $fn=res, center=true);
      mirror ([0,0,1]) 
        translate ([0,0,(x/2+beltb/2)]) 
          cylinder(h=x, d1=innerD,d2=definedD, $fn=res, center=true);
      if (padding == true) {
        translate ([0,0,3*x/2+beltb/2]) 
          cylinder(h=x,d=definedD, $fn=res, center=true);
        translate ([0,0,-(3*x/2+beltb/2)]) 
          cylinder(h=x,d=definedD, $fn=res, center=true);
      }
    }
    cylinder(h=100,d=arborD,$fn=res,center=true);
    translate ([0,key,0]) 
      cube([key,arborD,100], center=true);
    if (screw==true){
      translate([0,definedD/4,0]) 
        rotate([90,0,0]) 
          cylinder(h=definedD/2, d=.8*beltb,$fn=res,center=true);
    }
  }
  echo (str("-->pulley dia " ,definedD, screw ? " with setscrew " : ""));
}
