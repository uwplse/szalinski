//
// Funnel Module for OpenSCAD
// by richardsa April 9, 2019
// https://www.thingiverse.com/thing:3562546
//

//JarThroatSize  = 67;
JarThroatSize  = 57;
JarThroatDepth = 15;
EnableHandle   = false;

funnel(30,JarThroatSize,JarThroatDepth,20,EnableHandle);

module funnel(MouthHeight,ThroatDiameter,ThroatDepth,HandleDiameter,FunnelHandle) {
  //
  // These can be altered and the design will adjust automagically:
  //
  //   * FunnelHandle
  //   * HandleDiameter
  //   * ThroatDepth
  //
  // My orignial aim was to setup the module so that I can
  // create a funnel for *any* commecial jar throat. As you
  // will see, it works. But... Adjusting the following may
  // break the handle. Hence the "Handle" variable.
  // 
  //   * MouthHeight    = 30;
  //   * ThroatDiameter = 67;
  //
  // I didn't need the handle. It was just nice. So still a
  // work in progress...
  //
  // If you adjust the following, you *will* need to do some
  // serious designe tweaks.
  //
  FunnelThickness = 2;
  ArcRadius       = 15;    // The radius of the curve in the throat.
  ArcAngle        = 45;    // The angle of the curve in the throat.
  NudgeBead       = 1.55;  // Nudge bead off-centre for nice affect.
  Correction      = 8.81;  // Smooth transition from funnel to curve.
  //
  // General formulas used in the design.
  //
  BeadRadius      = FunnelThickness * 0.75;
  BeadHeight      = ThroatDepth+FunnelThickness+(ArcRadius/2)+MouthHeight+1;
  Thickness       = (FunnelThickness*2) + 1.6;
    
  color("White",1) {
    union() {
      // Bead around top of funnel.  
      translate([0,0,BeadHeight]) {
        rotate_extrude(angle=360, convexity=10, $fn=100) {
          translate([(ThroatDiameter/2)+MouthHeight+BeadRadius+NudgeBead,0]) {
            circle(BeadRadius,$fn=100);
          }
        }
      }
      if (FunnelHandle) {
        // Handle
        difference() {
          translate([ThroatDiameter,0,BeadHeight-0.5]) {
            cylinder(FunnelThickness,
                     d1=HandleDiameter,
                     d2=HandleDiameter,
                     false,
                     $fn=100);
          }
          translate([0,0,ThroatDepth+10.59]) {
            cylinder(MouthHeight+7,
                     d1=ThroatDiameter+Correction,
                     d2=ThroatDiameter+(MouthHeight*2)+Correction+7,
                     false,
                     $fn=100);
          }
          translate([ThroatDiameter+(HandleDiameter/4),0,BeadHeight-0.6]) {
            cylinder(FunnelThickness+0.2,
              d1=HandleDiameter/4,
              d2=HandleDiameter/4,
              false,
              $fn=100);
          }  
        }
      }
      // Funnel mouth
      translate([0,0,ThroatDepth+10.59]) {
        difference() {
          cylinder(MouthHeight,
                   d1=ThroatDiameter+Correction,
                   d2=ThroatDiameter+(MouthHeight*2)+Correction,
                   false,
                   $fn=100);
          translate([0,0,-0.1]) {
            cylinder(MouthHeight+0.2,
                     d1=ThroatDiameter-Thickness+Correction,
                     d2=ThroatDiameter+(MouthHeight*2)-Thickness+Correction,
                     false,
                     $fn=100);        
          }
        }
      }
      //
      // Create curve into throat. A nod of thanks to
      // chickenchuck040 for the arc module.
      //
      translate([0,0,ThroatDepth]) {          
        rotate_extrude(angle=360,convexity=10,$fn=100) { 
          translate([(ThroatDiameter/2)+ArcRadius,0]) {
            rotate(180-(ArcAngle/2)) {
              arc(ArcRadius,FunnelThickness,ArcAngle); 
            }
          }
        }     
      }
      // Funnel throat.
      difference() {
        cylinder(ThroatDepth,
                 d1=ThroatDiameter,
                 d2=ThroatDiameter,
                 false,
                 $fn=100);
        translate([0,0,-0.1]) {
          cylinder(ThroatDepth+0.2,
                   d1=ThroatDiameter-(FunnelThickness*2),
                   d2=ThroatDiameter-(FunnelThickness*2),
                   false,
                   $fn=100);
        }  
      }       
    }
  }
}   
//
// "Borrowed" a module from another author.
//
module arc(radius, thick, angle){
  //
  // Arc Module for OpenSCAD
  // by chickenchuck040 Nov 9, 2015
  // https://www.thingiverse.com/thing:1092611/files
  //
  intersection(){
    union(){
      rights = floor(angle/90);
      remain = angle-rights*90;
      if(angle > 90){
        for(i = [0:rights-1]){
          rotate(i*90-(rights-1)*90/2){
            polygon([
              [0, 0],
              [radius+thick, (radius+thick)*tan(90/2)],
              [radius+thick, -(radius+thick)*tan(90/2)]
            ]);
          }
        }
        rotate(-(rights)*90/2){
          polygon([
            [0, 0],
            [radius+thick, 0],
            [radius+thick, -(radius+thick)*tan(remain/2)]
          ]);
        }
        rotate((rights)*90/2){
          polygon([
            [0, 0],
            [radius+thick, (radius+thick)*tan(remain/2)],
            [radius+thick, 0]
          ]);
        }
      }else{
        polygon([
          [0, 0],
          [radius+thick, (radius+thick)*tan(angle/2)],
          [radius+thick, -(radius+thick)*tan(angle/2)]
        ]);
      }
    }
    difference(){
      circle(radius+thick, $fn=100);
      circle(radius, $fn=100);
    }
  }
}