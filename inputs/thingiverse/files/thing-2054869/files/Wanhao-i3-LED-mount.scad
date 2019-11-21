part=""; // [sideleft:Left side,sideright:Right side,coverleft:Left cover,coverright:Right cover (identical to left),dcjack:DC jack,top:Top,covertop:Top cover]

// ** Side LED angle calculation variables **
// Distance of the side LEDs from the center of the bed.
sideOffsetX = 142.5;

// The target X position for each side LED relative to the center of the bed (40 means point it 4 cm outwards from the center). Determines the amount of LEDs as well.
sideFocalOffsetsX = [70, 50, 30, 10];

// The amount of LEDs on the top mount.
topLEDCount = 4;

// Starting height of the side LEDs relative to the bed.
sideOffsetZ = 20;


// ** Side mount measurements **
// Distance between LEDs.
ledDistance = 20;

// Margin above the first and below the last LED.
firstLastMargin = 10;

// Margin on the sides of the LEDs.
sideMargin = 1;

// Depth of the LED mounting block.
mountDepth = 8;

// Width of the support structure you wish to clamp on to.
clampSpacing = 1.5;

// Thickness of the clamp itself.
clampThickness = 2;

// Depth of the clamp.
clampDepth = 15;


// Height of the LED lens. This variable isn't really accurate, but influences how far the LED can be pushed through. Smaller values means further.
ledHeight = 5.5;

// Diameter of the LED lens.
ledDiameter = 5.5;

// Diameter of the remainder of the hole for the LED.
ledHoleDiameter = 6.5;

// Width of the wire channel.
wireChannelWidth = 3;

// Depth of the wire channel.
wireChannelDepth = 2;


// Width of the tabs to hold the cover clip in place.
tabWidth = 2;

// Depth of the tabs to hold the cover clip in place.
tabDepth = 2;

// Height of the tabs to hold the cover clip in place.
tabHeight = 1;

// Thickness of the cover clip.
coverThickness = 2;

// Margin all around the cover to prevent it being too tight.
coverMargin = 0.2;


dcJackMountThickness = 2;
dcJackMountWidth = 19.5;
dcJackMountHeight = 19.5;
dcJackMountDepth = 29;
dcJackDiameter = 11.5;

// The depth of the cut-out on the side opposite the clamp, to leave room for the Z axis on the Wanhao i3.
dcJackCutoutDepth = 16;

// The width of the cut-out on the side opposite the clamp, to leave room for the Z axis on the Wanhao i3.
dcJackCutoutWidth = 6;


module IfPart(partName)
{
  if (part == "" || part == partName)
  {
    children();
  }
}


module LEDslicer()
{
  translate([0, 0, (ledHeight * 2) - 1])
    cylinder((mountDepth * 2) + 1, d = ledHoleDiameter, $fs = 1);

  cylinder(ledHeight * 2, d = ledDiameter, $fs = 1);
}


function MountWidth() = ledHoleDiameter + (2 * sideMargin);
function MountHeight(ledCount) = ((ledCount - 1) * ledDistance) + (2 * firstLastMargin);
function LEDOffset(ledIndex) = firstLastMargin + (ledIndex * ledDistance);

function SideLEDCount() = len(sideFocalOffsetsX);
function SideLEDAngle(ledIndex) = atan((sideOffsetX - sideFocalOffsetsX[ledIndex]) / (sideOffsetZ + LEDOffset(ledIndex)));


module Tab()
{
  translate([-(tabDepth / 2), tabWidth / 2, 0])
    rotate([90, 0, 0])
    linear_extrude(tabWidth)
    polygon([[0, 0], [tabDepth, 0], [tabDepth, tabHeight]]);
}


module Clamp(ledCount)
{
  translate([mountDepth - clampThickness, -clampSpacing, 0])
    cube([clampThickness, clampSpacing, MountHeight(ledCount)]);

  translate([mountDepth - clampDepth, -(clampSpacing + clampThickness), 0])
    cube([clampDepth, clampThickness, MountHeight(ledCount)]);
}


module Mount(ledCount)
{
  union()
  {
    difference()
    {
      // Mount
      cube([mountDepth, MountWidth(), MountHeight(ledCount)]);

      children();

      // LED wire channel
      translate([-1, sideMargin, -1])
        cube([wireChannelDepth + 1, wireChannelWidth, MountHeight(ledCount) + 2]);
    }

    // Tabs
    translate([mountDepth / 4 * 3, MountWidth() / 2, MountHeight(ledCount)])
      Tab();

    mirror([0, 0, 1])
      translate([mountDepth / 4 * 3, MountWidth() / 2, 0])
      Tab();

    Clamp(ledCount);
  }
}


module SideMount()
{
  Mount(SideLEDCount())
  {
      yOffset = sideMargin + (ledHoleDiameter / 2);

      // LED cutouts
      for (ledIndex = [0:SideLEDCount() - 1])
      {
        translate([mountDepth + ledDiameter, yOffset, LEDOffset(ledIndex) - (ledHoleDiameter / 2)])
          rotate([0, -SideLEDAngle(ledIndex), 0])
          LEDslicer();
      }
  }
}


module TopMount()
{
  Mount(topLEDCount)
  {
      yOffset = sideMargin + (ledHoleDiameter / 2);

      // LED cutouts
      for (ledIndex = [0:topLEDCount - 1])
      {
        translate([mountDepth + ledDiameter, yOffset, LEDOffset(ledIndex)])
          rotate([0, -90, 0])
          LEDslicer();
      }
  }
}


module CoverSide()
{
  difference()
  {
    cube([coverThickness + coverMargin + mountDepth, MountWidth(), coverThickness]);

    // Tab slots
    translate([(mountDepth / 4 * 3) + coverThickness + coverMargin, MountWidth() / 2, 0])
      translate([-(tabDepth / 2) - coverMargin, -(tabWidth / 2) - coverMargin, -1])
      cube([tabDepth + coverMargin, tabWidth + (2 * coverMargin), coverThickness + 2]);

    // Wire channel
    translate([coverThickness + coverMargin, -1, -1])
      cube([wireChannelDepth, wireChannelWidth + sideMargin + 1, coverThickness + 2]);
  }
}


module Cover(ledCount)
{
  translate([0, 0, -(coverMargin + coverThickness)])
    cube([coverThickness, MountWidth(), MountHeight(ledCount) + ((coverMargin + coverThickness) * 2)]);

  // Top
  translate([0, 0, MountHeight(ledCount) + coverMargin])
    CoverSide();

  // Bottom
  translate([0, 0, -coverMargin])
    mirror([0, 0, 1])
    CoverSide();
}


module ConnectedPreview()
{
  SideMount();
  translate([-(coverThickness + coverMargin), 0, 0])
    #Cover();
}


module DCJackMount()
{
  difference()
  {
    cube([dcJackMountDepth, dcJackMountWidth, dcJackMountHeight]);

    translate([-dcJackMountThickness, dcJackMountThickness, dcJackMountThickness])
      rotate([90, 0, 90])
      cube([dcJackMountWidth - (2 * dcJackMountThickness),
            dcJackMountHeight - (2 * dcJackMountThickness),
            dcJackMountDepth]);

    translate([dcJackMountDepth - dcJackMountThickness - 1, dcJackMountWidth / 2, dcJackMountHeight / 2])
      rotate([0, 90, 0])
      cylinder(d = dcJackDiameter, h = dcJackMountThickness + 2);

    translate([-1, dcJackMountWidth - dcJackCutoutWidth, -1])
      cube([dcJackCutoutDepth + 1, dcJackCutoutWidth + 1, dcJackMountHeight + 2]);
  }

  translate([dcJackMountDepth - clampThickness, -clampSpacing, 0])
    cube([clampThickness, clampSpacing, dcJackMountHeight]);

  translate([dcJackMountDepth - clampDepth, -(clampSpacing + clampThickness), 0])
    cube([clampDepth, clampThickness, dcJackMountHeight]);
}


// Replace * with ! to show a preview of the end result of a side mount
*ConnectedPreview();

IfPart("sideleft")
{
  translate([10, 0, mountDepth])
    rotate([0, 90, 0])
    SideMount();
}

IfPart("coverleft")
{
  translate([MountHeight(SideLEDCount()) + 10, MountWidth() + 10, mountDepth])
    rotate([-90, 0, 0])
    rotate([0, -90, 0])
    Cover(SideLEDCount());
}

IfPart("sideright")
{
  translate([-10, 0, mountDepth])
    rotate([0, -90, 0])
    mirror([1, 0, 0])
    SideMount();
}

IfPart("coverright")
{
  translate([-10, (MountWidth() + 10) * 2, mountDepth])
    rotate([-90, 0, 0])
    rotate([0, -90, 0])
    mirror([1, 0, 0])
    Cover(SideLEDCount());
}

IfPart("top")
{
  translate([10, (MountWidth() + 10) * 3, mountDepth])
    rotate([0, 90, 0])
    TopMount();
}

IfPart("covertop")
{
  translate([-10, (MountWidth() + 10) * 3, mountDepth])
    rotate([-90, 0, 0])
    rotate([0, -90, 0])
    Cover(topLEDCount);
}

IfPart("dcjack")
{
  translate([-(dcJackMountWidth / 2), -50, dcJackMountDepth])
    rotate([0, 90, 0])
    DCJackMount();
}