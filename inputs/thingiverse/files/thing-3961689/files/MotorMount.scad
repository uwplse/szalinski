//Base holes sides
HoleSideCount = 30; // [3:30]
// Model part to generate
ModelToDisplay = 0; // [0:Motor base, 1:Updated ball screw, 2:Updated top cap, 3:Motor-screw coupler, 4:Updated track]

$fn = 100;
$BodyLength = 65.98;
$CoreHeight = 15;
$CoreDiameter = 12.6;
$GearboxHeight = 9.2;
$GearboxWidth = 10.5;
$CapInsertHeight = 2;
$BatteryOpening = 15.1;
$SwitchSpacing = 21;
$BottomBaseHeight = 28;

if (ModelToDisplay == 0)
  BottomSideMotor();
else if (ModelToDisplay == 1)
  UpdatedScrew();
else if (ModelToDisplay == 2)
  UpdatedCap();
else if (ModelToDisplay == 3)
  BottomCoupler();
else if (ModelToDisplay == 4)
  UpdatedTrack();


//TopSideMotorSet(); // Terrible idea!!! Bottom motor is much better

module UpdatedTrack()
{
  difference()
  {
    import("Track.stl");
    cylinder(d = 22, h = 40, center = true);
  }
}

module UpdatedCap()
{
  translate([0, 0, -95.74])
    import("Turncap.stl");
  difference()
  {
    cylinder(d = 43, h = 7);
    cylinder(d = 38, h = 4.1);
    translate([0, 0, 4])
      cylinder(d = 41, h = 4.1);
  }
}

module UpdatedScrew()
{
  difference()
  {
    union()
    {
      import("Spiral.stl");
      translate([0, 0, 100])
        cylinder(d = 8.5, h = 9.8);
    }
    translate([0, 0, 98])
#      cylinder(d = 10, h = 12, $fn = 3);
  }
}

module BottomSideMotor()
{
  difference()
  {
    //Main base
    cylinder(d = 143, h = $BottomBaseHeight + 2);
    //Upper insert
    translate([0, 0, $BottomBaseHeight])
      cylinder(d = 140, h = 2.1);
    //Motor
    translate([0, 0, -($CoreHeight / 2) + $BottomBaseHeight - $GearboxHeight + 0.02])
      MotorOutline();
    //Batteries
    translate([8, 6.5, $BottomBaseHeight - ($BatteryOpening / 2)])
      LowerBatteryOpening();
    mirror([1, 0, 0])
      translate([8, 6.5, $BottomBaseHeight - ($BatteryOpening / 2)])
        LowerBatteryOpening();
    //Switch
    translate([0, 70, $BottomBaseHeight - 2.2])
      rotate(90, [0, 0, 1])
        Switch();
    translate([-3.5, 68, $BottomBaseHeight - 6])
      cube([7, 10, 10]);
    translate([-3.5, 58, $BottomBaseHeight - 2])
      cube([7, 10, 10]);
    //Wire openings
    translate([0, 0, ($BottomBaseHeight / 2) + 2])
    {
      cube([30, 3, $BottomBaseHeight], center = true);
      translate([14, 3.5, 0])
        cube([3, 10, $BottomBaseHeight], center = true);
      translate([-14, 3.5, 0])
        cube([3, 10, $BottomBaseHeight], center = true);
    }
    //Battery clips
    translate([8, 6.9, 12])
      cube([$BatteryOpening, .8, 20], center = true);
    translate([-8, 6.9, 12])
      cube([$BatteryOpening, .8, 20], center = true);
    translate([8, 6.9 + 55.2, 12])
      cube([$BatteryOpening, .8, 20], center = true);
    translate([-8, 6.9 + 55.2, 12])
      cube([$BatteryOpening, .8, 20], center = true);
    //Cutouts
    for (x =[0:7])
    {
      rotate((x * 40) + 130, [0, 0, 1])
        translate([52, 0, -0.1])
          cylinder(d = 33, h = $BottomBaseHeight + 2, $fn = HoleSideCount);
    }
    for (x =[0:6])
    {
      rotate((x * 40) + 150, [0, 0, 1])
        translate([29, 0, -0.1])
          cylinder(d = 16, h = $BottomBaseHeight + 2, $fn = HoleSideCount);
    }
    for (x =[0:3])
    {
      rotate((x * 40) + 210, [0, 0, 1])
        translate([16, 0, -0.1])
          cylinder(d = 10, h = $BottomBaseHeight + 2, $fn = HoleSideCount);
    }
    for (x =[0:8])
    {
      rotate((x * 40) + 150, [0, 0, 1])
        translate([64, 0, -0.1])
          cylinder(d = 10, h = $BottomBaseHeight + 2, $fn = HoleSideCount);
    }
  }
}

module LowerBatteryOpening()
{
  rotate(-90, [1, 0, 0])
    hull()
    {
      cylinder(d = $BatteryOpening, h = 56);
      translate([0, -10, 0])
        cylinder(d = $BatteryOpening, h = 56);
    }
}

module TopSideMotorSet()
{
  MotorHousing();
  translate([50, 0, 0])
    MotorMount();
  translate([28, 17, 0])
    TopCoupler();
  translate([28, -40, 7])
    rotate(180, [1, 0, 0])
      MotorCap();
}

module MotorCap()
{
  difference()
  {
    MotorCapInsert();
    translate([0, 13.5, 0])
      cylinder(d = 11, h = 5);
    translate([0, -13.5, 0])
      cylinder(d = 11, h = 5);
  }
  
  //Switch mount
  SwitchMount();
  translate([0, 0, 1])
    difference()
    {
      translate([0,0, 0.01])
        cylinder(d = 44 + 4, h = 6);
      cylinder(d = 44 + .8, h = 4);
      //Switch opening
      translate([$SwitchSpacing, 0, 1.79])
      {
        Switch();
      }
    }
}

module SwitchMount()
{
  difference()
  {
    translate([13, -8, 1])
      cube([9, 16, 4]);
    translate([$SwitchSpacing, 0, 2.8])
    {
      Switch();
    }
  }
}

module MotorCapInsert()
{
  $Clearance = .7;
  translate([0, 0, 5.0 - $CapInsertHeight])
  {
//    translate([0, 0, 59])
//      cylinder(d = 30 - $Clearance, h = $CapInsertHeight);
    //Alignment notch
    translate([-16, 0, $CapInsertHeight / 2])
      cube([6 - $Clearance, 6 - $Clearance, $CapInsertHeight], center = true);
    //Battery openings
//    translate([13.5, 0, 0])
//      BatteryOpening($Height = $CapInsertHeight);
    rotate(90, [0, 0, 1])
      translate([13.5, 0, 0])
        BatteryOpening($Height = $CapInsertHeight);
    rotate(-90, [0, 0, 1])
      translate([13.5, 0, 0])
        BatteryOpening($Height = $CapInsertHeight);
  }
}

module MotorHousing()
{
  difference()
  {
    //Main body
    translate([0, 0, 0.01])
      cylinder(d = 44, h = $BodyLength);
    //Lockcap mount
    cylinder(d = 40, h = 8);    
    //Motor mount opening
    translate([0, 0, ($CoreHeight / 2) + $GearboxHeight])
      rotate(180, [1, 0, 0])
        MotorOutline();
    //Motor wire openings
    translate([4, 0, 0])
      cylinder(d = 3.5, h = 70);
    translate([-4, 0, 0])
      cylinder(d = 3.5, h = 70);
    $Clearance = 0;
    //Battery openings
//#    translate([13.5, 0, 0])
//      BatteryOpening($Height = 54);
    rotate(90, [0, 0, 1])
      translate([13.5, 0, 10])
        BatteryOpening($Height = 56);
    rotate(-90, [0, 0, 1])
      translate([13.5, 0, 10])
        BatteryOpening($Height = 56);
    //Wiring access opening
    translate([0, 0, 59])
      cylinder(d = 30, h = 7);
    //Alignment notch
    translate([-16, 0, 63])
      cube([6, 6, 8], center = true);
    //Switch opening
    translate([$SwitchSpacing - 3.5, 0, $BodyLength - 2.2])
    {
//      Switch();
//      cube([13, 7, 5], center = true);
      cube([11, 17, 5], center = true);

    }
  }
}

module Switch()
{
  translate([0, 0, -.49])
  {
    cube([13, 7, 4.4], center = true);
    translate([-3.15, 0, -1.05 + .5])
      cube([6.7, 11.2, 6.5], center = true);
  }
  cube([13, 7, 4.4], center = true);
}

module BatteryOpening()
{
  translate([0, 0, $Height / 2])
  {
    cylinder(d = $BatteryOpening - $Clearance, h = $Height, center = true);
    cube([3, 20 - $Clearance, $Height], center = true);
  }
}

module MotorMount()
{
  //Use the original cap, align and flip
  rotate(180, [1, 0, 0])
    translate([0, 0, -110.75 - 9])
      import("Lockcap.stl");
  //Fill in the center with a motor aligner
  difference()
  {
    cylinder(d = 16, h = 9);
    translate([0, 0, 5.5])
      cube([$CoreDiameter, $GearboxWidth, 10], center = true);
    
    cylinder(d = 4.2, h = 2);
  }
}

module MotorOutline()
{
  //Motor
  intersection()
  {
    cylinder(d = $CoreDiameter, h = $CoreHeight, center = true);
    cube([$CoreDiameter, $GearboxWidth, $CoreHeight], center = true);
  }
  //Gearbox
  translate([0, 0, -0.01 + (($CoreHeight + $GearboxHeight) / 2)])
    cube([$CoreDiameter, $GearboxWidth, $GearboxHeight], center = true);
  //Upper bearing
  translate([0, 0, ($CoreHeight / 2) + $GearboxHeight])
    cylinder(d = 4, h = 1);
  //Shaft
  translate([0, 0, ($CoreHeight / 2) + $GearboxHeight])
    cylinder(d = 3, h = 10);
  //Lower bearing
  translate([0, 0, -($CoreHeight / 2) - 1.2])
    cylinder(d = 5.2, h = 1.2);
  //Connectors
  translate([0, 0, -($CoreHeight / 2) - 1])
    cube([$CoreDiameter, 3, 2], center = true);
}

module TopCoupler()
{
  difference()
  {
    union()
    {
      cylinder(d = 8.2, h = 10);
      cylinder(d = 13, h = 5.5, $fn = 3);
    }
    difference()
    {
      cylinder(d = 3.2, h = 10.1);
      translate([-3, 1.2, 0])
        cube([6, 6, 10.1]);
    }
  }
}

module BottomCoupler()
{
  difference()
  {
    cylinder(d = 9, h = 6, $fn = 3);
    difference()
    {
      cylinder(d = 3.2, h = 10.1);
      translate([-3, 1.2, 0])
        cube([6, 6, 10.1]);
    }
  }
}