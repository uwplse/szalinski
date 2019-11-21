// ========== EXECUTION ==========
s = 1.15;
r = 0.12;
h = 0.2;
mid = 0.5;
pin = 0.4;
size = 80;
i = 0;


// ========== SETUP ==========
// Set up variables
sq3 = sqrt(3);
x = sqrt( 3*sq3/2 );
y = sq3/2 * sqrt( 2*sq3-3 );

// Set up vertices
M = [0, 0];
G = [sq3, 0];           B = [-sq3, 0];
N = [-sq3/2, 0.5];      L = [sq3/2, -0.5];
O = N + [0, 1];         K = L - [0, 1];
E = [y, 1.5];           J = [-y, -1.5];
C = E + [-sq3, 0];      H = J + [sq3, 0];
D = E + [-3/2, y];      I = J + [3/2, -y];
F = E + [1.5, -y];      A = J + [-1.5, y];

// Set up shapes
shape = [
    [ [A,B,N,M,J], [A,B,J] ],
    [ [B,C,O,N], [B,O,G+[-3,2*y],2*B-A] ],
    [ [O,E,M,N], [O,E] ],
    [ [C,D,E], [E,D,O,C+[2*y,0]] ],
    [ [F,G,L,M,E], [F,G,E] ],
    [ [G,H,K,L], [G,K,B+[3,-2*y],2*G-F] ],
    [ [K,J,M,L], [K,J] ],
    [ [H,I,J], [J,I,K,H-[2*y,0]] ] ];


// ========== MODULES ==========
// Makes a polygon of the specified shape
module mypoly(i,h) {
	linear_extrude(height=h, center=true) polygon( shape[i][0] );
}

// Makes a cylinder at the specified vertex of a shape
module mycylinder(i,v,h,r,s=1,c=true) {
		translate(shape[i][1][v]) scale([s,s,s]) cylinder(h=h, r=r, center=c, $fn=100);
}

// Makes the specified shape, with correct hinges/etc.
module myshape(i) {
	difference() {
		union() {
			mypoly(i,h);			// Base shape
			mycylinder(i,0,h,r);	// + 100% main in-hinge
			mycylinder(i,1,h,r);	// + 100% main out-hinge
		}
		
		// - 105% top/bottom in-hinge
		translate([0,0,h*mid/2]) mycylinder(i,0,h,r,s,false);
		translate([0,0,-h*s-h*mid/2]) mycylinder(i,0,h,r,s,false);
		
		mycylinder(i,1,h*mid,r,s);	// - 105% middle out-hinge
		mycylinder(i,1,h,r*pin,s);	// - 105% pin out-hinge
		
		// Remove neighbour vertices
		if ( len(shape[i][1]) > 2 ) {
			for (j=[2:len(shape[i][1])-1])
				mycylinder(i,j,h,r,s);
		}
	}
	mycylinder(i,0,h,r*pin);		// + 100% pin in-hinge
	
	// Add keychain loop onto Shape 0
	if (i==0)
		translate([-.8,-1,h/2+.09]) rotate([0,90,23]) rotate_extrude($fn=100) translate([.14,0,0]) circle(.05);
}

// Make all shapes
module makeAll(size) {
	scale([size,size,size]) translate([0,0,h/2]) {
		translate([3,-2*y,0]) {
		//translate([0,0,0]) {
			myshape(0);
			myshape(1);
			myshape(2);
			myshape(3);
		}
		myshape(4);
		myshape(5);
		myshape(6);
		myshape(7);
	}
}

// Make specified shape
module make(i,size) {
		scale([size,size,size]) translate([0,0,h/2]) myshape(i);
}


// ========== EXECUTION ==========
if (i < 0)	makeAll( size/(2*sq3) );
if (i >= 0)	make( i, size/(2*sq3) );
