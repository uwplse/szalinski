// ========== PARAMETERS ==========

// Choose which piece to make (-1 to make all)
i = -1;

// Choose a height for the object, in mm
height = 8;

// Choose a width for the square, in mm
width = 50;

// Choose a hinge radius, in mm
hinge_radius = 1.5; 

// Choose a hinge clearance factor, in mm (controls distance around hinge parts)
//hinge_clearance = .45;
hinge_clearance = .45;

shape_shrink = .97;

// Choose a proportion for the inside hinge (keep at 0.2)
inside_prop = 0.2;

// Other variables that people don't get to choose
$fn=100;
fudge = .01;
inside_height = inside_prop * height;
outside_height = (1-inside_prop)/2 * height;
cone_height = 1.4*hinge_radius; 


// ========== SETUP ==========
// Set up variables
sq3 = sqrt(3);
x = sqrt( 3*sq3/2 );
y = sq3/2 * sqrt( 2*sq3-3 );
wscale = width / (2*sqrt(3));

// Set up vertices
M = [0, 0] * wscale;
G = [sq3, 0] * wscale;			B = [-sq3, 0] * wscale;
N = [-sq3/2, 0.5] * wscale;		L = [sq3/2, -0.5] * wscale;
O = N + [0, 1] * wscale;		K = L - [0, 1] * wscale;
E = [y, 1.5] * wscale;			J = [-y, -1.5] * wscale;
C = E + [-sq3, 0] * wscale;		H = J + [sq3, 0] * wscale;
D = E + [-3/2, y] * wscale;		I = J + [3/2, -y] * wscale;
F = E + [1.5, -y] * wscale;		A = J + [-1.5, y] * wscale;

// Set up shapes
shape = [
    [ [A,B,N,M,J], [A,B,J] ],
    [ [B,C,O,N], [B,O,G+[-3,2*y]*wscale,2*B-A] ],
    [ [O,E,M,N], [O,E] ],
    [ [C,D,E], [E,D,O,C+[2*y,0]*wscale] ],
    [ [F,G,L,M,E], [F,G,E] ],
    [ [G,H,K,L], [G,K,B+[3,-2*y]*wscale,2*G-F] ],
    [ [K,J,M,L], [K,J] ],
    [ [H,I,J], [J,I,K,H-[2*y,0]*wscale] ] ];

shapeCentre = [ (A+B+N+M+J)/5, (B+C+O+N)/4, (O+E+M+N)/4, (C+D+E)/3,
	(F+G+L+M+E)/5, (G+H+K+L)/4, (K+J+M+L)/4, (H+I+J)/3 ];

// Hex rotation variables
hexccw =	[ false,false,true,false,false,false,true,false ];
hexv =		[ [N,B],[B,N],[O,N],[C,E],[G,L],[L,G],[L,K],[J,H] ];
hexangle =	[ 0,0,60,330,0,0,60,330 ];


// ========== MODULES ==========
// Makes a polygon of the specified shape
module mypoly(i) {
	linear_extrude(height=height, center=true) polygon( shape[i][0] );
}

// Makes a cylinder at the specified vertex of a shape
module mycylinder(i,v,h,r,s=1,c=true) {
	translate(shape[i][1][v]) scale([s,s,s]) cylinder(h=h, r=r, center=c, $fn=100);
}

module mytoroid(r,thickness) {
	rotate_extrude($fn=100) translate([r,0,0]) circle(thickness);
}

module myshrink(i) {
	translate(shapeCentre[i]) scale([shape_shrink,shape_shrink,1]) translate(-shapeCentre[i]) mypoly(i);
}

module setangle(v1,v2,angle=0,proportion=1,ccw=false,pivot=[0,0]) {
	x = v2[0] - v1[0];
	y = v2[1] - v1[1];
	startangle = atan2(y,x);

	rotangle = angle - startangle;
	rotangle2 = ccw ? (rotangle ? rotangle : rotangle+360)
		: (rotangle ? rotangle-360 : rotangle);
	rotangle3 = rotangle2 * proportion;
	echo(rotangle);
	echo(rotangle3);
	
	translate(pivot) rotate(rotangle3) translate(-pivot) children();
}

// Makes the specified shape, with correct hinges/etc.
module myshape(i) {
	difference() {
		myshrink(i);		// Base shape
//		mypoly(i);		// Base shape
		myneighbors(i);	// Remove neighbour hinges
	}

	// Add keychain loop onto Shape 0
	if (i==0)
		translate([-.84,-1,.02]*wscale+[0,0,height/2]) rotate([0,90,30]) mytoroid(.14*wscale,.05*wscale);
//		translate([-.8,-1,.02]*wscale+[0,0,height/2]) rotate([0,90,23]) mytoroid(.14*wscale,.05*wscale);
//		translate([-.41,-.2,.02]*wscale+[0,0,height/2]) rotate([0,90,-60]) mytoroid(.14*wscale,.05*wscale);
	}

// Maps out all the neighbouring hinges that need to be subtracted from the shape
module myneighbors(i) {
	if ( len(shape[i][1]) > 2 ) {
		for (j=[2:len(shape[i][1])-1])
			translate( concat(shape[i][1][j], -height/2-fudge) )
				cylinder( h=height+2*fudge, r=hinge_radius+fudge+hinge_clearance );
	}
}

module addHinges(i,v1,v2) {
	difference() {
		union() {
			difference() {
				// Place the starting object(s)
				children();
				
				// Inside hinge: remove bottom and top cylinders with clearance
				translate(v1) {
					translate([0,0,inside_height/2])
						cylinder( h=outside_height+fudge, r=hinge_radius+fudge+hinge_clearance );
					mirror([0,0,1])	translate([0,0,inside_height/2])
						cylinder( h=outside_height+fudge, r=hinge_radius+fudge+hinge_clearance );
				}
				
				// Outside hinge: remove middle cylinder with clearance
				translate( concat(v2,-inside_height/2-hinge_clearance-fudge) ) {
					cylinder( h=inside_height+2*hinge_clearance+2*fudge, r=hinge_radius+fudge+hinge_clearance );
				}
			}
			
			// Outside hinge: add bottom and top cylinders
			translate(v2) {
				translate([0,0,inside_height/2+hinge_clearance])
					cylinder( h=outside_height-hinge_clearance, r=hinge_radius );
				mirror([0,0,1])	translate([0,0,inside_height/2+hinge_clearance])
					cylinder( h=outside_height-hinge_clearance, r=hinge_radius );
			}
			
			// Inside hinge: add cylinder, and top and bottom cones
			translate(v1) {
				translate([0,0,-inside_height/2])	cylinder( h=inside_height, r=hinge_radius );
								translate([0,0,inside_height/2])	cylinder( h=cone_height, r1=hinge_radius, r2=0);
				mirror([0,0,1])	translate([0,0,inside_height/2])	cylinder( h=cone_height, r1=hinge_radius, r2=0);
			}
		}
		
		// Outside hinge: remove top and bottom cones with clearance
		translate(v2) {
			translate([0,0,inside_height/2+hinge_clearance-fudge])
				cylinder(h=cone_height, r1=hinge_radius, r2=0);
			mirror([0,0,1]) translate([0,0,inside_height/2+hinge_clearance-fudge])
				cylinder(h=cone_height, r1=hinge_radius, r2=0);
		}
	}
}

// Make specified shape
module make(i) {
	translate([0,0,height/2]) addHinges(i, shape[i][1][0], shape[i][1][1]) myshape(i);
}

// Make all shapes
module makeAll() {
	translate([3,-2*y,0]*wscale) {
		make(0);
		make(1);
		make(2);
		make(3);
	}
	make(4);
	make(5);
	make(6);
	make(7);
}


module mymake() {
	// ISSUE WITH THIS TRANSLATION - THE COORDINATES OF SHAPE[0][1][1] HAVE CHANGED
	// BECAUSE OF THE ROTATION!!
	translate(shape[0][1][0]-shape[0][1][1]) union() {
		setangle( hexv[0][0], hexv[0][1], hexangle[0], prop=0.5, ccw=hexccw[0] )
			translate(-shape[0][1][0])
			make(0);
	}
}

module mymake2() {
	i = 0;
	
	setangle( hexv[i][0], hexv[i][1], hexangle[i], prop=0.5, ccw=hexccw[i] )
		translate(-shape[i][1][0])
		make(i);
}


// ========== EXECUTION ==========
if (i < 0)	makeAll();
if (i >= 0)	make(i);

