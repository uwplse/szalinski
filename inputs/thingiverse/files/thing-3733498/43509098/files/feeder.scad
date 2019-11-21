/*
 Creates a simple box that can be hung from a wire fence.  The
 default dimensions match a standard "chicken tractor" and can
 hold either food or water for about 4 chickens.

 If you want to hang on chicken wire, measure the distance between
 two horizontal twists and use that as the HangerPitch.
*/

BoxHeight = 50; // Height of box
BoxWidth = 150;  // Width
BoxDepth = 100;  // Depth
WallThickness = 1.2;  // Wall thickness
HangerWidth = 6; // Width of hanger
HangerHeight = 8; // Height of hanger
HangerPitch = 13; // Increments for hanger placement
HangerDepth = 3.2; // depth of hanger, also hanger offset

/*
  The rest of these are derived from
  the above.
*/
// Half values for translations
BoxHalfWidth = BoxWidth/2;
BoxHalfDepth = BoxDepth/2;
HangerHalfWidth = HangerWidth/2;
HangerInset = (HangerPitch-HangerWidth) / 2;

// Last possible offset for a hanger is based on the half width
HangerPitchCount = floor(BoxWidth/HangerPitch) -1;
HangerEdgeOffset = HangerPitch * HangerPitchCount / 2;

// Offsets for hanger.  Based on centering the hanger width within a hanger increment
LeftHangerPosition = -1 * (HangerEdgeOffset - HangerInset);
RightHangerPosition = HangerEdgeOffset - HangerWidth - HangerInset;
VerticalHangerOffset = BoxHeight - HangerHeight;
HangerOvershoot = HangerHeight - HangerDepth;
HangerOuterY = -1 * (BoxHalfDepth + (HangerDepth * 2));
HangerInnerY = -1 * (BoxHalfDepth + HangerDepth);

// spacer bar is based on the above
SpacerBarPosition = BoxHalfWidth / 5;
SpacerBarWidth = BoxWidth / 5;

// Create the main box, a simple cube with another smaller cube cut out
module MainBox() {
    translate([BoxHalfWidth*-1,BoxHalfDepth*-1,0]) {
        difference() {
            cube([BoxWidth,BoxDepth,BoxHeight]);
            translate([WallThickness,WallThickness,WallThickness]){
                cube([BoxWidth-(2*WallThickness),BoxDepth-(2*WallThickness),BoxHeight-WallThickness]);
            }
        }
    }
}

// Create a hanger, basically two overlapping cubes that will
// fit within the pitch supplied.
module Hanger(pos) {
    translate([pos,HangerOuterY,VerticalHangerOffset]) {
        cube([HangerWidth,HangerDepth,HangerHeight]);
        translate([0,HangerDepth,HangerOvershoot]) {
            cube([HangerWidth,HangerDepth,HangerDepth]);
        }
    }
}

// Spacer is placed on the bottom, to ensure the box stays upright when hung
module SpaceBar() {
    translate([-1 * SpacerBarPosition,HangerInnerY,0]) {
        cube([SpacerBarWidth,HangerDepth,HangerDepth]);
    }
}

MainBox();
Hanger(LeftHangerPosition);
Hanger(RightHangerPosition);
SpaceBar();
