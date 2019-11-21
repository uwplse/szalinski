// length of the hook
hookLength = 20;

// height of the wall mounted part
hookHeight = 40;

// depth of the hook area
hookDepth = 23;

// number of holes
holeCount = 1; // [0:70]

// hole diameter
holeDiameter = 5;

// hole offset to the top and the sides of the hook
holeOffset = 12;

// activates the tapered holes
holeTapered = 1; // [0:No, 1:Yes]

// enables the keyhole-style opening
holeKeyhole = 1; // [0:No, 1:Yes]

// separated hook count
hookCount = 1;

// distance from hook to hook
hookDistance = 20;

// activate rounded Corners (the hook will get 2mm thicker) [EXPERIMENTAL]
roundCorners  = 0; // [0:No, 1:Yes]

holeRadius = holeDiameter / 2.;
holeRadiusCountersunk = holeRadius * 2;
holeDepthCountersunk = holeRadius * 1;
holeZ = hookHeight - holeOffset;

holeDistance = (hookLength - (2 * holeOffset)) / 
(holeCount - 1);

hookSeperatorDistance = (hookLength - (hookDistance * (hookCount - 1))) / (hookCount);

module MyHook(){
	// set number of faces
	$fn=30; 
	
	difference(){
		if(roundCorners){
			minkowski(){
				plainMultipleHook();
				sphere(1, centered=true, $fn=20);
			}
		}else{
			plainMultipleHook();
		}
		generateHoles();
		
	}
}

module plainMultipleHook(){
	difference(){
		plainHook();
		multipleHookSpacers();
	}
}

module plainHook(){
	union(){
		// upper
		cube([7,hookLength,hookHeight]);
			
		// lower
		translate([7,0,0]) cube([hookDepth ,hookLength,7]);
		// hook
		translate([7 + hookDepth ,0,0]) cube([7,hookLength,15]);
			
		// corners
		translate([2,0,9]) rotate([0,45,0]) cube([10,hookLength,6]);
		translate([hookDepth + 5 ,0,2]) rotate([0,-45,0]) cube([10,hookLength,6]);
	}
}

module multipleHookSpacers(){
	// seperator boxes
	if(hookCount >= 2){
		for(seperator = [1: hookCount - 1]){
			translate([13, seperator * hookSeperatorDistance + hookDistance * (seperator - 1), -1]) cube([hookDepth + 7, hookDistance, 17]);
		}
	}
}

module generateHoles(){
	if(holeCount == 1){
		holeYPosition = hookLength / 2;
		generateSingleHole(holeYPosition);
	}else{
		
		for(hole = [0: holeCount - 1]){
			holeYPosition = hole * holeDistance + holeOffset;
			generateSingleHole(holeYPosition);
		}
	}
}

module generateSingleHole(holeYPosition){
	translate([0, holeYPosition, holeZ]){
		// hole
		translate([-5,0,0])
		rotate([0,90,0])
		cylinder(22, holeRadius, holeRadius);
		
		// tapering
		if(holeTapered){
			hull() {
				union() {
					translate([7 - holeDepthCountersunk, 0, 0])
					rotate([0,90,0])
					cylinder(3.1, holeRadius, holeRadiusCountersunk);
					
					translate([7.59, 0, 0])
					rotate([0,90,0])
					cylinder(10,holeRadiusCountersunk, holeRadiusCountersunk);
				}
				if(holeKeyhole) translate([0,0,-holeRadiusCountersunk * 1.5]) union() {
					translate([7 - holeDepthCountersunk, 0, 0])
					rotate([0,90,0])
					cylinder(3.1, holeRadius, holeRadiusCountersunk);
					
					translate([7.59, 0, 0])
					rotate([0,90,0])
					cylinder(10,holeRadiusCountersunk, holeRadiusCountersunk);
				}
			}
		}

		if(holeKeyhole){
			hull(){
				translate([-5,0,0]) rotate([0,90,0]) cylinder(22, holeRadius, holeRadius);
				translate([-5,0,-holeRadiusCountersunk * 1.5]) rotate([0,90,0]) cylinder(22, holeRadius, holeRadius);
			}
			translate([-1,0,-holeRadiusCountersunk * 1.5])
				rotate([0,90,0])
					cylinder(h = 10, r = holeRadiusCountersunk);
		}
	}
}

MyHook();
