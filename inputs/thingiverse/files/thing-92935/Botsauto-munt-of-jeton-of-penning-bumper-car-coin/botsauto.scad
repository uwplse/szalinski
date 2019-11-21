// diameter of the coin ("pancake")
A=35.0;

// outer diameter of the ring
B=21.5;

// inner diameter of the ring
C=11.0;

// thickness of the "pancake"
D=2.5;

// total thickness of the coin, including rings
E=5.2;

union() {

	difference() {
		cylinder( h = E, r = B/2 );
		cylinder( h = E, r = C/2 );
	}
	
	translate( [ 0, 0, E/2 ] ) cylinder( h = D, r = A/2, center = true );

}