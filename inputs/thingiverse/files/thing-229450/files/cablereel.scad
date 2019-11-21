//Thickness of back and reel walls
reelThickness = 2.5; //At least 1

//How far the reel comes out from the wall
reelDepth = 45; //At least 0

//The radius of the circular reel closest to the mount side
reelRadius = 48;

//How wide the back mounting portion comes out from the wheel circle
backHeight = 40; //At least 5x the diameter of your cable to allow room for the cable holder

//Radius of the 4 mounting holes:
holeRadius = 1.4;

//How far the center of the holes are from the edge of the back mounting portion
holeCenterOffset = 10;

//The diameter of the cable you're reeling.  Used for the cable holder scale.
cableDiameter = 5;


holderGap = cableDiameter * (4/5);
holderScale = holderGap/5;
holderDiameter = 32 * holderScale;
chamferLength = reelDepth / 10;
outerReelOffset = reelDepth / 5;

$fa = 2;
$fs = .5;

rotate([0,180,0]){
	difference(){
		rotate_extrude(convexity = 10){ //Main reel wheel and back portion is a rotational extrusion
			polygon(points = [[reelRadius,reelDepth],[reelRadius+reelThickness,reelDepth],[reelRadius+outerReelOffset+reelThickness,0],[reelRadius+outerReelOffset,0]]); //forms the reel wheel
			translate([reelRadius,reelDepth,0]) {
				square([backHeight,reelThickness]); //forms the back mounting portion
			}
			translate([reelRadius+reelThickness,reelDepth,0]) { 
				polygon(points = [[0,0],[0,-chamferLength],[chamferLength,0]]); //the chamfer triangle between the reel and the back portion
			}
			translate([reelRadius+outerReelOffset+(reelThickness/2),0,0]) {
				circle(reelThickness/2); //the round on the outside of the reel.
			}
		}
		rotate([0,0,45]){
			union(){  //The four mounting holes
				translate([reelRadius+backHeight-holeCenterOffset,0,reelDepth]){
					cylinder(reelThickness,holeRadius,holeRadius);
				}
				translate([0,reelRadius+backHeight-holeCenterOffset,reelDepth]){
					cylinder(reelThickness,holeRadius,holeRadius);
				}
				translate([-(reelRadius+backHeight-holeCenterOffset),0,reelDepth]){
					cylinder(reelThickness,holeRadius,holeRadius);
				}
				translate([0,-(reelRadius+backHeight-holeCenterOffset),reelDepth]){
					cylinder(reelThickness,holeRadius,holeRadius);
				}
			}
		}
	}
}
translate([reelRadius+backHeight-holderDiameter,0,-(reelDepth-reelThickness/2)]){
	scale([holderScale,holderScale,holderScale]){
		translate([0,-16.5,0]){
			import("CableHolder.stl"); //this is the cable holder
		}
	}
}