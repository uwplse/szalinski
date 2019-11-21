/*
// Diamond Hotend Bowden Assembly
// 
// This is an OpenSCAD script generating the bowden extruder mount used for The Diamond Hotend by RepRap.me
// To be used with the Wanhao MK9 molded extruder
//
// This code is published under Creative Commons CC-BY-SA license 2015 for RepRap.me by Kharar
// In plain english this means that you may download, use and modify this code as long as you make new versions available under the same license
// For further details please see http://creativecommons.org/licenses/
*/


//true: for assembled end product (for debugging purposes) - false: for printable output
assembled = false;

//0: Simple(no mounting bracket) - 1: coupling with frame grip - 2: like #1 but with wide hook for balance and no bottom hook - 3: Simple (like #1) but multi-in-one
mount = 3;

//1: Prusa i3 Hephestos - 2: Ultimaker/Witbox/Duplicator with lasercut bracket - 3: Custom (edit settings below)
frameType = 2;

//in case of mounting bracket and grip is in an angle (usually 45 deg. but this can be changed)
mountAngle = 45;

//1: true (left) - 0: false (right)
mirrorEnable = 0;

// fitting tolerance
mountTolerance = 0.5;

//support layer for floating holes. Set this value to the intended slicer layer thickness
layerHeight = 0.2;

//CONSTANTS below, no need to change these

equidistance = 70;		// distance in "mount=3" mode

bowdenFittingDia = 9.5;	// bowden fitting diameter
fittingDepth = 6;		// bowden fitting diameter

filamentCatchDia = 4;	// filament catching bulge
filamentCatchProt = 7;	// filament catching bulge prodrude

filamentOffsetZ = 10;	// filament height above motor base
filamentOffsetX = 6;	// filament offset to motor axis (depends on drivegear used: 6 for MK7 & 4 for MK8)

bodyWidth = 9;			// width of various parts of extruder mount (safe value = 8)
screwLength = 20;		// choose for M3 screw length 20 mm

countersinkM3 = 3;		// countersink the M3 screw head, since the screw tip should go at least 3 mm into the motor
countersinkM3Width = 7;	// width of hole for screw head
diameterHoleM3 = 3.7;	// small vertical holes tend to come out too narrow
stepperDistanceM3 = 31;	// 31 for NEMA17
stepperWidth = 42.3;	// 42.3 for NEMA17

leverExtension = 12;	// length of the lever counterpart
gripExtLength = 34;		// Length of balance hook extension (actual length of motor)


//Prusa i3 Hephestos
frameHeightType1 = 40.2;
frameThicknessType1 = 6.1;

//Lasercut (Witbox/Duplicator style mount)
frameHeightType2 = 40.2;
frameThicknessType2 = 6.4;

//Custom frame dimensions (if your frame has other dimensions enter them here)
frameHeightCustom = 40;
frameThicknessCustom = 6;


$fn = 50;

bodyHeight =
	(mount == 0 || mount == 2 || mount == 3)?
		screwLength:
	screwLength-countersinkM3;

angled =
	(((mount != 0) || (mount != 3)) && (frameType == 1))?
		1: // if Prusa i3 mount
	0;

frameGrip =
	((mount != 0) && (mount != 3))?
		true:
	false;

fittingDiameter =
	(mount == 2)?
		bowdenFittingDia + 0.2:	// add some, due to overhang in rotated mount=2
	bowdenFittingDia;

gripExtension =
	(mount == 2)?
		true:
	false;

otherMount =
	(frameType == 3)?
		true: // if you want to experiment with designing a custom mount, in code you may add: if (otherMount==true) { statements; }
	false;

frameThickness =
	(frameType == 1)?
		frameThicknessType1:
	(frameType == 2)?
		frameThicknessType2:
	frameThicknessCustom;
		
frameHeight =
	(frameType == 1)?
		frameHeightType1:
	(frameType == 2)?
		frameHeightType2:
	frameHeightCustom;


//MAIN
if (assembled == true) {
	body();
} else {
	printable();
}


module printable() {
	if (gripExtension) {
	translate([0, 0, filamentOffsetZ])
		rotate([0, 180, 0])
		intersection() {
			body();
			
			cut();
		}//intersection
		
		translate([-12, 15, bodyHeight])
		rotate([180, 0, 0])
		difference() {
			body();
			
			cut();
		}//difference
	} else {
		intersection() {
			body();
			
			cut();
		}//intersection
		
		translate([0, 15, bodyHeight])
		rotate([180, 0, 0])
		difference() {
			body();
			
			cut();
		}//difference
	}
}

module cut() {
	translate([0, 0, filamentOffsetZ-2*bodyHeight+0.01])
	cube([1000, 20, 4*bodyHeight], center=true);
}

module body() {
	mirror([mirrorEnable, 0, 0]) {
		difference() {
			union() {
				//main part top clamp
				hull() {
					translate([stepperDistanceM3/2+leverExtension+((mount==3)?2*equidistance:0), 0, bodyHeight/2])
					cylinder(r=bodyWidth/2, h=bodyHeight, center=true);
					
					translate([-stepperDistanceM3/2, 0, bodyHeight/2])
					cylinder(r=bodyWidth/2, h=bodyHeight, center=true);
				}//hull
				
				for (a=[0:1:(mount==3)?2:0])
				translate([a*equidistance, 0, 0]){
					bodyFilamentHoleAdd();
					
					mount();
					
					bodyGripExtension();
				}
			
			}//union
			
			//difference
			for (a=[0:1:(mount==3)?2:0])
			translate([a*equidistance, 0, 0])
			union() {
				//thumb retention
				translate([stepperDistanceM3/2+leverExtension/2, -bodyWidth/4-10, bodyHeight/2])
				cylinder(r=10, h=bodyHeight+1, center=true);
				
				union() {
					//stepper motor M3 cut
					for(i=[-1, 1]) {
						translate([i*stepperDistanceM3/2, 0, filamentOffsetZ])
						cylinder(r=diameterHoleM3/2, h=30, center=true);
						
						// M3 screw head countersunk
						if (mount == 0 || mount == 2|| mount == 3) {
							if (mount != 2)
								translate([i*stepperDistanceM3/2, 0, -0.1])
								cylinder(r=countersinkM3Width/2, h=countersinkM3+0.1);
							
							translate([i*stepperDistanceM3/2, 0, bodyHeight-countersinkM3])
							cylinder(r=countersinkM3Width/2, h=countersinkM3+0.1);
						} //if
					} //for
					
					translate([-filamentOffsetX, 0, filamentOffsetZ])
					union() {
						//bowden fitting
						rotate([90, 0, 0])
						cylinder(r=fittingDiameter/2, h=30);
						
						//filament funnel
						rotate([270, 0, 0])
						translate([0, 0, -0.1])
						cylinder(r1=2/2, r2=filamentCatchDia/2, h=filamentCatchProt+0.2);
					}//union
				}//union
				
				//top cut
				translate([0, 0, bodyHeight])
				cylinder(r=100, h=bodyHeight);
				
				if (frameGrip==true) {
					hull() {
						//MK9 lever axis cut-out
						translate([-stepperWidth/2+5, stepperDistanceM3, -1])
						cylinder(r=12/2, h=bodyHeight+2);
						
						//MK9 new wider version lever axis cut-out
						translate([-stepperWidth/2+5, stepperWidth/4, -1])
						cylinder(r=12/2, h=bodyHeight+2);
					}
				}
				
				if (mount == 3)
				for (b=[0])
				translate([stepperDistanceM3/2+leverExtension+7+(b*equidistance), 0, filamentOffsetZ])
				rotate([90, 0, 0])
				cylinder(r=2, h=20, center=true);
			}//union
		}//difference
		
		// M3 countersunk hole support
		for (a=[0:1:(mount==3)?2:0])
		translate([a*equidistance, 0, 0])
		if (mount == 0 || mount == 2 || mount == 3) {
			for(i=[-1, 1]) {
				if (mount != 2)
				translate([i*stepperDistanceM3/2, 0, countersinkM3])
				cylinder(r=countersinkM3Width/2, h=layerHeight);
				
				translate([i*stepperDistanceM3/2, 0, bodyHeight-countersinkM3-layerHeight])
				cylinder(r=countersinkM3Width/2, h=layerHeight);
			} //for
		}//if
	}//mirror
}//module

module bodyFilamentHoleAdd() {
	//filament catching bulge
	translate([-filamentOffsetX, -0.01, filamentOffsetZ])
	rotate([270, 0, 0])
	cylinder(r1=10/2, r2=filamentCatchDia/2, h=filamentCatchProt);
	
	//fitting support bulge
	translate([-filamentOffsetX, -bodyWidth/2+0.01, filamentOffsetZ])
	rotate([90, 0, 0])
	cylinder(r1=round(fittingDiameter)/2+fittingDepth-bodyWidth/2, r2=round(fittingDiameter)/2, h=fittingDepth-bodyWidth/2);
}

module bodyGripExtension() {
	if (gripExtension) {
		translate([0, 0, -gripExtLength])
		scale([1, 1, gripExtLength]) {
			intersection() {
				mount();
				
				if (angled) {
					difference() {
						translate([1, 16, 0])
						rotate([0, 0, mountAngle])
						translate([-1-1.5*stepperWidth, -bodyWidth/2, 0])
						cube([stepperWidth, frameHeight*0+bodyWidth*2, 1]);
						
						translate([0, stepperDistanceM3/2, 0])
						cube([stepperWidth, stepperWidth, 2], center=true);
					}
				} else {
					translate([-1-1.5*stepperWidth, -bodyWidth/2, 0])
					cube([stepperWidth, frameHeight*0+bodyWidth*2, 1]);
				}
			}
		}
	}
	
	//reinforcement around the angled part
	if (frameGrip && angled) {
		translate([-stepperDistanceM3/2, 0, 0])
		cylinder(r=bodyWidth/2+2, h=filamentOffsetZ);
	}
}

module mount() {
	translate([-angled*stepperDistanceM3/2, 0, 0])
	rotate([0, 0, angled*mountAngle])
	translate([angled*(stepperDistanceM3/2+6), 0, 0])
	if (frameGrip==true) {
		//main part top
		hull() {
			translate([-stepperDistanceM3/2-6*angled, 0, filamentOffsetZ/2])
			cylinder(r=bodyWidth/2, h=filamentOffsetZ, center=true);
			
			translate([-(stepperWidth/2+bodyWidth+frameThickness+mountTolerance), 0, filamentOffsetZ/2])
			cylinder(r=bodyWidth/2, h=filamentOffsetZ, center=true);
		}//hull
		
		//side part (vertical)
		hull() {
			translate([-(stepperWidth/2+bodyWidth/2), 0, filamentOffsetZ/2])
			cylinder(r=bodyWidth/2, h=filamentOffsetZ, center=true);
			
			translate([-(stepperWidth/2+bodyWidth/2), frameHeight+mountTolerance+bodyWidth/2, filamentOffsetZ/2])
			cylinder(r=bodyWidth/2, h=filamentOffsetZ, center=true);
		}//hull
		
		//mounting grip upper
		translate([-(stepperWidth/2+bodyWidth+frameThickness+mountTolerance), 0, 0])
		linear_extrude(height=filamentOffsetZ)
		polygon([
			[0, bodyWidth/2],
			[-bodyWidth/2, 0],
			[-bodyWidth/2, bodyWidth/2],
			[-frameThickness*(frameThickness/frameHeight), bodyWidth]
			]);
		
		//mounting grip lower
		if (!gripExtension) {
			translate([-(stepperWidth/2+bodyWidth/2), frameHeight+mountTolerance+bodyWidth/2, 0])
			linear_extrude(height=filamentOffsetZ)
			polygon([
				[0, 0],
				[1-frameThickness-bodyWidth/2, 0],
				[1-frameThickness/2-bodyWidth/2, bodyWidth/2],
				[0, bodyWidth/2]
				]);
		}
		
	}//if
}//module