// Duncan mask generator

OD = 218; // outside diameter of the mask
aperture = 203;
rim = 0.5*( OD - aperture) ; // rim area outside of the OD
ID = 72; // diameter of secondary mirror on SCT
sIDratio = 0.7; // fraction of aperture
handleH = 14; // height of handle around secondary

$fn = 120;

thk = 2.0; // thickness of the mask
rOD = 0.5*OD; // points along the far outside diameter
rID = 0.5*ID; // points along the perimeter of secondary
rA = 0.5*aperture; // points along the inside of the rim
rHUB = 0.5*aperture*sIDratio; // points along the inside hub of the spokes

// first, creat annular figure

difference() {
	union() {
		cylinder( h = thk, r1 = rOD, r2 = rOD );
		cylinder( h = handleH, r1 = rID+thk, r2 = rID+thk );
	} // union
	difference() {
		cylinder( h = thk+0.1, r1 = rA, r2 = rA );
		cylinder( h = thk, r1 = rHUB, r2 = rHUB );
	} // difference
	cylinder( h = handleH+0.1, r1 = rID, r2 = rID );
} // difference

// next, add back the "spokes"

for(a = [0,120,240] )
	linear_extrude( height = thk )
		polygon( points = [ 	[rHUB*cos(a+30),rHUB*sin(a+30)],
							[rOD*cos(a+30),rOD*sin(a+30)],
							[rOD*cos(a+0),rOD*sin(a+0)],
							[rOD*cos(a-30),rOD*sin(a-30)],
							[rHUB*cos(a-30),rHUB*sin(a-30)]
				 		] );
