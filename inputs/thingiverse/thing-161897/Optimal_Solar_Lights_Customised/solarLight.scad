use <write.scad>

//adampaterson 2013


// Optimal Solar Angle
stakeAngle = 30;

// Height
height = 20;

// Electrics Width
caseWidth = 58;

// Electrics Length
caseLength = 58;

// Solar Panel Width
panelWidth = 50;

// Solar Panel Length
panelLength = 45;

//Stake Width
stakeWidth = 10;

// Stake Length
stakeLength = 100;

// Wall Thickness
wallThickness = 4;

width = caseWidth + (2 * wallThickness);
length = caseLength + (2 * wallThickness);

widthDiff = width - panelWidth;
lengthDiff = length - panelLength;

union(){
difference() {
	union() {
		//main rect. extrude
		cube([width,length,height]);
		//angle extrude
		rotate([stakeAngle,0,0] ) cube([width, sin(stakeAngle) * height, height / 			cos(stakeAngle)]);
	}

//main cutout, not window
translate([wallThickness, wallThickness, wallThickness]) 
	cube([width - (2 * wallThickness), length - (2 * wallThickness), height]);

//window cut-out
translate([widthDiff/2, lengthDiff / 2, -1]) 
	cube([panelWidth, panelLength, height]);

// angle extrude remove
translate([wallThickness, wallThickness, wallThickness])
	rotate([stakeAngle,0,0] ) 
		cube([width - (2 * wallThickness), sin(stakeAngle) * height, height / cos(stakeAngle)]);

//bottom triangle
translate([-1, -length, height])
	cube([width + 2,length,height]);

}
difference() {
	//stake extrude
		rotate([stakeAngle,0,0] ) cube([stakeWidth, stakeWidth, stakeLength]);
	// stake extrude remove
	translate([wallThickness, wallThickness, wallThickness])
		rotate([stakeAngle,0,0] ) 
			cube([stakeWidth, stakeWidth, stakeLength]);
	// hack remove
	translate([wallThickness, wallThickness, wallThickness]) 
		cube([width - (2 * wallThickness), length - (2 * wallThickness), height]);
}}