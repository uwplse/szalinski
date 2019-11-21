

// number of cells in the x direction
_1_numCellsX = 1; // [1:12]

// number of cells in the y direction
_2_numCellsY = 3; // [1:12]

// inside size of each cell in the x direction
_3_cellSizeX = 24; // [0:100]

// inside size of each cell in the y direction
_4_cellSizeY = 16; // [0:100]

// height of the tray (including bottom)
_5_cellHeight = 12; // [0:100]

// radius of rounding of the bottom (should be less than half the minimum cell dimension)
_6_externalRounding = 3; // [1:50]

// thickness of the vertical walls
_7_sidewall = 0.8;

// thickness of the bottom
_8_bottomThickness = 1.2;

// resolution used to render curved surfaces (experiment with low resolutions, and render the final results with higher resolution settings)
_9_resolution = 30; // [30:Low (12 degrees), 60:Medium (6 degrees), 120:High (3 degrees)]


////////////////////////////////////////////////////////////

module roundedCube(x, y, z, fillet)
{
	if (fillet <= 0) {
		cube([x,y,z], center=true);
	} else {
   	assign (x = x/2-fillet, y = y/2-fillet, z = z/2-fillet) {
			hull() {
				for(xx = [-x,x]) {
					for(yy = [-y,y]) {
						for(zz = [-z,z]) {
							translate([xx,yy,zz]) {
								sphere(fillet);
							}
						}
					}
				}
			}
		}
	}
}

module squareTray(numx, numy, xsize, ysize, height, rounding, sidewall, bottom, $fn)
{
	xoutside = xsize * numx + sidewall * (numx + 1);
	youtside = ysize * numy + sidewall * (numy + 1);

	translate([0, 0, height])
	difference() {
		roundedCube(xoutside, youtside, height*2, rounding);
		for (x = [0:numx-1]) {
			for (y = [0:numy-1]) {
				translate([-xoutside/2 + (sidewall + xsize/2) + x * (sidewall + xsize),
							  -youtside/2 + (sidewall + ysize/2) + y * (sidewall + ysize), 0]) {
					roundedCube(xsize, ysize, (height - bottom)*2, rounding - sidewall);
				}
			}
		}
		translate([0,0,height]) {
			cube([xoutside+1,youtside+1,height*2], center=true);
		}
	}
}

squareTray(_1_numCellsX, _2_numCellsY, _3_cellSizeX, _4_cellSizeY, _5_cellHeight, _6_externalRounding, _7_sidewall, _8_bottomThickness, _9_resolution);