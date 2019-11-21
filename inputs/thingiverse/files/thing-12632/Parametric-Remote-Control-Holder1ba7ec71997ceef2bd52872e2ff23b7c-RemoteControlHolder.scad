//--------------------------------------------------------------------
//	Filename:	RemoteControlHolder.scad
//	Author:		Robert H. Morrison (rhmorrison)
//	Created On:	15 October 2011
//--------------------------------------------------------------------

use <MCAD/boxes.scad>;

AddTriangles=1;	//[0:No,1:Yes]

KT=20;			// Remote Control Thickness
ST=5;			// Screw head Thickness
T=2;			// Thickness of walls
BD=KT+ST+2*T;	// Box Depth
BW=45;			// Box Width
BL=90;			// Box Length
FW=25;			// Front Hole Width

module Triangle(h) {
	linear_extrude(height=h, center=false, convexity=10, twist=0)
		polygon(
			points=[[0,0],[0,5.5],[5.5,5.5]],
			paths=[[0,1,2]]);
}

module BracketHoles() {
	for (i=[-20, 0, 20])
	{
		translate([0,KT/2,i])
			rotate([90,0,0])
				cylinder(h=KT, r=2.5, center=true);
	}
}

module RemoteControlBracket() {
	union() {
		difference() {
			roundedBox([BW,BD,BL], 5, false);			// Holder frame
			translate([0,-(ST-T)/2,T])
				roundedBox([BW-2*T,KT,BL], 2, true);	// Remote Control
			translate([0,ST/2,10])
				roundedBox([BW/3,KT,BL], 2, true);  	// Screw heads
			translate([0,-(KT+ST+T)/2,30])
				rotate([90,90,0])
					roundedBox([BL,FW,ST], 2, true);  // Cut-out FRONT
			BracketHoles();
		}

		if (AddTriangles)
		{
			translate([T+5.5-BW/2,T-BD/2,2*T-BL/2])
				rotate([0,0,90])
					Triangle(BL-T*3);						// LL corner
			translate([BW/2-T+0.1,T+5.6-BD/2,2*T-BL/2])
				rotate([0,0,180])
					Triangle(BL-T*3);						// LR corner
			translate([T/2-BW/2, 5.5+T-BD/2, 6-T-BL/2])
				rotate([0,90,0])
					rotate([0,0,180])
						Triangle(BW-T);					// Bottom
		}
	}
}

RemoteControlBracket();