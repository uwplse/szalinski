//3d printable cigarette rolling machine
//Created By LinkReincarnate
//CC Share Alike Attribution Non-Commercial
//*************VARIABLE DECLARATION SECTION******** all values are in mm
//0 for build plate 1 = Lid, 2 = Body, 3 = TrackPanel, 4 = ControlArm  5= Roller 6= assembled box 
printItem = 0;
   
//make sure to change the hingeXOffset when you change the box length.     
boxLength = 90.4;         
boxWidth = 81.25;
boxHeight = 19.2;
boxBottomThickness = 2;
boxWallThickness = .67;
boxArcHeight = 3.5;
boxArcRadius=1;
boxControlArmHoleZOffset = 3.5;
boxControlArmHoleYOffset = 3;
boxHingePinDiameter = 3;
boxHingeDiameter= 5;
boxHingeZOffset = -5;
boxHingeYOffset = 0;
boxHingeTolerance = .1;
boxHingeSupportZOffset= 0;
boxHingeSupportYOffset = -4.5;
boxHingeNumberOfSplits = 7;
boxHingeClearance=1;
//the following variables determine the details of the cylinder (or sphere) used for minkowski sums
boxCornerRoundness = 7;
boxCornerSmoothness = 16;

controlArmLength = 38.5;
controlArmHeight = 7;
controlArmThickness = 5;
controlArmPinDiameter = 2;
controlArmHoleZOffset = 0;
controlArmHoleYOffset = 0;
controlArmPinTolerance = .1;

lidLipHeight = 5;
lidThickness = 5;
lidTolerance = 1;
lidHingeZOffset = 0;
lidHingeYOffset = 1;
lidHingeXOffset =.4;
lidHingeTolerance = 1;
lidOverlap = 2;

//moves hinge slot cutouts left and right
hingeSlotXOffset =0;
hingeSlotYOffset = 0;
hingeSlotZOffset = 0;

dispenserHoleLength = 71.5; //also used for dist between tracks
dispenserHoleWidth = 11.5;
dispenserHoleXOffset = 0;
dispenserHoleYOffset = 0;

trackPanelLength = 76;
trackPanelWidth = 19;
trackPanelThickness = 3;
trackWidth = 2.5;
trackLength = 61;
trackHeight = 14;
trackTolerance = 1;
trackControlPoint1X = 3;
trackControlPoint1Y = 3;
trackControlPoint1Z = 0;
trackControlPoint2X = 9;
trackControlPoint2Y = 9;
trackControlPoint2Z = 0;
trackControlPoint3X = 45;
trackControlPoint3Y = 8;
trackControlPoint3Z = 0;
trackControlPoint4X = 57;
trackControlPoint4Y = 14;
trackControlPoint4Z = 0;


rollerDiameter = 7;
rollerLength = 71;

rollerPinDiameter = 2;
hingePinDiameter = 1.6;
pinLength= 71;

pinTolerance = 1;
cigaretteDiameter = 7.75;
cigaretteLength = 70;

booleanOverlap = .01; //to ensure that the faces used to difference() dont line up
lowRollingClearance = 5; //the distance from the center of the rolling pin to the lid at the lowest point.
hightRollingClearance = 12.6;

boxRoundCorners = true;
arched = false;
//uses math to determin the arc radius of the curve of the box and creates the appropriate cylinder

//*************MODULE DECLARATION SECTION***************************
module CreateArc(            arcLength,
                             arcHeight, 
                             cylinderHeight){
    carveRadius = ((arcHeight/2)+((arcLength * arcLength)/arcHeight * 8)/(53));
    rotate(a=[90,180,90]){
        translate([0,-carveRadius + arcHeight - (boxHeight/2),0]){
            cylinder(r=carveRadius, h=cylinderHeight+booleanOverlap, $fn=1024, center=true);
        }
         
    }
}//end of module
                                                      

module CreateNonArchedBody(  boxLength, 
                             boxWidth, 
                             boxHeight, 
                             boxBottomThickness, 
                             boxWallThickness,
                             boxRoundCorners,
                             boxCornerRoundness,
                             boxCornerSmoothness, 
                             boxHingeDiameter, 
                             boxHingePinDiameter,  
                             boxHingeZOffset, 
                             boxHingeYOffset, 
                             boxHingeTolerance,
                             boxHingeClearance,
                             boxHingeNumberOfSplits, 
                             pinTolerance, 
                             controlArmPinDiameter,
                             boxControlArmHoleZOffset,   
                             boxControlArmHoleYOffset,
                             controlArmPinTolerance,
                             boxHingeSupportZOffset,
                             boxHingeSupportYOffset,
                             booleanOverlap){
 //union joins the difference of the outer and inner bodies with a pinhole for the arms and the hinge parts
    union(){
        //create body
         if (boxRoundCorners){
           difference(){     
                $fn=boxCornerSmoothness;
                minkowski(){
                 cube([boxLength-(2*boxCornerRoundness),boxWidth - (2*boxCornerRoundness),boxHeight/2], 
                     center = true);
                 cylinder(r=boxCornerRoundness,h=boxHeight/2, center=true);
                }
                translate([0,0,(boxBottomThickness/2) + booleanOverlap]) {
                    $fn=boxCornerSmoothness;
                    minkowski()
                    {
                     cube([boxLength - boxWallThickness-(2*boxCornerRoundness), 
                              boxWidth - boxWallThickness -(2*boxCornerRoundness), 
                              ((boxHeight/2) - (boxBottomThickness/2))], 
                              center = true);
                     cylinder(r=boxCornerRoundness,h=((boxHeight/2) - (boxBottomThickness/2)), center=true);
                    }
                }
                //create pinholes to connect control arms
                rotate(a=[0, -90, 0]){
                    translate([boxControlArmHoleZOffset,boxControlArmHoleYOffset,0]){
                        cylinder(d= (controlArmPinDiameter + controlArmPinTolerance), 
                                     boxLength + booleanOverlap, 
                                     center=true );
                    }
                }
                
            } //end of difference
         } else {
              difference(){
                    cube([boxLength,boxWidth,boxHeight], 
                         center = true);
                    translate([0,0,(boxBottomThickness/2) +booleanOverlap]) {
                        cube([boxLength - boxWallThickness, 
                              boxWidth - boxWallThickness, 
                              (boxHeight - boxBottomThickness)], 
                              center = true);
                    }
                    //create pinholes to connect control arms
                    rotate(a=[0, -90, 0]){
                        translate([boxControlArmHoleZOffset,boxControlArmHoleYOffset,0]){
                            cylinder(d= (controlArmPinDiameter + controlArmPinTolerance), 
                                         boxLength + booleanOverlap, 
                                         center=true );
                        }
                    }
                    
              }   
         }
         CreateHinge(boxRoundCorners,
                     boxWidth,
                     boxLength,
                     boxHeight,
                     boxHingeDiameter, 
                     boxHingePinDiameter,  
                     boxHingeZOffset, 
                     boxHingeYOffset, 
                     boxHingeTolerance,
                     boxHingeClearance,
                     boxHingeNumberOfSplits, 
                     pinTolerance,
                     boxHingeSupportZOffset,
                     boxHingeSupportYOffset,
                     lidHingeZOffset,
                     lidHingeYOffset,
                     lidHingeTolerance,
                     booleanOverlap);
     }// end of union body and hinge
}//end of module
module CreateArchedBody(     boxLength, 
                             boxWidth, 
                             boxHeight, 
                             boxBottomThickness, 
                             boxWallThickness,
                             boxRoundCorners,
                             boxCornerRoundness,
                             boxCornerSmoothness, 
                             boxHingeDiameter, 
                             boxHingePinDiameter,  
                             boxHingeZOffset, 
                             boxHingeYOffset, 
                             boxHingeTolerance,
                             boxHingeClearance,
                             boxHingeNumberOfSplits, 
                             pinTolerance, 
                             controlArmPinDiameter,
                             boxControlArmHoleZOffset,   
                             boxControlArmHoleYOffset,
                             controlArmPinTolerance,
                             boxHingeSupportZOffset,
                             boxHingeSupportYOffset,
                             booleanOverlap,
                             boxArcHeight,
                             boxArcRadius
                             ){
    union(){
    //create body
      if (boxRoundCorners){
         translate([0,0,boxHingeSupportZOffset+boxArcHeight+1])
             difference(){   
                intersection(){
                    $fn=boxCornerSmoothness;
                    minkowski(){
                     cube([boxLength-(2*boxCornerRoundness),
                           boxWidth - (2*boxCornerRoundness),
                           boxHeight+boxArcHeight/2], 
                         center = true);
                     cylinder(r=boxCornerRoundness,h=boxHeight + boxArcHeight/2);
                    }
                    translate([0,0,-boxHeight+boxArcHeight])
                        CreateArc(boxWidth, boxArcHeight, boxLength);
                 }  
                translate([0,0,(boxBottomThickness/2)]){
                   intersection(){
                         $fn=boxCornerSmoothness;
                         minkowski(){
                             cube([boxLength - boxWallThickness-(2*boxCornerRoundness), 
                                   boxWidth - boxWallThickness -(2*boxCornerRoundness), 
                                   (((boxHeight+boxArcHeight/2) - boxBottomThickness) + booleanOverlap)], 
                                   center = true);
                             cylinder(r=boxCornerRoundness,h=boxHeight/2);
                        }
                        translate([0,0,-boxHeight+boxArcHeight])
                            CreateArc(boxWidth, boxArcHeight, boxLength);
                    }  
                }
                //create pinholes to connect control arms
                rotate(a=[0, -90, 0]){
                    translate([boxControlArmHoleZOffset,boxControlArmHoleYOffset,0]){
                        cylinder(d= (controlArmPinDiameter +                                                                 
                                     controlArmPinTolerance), 
                                     boxLength + booleanOverlap, 
                                     center=true );
                    }
                }
                
                CreateArc(boxWidth, boxArcHeight, boxLength+booleanOverlap);
              //insert objects here to difference them from the main body  
      } 
      } else {
          difference(){
              intersection(){
                cube([boxLength,boxWidth,boxHeight+boxArcHeight], 
                     center = true);
                translate([0,0,-boxHeight+boxArcHeight]){
                    CreateArc(boxWidth, boxArcHeight, boxLength);
                }
                 
              }
              intersection(){
                    translate([0,0,(boxBottomThickness/2)]){
                        cube([boxLength - boxWallThickness, 
                              boxWidth - boxWallThickness, 
                              ((boxHeight +boxArcHeight - boxBottomThickness) + booleanOverlap)], 
                              center = true);
                    }
                    translate([0,0,-boxHeight+boxArcHeight]){
                         CreateArc(boxWidth, boxArcHeight, boxLength);
                    } 
                }
                //create pinholes to connect control arms
                rotate(a=[0, -90, 0]){
                   translate([boxControlArmHoleZOffset,boxControlArmHoleYOffset,0]){
                       cylinder(d= (controlArmPinDiameter +                                                        
                                    controlArmPinTolerance), 
                                    boxLength + booleanOverlap, 
                                    center=true );
                   }
                }
                CreateArc(boxWidth,boxArcHeight,boxLength + booleanOverlap);
                //insert here to difference with body
            }   
      }
    //Create Hinge and hinge support
    CreateHinge( boxRoundCorners,
                 boxWidth,
                 boxLength,
                 boxHeight,
                 boxHingeDiameter, 
                 boxHingePinDiameter,  
                 boxHingeZOffset, 
                 boxHingeYOffset, 
                 boxHingeTolerance,
                 boxHingeClearance,
                 boxHingeNumberOfSplits, 
                 pinTolerance,
                 boxHingeSupportZOffset,
                 boxHingeSupportYOffset,
                 lidHingeZOffset,
                 lidHingeYOffset,
                 lidHingeTolerance,
                 booleanOverlap);
    //insert new parts to be added to the body here
    }
}//end of module
module CreateNonArchedLid(          lidLipHeight,
                                    lidThickness,
                                    lidTolerance,
                                    lidHingeZOffset,
                                    lidHingeYOffset,
                            //add lidHingeXOffset and hingeSlotXOffset
                                    lidHingeTolerance,
                                    lidOverlap,
                                    hingeSlotXOffset,
                                    hingeSlotYOffset,
                                    hingeSlotZOffset,
                                    boxLength, 
                                    boxWidth, 
                                    boxHeight,
                                    boxRoundCorners,
                                    boxCornerRoundness,
                                    boxCornerSmoothness, 
                                    boxHingeDiameter, 
                                    boxHingePinDiameter,
                                    boxHingeNumberOfSplits,
                                    dispenserHoleLength,
                                    dispenserHoleWidth,
                                    dispenserHoleXOffset,
                                    dispenserHoleYOffset,
                                    rollerLength,
                                    trackPanelThickness,
                                    booleanOverlap){
  if (boxRoundCorners){
      union(){
             difference(){     
                    $fn=boxCornerSmoothness;
                    //this is the exterior of the lid
                    
                        minkowski(){
                         cube([lidOverlap + boxLength + lidTolerance - (2 * boxCornerRoundness),
                               lidOverlap + boxWidth + lidTolerance - (2 * boxCornerRoundness),
                               ((lidThickness + lidLipHeight)/2)]);
                         cylinder(r=boxCornerRoundness,h=((lidThickness + lidLipHeight)/2));
                        }
                        
                   
                    
                    //this is the interior cutout
                    translate([lidOverlap/2,lidOverlap/2,-booleanOverlap ]){
                        $fn=boxCornerSmoothness;
                        minkowski()
                        {
                         cube([boxLength + lidTolerance - (2 * boxCornerRoundness) ,
                               boxWidth + lidTolerance - (2 * boxCornerRoundness),
                               lidLipHeight/2]); 
                         cylinder(r=boxCornerRoundness,h=lidLipHeight/2);
                        }
                    }
                    //this is the hinge lip cutout
                    {
                    translate([-((boxCornerRoundness/2) + (lidTolerance/2) + ((lidOverlap/2))),boxWidth/2 + lidOverlap +lidTolerance +booleanOverlap - (boxCornerRoundness),-booleanOverlap])
                    cube([boxLength - lidTolerance,
                               boxWidth/2,
                               lidLipHeight +booleanOverlap]); 
                    }
                    //hingeslots
                    //this splits the hinge cylinder into individual pieces, also cuts clearance slots into the lid
                   difference(){
                        //change this rotate to 90 to invert the hinge slot cut over one hingelength
                      rotate(a=[0,270,0]) 
                       translate([lidLipHeight,
                                  boxWidth + lidOverlap+boxHingeDiameter/2 -lidTolerance/2 - (boxCornerRoundness),
                                  -((boxCornerRoundness/2)) -boxLength]){
                          translate([0,0,hingeSlotXOffset + lidOverlap/2 + lidTolerance])
                          {
                               for ( i = [0 : boxHingeNumberOfSplits/2] )
                                    {
                                        //LOOK HERE TO TRY TO FIX HINGE SLOT MISALIGNMENT
                                        translate([0, 0, boxLength/boxHingeNumberOfSplits * i *2])
                                        cylinder(d=boxHingeDiameter+boxHingeTolerance+booleanOverlap + boxHingeClearance, 
                                                (boxLength/boxHingeNumberOfSplits) + boxHingeTolerance + lidHingeTolerance);
                                     }
                          }
                               
                        }
                        //this cube acts as an endstop precenting the hinge from being cut past the point it needs to be cut
                        translate([-boxCornerRoundness + boxLength -(boxCornerRoundness/2) +lidTolerance/2 - (lidOverlap/2),
                                   0,
                                   lidLipHeight -boxHingeDiameter - boxHingeTolerance - boxHingeClearance,]){
                            cube([boxLength,
                                  boxWidth+10,
                                  boxHeight]);
                        }
                        //same as above but on the other side! exciting...
                        translate([-boxCornerRoundness,
                                   0,
                                   lidLipHeight -boxHingeDiameter - boxHingeTolerance - boxHingeClearance]){
                            cube([boxCornerRoundness,
                                  boxWidth+10,
                                  boxHeight]);
                        }
                    }//end of hinge slot subtration
                    //dispenser hole
                    translate([boxCornerRoundness/2 +lidTolerance/2 ,0,lidThickness-2])
                    cube([dispenserHoleLength,dispenserHoleWidth,lidThickness+10 +booleanOverlap]);
                    //trackPanelMountingHoles
  //***********Get the thickness out of the module somehow so i can arrange the track panels outside the dispenser hole                  
                    translate([boxCornerRoundness/2 +lidTolerance/2,0,lidThickness+booleanOverlap]){
                     rotate([270,0,90]){ 
                     CreateControlTrack(
                            controlArmLength,
                            controlArmHeight,
                            controlArmThickness,
                            controlArmPinDiameter,
                            controlArmHoleZOffset,
                            controlArmHoleYOffset,
                            controlArmPinTolerance,
                            lidLipHeight,
                            lidThickness,
                            lidTolerance,
                            boxLength, 
                            boxWidth, 
                            boxHeight,
                            boxRoundCorners,
                            boxCornerRoundness,
                            boxHingePinDiameter,
                            trackPanelLength,
                            trackPanelWidth,
                            trackPanelThickness,
                            trackWidth,
                            trackLength,
                            trackHeight,
                            trackTolerance,
                            trackControlPoint1X,
                            trackControlPoint1Y,
                            trackControlPoint1Z,
                            trackControlPoint2X,
                            trackControlPoint2Y,
                            trackControlPoint2Z,
                            trackControlPoint3X,
                            trackControlPoint3Y,
                            trackControlPoint3Z,
                            trackControlPoint4X,
                            trackControlPoint4Y,
                            trackControlPoint4Z); 
                      translate([0,0,-dispenserHoleLength -trackPanelThickness])
                     CreateControlTrack(
                            controlArmLength,
                            controlArmHeight,
                            controlArmThickness,
                            controlArmPinDiameter,
                            controlArmHoleZOffset,
                            controlArmHoleYOffset,
                            controlArmPinTolerance,
                            lidLipHeight,
                            lidThickness,
                            lidTolerance,
                            boxLength, 
                            boxWidth, 
                            boxHeight,
                            boxRoundCorners,
                            boxCornerRoundness,
                            boxHingePinDiameter,
                            trackPanelLength,
                            trackPanelWidth,
                            trackPanelThickness,
                            trackWidth,
                            trackLength,
                            trackHeight,
                            trackTolerance,
                            trackControlPoint1X,
                            trackControlPoint1Y,
                            trackControlPoint1Z,
                            trackControlPoint2X,
                            trackControlPoint2Y,
                            trackControlPoint2Z,
                            trackControlPoint3X,
                            trackControlPoint3Y,
                            trackControlPoint3Z,
                            trackControlPoint4X,
                            trackControlPoint4Y,
                            trackControlPoint4Z); 
                        }
                    }
             } // end of difference
         CreateLidHinge(  boxRoundCorners,boxWidth,boxLength,boxHeight,boxHingeDiameter,boxHingePinDiameter,boxHingeZOffset,boxHingeYOffset,                    boxHingeTolerance,boxHingeClearance,boxHingeNumberOfSplits,pinTolerance,boxHingeSupportZOffset,boxHingeSupportYOffset,lidHingeZOffset,                    lidHingeYOffset,lidHingeXOffset,lidHingeTolerance,lidOverlap,booleanOverlap);  
         //make support for lidhinge with proper cutouts
             difference(){
                translate([-((boxCornerRoundness/2) + (lidTolerance/2) + ((lidOverlap/2))),boxWidth*15/16 + lidOverlap +lidTolerance+(boxHingeDiameter*.75) -lidHingeYOffset - (boxCornerRoundness),lidThickness])
                cube([boxLength - lidTolerance,
                               boxWidth/16,
                               lidThickness-booleanOverlap]); 
                translate([boxLength + lidOverlap/2 + lidTolerance/2 - (boxCornerRoundness*2) + lidHingeXOffset,
                           boxWidth +lidHingeYOffset -(boxCornerRoundness/2) - lidOverlap/2 + lidTolerance/2,
                           (lidThickness)+lidHingeZOffset]){
                    //remember rotation is counterclockwise 
                           rotate(a=[0,270,0]){
                                cylinder(d=boxHingePinDiameter, boxLength*2 +booleanOverlap,center=true);    
                           }
                }
                difference(){
                        //change this rotate to 90 to invert the hinge slot cut over one hingelength
                      rotate(a=[0,270,0]) 
                       translate([lidLipHeight,
                                  boxWidth + lidOverlap+boxHingeDiameter/2 -lidTolerance/2 - (boxCornerRoundness),
                                  -((boxCornerRoundness/2)) -boxLength]){
                          translate([0,0,hingeSlotXOffset + lidOverlap/2 + lidTolerance])
                          {
                               for ( i = [0 : boxHingeNumberOfSplits/2] )
                                    {
                                        //LOOK HERE TO TRY TO FIX HINGE SLOT MISALIGNMENT
                                        translate([0, 0, boxLength/boxHingeNumberOfSplits * i *2])
                                        cylinder(d=boxHingeDiameter+boxHingeTolerance+booleanOverlap + boxHingeClearance, 
                                                (boxLength/boxHingeNumberOfSplits) + boxHingeTolerance + lidHingeTolerance);
                                     }
                          }
                               
                        }
                        //this cube acts as an endstop precenting the hinge from being cut past the point it needs to be cut
                        translate([-boxCornerRoundness + boxLength -(boxCornerRoundness/2) +lidTolerance/2 - (lidOverlap/2),
                                   0,
                                   lidLipHeight -boxHingeDiameter - boxHingeTolerance - boxHingeClearance,]){
                            cube([boxLength,
                                  boxWidth+10,
                                  boxHeight]);
                        }
                        //same as above but on the other side! exciting...
                        translate([-boxCornerRoundness,
                                   0,
                                   lidLipHeight -boxHingeDiameter - boxHingeTolerance - boxHingeClearance]){
                            cube([boxCornerRoundness,
                                  boxWidth+10,
                                  boxHeight]);
                        }
                    }//end of hinge slot subtration
     }
          }//end of union 
         } else {
              difference(){     
                   //this is the exterior of the lid
                   cube([lidOverlap + boxLength + lidTolerance,
                           lidOverlap + boxWidth + lidTolerance,
                           ((lidThickness + lidLipHeight))]);
                    //this is the interior cutout
                    translate([lidOverlap/2,lidOverlap + booleanOverlap,-booleanOverlap]){
                        cube([boxLength + lidTolerance,
                               boxWidth + lidTolerance,
                               lidLipHeight]); 
                    }
                    //this is the hinge lip cutout
                    translate([lidOverlap/2,lidOverlap/2,-booleanOverlap]){
                        cube([boxLength + lidTolerance,
                                   boxWidth + lidTolerance,
                                   lidLipHeight]); 
                    }
                    //hingeslots
                    //this splits the hinge cylinder into individual pieces, also cuts clearance slots into the lid
                    rotate(a=[0,90,0]) 
                       translate([-lidLipHeight,+boxWidth + boxHingeDiameter/2,lidOverlap/2]){
                            for ( i = [0 : boxHingeNumberOfSplits] ){
                                    translate([0, 0, boxLength/boxHingeNumberOfSplits * i *2])
                                    cylinder(d=boxHingeDiameter+boxHingeTolerance+booleanOverlap + boxHingeClearance, 
                                            (boxLength/boxHingeNumberOfSplits) + boxHingeTolerance + lidHingeTolerance);
                            }
                        }
              } // end of difference  
           
         }//end of else
         

 }//end of Lid Module
module CreateArchedLid(             lidLipHeight,
                                    lidThickness,
                                    lidTolerance,
                                    lidHingeZOffset,
                                    lidHingeYOffset,
                                    lidHingeTolerance,
                                    boxLength, 
                                    boxWidth, 
                                    boxHeight,
                                    boxRoundCorners,
                                    boxCornerRoundness,
                                    boxCornerSmoothness, 
                                    boxHingeDiameter, 
                                    boxHingePinDiameter,
                                    dispenserHoleLength,
                                    dispenserHoleWidth,
                                    dispenserHoleXOffset,
                                    dispenserHoleYOffset,
                                    rollerLength,
                                    boxArcHeight,
                                    boxArcRadius,
                                    booleanOverlap)
                                    {}
                                    
                                    
module CreateControlArm(            controlArmLength,
                                    controlArmHeight,
                                    controlArmThickness,
                                    controlArmPinDiameter,
                                    controlArmHoleZOffset,
                                    controlArmHoleYOffset,
                                    controlArmPinTolerance){

    difference(){
        hull(){
            translate()
                cylinder(d=controlArmHeight, h=controlArmThickness);
            translate([controlArmLength,0,0])
                cylinder(d=controlArmHeight, h=controlArmThickness);
        }//end of hull
        translate([0,0,-controlArmThickness/2])
                #cylinder(d=controlArmPinDiameter, h=controlArmThickness*2, $fn=32);
            translate([controlArmLength,0,-controlArmThickness/2])
                #cylinder(d=controlArmPinDiameter, h=controlArmThickness*2, $fn=32);
    }//end of difference
}//end of module
module CreateControlTrack(          controlArmLength,
                                    controlArmHeight,
                                    controlArmThickness,
                                    controlArmPinDiameter,
                                    controlArmHoleZOffset,
                                    controlArmHoleYOffset,
                                    controlArmPinTolerance,
                                    lidLipHeight,
                                    lidThickness,
                                    lidTolerance,
                                    boxLength, 
                                    boxWidth, 
                                    boxHeight,
                                    boxRoundCorners,
                                    boxCornerRoundness, 
                                    boxHingePinDiameter,
                                    trackPanelLength,
                                    trackPanelWidth,
                                    trackPanelThickness,
                                    trackWidth,
                                    trackLength,
                                    trackHeight,
                                    trackTolerance,
                                    trackControlPoint1X,
                                    trackControlPoint1Y,
                                    trackControlPoint1Z,
                                    trackControlPoint2X,
                                    trackControlPoint2Y,
                                    trackControlPoint2Z,
                                    trackControlPoint3X,
                                    trackControlPoint3Y,
                                    trackControlPoint3Z,
                                    trackControlPoint4X,
                                    trackControlPoint4Y,
                                    trackControlPoint4Z){ 
    union(){                                     
        difference(){
            //Track Panel
            cube([trackPanelLength,trackPanelWidth, trackPanelThickness]);
            //Track 
            hull(){ 
                translate([trackControlPoint1X,trackControlPoint1Y,trackControlPoint1Z - booleanOverlap])
                    cylinder(d=trackWidth+trackTolerance,h = trackPanelThickness + booleanOverlap*2, $fn=32);
                
                translate([trackControlPoint2X,trackControlPoint2Y,trackControlPoint2Z - booleanOverlap])
                    cylinder(d=trackWidth+trackTolerance,h = trackPanelThickness + booleanOverlap*2, $fn=64);
            }
            hull(){ 
                translate([trackControlPoint2X,trackControlPoint2Y,trackControlPoint2Z - booleanOverlap])
                    cylinder(d=trackWidth+trackTolerance,h = trackPanelThickness + booleanOverlap*2, $fn=64);
                
                translate([trackControlPoint3X,trackControlPoint3Y,trackControlPoint3Z - booleanOverlap])
                    cylinder(d=trackWidth+trackTolerance,h = trackPanelThickness + booleanOverlap*2, $fn=64);
            }
            hull(){ 
                translate([trackControlPoint3X,trackControlPoint3Y,trackControlPoint3Z - booleanOverlap])
                    cylinder(d=trackWidth+trackTolerance,h = trackPanelThickness + booleanOverlap*2, $fn=64);
                
                translate([trackControlPoint4X,trackControlPoint4Y,trackControlPoint4Z - booleanOverlap])
                    cylinder(d=trackWidth+trackTolerance,h = trackPanelThickness + booleanOverlap*2, $fn=64);
            }
            //rollerflap pin holes
            translate([trackPanelLength*.14,trackPanelWidth *.07,-booleanOverlap])
                cylinder(d= boxHingePinDiameter, h= trackPanelThickness + booleanOverlap*2, $fn=64);
            translate([trackPanelLength*.9,trackPanelWidth *.14,-booleanOverlap])
                cylinder(d= boxHingePinDiameter, h= trackPanelThickness + booleanOverlap*2, $fn=64);
            
            //Right Side Angle Cut
            translate([trackPanelLength,0,-booleanOverlap]){
                rotate([0,0,45]){
                    cube([trackPanelLength/4,sqrt(pow(trackPanelWidth,2)+pow(trackPanelWidth,2)),trackPanelThickness+booleanOverlap*2]);
                }
            }
            
            //bottom-left corner rounding
           difference(){
                translate([-booleanOverlap,-booleanOverlap,-booleanOverlap])
                cube([trackWidth*2+booleanOverlap*2,trackWidth*2+booleanOverlap*2,trackPanelThickness + booleanOverlap*2]);
                translate([trackWidth,trackWidth,-booleanOverlap])
                    cylinder(r=trackWidth,h=trackPanelThickness + booleanOverlap*2);
                translate([trackWidth*2,-trackWidth,0])
                    rotate([0,0,45])
                        cube([trackWidth*4,trackWidth*4,trackPanelThickness + booleanOverlap*2]);
           }
           //top-left corner cuttoff
           translate([-booleanOverlap,(trackPanelWidth/2) - booleanOverlap, - booleanOverlap])
               rotate([0,0,45])
                   cube([trackPanelWidth + booleanOverlap*2, trackPanelWidth + booleanOverlap*2, trackPanelThickness + booleanOverlap*2]);
           //Top angle cutoff
           translate([-booleanOverlap, (trackPanelWidth * .75) - booleanOverlap, - booleanOverlap])
               rotate([0,0,3])
                   cube([trackPanelLength + booleanOverlap*2, trackPanelWidth + booleanOverlap*2, trackPanelThickness + booleanOverlap*2]);
           //Bottom-right corner rounding
           translate([trackPanelLength-lidTolerance, -booleanOverlap,-booleanOverlap])
                   rotate([0,0,0])
                   cube([trackPanelWidth, trackPanelWidth, trackPanelThickness + booleanOverlap*2]);
           
            
        }//end of difference
    //Connecting tabs
    translate([trackPanelLength*.66,-lidThickness, 0])    
        cube([trackPanelThickness,lidThickness+1,trackPanelThickness]); 
    translate([trackPanelLength*.22, -lidThickness, 0])    
        cube([trackPanelThickness,lidThickness+1,trackPanelThickness]);     
    }//end of union    
}// end of CreateControlTrack module
module CreateRoller(                rollerDiameter,
                                    rollerLength,
                                    rollerPinDiameter){
difference(){
    
    cylinder(d=rollerDiameter, h=rollerLength, $fn=128);                        
    translate([0,0,-2.5])
    cylinder(d=rollerPinDiameter, h=rollerLength +5, $fn=128);
}
}

module CreateLidHinge(              boxRoundCorners,
                                    boxWidth,
                                    boxLength,
                                    boxHeight,
                                    boxHingeDiameter, 
                                    boxHingePinDiameter,  
                                    boxHingeZOffset, 
                                    boxHingeYOffset, 
                                    boxHingeTolerance,
                                    boxHingeClearance,
                                    boxHingeNumberOfSplits, 
                                    pinTolerance,
                                    boxHingeSupportZOffset,
                                    boxHingeSupportYOffset,
                                    lidHingeZOffset,
                                    lidHingeYOffset,
                                    lidHingeXOffset,
                                    lidHingeTolerance,
                                    lidOverlap,
                                    booleanOverlap){
difference(){
    union(){
        //hingepart is created here
        if (boxRoundCorners){
            
            translate([boxLength + lidOverlap/2 + lidTolerance/2 - (boxCornerRoundness*2) + lidHingeXOffset,
                       boxWidth +lidHingeYOffset -(boxCornerRoundness/2) - lidOverlap/2 + lidTolerance/2,
                       (lidThickness)+lidHingeZOffset]){
                //remember rotation is counterclockwise 
                rotate(a=[0,270,0]){
                      cylinder(d=boxHingeDiameter, boxLength - (boxCornerRoundness * 2));
                }
            } 
        } else {
               translate([lidOverlap/2 + lidTolerance/2 +lidHingeXOffset,
                       (boxWidth + lidHingeYOffset + boxHingeDiameter/2),
                       (lidThickness)+lidHingeZOffset ]){
                //remember rotation is counterclockwise 
                    rotate(a=[0,90,0])
                    {
                          cylinder(d=boxHingeDiameter, boxLength);
                    }
                }  
        }
        //add geometry to the hinge here
     }
     
     //hingehole
     if(boxRoundCorners){
         translate([boxLength + lidOverlap/2 + lidTolerance/2 - (boxCornerRoundness*2) + lidHingeXOffset,
                           boxWidth +lidHingeYOffset -(boxCornerRoundness/2) - lidOverlap/2 + lidTolerance/2,
                           (lidThickness)+lidHingeZOffset]){
                    //remember rotation is counterclockwise 
                    rotate(a=[0,270,0]){
                          cylinder(d=boxHingePinDiameter, boxLength*2 +booleanOverlap,center=true);    
                    }
         }
     }else{
          translate([lidOverlap/2 + lidTolerance/2 +lidHingeXOffset +booleanOverlap,
                       (boxWidth + lidHingeYOffset + boxHingeDiameter/2),
                       (lidThickness)+lidHingeZOffset ]){
                //remember rotation is counterclockwise 
                    rotate(a=[0,90,0]){
                          cylinder(d=boxHingePinDiameter, boxLength*2 +booleanOverlap,center=true);    
                    }
         }   
     }
          
        
      //hingeslots
      //here the part to be subtracted from the hinge is created
        if(boxRoundCorners){
                translate([lidOverlap/2 -lidTolerance + lidHingeXOffset,
                               boxWidth +lidHingeYOffset -(boxCornerRoundness/2) - lidOverlap/2 + lidTolerance/2,
                               (lidThickness)+lidHingeZOffset]){
                    rotate(a=[0,90,0])
                       {
                                            for ( i = [0 : boxHingeNumberOfSplits/2] )
                                                {
                                                    
                                                    translate([0, 0, boxLength/boxHingeNumberOfSplits * i *2])
                                                    cylinder(d=boxHingeDiameter+boxHingeTolerance+booleanOverlap + boxHingeClearance, 
                                                            (boxLength/boxHingeNumberOfSplits) + boxHingeTolerance + lidHingeTolerance);
                                                }
                       }
                       
                } 
        }else{
                translate([lidOverlap/2 -lidTolerance + lidHingeXOffset,
                                       boxWidth +lidHingeYOffset  + lidOverlap + lidTolerance,
                                       (lidThickness)+lidHingeZOffset]){
                            rotate(a=[0,90,0])
                               {
                                                    for ( i = [0 : boxHingeNumberOfSplits/2] )
                                                        {
                                                            
                                                            translate([0, 0, boxLength/boxHingeNumberOfSplits * i *2])
                                                            cylinder(d=boxHingeDiameter+boxHingeTolerance+booleanOverlap + boxHingeClearance, 
                                                                    (boxLength/boxHingeNumberOfSplits) + boxHingeTolerance + lidHingeTolerance);
                                                        }
                               }
                               
                }     
        }//end of hinge slots
     
     }//end of difference (hinge, hingehole, hingeslots trackPanelSlots)    
 }//end of module
module CreateHinge(                 boxRoundCorners,
                                    boxWidth,
                                    boxLength,
                                    boxHeight,
                                    boxHingeDiameter, 
                                    boxHingePinDiameter,  
                                    boxHingeZOffset, 
                                    boxHingeYOffset, 
                                    boxHingeTolerance,
                                    boxHingeClearance,
                                    boxHingeNumberOfSplits, 
                                    pinTolerance,
                                    boxHingeSupportZOffset,
                                    boxHingeSupportYOffset,
                                    lidHingeZOffset,
                                    lidHingeYOffset,
                                    lidHingeTolerance,
                                    booleanOverlap){
    
 //Create Hinge and hinge support
    //difference to create hole in hinge and hinge slots
    
    difference(){
       union(){
        //hingepart is created here
        if (boxRoundCorners){
            translate([0,
                       ((boxWidth / 2)+(boxHingeYOffset + (boxHingeDiameter/2))),
                       (boxHeight/2) ]){
                //remember rotation is counterclockwise 
                rotate(a=[0,270,0]){
                      cylinder(d=boxHingeDiameter, boxLength - (boxCornerRoundness * 2),center=true);
                }
            } 
        } else {
               translate([0,
                       ((boxWidth / 2)+(boxHingeYOffset + (boxHingeDiameter/2))),
                       (boxHeight/2) ]){
                //remember rotation is counterclockwise 
                rotate(a=[0,270,0])
                {
                      cylinder(d=boxHingeDiameter, boxLength - (boxCornerRoundness * 2),center=true);
                }
            }  
        }
        //support part is created here, also this part is unioned to the hingepart
        if(boxRoundCorners){
             difference(){
                 translate([0,((boxWidth / 2)+(boxHingeYOffset+boxHingeSupportYOffset)),((boxHeight/2)+boxHingeZOffset)]){
                     rotate(a=[0,270,0]){
                        rotate(a=[0,0,-25]){
                            cylinder(d=boxHingeDiameter*4, (boxLength-(boxCornerRoundness * 2)), $fn=4,center=true);                                   
                        }
                     }
                 }
                 translate([0,boxWidth/4,boxHeight-(boxHeight/4) - booleanOverlap]){
                     //cut for top of hinge support
                     cube([boxLength +booleanOverlap, boxWidth/2, boxHeight/2], ,center=true);
                 }
                 //cut for removing hinge support from inside box
                 cube([boxLength-(booleanOverlap), boxWidth-(booleanOverlap), boxHeight- booleanOverlap],center=true);
             }
         }else{
             difference(){
                 translate([0,((boxWidth / 2)+(boxHingeYOffset+boxHingeSupportYOffset)),((boxHeight/2)+boxHingeZOffset)]){
                     rotate(a=[0,270,0]){
                        rotate(a=[0,0,-25]){
                            cylinder(d=boxHingeDiameter*4, (boxLength), $fn=4,center=true);                                   
                        }
                     }
                 }
                 translate([0,boxWidth/4,boxHeight-(boxHeight/4) - booleanOverlap]){
                     //cut for top of hinge support
                     cube([boxLength +booleanOverlap, boxWidth/2, boxHeight/2], ,center=true);
                 }
                 //cut for removing hinge support from inside box
                 cube([boxLength-booleanOverlap, boxWidth-booleanOverlap, boxHeight-booleanOverlap],center=true);
             }
         }//end of else  end of addition of geomotry
     }
      //hingehole
      translate([0, ((boxWidth / 2) + (boxHingeYOffset+boxHingeDiameter/2)), ((boxHeight/2))]){
                                            rotate(a=[0,-90,0]){
                                               cylinder(d=boxHingePinDiameter, boxLength + booleanOverlap,center=true);    
                                            }
                                        }  
       //hingeslots
       //here the part to be subtracted from the hinge is created 
        translate([0,
                   ((boxWidth / 2)+(boxHingeYOffset + (boxHingeDiameter/2))),
                   ((boxHeight/2))]){
            rotate(a=[0,90,0])
               translate([0,0,(-boxLength/2) ]){
                    for ( i = [0 : boxHingeNumberOfSplits/2] ){
                            
                            translate([0, 0, boxLength/boxHingeNumberOfSplits * i *2])
                            cylinder(d=boxHingeDiameter+boxHingeTolerance+booleanOverlap + boxHingeClearance, 
                                      (boxLength/boxHingeNumberOfSplits) + boxHingeTolerance,
                                       center=true);
                    }
               }
        } //end of hinge slots                                
     }//end of difference (hinge, hingehole, hingeslots)
     
     
    
     
     
    
}//end of Hinge Module
                            
                            
//**********************END OF DECLARATIONS***********************************
if(printItem == 1)
{
  translate([0,0,lidLipHeight + lidThickness])
rotate([0,180,0])
CreateNonArchedLid( lidLipHeight,
                        lidThickness,
                        lidTolerance,
                        lidHingeZOffset,
                        lidHingeYOffset,
                        lidHingeTolerance,
                        lidOverlap,
                        hingeSlotXOffset,
                        hingeSlotYOffset,
                        hingeSlotZOffset,
                        boxLength, 
                        boxWidth, 
                        boxHeight,
                        boxRoundCorners,
                        boxCornerRoundness,
                        boxCornerSmoothness, 
                        boxHingeDiameter, 
                        boxHingePinDiameter,
                        boxHingeNumberOfSplits,
                        dispenserHoleLength,
                        dispenserHoleWidth,
                        dispenserHoleXOffset,
                        dispenserHoleYOffset,
                        rollerLength,
                        trackPanelThickness,
                        booleanOverlap);     
}else if(printItem == 2){ 
    translate([0,0,boxHeight/2])
    if(arched){
    CreateArchedBody(         boxLength, 
                             boxWidth, 
                             boxHeight, 
                             boxBottomThickness, 
                             boxWallThickness, 
                             boxRoundCorners,
                             boxCornerRoundness,
                             boxCornerSmoothness, 
                             boxHingeDiameter, 
                             boxHingePinDiameter,  
                             boxHingeZOffset, 
                             boxHingeYOffset, 
                             boxHingeTolerance,
                             boxHingeClearance,
                             boxHingeNumberOfSplits, 
                             pinTolerance, 
                             controlArmPinDiameter,
                             boxControlArmHoleZOffset,   
                             boxControlArmHoleYOffset,
                             controlArmPinTolerance,
                             boxHingeSupportZOffset,
                             boxHingeSupportYOffset,
                             booleanOverlap,
                             boxArcHeight,
                             boxArcRadius
                             );
}else{                         
   CreateNonArchedBody(          boxLength, 
                                 boxWidth, 
                                 boxHeight, 
                                 boxBottomThickness, 
                                 boxWallThickness, 
                                 boxRoundCorners,
                                 boxCornerRoundness,
                                 boxCornerSmoothness, 
                                 boxHingeDiameter, 
                                 boxHingePinDiameter,  
                                 boxHingeZOffset, 
                                 boxHingeYOffset, 
                                 boxHingeTolerance,
                                 boxHingeClearance,
                                 boxHingeNumberOfSplits, 
                                 pinTolerance, 
                                 controlArmPinDiameter,
                                 boxControlArmHoleZOffset,   
                                 boxControlArmHoleYOffset,
                                 controlArmPinTolerance,
                                 boxHingeSupportZOffset,
                                 boxHingeSupportYOffset,
                                 booleanOverlap,
                                 boxArcHeight,
                                 boxArcRadius);
}    
}else if(printItem == 3){  
 CreateControlTrack(
                            controlArmLength,
                            controlArmHeight,
                            controlArmThickness,
                            controlArmPinDiameter,
                            controlArmHoleZOffset,
                            controlArmHoleYOffset,
                            controlArmPinTolerance,
                            lidLipHeight,
                            lidThickness,
                            lidTolerance,
                            boxLength, 
                            boxWidth, 
                            boxHeight,
                            boxRoundCorners,
                            boxCornerRoundness,
                            boxHingePinDiameter,
                            trackPanelLength,
                            trackPanelWidth,
                            trackPanelThickness,
                            trackWidth,
                            trackLength,
                            trackHeight,
                            trackTolerance,
                            trackControlPoint1X,
                            trackControlPoint1Y,
                            trackControlPoint1Z,
                            trackControlPoint2X,
                            trackControlPoint2Y,
                            trackControlPoint2Z,
                            trackControlPoint3X,
                            trackControlPoint3Y,
                            trackControlPoint3Z,
                            trackControlPoint4X,
                            trackControlPoint4Y,
                            trackControlPoint4Z);    
}else if(printItem == 4){ 
    CreateControlArm(                   controlArmLength,
                                            controlArmHeight,
                                            controlArmThickness,
                                            controlArmPinDiameter,
                                            controlArmHoleZOffset,
                                            controlArmHoleYOffset,
                                            controlArmPinTolerance);
}else if(printItem == 5){
  CreateRoller(rollerDiameter,
                                    rollerLength,
                                    rollerPinDiameter);  
}else if(printItem == 6){ 
    if(arched){
    CreateArchedBody(         boxLength, 
                             boxWidth, 
                             boxHeight, 
                             boxBottomThickness, 
                             boxWallThickness, 
                             boxRoundCorners,
                             boxCornerRoundness,
                             boxCornerSmoothness, 
                             boxHingeDiameter, 
                             boxHingePinDiameter,  
                             boxHingeZOffset, 
                             boxHingeYOffset, 
                             boxHingeTolerance,
                             boxHingeClearance,
                             boxHingeNumberOfSplits, 
                             pinTolerance, 
                             controlArmPinDiameter,
                             boxControlArmHoleZOffset,   
                             boxControlArmHoleYOffset,
                             controlArmPinTolerance,
                             boxHingeSupportZOffset,
                             boxHingeSupportYOffset,
                             booleanOverlap,
                             boxArcHeight,
                             boxArcRadius
                             );
}else{                         
   CreateNonArchedBody(          boxLength, 
                                 boxWidth, 
                                 boxHeight, 
                                 boxBottomThickness, 
                                 boxWallThickness, 
                                 boxRoundCorners,
                                 boxCornerRoundness,
                                 boxCornerSmoothness, 
                                 boxHingeDiameter, 
                                 boxHingePinDiameter,  
                                 boxHingeZOffset, 
                                 boxHingeYOffset, 
                                 boxHingeTolerance,
                                 boxHingeClearance,
                                 boxHingeNumberOfSplits, 
                                 pinTolerance, 
                                 controlArmPinDiameter,
                                 boxControlArmHoleZOffset,   
                                 boxControlArmHoleYOffset,
                                 controlArmPinTolerance,
                                 boxHingeSupportZOffset,
                                 boxHingeSupportYOffset,
                                 booleanOverlap,
                                 boxArcHeight,
                                 boxArcRadius);
}    


 if(boxRoundCorners){
     rotate([270,0,0])
      union(){
        translate([-boxLength/2 - lidTolerance/2 - lidOverlap/2 + boxCornerRoundness,
                   -boxWidth/2  - lidTolerance/2 - lidOverlap/2 + boxCornerRoundness -52.7,
                   (boxHeight/2)+ booleanOverlap-lidLipHeight+33.5]){
            CreateLidHinge(  boxRoundCorners,
                     boxWidth,
                     boxLength,
                     boxHeight,
                     boxHingeDiameter, 
                     boxHingePinDiameter,  
                     boxHingeZOffset, 
                     boxHingeYOffset, 
                     boxHingeTolerance,
                     boxHingeClearance,
                     boxHingeNumberOfSplits, 
                     pinTolerance,
                     boxHingeSupportZOffset,
                     boxHingeSupportYOffset,
                     lidHingeZOffset,
                     lidHingeYOffset,
                     lidHingeXOffset,
                     lidHingeTolerance,
                     lidOverlap,
                     booleanOverlap);  
                 
        CreateNonArchedLid( lidLipHeight,
                        lidThickness,
                        lidTolerance,
                        lidHingeZOffset,
                        lidHingeYOffset,
                        lidHingeTolerance,
                        lidOverlap,
                        hingeSlotXOffset,
                        hingeSlotYOffset,
                        hingeSlotZOffset,
                        boxLength, 
                        boxWidth, 
                        boxHeight,
                        boxRoundCorners,
                        boxCornerRoundness,
                        boxCornerSmoothness, 
                        boxHingeDiameter, 
                        boxHingePinDiameter,
                        boxHingeNumberOfSplits,
                        dispenserHoleLength,
                        dispenserHoleWidth,
                        dispenserHoleXOffset,
                        dispenserHoleYOffset,
                        rollerLength,
                        trackPanelThickness,
                        booleanOverlap); 
                        
                        
                     translate([boxCornerRoundness/2 +lidTolerance/2,0,lidThickness+booleanOverlap]){
                     rotate([270,0,90]){ 
                     CreateControlTrack(
                            controlArmLength,
                            controlArmHeight,
                            controlArmThickness,
                            controlArmPinDiameter,
                            controlArmHoleZOffset,
                            controlArmHoleYOffset,
                            controlArmPinTolerance,
                            lidLipHeight,
                            lidThickness,
                            lidTolerance,
                            boxLength, 
                            boxWidth, 
                            boxHeight,
                            boxRoundCorners,
                            boxCornerRoundness,
                            boxHingePinDiameter,
                            trackPanelLength,
                            trackPanelWidth,
                            trackPanelThickness,
                            trackWidth,
                            trackLength,
                            trackHeight,
                            trackTolerance,
                            trackControlPoint1X,
                            trackControlPoint1Y,
                            trackControlPoint1Z,
                            trackControlPoint2X,
                            trackControlPoint2Y,
                            trackControlPoint2Z,
                            trackControlPoint3X,
                            trackControlPoint3Y,
                            trackControlPoint3Z,
                            trackControlPoint4X,
                            trackControlPoint4Y,
                            trackControlPoint4Z); 
                      translate([0,0,-dispenserHoleLength -trackPanelThickness])
                     CreateControlTrack(
                            controlArmLength,
                            controlArmHeight,
                            controlArmThickness,
                            controlArmPinDiameter,
                            controlArmHoleZOffset,
                            controlArmHoleYOffset,
                            controlArmPinTolerance,
                            lidLipHeight,
                            lidThickness,
                            lidTolerance,
                            boxLength, 
                            boxWidth, 
                            boxHeight,
                            boxRoundCorners,
                            boxCornerRoundness,
                            boxHingePinDiameter,
                            trackPanelLength,
                            trackPanelWidth,
                            trackPanelThickness,
                            trackWidth,
                            trackLength,
                            trackHeight,
                            trackTolerance,
                            trackControlPoint1X,
                            trackControlPoint1Y,
                            trackControlPoint1Z,
                            trackControlPoint2X,
                            trackControlPoint2Y,
                            trackControlPoint2Z,
                            trackControlPoint3X,
                            trackControlPoint3Y,
                            trackControlPoint3Z,
                            trackControlPoint4X,
                            trackControlPoint4Y,
                            trackControlPoint4Z); 
                        }
                    }   
                    }//end of Translate
                }//end of union

 }else{
    translate([-boxLength/2 - lidTolerance/2 - lidOverlap/2,
               -boxWidth/2  - lidTolerance/2 - lidOverlap/2,
               (boxHeight/2)+ booleanOverlap-lidLipHeight]){
           
           
CreateNonArchedLid( lidLipHeight,
                    lidThickness,
                    lidTolerance,
                    lidHingeZOffset,
                    lidHingeYOffset,
                    lidHingeTolerance,
                    lidOverlap,
                    hingeSlotXOffset,
                    hingeSlotYOffset,
                    hingeSlotZOffset,
                    boxLength, 
                    boxWidth, 
                    boxHeight,
                    boxRoundCorners,
                    boxCornerRoundness,
                    boxCornerSmoothness, 
                    boxHingeDiameter, 
                    boxHingePinDiameter,
                    boxHingeNumberOfSplits,
                    dispenserHoleLength,
                    dispenserHoleWidth,
                    dispenserHoleXOffset,
                    dispenserHoleYOffset,
                    rollerLength,
                    trackPanelThickness,
                    booleanOverlap);   
               }
     }                                   
   
 


translate([-39.25,3,3.5])
    rotate([0,270,0])
        rotate([0,0,44])
        CreateControlArm(                   controlArmLength,
                                            controlArmHeight,
                                            controlArmThickness,
                                            controlArmPinDiameter,
                                            controlArmHoleZOffset,
                                            controlArmHoleYOffset,
                                            controlArmPinTolerance);
translate([44.25,3,3.5])
    rotate([0,270,0])
        rotate([0,0,44])
        CreateControlArm(                   controlArmLength,
                                            controlArmHeight,
                                            controlArmThickness,
                                            controlArmPinDiameter,
                                            controlArmHoleZOffset,
                                            controlArmHoleYOffset,
                                            controlArmPinTolerance);  
rotate([0,90,0]) 
translate([-31,29,-rollerLength/2])
CreateRoller(rollerDiameter,
                                    rollerLength,
                                    rollerPinDiameter); 


rotate([270,0,0])
    
        translate([-boxLength/2 - lidTolerance/2 - lidOverlap/2 + boxCornerRoundness,
                   -boxWidth/2  - lidTolerance/2 - lidOverlap/2 + boxCornerRoundness -52.7,
                   (boxHeight/2)+ booleanOverlap-lidLipHeight+33.5]){
            
                 
        CreateNonArchedLid( lidLipHeight,
                        lidThickness,
                        lidTolerance,
                        lidHingeZOffset,
                        lidHingeYOffset,
                        lidHingeTolerance,
                        lidOverlap,
                        hingeSlotXOffset,
                        hingeSlotYOffset,
                        hingeSlotZOffset,
                        boxLength, 
                        boxWidth, 
                        boxHeight,
                        boxRoundCorners,
                        boxCornerRoundness,
                        boxCornerSmoothness, 
                        boxHingeDiameter, 
                        boxHingePinDiameter,
                        boxHingeNumberOfSplits,
                        dispenserHoleLength,
                        dispenserHoleWidth,
                        dispenserHoleXOffset,
                        dispenserHoleYOffset,
                        rollerLength,
                        trackPanelThickness,
                        booleanOverlap);    
                    }//end of Translate
         
}else{
   translate([0,0,lidLipHeight + lidThickness])
rotate([0,180,0])
CreateNonArchedLid( lidLipHeight,
                        lidThickness,
                        lidTolerance,
                        lidHingeZOffset,
                        lidHingeYOffset,
                        lidHingeTolerance,
                        lidOverlap,
                        hingeSlotXOffset,
                        hingeSlotYOffset,
                        hingeSlotZOffset,
                        boxLength, 
                        boxWidth, 
                        boxHeight,
                        boxRoundCorners,
                        boxCornerRoundness,
                        boxCornerSmoothness, 
                        boxHingeDiameter, 
                        boxHingePinDiameter,
                        boxHingeNumberOfSplits,
                        dispenserHoleLength,
                        dispenserHoleWidth,
                        dispenserHoleXOffset,
                        dispenserHoleYOffset,
                        rollerLength,
                        trackPanelThickness,
                        booleanOverlap);   
                        
 translate([-boxLength/2 + boxCornerRoundness,-boxWidth *.7,boxHeight/2])
    if(arched){
    CreateArchedBody(         boxLength, 
                             boxWidth, 
                             boxHeight, 
                             boxBottomThickness, 
                             boxWallThickness, 
                             boxRoundCorners,
                             boxCornerRoundness,
                             boxCornerSmoothness, 
                             boxHingeDiameter, 
                             boxHingePinDiameter,  
                             boxHingeZOffset, 
                             boxHingeYOffset, 
                             boxHingeTolerance,
                             boxHingeClearance,
                             boxHingeNumberOfSplits, 
                             pinTolerance, 
                             controlArmPinDiameter,
                             boxControlArmHoleZOffset,   
                             boxControlArmHoleYOffset,
                             controlArmPinTolerance,
                             boxHingeSupportZOffset,
                             boxHingeSupportYOffset,
                             booleanOverlap,
                             boxArcHeight,
                             boxArcRadius
                             );
}else{                         
   CreateNonArchedBody(          boxLength, 
                                 boxWidth, 
                                 boxHeight, 
                                 boxBottomThickness, 
                                 boxWallThickness, 
                                 boxRoundCorners,
                                 boxCornerRoundness,
                                 boxCornerSmoothness, 
                                 boxHingeDiameter, 
                                 boxHingePinDiameter,  
                                 boxHingeZOffset, 
                                 boxHingeYOffset, 
                                 boxHingeTolerance,
                                 boxHingeClearance,
                                 boxHingeNumberOfSplits, 
                                 pinTolerance, 
                                 controlArmPinDiameter,
                                 boxControlArmHoleZOffset,   
                                 boxControlArmHoleYOffset,
                                 controlArmPinTolerance,
                                 boxHingeSupportZOffset,
                                 boxHingeSupportYOffset,
                                 booleanOverlap,
                                 boxArcHeight,
                                 boxArcRadius);
}  
rotate([0,0,90]){
translate([0,-boxLength/5,0])
CreateControlTrack(
                            controlArmLength,
                            controlArmHeight,
                            controlArmThickness,
                            controlArmPinDiameter,
                            controlArmHoleZOffset,
                            controlArmHoleYOffset,
                            controlArmPinTolerance,
                            lidLipHeight,
                            lidThickness,
                            lidTolerance,
                            boxLength, 
                            boxWidth, 
                            boxHeight,
                            boxRoundCorners,
                            boxCornerRoundness,
                            boxHingePinDiameter,
                            trackPanelLength,
                            trackPanelWidth,
                            trackPanelThickness,
                            trackWidth,
                            trackLength,
                            trackHeight,
                            trackTolerance,
                            trackControlPoint1X,
                            trackControlPoint1Y,
                            trackControlPoint1Z,
                            trackControlPoint2X,
                            trackControlPoint2Y,
                            trackControlPoint2Z,
                            trackControlPoint3X,
                            trackControlPoint3Y,
                            trackControlPoint3Z,
                            trackControlPoint4X,
                            trackControlPoint4Y,
                            trackControlPoint4Z); 
                          
 translate([-80,-boxLength/5,0])                         
                            CreateControlTrack(
                            controlArmLength,
                            controlArmHeight,
                            controlArmThickness,
                            controlArmPinDiameter,
                            controlArmHoleZOffset,
                            controlArmHoleYOffset,
                            controlArmPinTolerance,
                            lidLipHeight,
                            lidThickness,
                            lidTolerance,
                            boxLength, 
                            boxWidth, 
                            boxHeight,
                            boxRoundCorners,
                            boxCornerRoundness,
                            boxHingePinDiameter,
                            trackPanelLength,
                            trackPanelWidth,
                            trackPanelThickness,
                            trackWidth,
                            trackLength,
                            trackHeight,
                            trackTolerance,
                            trackControlPoint1X,
                            trackControlPoint1Y,
                            trackControlPoint1Z,
                            trackControlPoint2X,
                            trackControlPoint2Y,
                            trackControlPoint2Z,
                            trackControlPoint3X,
                            trackControlPoint3Y,
                            trackControlPoint3Z,
                            trackControlPoint4X,
                            trackControlPoint4Y,
                            trackControlPoint4Z); 
   
   
    }
rotate([0,0,90]){
    translate([20,-40,0])
CreateControlArm(                   controlArmLength,
                                            controlArmHeight,
                                            controlArmThickness,
                                            controlArmPinDiameter,
                                            controlArmHoleZOffset,
                                            controlArmHoleYOffset,
                                            controlArmPinTolerance);    
  translate([-60,-40,0])  
CreateControlArm(                   controlArmLength,
                                            controlArmHeight,
                                            controlArmThickness,
                                            controlArmPinDiameter,
                                            controlArmHoleZOffset,
                                            controlArmHoleYOffset,
                                            controlArmPinTolerance);    
    
}
translate([40,0,0])
CreateRoller(rollerDiameter,
                                    rollerLength,
                                    rollerPinDiameter); 

}   
    
    


