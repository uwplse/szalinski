// thickness of wood plate, mm
thick = 16;

// vertical length of plate side to cover, mm
sides = 20;

// inner diameter of bearing axle, mm
b_inner = 8;

// outer diameter of bearing, mm
b_outer = 22;

// height/thickness of bearing, mm
b_height = 7;


rotate( [ 90, 0, 0 ] ) {

translate( [0,0,10.5]) {
//	cylinder( d=b_outer, b_height ); // bearing
}

difference() {
union() {
translate( [ - 3 - 0.5 * thick , b_inner / 2, 0 ] )  {
	cube( [ thick + 3+3, sides, 21 + b_height ] ); // main body
	translate( [ 0, -2 -1 * b_inner, 0 ] )
		cube( [ thick + 3+ 3, sides, 21 + b_height ] ); // front round
	}
	}
translate( [ - 0.5 * thick, 0.5 * b_inner, -0.5 ] )
	cube( [ thick, sides + 1, b_height + 22 ] ); //  wood plate
translate( [ -0.5 * (thick + 6 + 1), -0.5 * (b_outer + 1), 10 ] )
	cube( [ thick + 6 + 1, b_outer + 1, b_height + 1 ] ); // opening for bearing
translate( [0,0, -0.5] )
	cylinder( 22 + b_height, d=b_inner ); // axle

translate( [- 0.5 * (thick + 6.1 ),sides - 1, 5 ] ) 
	rotate( [ 0, 90, 0 ] )
	cylinder( d = 3, thick + 6.1 ); // screw hole

translate( [- 0.5 * (thick + 6.1 ),sides - 1, 21 + b_height - 5  ] ) 
	rotate( [ 0, 90, 0 ] )
	cylinder( d = 3, thick + 6.1 ); // screw hole


}

}