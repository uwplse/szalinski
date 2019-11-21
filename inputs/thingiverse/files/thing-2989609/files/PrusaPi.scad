//===========================================================================
//
// PrusaPi Pi case for Prusa MK3 https: 
//
// This part was designed 24 November 1017 by Joe McKeown. 
// It's available under the terms of the Creative Commons CC-BY license 
// (https://creativecommons.org/licenses/by/3.0/).
// 
// History:
// V1.0 24 NOV 1017 First version
//===========================================================================

// Also needed: 
//    1x M4 T-nut for 30x30 extrusion
//    1x M4x10 Cap (or pan head) screw.
//    2x M3 Square nuts (check the Prusa's spares bag)
//    2x M3x 8MM cap screws (up to 12mm length should work)
//
// Be sure to look for drop-in T-nuts, or the frame will need to be dissambled.
// I wouldn't necessarily recommend buying all of the following, because the
// kits contain too many parts for this project, but for reference I build my
// Pi case by pulling from the folloing products: 
// https://www.amazon.com/gp/product/B0785PJZTP - M4 T-nuts for 30x30.
// https://www.amazon.com/gp/product/B015A351WS - M4x10 Cap screws
// https://www.amazon.com/gp/product/B018503K94 - M3 Square nuts.
// https://www.amazon.com/gp/product/B072FKMYMF - M3 Cap screw kit (various lenghts)

/* [Options] */
// Which part to build
Part="both"; // [base:Bottom, lid:Cover, both:Both]
//Include Mount for 30x30 extrusion
Extrusion_Mount="Yes"; // [Yes, No] 
// Include Slot for Camera Cable
Include_Camera_Slot="No"; // [Yes, No] 

/* [Hidden] */
// Customizer does not do booleans. Really??
cameraSlot= (Include_Camera_Slot == "Yes") ? true : false; 
mount3030= (Extrusion_Mount == "Yes") ? true : false; 
epsilon=0.01;
baseGap=3.25;
PCBThick=1.3;
baseThick=1.25;
totalHeight=21.5;//20.2;
baseHeight=15;
mountHeight=10;
topHeight=totalHeight-baseHeight;
topToBoard=totalHeight-baseGap-PCBThick;
rimHeight=topToBoard-6.5;

bracketOffset=65;

PCBBase=baseGap+PCBThick;

BoardSize=[85,56];
PostCenters = [
  [ 3.5,  3.5],
  [ 3.5, 52.5],
  [61.5,  3.5],
  [61.5, 52.5]
  ];

function addvec(v, av) = (len(v) == len(av)) ? [ for (i = [ 0 : len(v)-1 ]) v[i] + av[i] ] : [0,0,0]; 
  
module m3_CapScrew(placement, orientation, length, cap=true,
cap_ht=3.25, cap_diameter=5.5, body_diameter=3.1){
  epsilon=0.01;
  translate(placement)
  rotate(orientation)
  if (cap) {
    union(){
      translate([0,0,-length-cap_ht+epsilon])
        cylinder(d=body_diameter, h=length+epsilon, $fn=30);
      translate([0,0,-cap_ht])
        cylinder(d=cap_diameter, h=cap_ht+epsilon, $fn=30);
    }
  } else {
    translate([0,0,-length+epsilon])
      cylinder(d=body_diameter, h=length+epsilon, $fn=30);
  }
}

module m3_SquareSlot(placement, orientation, length){
  //Increase these if tolerance is too tight.
  nut_ht=2.15;//2.0 actually
  nut_width=5.65;//5.5 actually
  
  translate(placement)
  rotate(orientation)
  translate([-nut_width/2,(nut_width/2)-length,-nut_ht])
    cube([nut_width, length, nut_ht]);
}


module outline(r=3){   
   hull()
   for (point=[[3,3],[3,53],[82,3],[82,53]]){
     translate(point) circle(r, $fn=50);
   }
 }
 
module posts(r, h){
  for (point=PostCenters){
    translate(point)
      cylinder(r=r, h=h);
  }
}

module cardSlot(){
  slotWidth=15;
  y=(BoardSize[1]-slotWidth)/2;
  translate([-5,y,-epsilon])
    cube([7, slotWidth, baseGap+epsilon]);
}

module powerSlotB(){
  //height is 3;
  translate([6.7, -5, PCBBase-0.2])
  cube([7.8, 10, 15]);
}

module powerSlotT(){
  //height is 3;
  translate([6.7, BoardSize[1]-0.5, 0])
  cube([7.8, 2.5, topToBoard - 3]);
}

module HDMISlotB(){
  //height is 6.5;
  translate([24.45, -5, PCBBase+1])
  cube([15.1, 10, 10]);
}

module HDMISlotT(){
  //height is 6.5;
  translate([24.45, BoardSize[1]-0.5, 0])
  cube([15.1, 2.5, topToBoard-6.75]);
}

module AudioSlotB(){
  radius=3.25;
  //height is 6.0;
  translate([53.5-radius, -5, PCBBase])
  union(){
  translate([0, 0, radius])
    cube([6.5, 7, 10]);
  translate([radius, 0, radius])
    rotate([-90,0,0])
      cylinder(r=radius, h=7, $fn=30);
  }
}

module AudioSlotT(){
  radius=3.25;
  //height is 6.0;
  zOffset=totalHeight-radius-baseGap-PCBThick;
  translate([53.5-radius, BoardSize[1]-0.5, 0])
  
  difference(){
  translate([0, 0, 0])
    cube([6.5, 2.5, zOffset]);
  translate([radius, -2, zOffset])
    rotate([-90,0,0])
      cylinder(r=radius, h=5, $fn=30);
  }
}

module EthSlotB(){
  //height is 13.5;
  JackWidth=16;
  translate([BoardSize[0]-5, 2.25, PCBBase])
  cube([10, JackWidth, 15]);
}

module EthSlotT(){
  //height is 13.5;
  JackWidth=16;
  //centerY=
  y=(BoardSize[1] - 2.25 - JackWidth);
  translate([BoardSize[0]-20, y, baseThick+ 2.0])
  cube([30, JackWidth, 15]);
  translate([BoardSize[0]-20, y, baseThick])
  cube([19.5, JackWidth, 2.5]);
}

module USBSlotB(centerY){
  //height is 16;
  JackWidth=13.35;
  translate([BoardSize[0]-5, centerY-(JackWidth/2), PCBBase+0.5])
  cube([10, JackWidth, 15]);
}

module USBSlotT(centerY){
  //height is 16;
  JackWidth=13.35;
  y=(BoardSize[1] - centerY) - (JackWidth/2);
  translate([BoardSize[0]-20, y, baseThick])
  cube([30, JackWidth, 15]);
}

module LEDs(){
  translate([-5, 7.9, baseGap+PCBThick+1])rotate([0,90,0])
    cylinder(r=1.2, h=10, $fn=20);
  translate([-5, 11.5, baseGap+PCBThick+1])rotate([0,90,0])
    cylinder(r=1.2, h=10, $fn=20);
}

/*
Bracket 1 is common is the profile for attaching the case to the 
frame with a T-nut
 */
module bracket1Common(height=baseHeight){
  verticalM3Pos=[-4.5, -4.5, 0];
  wallThickness=2;
  overlap=abs(verticalM3Pos[0])-wallThickness; 
  m3Outer=9;
  linear_extrude(height)
    difference(){
      union(){
          translate([-21, -2, 0])
            square([21, 4]);
          translate([0, 0, 0])
            square([10, 2]);
          translate([-2,-13,0])
            square([2, 11]);
          translate(addvec(verticalM3Pos, [0,-m3Outer/2-overlap,0]))
            square([m3Outer/2, m3Outer/2+overlap]);
          translate(addvec(verticalM3Pos, [-m3Outer/2-overlap,0,0]))
            square([m3Outer/2+overlap,m3Outer/2]);
          translate(verticalM3Pos)
            circle(d=m3Outer, $fn=50);
        }
      translate(addvec(verticalM3Pos, [0,-m3Outer/2-overlap,0]))
        circle(r=overlap, $fn=50);
      translate(addvec(verticalM3Pos, [-m3Outer/2-overlap,0,0]))
        circle(r=overlap, $fn=50);
      //translate(verticalM3Pos)
      //  circle(d=3.05, $fn=50); //screw shaft
    }
}

module bracket1B(height=baseHeight){
  difference(){
    translate([0, BoardSize[1], 0])
      bracket1Common(baseHeight);
    translate([-16, BoardSize[1]-5, mountHeight])
    rotate([-90,0,0])
    union(){
      cylinder(d=4.1, h=10, $fn=30);
      cylinder(d=8, h=5, $fn=30);
    }
    color("red")m3_SquareSlot([-4.5,BoardSize[1],totalHeight-8], [0, 0, 0], 10);
  }
}

module bracket1T(){
  difference(){
    translate([0,0,topHeight])
      rotate([180,0,0])
        bracket1Common(height=topHeight);
    //color("red")m3_SquareSlot([-4.5,4.5,topHeight-2], [0, 0, 0], 12);
  }
}


module bracket2B($fn=20){
  slotWidth=8; //needed for 30x30
  slotDepth=2.5;
  bracketWidth=slotWidth-1.5;
  slotOffset=(slotWidth-bracketWidth)/2;
  innerWidth=14;
  innerDepth=4;
  innerOffset=(innerWidth-bracketWidth)/2;
  supportHeight=mountHeight-(innerWidth)/2;
  difference(){
    translate([bracketOffset,BoardSize[1]+1.5,mountHeight])
    rotate([-90, 0,0])
    union(){
      linear_extrude(slotDepth)
      hull(){
        translate([0, slotOffset, 0])
          circle(d=bracketWidth);
        translate([0, -slotOffset, 0])
          circle(d=bracketWidth);
      }
      translate([0,0,slotDepth])
      linear_extrude(innerDepth)
      hull(){
        translate([0, innerOffset, 0])
          circle(d=bracketWidth);
        translate([0, -innerOffset, 0])
          circle(d=bracketWidth);
      }
    }
  }
  
  translate([bracketOffset-bracketWidth/2,BoardSize[1]+innerDepth,0])
    color("blue")cube([bracketWidth, innerDepth+3, supportHeight]);
  translate([bracketOffset-bracketWidth/2,BoardSize[1]+1+2*innerDepth,0])
    color("blue")cube([bracketWidth, 2, mountHeight+1]);
  translate([bracketOffset-bracketWidth/2,BoardSize[1]+2*innerDepth,mountHeight+1])
    color("aqua")cube([bracketWidth, 3, 0.35]);
}

module bracket2T(){
  translate([bracketOffset-4,-0.75,0])
    cube([7,5.5,topToBoard-2]);
}

module bottomShell() {
  difference(){
    union(){
      linear_extrude(baseHeight) outline(5);
      if(mount3030) {
        bracket1B();
        bracket2B();
      }
    }
    translate([0,0,baseThick]) 
      linear_extrude(baseHeight) outline(3.75);
    cardSlot();
    powerSlotB();
    HDMISlotB();
    AudioSlotB();
    EthSlotB();
    USBSlotB(29);
    USBSlotB(47);
    LEDs();
    for(y=[10,(BoardSize[1]/2)+2.5 ]){
      for(x=[10:4:BoardSize[0]-18]){
        translate([x,y,-epsilon])
          cube([2, (BoardSize[1]/2)-12.5, 
            baseThick+2*epsilon]);
      }
    }
    if(mount3030) {
      m3_CapScrew([bracketOffset,BoardSize[1]+8,mountHeight], [-90,0,0], 10);
      m3_CapScrew([-4.5,BoardSize[1]-4.5,totalHeight], [0,0,0], 12);
    }
  }
}

module cameraCableSlot(){
  translate([45,BoardSize[1]-19.1,-epsilon])
  linear_extrude(baseThick+2*epsilon) hull(){
  translate([0,15,0])
  circle(1.3, $fn=50);
  circle(1.3, $fn=50);
  }
}

module shelf() {
  shelfWidth=35;
  y=(BoardSize[1]-shelfWidth)/2;
  translate([BoardSize[0]-4.25,y,0]) 
    cube([5,shelfWidth,baseGap]);
}


module base() {
  union(){
    bottomShell();
    posts(r=3, h= baseGap, $fn=50);
    posts(r=1.3, h=baseGap+PCBThick, $fn=50);
    shelf();
  }
}

module topShell() {
  
  difference(){
    union(){
      linear_extrude(topHeight) outline(5);
      linear_extrude(rimHeight) outline(3.75);
    }
    difference(){
      translate([0,0,baseThick]) 
        linear_extrude(totalHeight) outline(2.5);    
      translate([BoardSize[0],10, 11])
        rotate([-90,0,0])rotate(60)
          cube([20, 20, BoardSize[1]-20]);
    }
    if (cameraSlot) cameraCableSlot();
    EthSlotT();
    USBSlotT(29);
    USBSlotT(47);
    for(y=[10,(BoardSize[1]/2)+2.5 ]){
      for(x=[10:4:BoardSize[0]-18]){
        if (!cameraSlot || ((x < 42) || (x > 46) || (y <= 10)))
        translate([x,y,-epsilon])
          cube([2, (BoardSize[1]/2)-12.5, 
            baseThick+2*epsilon]);
      }
    }
    
  }
}


module lid() {
  difference(){
    union(){
      topShell();
      AudioSlotT();
      HDMISlotT();
      powerSlotT();
      posts(r=3, h=topToBoard, $fn=50);    
      if(mount3030) {
        bracket1T();
        bracket2T();
      }
    }

    if(mount3030) {
      height=totalHeight-mountHeight;
      m3_SquareSlot([bracketOffset,3,height], [0,90,90], 10);
      m3_CapScrew([bracketOffset,-6,height], [90,0,0], 10);
      m3_CapScrew([-4.5,4.5,0], [180,0,0], 10);
    }
  }
}


if (Part=="debug") {
  //translate([-60,0,0]) bracket1Common(1);
  translate([-BoardSize[0]/2,-BoardSize[1]/2,0])
    base();
  translate([-BoardSize[0]/2,BoardSize[1]/2,baseHeight+topHeight])
  rotate([180,0,0])
    color("red") lid();
}
if (Part=="both") {
  translate([-BoardSize[0]/2,-BoardSize[1]-8,0])
  base();
  translate([-BoardSize[0]/2,+8,0])
    lid();
}

if (Part=="lid") {
  //translate([-60,0,0]) bracket1Common(1);
  translate([-BoardSize[0]/2,-BoardSize[1]/2,0])
  lid();
}

if (Part=="base") {
  translate([-BoardSize[0]/2,-BoardSize[1]/2,0])
  base();
}
