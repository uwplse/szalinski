

//size of the cube (mm)
edge = 50; //[10.0:100.0]

// angle in degrees you'll have to screw the pieces to assemble the cube
twist_angle = 330; //[300:720]

// size of the gap between pieces (mm)
epsilon = 0.4; //[0.0,0.05,0.1,0.15,0.2,0.3,0.4,0.5]


/* [Hidden] */
angle = atan(1/sqrt(2));
diag = edge*sqrt(3);
d = diag/2;

module piece(){
	  intersection(){
		 rotate ([45,angle,30])cube( [edge,edge,edge],center = true);
		translate([0, 0, -diag/2]) linear_extrude(height = diag, center = false, convexity = 10, twist = twist_angle, $fn = 200)
		polygon( points=[[0+epsilon/2,0+epsilon/2],[d+epsilon,-tan(30-epsilon)*d],[d,d],[0+epsilon/2,d]] );
	}
}



rotate ([45,0,-0]) rotate ([-0,-angle,-0]) rotate ([-0,-0,-30])color("blue")piece ();

// remove * to get the complete cube
*rotate ([45,0,-0]) rotate ([-0,-angle,-0]) rotate ([-0,-0,-30]) rotate([0,0,120,]) color("red")piece ("red");

*rotate ([45,0,-0]) rotate ([-0,-angle,-0]) rotate ([-0,-0,-30]) rotate([0,0,240,]) color("green")piece ();
