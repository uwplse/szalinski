//Trim Line Awning Ball End Base
//TekMason
$fn=120;
CircCenterOut_D = 24.0;
CircSides_D = 17.0;
CircSides_Span = 51.0;
//Standard Screw Size is 5.0
ScrewHoles_D = 6.0;
Base_Z = 5.0;

Cyl_Z = 21.0;
//Ball End Diameter
CylInside1_D = 16.2;  //16.0 is a little tight
CylInside2_D = CylInside1_D -2.4;
Lip_Z = 2.2;  //was 2.5
SlotWidth = 2.5;
Slot_Z = 13.5;
SlotRod_D = 8.0;

difference(){
  union(){
    Base();
    cylinder(h=Cyl_Z, d=CircCenterOut_D);
  }
    cylinder(h=Cyl_Z -Lip_Z, d=CylInside1_D);
    translate([0, 0, Cyl_Z -Lip_Z]){
      cylinder(h=Lip_Z, d=CylInside2_D);
    }
  
    union(){
      translate([-CircCenterOut_D/2, -SlotWidth/2, Cyl_Z -Slot_Z]){
        cube([CircCenterOut_D, SlotWidth, Slot_Z], center=false);
      }
      translate([SlotWidth/2, -CircCenterOut_D/2, Cyl_Z -Slot_Z]){
        rotate([0,0,90]){
          cube([CircCenterOut_D, SlotWidth, Slot_Z], center=false);
      }
    }
  }
  PoleCutout();
}
module Base(){
  difference(){
    hull(){
      cylinder(h=Base_Z, d=CircCenterOut_D);
      translate([-CircSides_Span/2,0,0]){cylinder(h=Base_Z, d1=CircSides_D, d2=CircSides_D -4);}
      translate([CircSides_Span/2,0,0]){cylinder(h=Base_Z, d1=CircSides_D, d2=CircSides_D -4);}
    }
    translate([-CircSides_Span/2,0,0]){cylinder(h=Base_Z, d=ScrewHoles_D);}
    translate([CircSides_Span/2,0,0]){cylinder(h=Base_Z, d=ScrewHoles_D);
    }
  }
}

module PoleCutout(){
  translate([0, -SlotRod_D/2 +CircCenterOut_D/2, Cyl_Z -SlotRod_D/2]){
    rotate([90, 0, 0]){
      hull(){
        cylinder(h=SlotRod_D, d=SlotRod_D, center=true);
        translate([0, SlotRod_D/2, 0]){cylinder(h=SlotRod_D, d=SlotRod_D, center=true);}
      }
    }
  }
}  
