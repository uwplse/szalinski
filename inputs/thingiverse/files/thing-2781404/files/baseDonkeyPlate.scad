use <MCAD/boxes.scad>

/* [Hidden] */
mPlateH=2;
mStandoffH=5;
plateW=95;
plateL=195;
plateH=5;

/* [Pin Spacing] */
front_Pin_Spacing=12.5; // /*[5:40]*/
rear_Pin_Spacing=12.5;  // /*[5:40]*/
/* [Pin Positioning] */
front_Pin_Position=85; // /*[73:90]*/
rear_Pin_Position=90; // /*[73:90]*/
/* [rPi Mount rotation] */
rot_angle = 0;  // [0,90,-90]

print_part();

module print_part() {
    difference() {
      union(){
        newPlate(plateH);
        if( rot_angle == 0 ) {
           translate([0,0,0]) rotate([0,0,rot_angle])
             translate([-3.0,0,0]) rPiMountPins(plateH,3);
        }
        else if( rot_angle == 90 ) {
           translate([-15,3,0]) rotate([0,0,rot_angle])
             translate([-3.0,0,0]) rPiMountPins(plateH,3);
        }
        else if( rot_angle == -90 ) {
           translate([-15,-5,0]) rotate([0,0,rot_angle])
             translate([-3.0,0,0]) rPiMountPins(plateH,3);
        }
        translate([-3.0,0,0]) PwmDvrMountPins(plateH,3);
      }
        if( rot_angle == 0 ) {
           translate([0,0,0]) rotate([0,0,rot_angle])
              translate([-3.0,0,0]) #rPiHoles();
        }
        else if( rot_angle == 90 ) {
           translate([-15,3,0]) rotate([0,0,rot_angle])
              translate([-3.0,0,0]) #rPiHoles();
        }
        else if( rot_angle == -90 ) {
           translate([-15,-5,0]) rotate([0,0,rot_angle])
              translate([-3.0,0,0]) #rPiHoles();
        }      
        translate([-3.0,0,0]) #PwmDvrHoles();
        #handleMountingHoles();
     #platePinClearance(front_Pin_Spacing,rear_Pin_Spacing);
        #translate([-3,0,0])plateMountHolesPins(front_Pin_Spacing,rear_Pin_Spacing,front_Pin_Position,rear_Pin_Position);
        #wireHole(10,2);
      }  
}

module rPiMounts(rotation=0) {
    if( rotation==0 ) {
      difference(){
    translate([-3.0,0,0]) rPiMountPins(plateH,3);
    translate([-3.0,0,0]) #rPiHoles();
    }}
    if( rotation==90 ) {
      difference(){
    rotate([0,0,rotation])translate([-3.0,0,0]) rPiMountPins(plateH,3);
    rotate([0,0,rotation])translate([-3.0,0,0]) #rPiHoles();
    }}  
}

module handleMountingHoles(plateh=3) {
    $fn=30;
    platePinW=3.1; // actual mount hole diameter
    plateH=15.0;
    platePinH=plateh;
    translate([-66.9,-42.35,plateh])
      cylinder(r=platePinW/2, h=platePinH*5,center=true);
    translate([-66.9,42.35,plateh])
      cylinder(r=platePinW/2, h=platePinH*5,center=true);
    translate([90.8,0,plateh])
      cylinder(r=platePinW/2, h=platePinH*5,center=true);    
}

module rPiHoles () {
    $fn=30;
    platePinW=2.7; // actual mount hole diameter
    plateH=15.0;
    platePinH=plateH;
translate([21,-24.5,0]) cylinder(r=platePinW/2,h=plateH*2,center=true);
translate([21,24.5,0]) rotate([0,0,90]) cylinder(r=platePinW/2,h=plateH*2,center=true);
//end 2
translate([-37,-24.5,0]) rotate([0,0,90])cylinder(r=platePinW/2,h=plateH*2,center=true);
translate([-37,24.5,0]) rotate([0,0,90])cylinder(r=platePinW/2,h=plateH*2,center=true);    
}
module rPiMountPins (plateH=5,piOffset=2) {
    $fn=20;
    platePinW=5.8;
    platePinH=plateH+piOffset;
translate([21,-24.5,platePinH/2]) cylinder(r=platePinW/2,h=platePinH,center=true);
translate([21,24.5,platePinH/2]) rotate([0,0,90]) cylinder(r=platePinW/2,h=platePinH,center=true);
//end 2
translate([-37,-24.5,platePinH/2]) rotate([0,0,90])cylinder(r=platePinW/2,h=platePinH,center=true);
translate([-37,24.5,platePinH/2]) rotate([0,0,90])cylinder(r=platePinW/2,h=platePinH,center=true);    
}

module newPlate (plateH=5, plateW=95, plateL=195) {
    translate([0,0,plateH/2])  //translate([3,0,plateH/2])
    //cube([plateL,plateW,plateH],center=true);
    roundedBox([plateL,plateW,plateH],15, true);   
}
module PwmDvrMountPins (plateH=5,piOffset=2) {
    $fn=20;
    platePinW=5.8;
    platePinH=plateH+piOffset;
translate([74,-28,platePinH/2]) cylinder(r=platePinW/2,h=platePinH,center=true);
translate([74,28,platePinH/2]) rotate([0,0,90]) cylinder(r=platePinW/2,h=platePinH,center=true);
//end 2
translate([55,-28,platePinH/2]) rotate([0,0,90])cylinder(r=platePinW/2,h=platePinH,center=true);
translate([55,28,platePinH/2]) rotate([0,0,90])cylinder(r=platePinW/2,h=platePinH,center=true);    
}
module PwmDvrHoles (plateH=5,piOffset=2) {
    $fn=30;
    platePinW=2.7;
    platePinH=plateH+piOffset;
translate([74,-28,platePinH/2]) cylinder(r=platePinW/2,h=platePinH*2,center=true);
translate([74,28,platePinH/2]) rotate([0,0,90]) cylinder(r=platePinW/2,h=platePinH*2,center=true);
//end 2
translate([55,-28,platePinH/2]) rotate([0,0,90])cylinder(r=platePinW/2,h=platePinH*2,center=true);
translate([55,28,platePinH/2]) rotate([0,0,90])cylinder(r=platePinW/2,h=platePinH*2,center=true);    
}


module platePinClearance(fSpacing=12.5,rSpacing=12.5,fPos=85,rPos=90) {
    platePinH=3.0;
    plateH=5.0;
    pinSlotW=10;
    pinSlotL=25;
//end 1 = Rear    
translate([rPos-5,-rSpacing,plateH-(plateH-platePinH)/2]) cube([pinSlotL,pinSlotW,plateH-platePinH],center=true);
translate([rPos-5,rSpacing,plateH-(plateH-platePinH)/2]) cube([pinSlotL,pinSlotW,plateH-platePinH],center=true);
//end 2 - Front
translate([-fPos,-fSpacing,plateH-(plateH-platePinH)/2]) cube([pinSlotL,pinSlotW,plateH-platePinH],center=true);
translate([-fPos,fSpacing,plateH-(plateH-platePinH)/2]) cube([pinSlotL,pinSlotW,plateH-platePinH],center=true);
    
}
module plateMountHolesPins(fSpacing=12.5,rSpacing=12.5,fPos=85,rPos=85) {
    $fn=6;
    platePinW=5.8;
    plateH=5.0;
    platePinH=plateH;
    pinSlotW=10;
    pinSlotL=25;
//end 1 - Rear    
translate([rPos,-rSpacing,plateH-(plateH-platePinH)/2]) cylinder(r=platePinW/2,h=plateH*2,center=true);
translate([rPos,rSpacing,plateH-(plateH-platePinH)/2]) cylinder(r=platePinW/2,h=plateH*2,center=true);
//end 2 - Front
translate([-fPos,-fSpacing,plateH-(plateH-platePinH)/2]) cylinder(r=platePinW/2,h=plateH*2,center=true);
translate([-fPos,fSpacing,plateH-(plateH-platePinH)/2]) cylinder(r=platePinW/2,h=plateH*2,center=true);
    
}

module wireHole( defH=3.0 ) {
  $fn=50;

    translate([30,-12.5,-defH/4])
    linear_extrude(height = defH, center = false, convexity = 100, scale=[1,1], $fn=20,twist=0)
        hull() {
          translate([0,26,0]) circle(8);
          circle(8);
        }
}

