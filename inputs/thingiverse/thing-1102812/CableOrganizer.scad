// Height of back plate
Height = 32;
// Thickness of back plate
BackThickness = 2;
// Total distance from back plate to tip of arms
Depth = 75;
// Fillet between back plate and arms for strength
FilletRadius = 6;

// Vertical thickness of Arms/Prongs
ArmThickness = 2;
// Arm Width
ArmWidth = 12;
// How much end of arm is angled above horizontal
AngleDegrees = 45;
// Length of angled portion of arms
AngledLength = 5;
// Gap between arms
SlotWidth = 7;
// How many slot for holding leads
SlotCount = 9;
// Detail
$fn = 50;

// Bolt/Screw hole style, none for adhesive mounting
HoleStyle = 1; // [0:None,1:Circular,2:Keyhole]
// Bolt thread outer diameter
BoltDiameter = 4;
// Only for "Keyhole" style
BoltHeadDiameter = 8;
// Number of mounting holes
BoltCount = 3; // [2:8]

TotalLength = SlotCount * SlotWidth + ArmWidth * (SlotCount + 1);
HoleInset = (Height - FilletRadius) / 2;
DepthLessAngle = Depth - AngledLength * cos(AngleDegrees);


module KeyHole(dlarge,dsmall,depth) {
  err = 0.01; // avoid coincident faces
  translate([0,0,-err/2]) {
    cylinder(h=depth + err,d=dsmall);
    translate([0,dlarge,0]) cylinder(h=depth + err,d=dlarge);
    translate([0,dlarge / 2, (depth + err) / 2]) cube([dsmall, dlarge, depth + err], center = true);
  }
}

module insidefillet(r, length) {
  err = 0.01;
  difference () {
   translate([0,r/2,r/2]) cube([length,r,r], center=true);
   translate([0,r,r]) rotate([0,90,0]) cylinder(h=length+2*err, r=r, center=true);
  }
}

module outsidefillet(r, length) {
  err = 0.01;
  translate([length / 2,0,0])
  difference () {
   translate([0,r,r]) cube([length+err,r*2,r*2], center=true);
   rotate([0,90,0]) cylinder(h=length+2*err, r=r, center=true);
  }
}

err = 0.01;
difference() {
  union() {
    translate([-TotalLength/2,0,0]) {
      cube([TotalLength,BackThickness,Height]);
      cube([TotalLength, DepthLessAngle, ArmThickness]);
      translate([0,DepthLessAngle]) rotate([AngleDegrees,0,0]) 
        cube([TotalLength, AngledLength, ArmThickness]);
    }
    translate([0,BackThickness-err,ArmThickness-err]) insidefillet(FilletRadius, TotalLength);
  }
  translate([TotalLength / 2 - HoleInset, 0, Height - HoleInset]) rotate([90,0,90]) 
    outsidefillet(HoleInset, BackThickness + err);
  translate([-TotalLength / 2 + HoleInset, 0, Height - HoleInset]) rotate([0,0,90]) 
    outsidefillet(HoleInset, BackThickness + err);
  
  totalBoltDistance = TotalLength - HoleInset * 2;
  for (offset = [0: totalBoltDistance / (BoltCount - 1): totalBoltDistance]) {
    if (HoleStyle == 2)
      translate([-TotalLength / 2 + HoleInset + offset, 0, Height - HoleInset]) rotate([-90,0,0]) 
        KeyHole(BoltHeadDiameter, BoltDiameter, BackThickness+FilletRadius*2);
    else if (HoleStyle == 1)
      translate([-TotalLength / 2 + HoleInset + offset, -err, Height - HoleInset]) rotate([-90,0,0]) 
        cylinder(h = BackThickness + err * 2, d = BoltDiameter);
  }
  
  for(i = [1:SlotCount]) {
    translate([-TotalLength / 2 + ArmWidth + (i-1) * (ArmWidth + SlotWidth), BackThickness + FilletRadius + SlotWidth / 2, -err])
    union() {  
      translate([SlotWidth/2, 0, 0]) cylinder(h = ArmThickness + AngledLength + err*2, d = SlotWidth);
      cube([SlotWidth, Depth, ArmThickness + AngledLength + err*2]);
    }
  }
}

