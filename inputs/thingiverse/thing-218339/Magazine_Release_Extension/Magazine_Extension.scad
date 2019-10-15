$fn = 200*1;

//The total height of this magazine release extension
TOTAL_HEIGHT = 25.4;

//The depth of the pocket that the existing magazine release fits in
POCKET_DEPTH = 7.6;

//The width of the existing magazine release
RELEASE_WIDTH = 11.6;

//The height of the existing magazine release
RELEASE_HEIGHT = 2.3;

//How thick to make the walls (added to the RELEASE_WIDTH)
SIDE_WALL_THICKNESS = 1.5;

//How thick to make the walls (added to the RELEASE_HEIGHT)
TOP_AND_BOTTOM_WALL_THICKNESS = 2;

// Used to make sure that there isn't a "film" 
// of plastic covering the top
TOLERANCE = 0.01 * 1;

// An adjustment to the rounding of corners
ROUNDING_ADJUSTMENT = 0.05 * 1; //


intersection() {
	difference() {
		cube(size = [RELEASE_WIDTH + 2*SIDE_WALL_THICKNESS,
						 RELEASE_HEIGHT + 2*TOP_AND_BOTTOM_WALL_THICKNESS,
						 TOTAL_HEIGHT],
								 center = true);
		translate([0, 0, (TOTAL_HEIGHT - POCKET_DEPTH)/2 + TOLERANCE]){
			cube(size = [RELEASE_WIDTH, RELEASE_HEIGHT, POCKET_DEPTH], center = true);
		}
	}

	//Round the corners slightly
	cylinder(r = max( RELEASE_WIDTH/2 + SIDE_WALL_THICKNESS, RELEASE_HEIGHT/2 + TOP_AND_BOTTOM_WALL_THICKNESS) + ROUNDING_ADJUSTMENT, h = TOTAL_HEIGHT, center = true);

}
