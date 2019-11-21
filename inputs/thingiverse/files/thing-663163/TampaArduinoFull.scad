thickness = 3;
height = 170;
width = 85;
length = 70;

sideProtectionHeight = 20;

usbHoleSize = 14;
usbSideDistance = 16;
usbHeight = length - usbHoleSize - 2;

powerLength = 20;
powerWidth = 26;
powerOppositeSideDistance = width - powerWidth - 15;
powerLengthDistance = length - powerLength - 13;

cablesRadius = 15;
cablesHeightDistance = 70;

fixationUpperDistance = 10;
fixationLengthDistance = usbHoleSize+usbSideDistance;
fixationWidth = 10;
fixationHeight = length - 14;
fixationThickness = thickness * 1.5;
fixationSupportStep = 15;

fixationBottomUpperDistance = fixationUpperDistance + 110;
fixationBottomLengthDistance = powerOppositeSideDistance+powerWidth-fixationWidth;
fixationBottomHeight = length - 26;
fixationBottomSupportHeight = fixationBottomHeight * .8;
fixationBottomSupportLength = height - fixationThickness*3 - fixationBottomUpperDistance;
fixationBottomSupportAngle = 313;


ventilationHoleHeight = 95;
ventilationHoleWidth = width * .8;
ventilationHoleHeightDistance = fixationUpperDistance + 10;
ventilationHoleWidthDistance = width * .1;

ventilationStep = 3;

union() {
	//Main box
	difference() {
		cube([height, width, length]);
		translate([thickness,thickness,thickness])
			cube([height+thickness, width+thickness, length+thickness]);

		//USB hole
		translate([0, usbSideDistance, usbHeight])
			cube([thickness*2, usbHoleSize, usbHoleSize	]);

		//Power Source hole
		translate([0, powerOppositeSideDistance, powerLengthDistance])
			cube([thickness*2, powerWidth, powerLength]);

		//Cables hole
		translate([cablesHeightDistance, 0, length])
			rotate([270,0,0])
				cylinder(h = thickness*2, r = cablesRadius);

		//Ventilation hole
		translate([ventilationHoleHeightDistance, ventilationHoleWidthDistance, 0])
			cube([ventilationHoleHeight, ventilationHoleWidth, thickness*2]);


	}
	
	//Upper fixation
	translate([fixationUpperDistance, fixationLengthDistance, 0])
		cube([fixationThickness, fixationWidth, fixationHeight]);
	translate([fixationUpperDistance+fixationThickness, fixationLengthDistance, fixationHeight-thickness])
		rotate([270,0,0])
			cylinder(h = fixationWidth, r = thickness);	
	for (stepSupport = [thickness+fixationSupportStep:fixationSupportStep:fixationHeight-fixationSupportStep*2]) 		{
			translate([thickness, fixationLengthDistance, stepSupport])
				cube([fixationUpperDistance, fixationWidth, thickness]);		
	}
	
	//Bottom fixation
	translate([fixationBottomUpperDistance, fixationBottomLengthDistance, 0])
		cube([fixationThickness, fixationWidth, fixationBottomHeight]);
	translate([fixationBottomUpperDistance, fixationBottomLengthDistance, fixationBottomHeight-thickness])
		rotate([270,0,0])
			cylinder(h = fixationWidth, r = thickness);	
	difference() {
		translate([fixationBottomUpperDistance+fixationThickness, fixationBottomLengthDistance+(fixationWidth/2-thickness/4), 0])
			cube([fixationBottomSupportLength, thickness/2, fixationBottomSupportHeight]);

		translate([fixationBottomUpperDistance+fixationThickness+fixationBottomSupportLength, fixationBottomLengthDistance+(fixationWidth/2-thickness/2), 0])
			rotate([0, fixationBottomSupportAngle, 0])
				cube([fixationBottomSupportLength, fixationThickness, fixationBottomSupportHeight*2]);
	}
	

	//Side Protection
	translate([0, width-thickness, 0])
		cube([height, thickness, sideProtectionHeight]);
	
	//Bottom Protection
	translate([height-thickness, 0, 0])
		cube([thickness, width, sideProtectionHeight]);

	//Ventilation grid
	for (step = [fixationUpperDistance:ventilationStep:ventilationHoleHeightDistance+ventilationHoleHeight]) 		{
		if ((step%2) == 0) {
			translate([fixationUpperDistance+step, ventilationHoleWidthDistance, thickness/2])
				rotate([270,0,0])
					cylinder(h = ventilationHoleWidth, r = thickness/2);		
		}
	}


}