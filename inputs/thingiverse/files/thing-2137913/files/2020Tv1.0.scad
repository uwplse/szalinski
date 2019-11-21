profileLength = 1000;
//printX = 150; Not implemented
//printY = 150; Not implemented
printZHeight = 230;
printTolerance = 0.25; //Change dimensions of pin and hole 0.25mm equals gab of 0.5 mm
spaceBetweenProfiles = 5;
$fa=0.5; // default minimum facet angle is now 0.5
$fs=0.5; // default minimum facet size is now 0.5 mm

if(profileLength <= printZHeight) {
	translate([10,10,profileLength/2]) profile(profileLength);
} else {
	numOfProfiles = ceil(profileLength/(printZHeight-8));
	numOfRow = ceil(sqrt(numOfProfiles));
	currentProfile = 2;
	start = 0;
	translate([start,start,0]) profileWithPin(profileLength/numOfProfiles, printTolerance);
	for(row=[0:numOfRow-1]) {
		for(col=[0:numOfRow-1]) {
			if(row*numOfRow+col < numOfProfiles-1 && row*numOfRow+col > 0) {
				translate([start+row*(20+spaceBetweenProfiles),start+col*(20+spaceBetweenProfiles),0]) profileWithHoleAndPin(profileLength/numOfProfiles, printTolerance);
			} else {
				if(row*numOfRow+col < numOfProfiles) {
					translate([start+row*(20+spaceBetweenProfiles),start+col*(20+spaceBetweenProfiles),0]) profileWithHole(profileLength/numOfProfiles, printTolerance);
					lastProfileDone = 1;
				}
			}
		}
	}
}

module hole(height, size) {
	radius = 1;
	divider = 1.6;
	union() {
		cube([size,size,height], center = true);
		translate([size/2-radius/divider,size/2-radius/divider,0]) cylinder(h=height, r=radius, center = true);
		translate([size/2-radius/divider,-size/2+radius/divider,0]) cylinder(h=height, r=radius, center = true);
		translate([-size/2+radius/divider,size/2-radius/divider,0]) cylinder(h=height, r=radius, center = true);
		translate([-size/2+radius/divider,-size/2+radius/divider,0]) cylinder(h=height, r=radius, center = true);
	}
}

module profileWithPin(length, tolerance) {
	height = 8 - tolerance - 1;
	size = 5.4 - tolerance;
	plunge = 5;
	translate([10,10,length/2]) union() {
		profile(length);
		translate([0,0,length/2+(height+plunge)/2-plunge]) cube([size,size,height+plunge], center = true);
	}
}

module profileWithHole(length, tolerance) {
	height = 8 + tolerance;
	size = 5.4 + tolerance;
	plunge = 1;
	translate([10,10,length/2]) difference() {
		profile(length);
		translate([0,0,length/2-(height+plunge)/2+plunge]) hole(height+plunge, size);
	}
}

module profileWithHoleAndPin(length, tolerance) {
	heightHole = 8 + tolerance;
	heightPin = 7 - tolerance;
	size = 5.4;
	plunge = 1;
	translate([10,10,length/2]) union() {
		difference() {
			profile(length);
			translate([0,0,-length/2+(heightHole+plunge)/2-plunge]) hole(heightHole+plunge, size+tolerance);
		}
		translate([0,0,length/2+(heightPin+plunge)/2-plunge]) cube([size-tolerance,size-tolerance,heightPin+plunge], center = true);
	}
}

module profile(length) { // generate a profile based on length
	difference() {
		// Create main body
		cube([20,20,length], center = true);
		
		// Create hole in middle
		cylinder(r=5/2, h=length+2, center = true);

		// Create groove
		grooveLength = length + 2;
		lengthOfCenterSide = 5.75;
		gabWidth = 6.5;
		gabDepth = 6.1;
		sizeOfCube = 12;
		gabFrontWallWidth = 1.5;
		sizeOfCornerCube = sqrt(pow(sizeOfCube/2, 2)*2);
		for(i = [0:90:270]) {
			rotate([0,0,i]) translate([sizeOfCube/2-gabDepth+20/2,0,0]) difference() {
				cube([sizeOfCube,sizeOfCube,grooveLength], center = true);
				translate([-sizeOfCube/2,-sizeOfCube/2-lengthOfCenterSide/2,0]) rotate([0,0,45]) cube([sizeOfCornerCube,sizeOfCornerCube,grooveLength+2], center = true);
				translate([-sizeOfCube/2,sizeOfCube/2+lengthOfCenterSide/2,0]) rotate([0,0,45]) cube([sizeOfCornerCube,sizeOfCornerCube,grooveLength+2], center = true);
				translate([gabDepth-gabFrontWallWidth,sizeOfCube/2+gabWidth/2,0]) cube([sizeOfCube,sizeOfCube,grooveLength+2], center = true);
				translate([gabDepth-gabFrontWallWidth,-sizeOfCube/2-gabWidth/2,0]) cube([sizeOfCube,sizeOfCube,grooveLength+2], center = true);
			}
		}
	}
}
//cube([20,20,length]);