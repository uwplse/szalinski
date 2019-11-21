// PIRBox
// Version: 1.1
// Author: PrinGer @ thingiverse
// License: CC No commercial - Share alike

$fn = 30;

UseFresnelLens = 0;

// Sensor hole diameter (Big or small)
SensorHoleDiameter = UseFresnelLens ? 23.0 : 8.5;

// Note:
// Front side: Side of the lens (Z = 0)
// Back side: where the adjustment potentiometers are located (positive Y and positive Z)
// Right Side: (positive X)

// Dimensions of the box (inner sizes)
WallThickness = 2;
InnerSizeX = 32.5;
InnerSizeY = 26.0;
InnerSizeZ = UseFresnelLens ? 17.00 : 14.5; // If fresnel lens increase the height

// Clip sizes in the cover
ClipLength = 10;
ClipHeightZ = 6;

// Potentiometer holes for time and sensitivity
PotentiometerHoleTimeX = -6.25; // Distance from the center (seen from lens side, power pins up). Set to zero if you don't want it.
PotentiometerHoleSensitivityX = 1.75; // Distance from the center
PotentiometerHoleZ = 3.5; // Down from the back side
PotentiometerHoleDiameter = 3; // 
PotentiometerHoleOffsetZ = UseFresnelLens ? 11.5 : 9; // Seen from the lens side of the box
MyFont = "Courier";

// Cable hole
MakeCableHoleAsCube = 1; // 0: cylinder
PositionCableHole = 2; // 0: no, 1: left, 2: right, 3: top, 4: bottom
CableHoleX = 27.5; // From the left side for cable output at top or bottom
CableHoleY = 5; // From bottom for cable output left or right
CableHoleZ = 2.0; // From the back side, must be the double of the cable hole diameter if hole as cube
CableHoleDiameter = 1;

// Translate to see OpenScad scalings
//translate([0, +InnerSizeY / 2 + WallThickness, 0])
// Rotate to see the inscription of the potentiometer holes
//rotate([0, 0, 180])

Box();

Cover();

if( ! UseFresnelLens)
  Tube();

// Tube
// ----
module Tube()
{
  // This part has to be sticked at the box
  // Extend this tube by a shrinking tube
  translate([- (InnerSizeX + SensorHoleDiameter) / 2 - WallThickness * 4, SensorHoleDiameter, 0])
  {
    difference()
    {
      cylinder(d = SensorHoleDiameter + 3 * WallThickness, h = 2, center = false);
      cylinder(d = SensorHoleDiameter , h = 2, center = false);
      echo("End Hole Diameter 1",  SensorHoleDiameter);
    }
    translate([0, 0, 2])
    difference()
    {
      cylinder(d1 = SensorHoleDiameter + 3 * WallThickness, d2 = SensorHoleDiameter, h = 2, center = false);
      cylinder(d1 = SensorHoleDiameter, d2 = SensorHoleDiameter - 2 * WallThickness  , h = 2, center = false);
    }
    // Start of the shrinking tube
    translate([0, 0, 4])
    difference()
    {
      cylinder(d1 = SensorHoleDiameter, d2 = SensorHoleDiameter - WallThickness * 0.5, h = 6, center = false);
      cylinder(d = SensorHoleDiameter - 2 * WallThickness  , h = 6, center = false);
    }   
  } // translate

  // Stabilzer ring at the end of the shrinking tube
  translate([- (InnerSizeX + SensorHoleDiameter) / 2 - WallThickness * 4, -SensorHoleDiameter, 0])
  {

    difference()
    {
      cylinder(d = SensorHoleDiameter + WallThickness, h = 0.5, center = false);
      cylinder(d = SensorHoleDiameter - 2* WallThickness, h = 0.5, center = false);
    }

    translate([0, 0, 0.49])
    difference()
    {
      cylinder(d1 = SensorHoleDiameter, d2 = SensorHoleDiameter - WallThickness * 0.5, h = 6, center = false);
      cylinder(d = SensorHoleDiameter - 2 * WallThickness  , h = 6, center = false);
    } 
  } // translate
}

// Box
// ---
module Box()
{
  translate([ 0, 0, InnerSizeZ / 2])
  {
	difference()
	{
      minkowski() // make rounded corners
      {
        cube ([InnerSizeX, InnerSizeY, InnerSizeZ - WallThickness], true);
        cylinder(r = WallThickness, h= WallThickness, center = true);
      }

      // Cut Sensor hole
      cylinder(d = SensorHoleDiameter, h=InnerSizeZ, center = true);
      // Cut inside
      translate([0, 0, WallThickness])
      cube ([InnerSizeX, InnerSizeY, InnerSizeZ], true);
   
      // Cut time hole
      if(PotentiometerHoleDiameter > 0.)
      {
        translate([PotentiometerHoleTimeX, (InnerSizeY + WallThickness) / 2, - InnerSizeZ / 2 + WallThickness  + PotentiometerHoleOffsetZ])
          rotate([-90, 0, 0]) // Note: changes x and y
          {
            cylinder(d = PotentiometerHoleDiameter, h= WallThickness * 1.05, center = true);
            // Labeling
            translate([0, 0, WallThickness / 4])
            linear_extrude(WallThickness / 2 )
            {
              translate([-1.5, +3, -2])
                #text("T", font = MyFont, size = 3); 
              translate([-3, -1, WallThickness * 0.4])
                #text("+", font = MyFont, halign = "center", size = 3); 
              translate([2.75, -1, WallThickness * 0.4])
                #text("-", font = MyFont, halign = "center", size = 3); 
              translate([1.5, -2.25, WallThickness * 0.4])
                rotate([0, 0, 90])
                  #text("(", font = MyFont, halign = "center", size = 4);
            }
         }
      }
    
      // Cut sensitivity hole
      if(PotentiometerHoleDiameter)
      {
        translate([PotentiometerHoleSensitivityX, (InnerSizeY + WallThickness) / 2,  - InnerSizeZ / 2 + WallThickness  + PotentiometerHoleOffsetZ])
          rotate([-90, 0, 0])
          {
            cylinder(d = PotentiometerHoleDiameter, h= WallThickness * 1.05, center = true);
            // Labeling
           translate([0, 0, WallThickness / 4])
           linear_extrude(WallThickness / 2)
            {
              translate([-1.5, +3, -2])
                #text("S", font = MyFont, size = 3); 
              translate([-3, -1, WallThickness * 0.4])
                #text("+", font = MyFont, halign = "center", size = 3); 
              translate([2.75, -1, WallThickness * 0.4])
                #text("-", font = MyFont, halign = "center", size = 3); 
              translate([1.5, -2.25, WallThickness * 0.4])
                rotate([0, 0, 90])
                  #text("(", font = MyFont, halign = "center", size = 4);
            }
          }
        }
     
      // Cut cable hole
      if( ! MakeCableHoleAsCube)
      {
        translate(SetHolePosition())
          rotate(SetHoleRotate())
           cylinder(d = CableHoleDiameter, h= WallThickness, center = true);
      }
      else // cut a box
      {
        translate(SetHolePosition())
          rotate(SetHoleRotate())
           cube([CableHoleDiameter, WallThickness, CableHoleDiameter*4], center = true);
      } // no box, box
	} // difference

  } // translate box
}

// Cover
// -----
module Cover()
{
  translate([InnerSizeX + WallThickness * 4, 0, WallThickness / 2])
  {
    minkowski()
    {
      cube ([InnerSizeX, InnerSizeY, WallThickness  / 2], true);
      cylinder(r = WallThickness, h= WallThickness / 2, center = true);
    }
  
    // Clips
    // Left long
    translate([ -InnerSizeX / 2 + WallThickness / 2, 0, (WallThickness + ClipHeightZ) / 2 - 0.2])
      rotate([0, -2, 0])
        cube([WallThickness, ClipLength, ClipHeightZ], center = true);
    // Right long
    translate([+InnerSizeX / 2 - WallThickness / 2, 0, (WallThickness + ClipHeightZ) / 2 - 0.2])
      rotate([0, 2, 0])
        cube([WallThickness, ClipLength, ClipHeightZ], center = true);
    // Front short
    translate([0, +InnerSizeY / 2 - WallThickness / 2, (WallThickness + 1) / 2 ])
      cube([ClipLength, WallThickness, 1], center = true);
    // Back short
    translate([0, -InnerSizeY / 2 + WallThickness / 2, (WallThickness + 1) / 2 ])
      cube([ClipLength, WallThickness, 1], center = true);
 
  } // translate cover
}

// Helpers
// -------
function SetHolePosition() =
  PositionCableHole == 4 ? 
    [- InnerSizeX / 2 + CableHoleX, -(InnerSizeY + WallThickness) / 2, InnerSizeZ / 2 - CableHoleZ] : 
  PositionCableHole == 3 ? 
    [- InnerSizeX / 2 + CableHoleX, (InnerSizeY + WallThickness) / 2, InnerSizeZ / 2 - CableHoleZ] : 
  PositionCableHole == 2 ? 
    [ -(InnerSizeX + WallThickness ) / 2 , -InnerSizeY / 2 + CableHoleY, InnerSizeZ / 2 - CableHoleZ] : 
    [  (InnerSizeX + WallThickness ) / 2 , -InnerSizeY / 2 + CableHoleY, InnerSizeZ / 2 - CableHoleZ]
 ;

function SetHoleRotate() =
  PositionCableHole == 1 ? 
    MakeCableHoleAsCube ? [0, 0, 90] : [0,90,0] :
  PositionCableHole == 2 ? 
    MakeCableHoleAsCube ? [0, 0, 90] : [0,90,0] :
  PositionCableHole == 3 ? 
    MakeCableHoleAsCube ? [0, 0, 0] : [-90,0,0] :
    MakeCableHoleAsCube ? [0, 0, 0] : [-90,0,0]
  ;

