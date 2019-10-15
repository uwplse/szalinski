// v block for collimating laser collimator


OA = 82; // out-to-out of blocks
Y = 10; // height from point of V to base

H = 30;  // overall height of v block
W = 50;  // overall width of v block
L = 10;  // thickness of one v block
C = 10; // stretcher dimension
S = OA - L - L; // clear spacing between blocks

notch = 80.0 * sqrt(0.5);

union() {
	vblock(Y);
	translate( [0.5*W-10,0.5*L,0] )
		cube ( [C, S, C] );
	translate( [-0.5*W,0.5*L,0] )
		cube ( [C, S, C] );
	translate( [0,L+S,0 ] )
		vblock(Y);
}

module vblock( hV ) { // hV is height of notch above base
	difference() {
		translate( [-0.5*W, -0.5*L, 0] )
			cube ( [ W, L, H ] );
		translate( [ 0,-0.5*L, hV ] )
			rotate( [0,-45,0] )
				cube( [notch,L,notch] );
	}
}