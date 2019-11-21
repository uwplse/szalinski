//
// LED Strip Mount for FlashForge Creator Pro to attach
//    to the cable tie screws on the vertical supports
//

$fn = 100;

//
// Parameters:
//

LEDMountWidth = 10;		// LED Strip width
LEDMountLength = 244;		// LED Strip Length
LEDMountThickness = 2;		// LED Mounting plate thickness

MountAngle = 45;				// Degrees from mount point to strip

MountTongueWidth = 9;		// Mounting Tongue Plate Width
MountTongueLength = 15;	// Mounting Tongue Plate Length
MountTongueThickness = 2;	// Mounting Tongue Plate Thickness
MountHoleDia = 3.5;			// Diameter of the Mounting Holes
MountHoleExtraOffset = 0.5;	// Extra offset distance from main piece to mounting hole

FFCPMntCenters = 112.5;		// Distance from mount screw to mount screw in FFCP
NumTongues = floor(LEDMountLength/FFCPMntCenters);		// Zero-originated
EndArea = (LEDMountLength - (NumTongues*FFCPMntCenters))/2;


//
// Rendering:
//
RenderType = 0;				// 0=Render All, 1=Render Left, 2=Render Right
RenderSplit = (LEDMountLength*3)/5;		// Point to split left/right halves (avoid mount tongue!)
RenderCutCount = 5;						// Number of cut point lines
RenderCutMag = [ -2, 2, -2, 2, -2, 2 ];		// Offset and direction of each cut point line

Render();

// ------------------------------------------------------------------

module Render() {
	CutStepSize = LEDMountWidth/RenderCutCount;

	if (RenderType == 0) {
		LEDStripMount();
	} else if (RenderType == 1) {
		intersection() {
			union() {
				// Make "splice teeth":
				for (n = [0:RenderCutCount-1]) {
					translate([0, 0, -MountTongueWidth - 0.1])
					linear_extrude(height = LEDMountThickness + MountTongueWidth + 0.2)
					polygon(points =
									[	[n*CutStepSize, RenderSplit + RenderCutMag[n] ],
										[(n+1)*CutStepSize, RenderSplit + RenderCutMag[n+1] ],
										[(n+1)*CutStepSize, 0 ],
										[n*CutStepSize, 0]
									]
					);
				}
				// Keep remaining parts outside of main mount:
				translate([LEDMountWidth-0.1, -RenderCutMag[RenderCutCount], -MountTongueWidth-0.1])
				cube([LEDMountWidth + MountTongueWidth+0.2, RenderSplit, LEDMountThickness + MountTongueWidth + 0.2]);
			}
			
			LEDStripMount();
		}
	} else if (RenderType == 2) {
		intersection() {
			union() {
				// Make "splice teeth":
				for (n = [0:RenderCutCount-1]) {
					translate([0, 0, -MountTongueWidth - 0.1])
					linear_extrude(height = LEDMountThickness + MountTongueWidth + 0.2)
					polygon(points =
									[	[n*CutStepSize, RenderSplit + RenderCutMag[n] ],
										[(n+1)*CutStepSize, RenderSplit + RenderCutMag[n+1] ],
										[(n+1)*CutStepSize, LEDMountLength ],
										[n*CutStepSize, LEDMountLength]
									]
					);
				}
				// Keep remaining parts outside of main mount:
				translate([LEDMountWidth-0.1, RenderSplit+RenderCutMag[RenderCutCount], -MountTongueWidth-0.1])
				cube([LEDMountWidth + MountTongueWidth+0.2, LEDMountLength, LEDMountThickness + MountTongueWidth + 0.2]);
			}
			
			LEDStripMount();
		}
	}
}

module LEDStripMount()
{
	LEDStrip();

	for (n = [0:NumTongues])
	{
		translate([LEDMountWidth, EndArea + n*FFCPMntCenters, 0])
		MountTongue();
	}
}

module MountTongue()
{
	union() {
		translate([0,0, MountTongueThickness - MountTongueThickness*cos(MountAngle) ])
		rotate([0, MountAngle, 0])
		difference() {
			// Tongue:
			translate([0, -MountTongueLength/2, 0])		// Center with mounting hole
			union() {
				// Main Tongue:
				cube([MountTongueWidth, MountTongueLength, MountTongueThickness]);

				// End perpendicular:
				translate([0,0, MountTongueThickness])
				rotate([-MountAngle,0,90])
				prism(MountTongueLength, MountTongueThickness*sin(MountAngle), -MountTongueThickness);
			}

			// Mounting hole:
			translate([MountTongueWidth/2+MountHoleExtraOffset,0,-0.1])
			cylinder(d=MountHoleDia, h=MountTongueThickness+0.2);
		}

		// Transition
		if (MountAngle <= 45) {
			translate([-0.1, -MountTongueLength/2, 0])
			cube([2*((MountTongueThickness - MountTongueThickness*cos(MountAngle))+0.1), MountTongueLength, LEDMountThickness]);
		} else {
			translate([-0.1, -MountTongueLength/2, 0])
			cube([2*((MountTongueThickness - MountTongueThickness*sin(MountAngle))+0.1), MountTongueLength, LEDMountThickness]);
		}
	}
}

module prism(l, w, h){
	polyhedron(
		points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
		faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
	);
}

module LEDStrip()
{
	cube([LEDMountWidth, LEDMountLength, LEDMountThickness]);
}
