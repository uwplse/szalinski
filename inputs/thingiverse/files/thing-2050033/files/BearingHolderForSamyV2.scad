//Sammys 3D Printer Bearing holder
//Bearing OD=15mm,L=24mm
OD=15.1;
L=24;
H=3; // Distance from surface to the bearing

difference()
{
  MainPart();
  // mounting holes
  translate([OD/2+6,0,0])
    MountingHoleSingle();
  translate([-(OD/2+6),0,0])
    MountingHoleSingle();
/*
  translate([-(OD/2+6),-(L/2-5),0])
    MountingHoleSingle();
  translate([OD/2+6,-(L/2-5),0])
    MountingHoleSingle();
*/
  // flatten bottom
  translate([0,0,-(5+H)])
    cube([OD*4,L,10], center = true);
}
  
// MODULES

module MountingHoleSingle(){
    hull(){
    translate([1,0,0])
      cylinder(d=3.1,10,$fn=20,center=true);
    translate([-1,0,0])
      cylinder(d=3.1,10,$fn=20,center=true);
    }
    hull(){
    translate([1,0,OD/2+1])
      cylinder(d=5.6,OD,$fn=6,center=true);
    translate([-1,0,OD/2+1])
      cylinder(d=5.6,OD,$fn=6,center=true);
    }
}

module MainPart(){
  difference(){
  union(){
  translate([0,0,-3])
  minkowski()
  {
      cube(size=[OD+17,L-4,10],center=true);    // 14mm for bolts
      cylinder(r=2,$fn=20);
  }

  difference()
  {
      translate([0,0,(OD+2)/2-6/2+2]) // 2mm between bearing and surface
           rotate([90,0,0])
           {
               cylinder(d=OD+6,L,$fn=96,center=true);
           }
      translate([0,0,OD+(4/2)])
           rotate([0,90,0])
                 rotate([0,0,90])
                     cylinder(d=7,OD+6,$fn=6, center=true);
   }
  // add tightening bolt
  translate([0,0,OD+(4/2)])
       rotate([0,90,0])
            rotate([0,0,90])
                 difference(){
                     cylinder(d=7,9,$fn=6, center=true);
                     cylinder(d=3.1,10,$fn=20, center=true);
                 }

  // prepare material for the rounding corner
  translate([-(OD+6)/2,-L/2,0])
       cube([OD+6,L,OD/2]);

  }  // end if union

  translate([0,0,(OD+2)/2-6/2+2]) // 2mm between bearing and surface
       rotate([90,0,0])
       {
            cylinder(d=OD,L+1,$fn=96,center=true);
       }
  translate([0,0,OD])
       cube([2,L+1,20], center=true);
  }

  roundCorner();
  mirror([1,0,0])
       roundCorner();
}

module roundCorner(){
difference()
{
    translate([(OD+6)/2,-L/2,6/2])
         cube([OD/4/2,L,OD/4/2]);
    translate([(OD+6+OD/4)/2,L/2,OD/4/2+6/2])
    rotate([90,0,0])
         cylinder(d=OD/4,L,$fn=20);
}
}