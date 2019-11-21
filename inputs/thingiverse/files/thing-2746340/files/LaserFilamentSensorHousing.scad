/* [Hidden] */
// Duet3D laser filament sensor housing by D. Crocker, Escher 3D

/* [Options] */

// Select height of the filament centre above the PCB
filamentHeight=7;				// [4:0.2:9]

// Select the nominal diameter of the cutout for the PTFE tube. This needs to be somewhat larger than the outside diameter of the tube, but small enough to grip the tube when the two pieces are fastened together.
tubeDiameter=4.5;				// [4.0:0.1:5.2]

// Select the nominal diameter of the holes in the tube end stops for the filament to pass through. This needs to be somewhat larger than the outside diameter of the filament to prevent it rubbing, but smaller than the outside diameter of the tubing.
innerDiameter=2.7;				// [2.0:0.1:4.2]

// Do you want the top to be open or closed?
closedTop = 1;					// [0:Open,1:Closed]

/* [Hidden] */

width=25;
depth=15;
holeSpacing=16;

boardWidth=22.2;					// added 0.2mm clearance
boardComponentsWidth1=18.5;
boardComponentsWidth2=9;
boardComponentsHeight1=2.8;		// the deepest parts are the connector spills
boardComponentsHeight2=2.0;		// the deepest parts are the connector spills

holeInsetDepth1=5;
holeInsetDepth2=4.5;
boardDepth=9.5;
boardThickness=1.2;
stopThickness=1.0;

topHeight=4;
innerTubeDiameter=2.5;
chipDepth=4;
chipWidth=6;
M3clear=3.2;
M3head=7.5;

overlap=0.1;

module cubeXY(x,y,z) {
	translate([-x/2, -y/2, 0]) cube([x,y,z]);
}

module cubeX(x,y,z) {
	translate([-x/2, 0, 0]) cube([x,y,z]);
}

module FilamentGroove() {
	translate([0, -depth/2-overlap, 0]) rotate([-90,0,0]) cylinder(r=innerDiameter/2,h=99,$fn=6);
	translate([0, chipDepth/2+stopThickness, 0]) rotate([-90,0,0]) cylinder(r=tubeDiameter/2,h=99,$fn=6);
	translate([0, -chipDepth/2-stopThickness, 0]) rotate([90,0,0]) cylinder(r=tubeDiameter/2,h=99,$fn=6);
}

module Base(thickness) {
	difference() {
		cubeXY(width,depth,thickness+boardThickness);
		translate([-holeSpacing/2,0,-overlap]) cylinder(r=M3clear/2, h=99, $fn=32);
		translate([holeSpacing/2,0,-overlap]) cylinder(r=M3clear/2, h=99, $fn=32);
		FilamentGroove();
		translate([0,0,-overlap]) cubeXY(chipWidth, chipDepth, thickness+2*overlap);
		translate([0,-holeInsetDepth1, thickness]) cubeX(boardWidth,depth, boardThickness+overlap);
		translate([0,+holeInsetDepth2, thickness-boardComponentsHeight1])
			cubeX(boardComponentsWidth1, depth, boardComponentsHeight1+overlap);
		translate([0,-holeInsetDepth1, thickness-boardComponentsHeight2])
			cubeX(boardComponentsWidth2, depth, boardComponentsHeight2+overlap);
		translate([-20,holeInsetDepth2,thickness-boardComponentsHeight2]) cube([20,5,10]);
	}
}

module Top(thickness, isClosed) {
	difference() {
		cubeXY(width,depth,(isClosed) ? thickness + 1 : thickness);
		translate([0,0,(isClosed) ? 1 : -overlap]) cubeXY(chipWidth, chipDepth, thickness+2*overlap);
		translate([-holeSpacing/2,0,-overlap]) cylinder(r=M3clear/2, h=99, $fn=32);
		translate([holeSpacing/2,0,-overlap]) cylinder(r=M3clear/2, h=99, $fn=32);
		translate([0,0,(isClosed) ? thickness + 1 : thickness]) FilamentGroove();
	}
}

Base(filamentHeight);
translate([0, 20, 0]) Top(topHeight, closedTop);
