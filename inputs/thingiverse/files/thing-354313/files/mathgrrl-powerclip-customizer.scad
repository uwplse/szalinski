// mathgrrl customizable power hair clip

////////////////////////////////////////////////////////////////////////////
// parameters //////////////////////////////////////////////////////////////

// Thickness of the path, in millimeters - make larger for sturdier clip, smaller for daintier clip
path_radius = 1.8;

// Radius of the hook loop, in millimeters
loop_radius = 6; 

// Length of the opening that captures the hair, in millimeters
capture_length = 25; 

// Height of the opening that captures the hair, in millimeters - larger for looser clip, smaller for tighter clip
capture_height = 8; 

// Length of the part that extends past the hook loop, in millimeters
end_length = 15;

////////////////////////////////////////////////////////////////////////////
// points //////////////////////////////////////////////////////////////////

points = [ 
	// points around a circle of given radius at 45 degree intervals
	[loop_radius*sqrt(2)/2,loop_radius*sqrt(2)/2,0],
	[loop_radius*0,loop_radius*1,0],
	[loop_radius*-sqrt(2)/2,loop_radius*sqrt(2)/2,0],
	[loop_radius*-1,loop_radius*0,0],
	[loop_radius*-sqrt(2)/2,loop_radius*-sqrt(2)/2,0],
	[loop_radius*0,loop_radius*-1,0],
	// move out from the loop
	[loop_radius*4,loop_radius*-sqrt(2)/2,0],
	// move up to top of capture
	[loop_radius*6,0,0],
	// move around the capture
	[loop_radius*6+capture_length,0,0],
	//[loop_radius*6.5+capture_length,0,0],
	[loop_radius*6.5+capture_length,loop_radius*-sqrt(2)/2,0],
	[loop_radius*6+capture_length,-capture_height,0],
	// move back under the loop 
	[0,loop_radius*-1-2*path_radius,0],
	// move to the endpoint
	[-loop_radius-end_length,loop_radius*-1-2*path_radius,0]
];

////////////////////////////////////////////////////////////////////////////
// render //////////////////////////////////////////////////////////////////

for(i = [0:len(points)-2]){
	hull(){
		translate(points[i]) sphere(path_radius);
		translate(points[i+1]) sphere(path_radius);
	}
}
