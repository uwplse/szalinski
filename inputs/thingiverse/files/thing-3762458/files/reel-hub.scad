/* Builds a reel hub that handles most common reel sizes.
   For FlashForge Inventor, the reel stand needs to be replaced.
   See reel-holder.scad for details.

   Uses commonly available skate board bearings.
*/

$fa=1;
$fs=1;

BearingDiameter = 22;
BearingID = 8;
BearingHeight = 7;
MinReelDiameter=48;
MaxReelDiameter=55;
MaxIntrusion=10; // Maximum depth to penetrate into the reel hub
WallThickness = 3;

// Add 2% to the radius to compensate for the interior polygon effect
BearingOuterRadius = BearingDiameter * 1.02 / 2;
BearingInnerRadius = BearingOuterRadius - WallThickness;

// Outer reel cone and top plate
difference(){
    cylinder(r2=MaxReelDiameter/2, r1=MinReelDiameter/2, h=MaxIntrusion);
    translate([0,0,MaxIntrusion-BearingHeight]){
        cylinder(r2=MaxReelDiameter/2-WallThickness, r1=MinReelDiameter/2-WallThickness, h=BearingHeight);
    }
    cylinder(r=BearingInnerRadius, h=MaxIntrusion);
}

// Inner bearing holder ring
translate([0,0,MaxIntrusion-BearingHeight]){
    difference(){
        cylinder(r=BearingOuterRadius+WallThickness, h=BearingHeight);
        cylinder(r=BearingOuterRadius, h=BearingHeight);
    }
}

// Bracing between the two
intersection(){
    translate([0,0,MaxIntrusion-BearingHeight]){
        for (i = [1:12]){
            rotate(a=360*i/12,v=[0,0,1]){
                difference(){
                    cube([WallThickness, MaxReelDiameter/2, BearingHeight]);
                    cube([WallThickness, BearingOuterRadius, BearingHeight]);
                }
            }
        }
    }
    difference(){
        cylinder(r2=MaxReelDiameter/2-WallThickness, r1=MinReelDiameter/2-WallThickness, h=MaxIntrusion);
        cylinder(r=BearingOuterRadius+WallThickness, h=MaxIntrusion);
    }
}
