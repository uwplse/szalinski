HoleDiameterInches=0.5625;
RingThicknessInches= .125;
RingInsertionDepthInches=.5;

//Multiplying by 1 prevents Thingiverse's Customizer from making constants variables.
inch=25.4*1;
internalD = HoleDiameterInches*inch;
SlotWidth = inch/8;
ORingThickness = RingThicknessInches*inch;
OringDepth = RingInsertionDepthInches*inch;
Gap=.25;
$fn=72*1;
use <partial_rotate_extrude.scad>;

ORingInserter();
translate([0,50,0])
  ORingInserterPartsLayout();

module ORingInserter(){
  color("blue", alpha=.5)
    InserterShell();
  color("silver",alpha=.6)
    InserterPlug();
  color("gray")
    InserterFinger();
  color("brown")
    InserterHandle();
}
module ORingInserterPartsLayout(){
   translate([-30,0,1.25*inch])
    rotate([0,180,0])
     color("blue", alpha=.5)
        InserterShell();
  translate([30,0,1*inch-Gap-ORingThickness])
    rotate([0,180,0])
      color("silver")
        InserterPlug();
  translate([15,-25,SlotWidth/2])
    rotate([0,-90,0])
      color("gray")
        InserterFinger();
  translate([0, 00,2.5*inch-internalD+ORingThickness/2])
    rotate([0,180,0])
      color("gray")  
        InserterHandle();
}

module InserterShell(){
  difference(){
    cylinder(d=internalD+inch/4, h=1.25* inch);
    translate([0,0,-.05])
      cylinder(d=internalD+Gap, h=1* inch);
    translate([0,0,.95*inch])
      cylinder(d=inch/4+Gap, h=.4* inch);
    FingerKeyway();
  }
}

module InserterPlug(){
  translate([0,0,-OringDepth-SlotWidth ])
    difference(){
    //Main shaft
    cylinder(d=internalD-Gap, h=1* inch+OringDepth-Gap);
      FingerKeyway()
    //Bottom bevel
    translate([0,0,-Gap])
      rotate_extrude() 
        polygon([[internalD/2+.1,ORingThickness*.85],
                      [internalD/2+.1, 0],
                      [internalD/2-ORingThickness*.75-Gap,0]]);
      //Oring slot
      translate([0,0,SlotWidth])
      rotate_extrude() 
        polygon([[internalD/2-2*Gap,ORingThickness*1.1],
                      [internalD/2+Gap,ORingThickness*1.3],
                      [internalD/2+Gap, -SlotWidth-ORingThickness],
                      [internalD/2-.5-Gap, -SlotWidth-ORingThickness],
                      [internalD/2-.5-Gap, -ORingThickness*.3],
                      [internalD/2-.5-5*Gap, 0],
                      [internalD/2-ORingThickness+Gap/2,0],
                      [internalD/2-ORingThickness+Gap/2,ORingThickness*1.1]]);      
      //Streched Oring channel
      angle1 = atan(ORingThickness/(internalD/2-ORingThickness));
      angle2= atan(SlotWidth/(internalD/2-ORingThickness));
      echo("Angle 1 = ", angle1, "   Angle 2 = ", angle2);
      translate([0,0,-ORingThickness-Gap])
        difference(){
          rotate([0,0,-angle1-angle2/2])
           partial_rotate_extrude(angle=(2*angle1+angle2), radius= internalD/2-ORingThickness, convex=10)
                translate([0,10,0])
                  square([2*ORingThickness+1*Gap,3.25*ORingThickness]);
         translate([0,0,-1*inch])
            cylinder(d=internalD-ORingThickness*2, h= 1.5*inch, $fn=36);
        }
    }
  }
module FingerKeyway(){
    translate([-SlotWidth/4,-SlotWidth/2-Gap,-.1*inch])
      cube([internalD/2 +SlotWidth/4+Gap,SlotWidth+Gap,2.5*inch - OringDepth]);
}
module InserterFinger(){
   difference(){
        translate([0,0,-OringDepth-SlotWidth-Gap])
        intersection(){
           translate([-SlotWidth/4+Gap/2,-SlotWidth/2+Gap,-.05])
            cube([internalD/2 +SlotWidth/2,SlotWidth-Gap*2,2*inch+OringDepth]);
            cylinder(d=internalD-.05, h=3* inch+OringDepth , $fs=.3, $fa=1, $fn=360);
        }
        translate([internalD/2-ORingThickness,-SlotWidth/1.9,-OringDepth])
          cube([ORingThickness, SlotWidth+.1,ORingThickness*1.1]);
    }
  }


module InserterHandle(){
  difference(){
  union(){
    translate([0,0,1.625*inch])
    cylinder(r1=SlotWidth/2, r2=internalD/2,h = inch/4);
    translate([0,0,1.874*inch])
    cylinder(d=internalD,h = inch/8);
  }
  scale([1.01,1.05,1])//Tolerances
    InserterFinger();
}
}

