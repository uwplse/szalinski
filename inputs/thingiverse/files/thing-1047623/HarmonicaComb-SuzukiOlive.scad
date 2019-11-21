//Harmonica Comb Builder

/*[Global]*/
WhatToShow=0;//[0:Comb Only, 1:Assembled, 2:Exploded,3:2D Slice (for DXF export),4:Hole Test Piece (to set HoleOversize)]
//Slice to 2D is for DXF export. (for laser cutting) 
//**Slicing is VERY SLOW**, do it when design is finalised. 
//Export DXF from menu File->Export->export to DXF .


/*[View]*/
ShowReedPlates=1;//[1:Show,0:hide]
ShowScrews=1;//[1:Show,0:hide]

//Slice to 2D for DXF export. **Slicing is VERY SLOW** .
//ShowSlice=0;//[0:3D,1:2D]
//--------- Printer Specific ---------------------
//HoleOversize corrects for 3D printer making holes the wrong size - too big or small. This is printer specific, and is diameter.+ve make holes bigger
HoleOS=0.1;
//---------- Harmonica Specific BEGINS ------
//Enter Harmonica Name (does nothing)
HarmonicaType="Suzuki Olive";

//minimum wall thickness around holes. For holes through slot dividers that need thickening
ScrewHoleWall=1;

/*[Comb]*/

FlushReedPlates=1; //[0:Recessed Into Comb,1:Flush ON Comb]
//Length of Comb
L=100.5;
//Width of Comb
W=26.8;
//Thickness of Comb
T=6.3;
//Radius of outer corners of comb
CornerR=3;

/*[Cover]*/
//Measure outside edge of cover hole to side of comb
CoverHoleXEdge=4.3;
//Measure front edge of cover hole to front of comb
CoverHoleYEdge=10.8;

//Diameter of cover holes measured in comb for CoverHoleXEdge
CoverHoleD=4;

//Diameter to make cover holes in your comb
CoverScrewHoleD=4;


/*[Slots]*/

//When reedplate recesses are used,can cut through lip 
FullSlots=0; //[0:Has Lip,1: No Lip]

//Not measuring Width and Pitch as too hard to measure accurately.
//Measured at opening end. 
//SlotWidth=4.25;
//Spacing of slots. (0 or -ve to use Total)
//SlotPitch=-10;

//Measured at opening end.
SlotDivider=3.2;

//Total distance across all slots to outer edges
SlotPitchTotalOuter=71.3;

//Left to right. Either have 2 values - it will interpolate, or all (10) values 
SlotDepths=[23.2,22.4,21.6,20.8,20,    19.2,18.4,17.6,16.8,16];
//SlotDepths=[25,24,23,22,21,20,19,18,17,16];
//Diatonic Harps have 10 holes
NumSlots=10;
//Radius of outside corner of slot (against tongue)
SlotR=1;
//inner corner radius - makes it a bit nore cleanable
SlotInnerR=2;

/*[Reeds]*/

//Actual ReedPlate dimension
ReedPlateX=100.8;
ReedPlateY=27.2;
//Depth of Reedplate recess into comb
ReedPlateZ=0.93;

//Offset to front edge of ReedPlate (-ve if reedplate bigger than comb
ReedPlateY1=-0.2;
//Make the recess this much bigger than the plate
RecessOversize=1;
//adjust reedplate sideways if not perfectly centred 
ReedPlateXOffset=0;

//Radius reedplate corners 
ReedPlateR=2;

//Hole size in comb for reedplate screws (Main hole size)
ReedScrewHoleD=2.6;
//Size of holes in reedplate itself (used to offset Pos measurements)
ReedPlateScrewHoleD=2.2;
//x,y pairs. Measure from left and front of holes to edge of reedplate (not centres)
ReedScrewPos=[[9.6,5.8],[9.6,17.8],[26.9,22.8],[49.4,22.8] ,[71.9,19.3],[89,5.8],[89,17.8]];

//Hole size in comb for reedplate screws (2nd hole size)
ReedScrewHoleD2=2.1;
//Size of holes in reedplate itself (2nd hole size) 
ReedPlateScrewHoleD2=2.2;
//x,y pairs. (2nd hole size)
ReedScrewPos2=[[49.4,5.8]];
//---------- Harmonica Specific ENDS ------

/*[Hidden]*/ 
//----------------------
ShowExploded=(WhatToShow==2);
//FlushReedPlate=(RecessedReedPlate==0;
NumReedScrews=len(ReedScrewPos);
ReedScrewR=ReedScrewHoleD/2;

NumReedScrews2=len(ReedScrewPos2);
ReedScrewR2=ReedScrewHoleD2/2;

ReedPlateX1=(L-ReedPlateX)/2 + ReedPlateXOffset;
CoverHoleR=CoverHoleD/2;
CoverScrewHoleR=CoverScrewHoleD/2;
CoverHoleX=CoverHoleXEdge+CoverHoleR;
CoverHoleY=CoverHoleYEdge+CoverHoleR;
CoverHolePitch=L- 2*CoverHoleX;

//if (SlotPitch<1) {
NumWalls=NumSlots-1;
SlotPitch=(SlotPitchTotalOuter+SlotDivider)/NumSlots;
SlotWidth=(SlotPitchTotalOuter-(SlotDivider*NumWalls)) /NumSlots;

//SlotDivider=(SlotPitchTotalOuter-(SlotWidth*NumSlots)) /NumWalls;
//SlotPitch=(SlotPitchTotalOuter+SlotWall)/NumSlots;
//}
Slot1X=(L - ((NumSlots-1)*SlotPitch))/2;//centre of 1st slot
SlotT=T-ReedPlateZ*2;

//---- show some messages to console
echo("SlotPitch (calc) is:", SlotPitch, " NumSlots:", NumSlots);
echo("Outer-Distance between outside walls of outer slots (calc) is:", (NumSlots * SlotPitch) - SlotDivider , " given is:",SlotPitchTotalOuter);
echo("Divider between slots (calc) is:", SlotPitch-SlotWidth, "  given:", SlotDivider);
echo("Slot Width (calc) is:", SlotWidth);
if (len(SlotDepths)!=2 && len(SlotDepths)!=NumSlots) {echo("ERROR: SlotDepths has ",len(SlotDepths)," elements not  ",NumSlots);}
//---------------------------
//Main
  if (WhatToShow<=2) {
      Comb();
     //Visualise screws and plates
      if (WhatToShow!=0 && ShowReedPlates) {
          color("gold")
          if (ShowExploded) {
                    translate([0,0,-2*T]) ReedPlates(0,Plates=[-1]);
              translate([0,0,2*T]) ReedPlates(0,Plates=[1]);
                } else {
                    ReedPlates(0);
                }
          }//if
      if (WhatToShow!=0 && ShowScrews) {
          color("red") 
            if (ShowExploded) {
                    translate([0,0,4*T])
                        Holes();
                } else {
                    Holes();}
                }
     
  } 
  if (WhatToShow==3) { //2D Slice
      projection(cut = true) translate([0,0,-T/2])Comb();
  } 
  if (WhatToShow==4) {
     TestHoles();
  }
//--------------------------
  TestH=3;
  font="Liberation Sans:style=Bold";
  fontsize=6;
 module TestHoles() {
     $fn=16;
     difference() {
        color("green") rcube([20,10,TestH], r=3);
        translate([5,5,-0.1]) 
            cylinder(r=CoverScrewHoleR+HoleOS/2,h=TestH+1);
        translate([15,5,-0.1])
            cylinder(r=ReedScrewR+HoleOS/2,h=TestH+1);
     }
     color("red") translate([2,12,0]) 
        linear_extrude(height = 0.5) {
             translate([2.5,0,0]) text(text = str(2*CoverScrewHoleR), font = font, size = fontsize, halign="center");
             translate([12.5,0,0]) text(text = str(2*ReedScrewR), font = font, size = fontsize, halign="center");
     }

     }     
 module Comb(){
 difference() {
     color("cyan") union(){
        difference(){
            rcube([L,W,T],r=CornerR); //make the comb block        
            //cut out Slots 
            translate([0,-0.05,-0.05]) 
                for (i=[0:NumSlots-1]) { // for each slot
                    translate([Slot1X+ i*SlotPitch,-0.01,0])
                    if (len(SlotDepths)>2) {
                        Slot2(SlotDepths[min(i,len(SlotDepths)-1)]);
                    } else { //start and end values given so interpolate
                        Slot2(i*(SlotDepths[1]-SlotDepths[0])/NumSlots + SlotDepths[0]);
                    }
                }//for
        }//diff
        //now add in the thickened screw hole walls
        Holes(HoleZ=T, HoleZOffset=0, OS=ScrewHoleWall );
    } //union

     //cut Reed plate Recesses
    if (FlushReedPlates!=1) { 
        ReedPlates(RecessOversize);
    }
    //cut holes
    Holes();  

}//diff
}
module ReedPlates(RecessOversize,Plates=[-1,1]) {
  difference() {  
  for (i=Plates) //i=[0,1]
    translate([ReedPlateX1-RecessOversize,
        ReedPlateY1-RecessOversize,
   (T-ReedPlateZ)/2+ i*(T/2-ReedPlateZ/2) + i*ReedPlateZ*FlushReedPlates -0.05])
 //       i*(T-ReedPlateZ) -0.05])
        rcube([ReedPlateX+2*RecessOversize,        ReedPlateY+2*RecessOversize,
            ReedPlateZ+0.1],r=ReedPlateR);
    Holes();
      }//diff
    }
  

//HoleZOffset=ReedPlateZ+1;
//HoleZ=T+2*HoleZOffset; 
  
module Holes( HoleZOffset=ReedPlateZ+1, HoleZ=T+2*(ReedPlateZ+1), OS=HoleOS/2 ) {
    $fn=16;
    translate([0,0,-HoleZOffset]) {
    //Cover Holes   
    for (i=[0,1]) {
        translate([CoverHoleX+ CoverHolePitch*i,CoverHoleY,0])
        cylinder(r=CoverScrewHoleR+OS,h=HoleZ);
    }//for
    
    //ReedPlateScrews
    for (i=[0:NumReedScrews-1]) {
        translate([0,0,-0.1])
        translate(ReedScrewPos[i]+[ReedPlateX1,ReedPlateY1]+[ReedPlateScrewHoleD/2,ReedPlateScrewHoleD/2]) 
        cylinder(r=ReedScrewR+OS,h=HoleZ);
        }//for
     for (i=[0:NumReedScrews2-1]) {
        translate([0,0,-0.1])
        translate(ReedScrewPos2[i]+[ReedPlateX1,ReedPlateY1]+[ReedPlateScrewHoleD2/2,ReedPlateScrewHoleD2/2]) 
        cylinder(r=ReedScrewR2+OS,h=HoleZ);
        }//for
    
    }    
    }
module rcube(size, r) {
    translate(size/2){
        cube(size - [2*r,0,0], true);
        cube(size - [0,2*r,0], true);
        for (x = [r-size[0]/2, -r+size[0]/2],  y = [r-size[1]/2, -r+size[1]/2]) {
            translate([x,y,0]) cylinder(r=r, h=size[2], center=true);
            }
    }
}          
module Fillet(r,h=T+0.2, $fn=16){
    difference(){
            translate([-r,0,0]) cube([r,r,h]); //make a cube of 1 quarter sector
            translate([-r,r,-0.01])
                cylinder(r=r,h=h+0.2); //cube cylinder out of it
        }
    }
    
module Slot2(SlotDepth){ //switch if full slots
    if ((FullSlots==1) || FlushReedPlates || (ReedPlateZ<0.1)) {
        Slot(SlotDepth, H=T+0.1); 
    } else { 
        translate([0,0,ReedPlateZ])
            Slot(SlotDepth,H=SlotT);
    }
    }
//module Fillet2(){Fillet(r=SlotInnerR, h=9+0.2);}    
module Slot(SlotDepth, H) {
    difference() {
        translate([-SlotWidth/2,0,0])
            cube([SlotWidth,SlotDepth,H+0.1]);
        translate([0,SlotDepth,-0.05])
            for (i=[0,1]) mirror([-i,0,0]) 
                translate([-SlotWidth/2-0.1,0.1,0])
                    rotate([0,0,180])
                       Fillet(r=SlotInnerR, h=H+0.2);
    }
    //Outer face radius vertical
    for (i=[0,1])
       //translate([0,SlotR/2]) 
        mirror([i,0,0]) 
            translate([-SlotWidth/2,0,-SlotR/2])           Fillet(r=SlotR, h=H+SlotR);
    //Outer face radius horizontal
    for (i=[0,1])
       translate([SlotWidth/2 +SlotR/2,0,H/2]) 
        mirror([0,0,i]) 
            translate([0,0,-H/2])
    rotate([0,-90,0])
                Fillet(r=SlotR, h=SlotWidth+SlotR);
    }//diff
    
    