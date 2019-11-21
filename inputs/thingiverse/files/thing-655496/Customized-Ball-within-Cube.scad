//
//  Customized Ball within Cube
//      Robert Nix
//      January 27, 2015
//

$fn=100;			// set overall resolution

// 
//  Customizing

// Size of each side of the cube
cubeSide=22;		// [15:40]

// Size of the captured sphere inside the cube
sphereRadius=11;	// [7:24]

// Make the hollowed space just a bit larger than the ball
sphereSpaceRadius=sphereRadius+3;

translate([0,0,(cubeSide/2)]) {
	difference() {
		// Draw the solid cube
		cube(cubeSide, center=true);

		// Then remove the larger sphere
		sphere(sphereSpaceRadius);
	}

	difference() {
		// Draw the solid sphere
		sphere(sphereRadius);

		// Then remove the very bottom of the 
		// sphere so that it doesn't extend below
		// the build plate
		translate([0,0,((cubeSide/2)-(cubeSide/2)-sphereRadius)])
			#cube([cubeSide,cubeSide,(sphereRadius-(cubeSide/2))+2], center=true);
	}
}



