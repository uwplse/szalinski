/** cale pour support enceintes */

// preview[view:north east, tilt:top diagonal]

/* [Global] */

// height of the bottom (mm)
haut = 40; // [0:100]
// Inside hole ?
in_hole="yes"; // [yes,no]
// wall thickness of the inside hole (mm)
thick = 5;

/* [Hidden] */
// width of the base
larg = 47;
// height of the base
long = 77;

$fn=60;

lsq=long-larg/2; // longueur "square"
scircle=10; // diametre petits cercles
dy=-(lsq-larg/2-scircle/2); // decalage centre petits cercles

// main base
module base () {
	linear_extrude (haut) {
		hull() {
			translate([0,larg/2,0]) circle (d=larg);
			translate ([  larg/2-scircle/2, dy,0]) circle(d=scircle);
			translate ([-(larg/2-scircle/2),dy,0]) circle(d=scircle);
		}
	}
}

cut_long=sqrt(haut*haut+long*long); // length of the cut. Yeah! Pytagore
alpha=atan(haut/long); // angle of the cut

// angle cut
module cut() {
	// angle cutting
	translate([-1,dy-scircle/2,haut+0.6])
		rotate([-alpha,0,0])
			translate([-larg/2,0,0])
				cube([larg+2, cut_long, haut]);
	// inside cutting
	if (in_hole == "yes") {
		in_larg=larg-2*thick;
		in_long=long-2*thick-10-3-5-6;
		translate([-(in_larg)/2,dy-scircle/2+3+thick+6,-1])
			cube([in_larg, in_long, haut+2]);
	}
}

// MAIN
difference() {
	base();
	cut();
	translate([-3,larg-10-5,-1]) cube ([6,10,haut+2]); // top hole, 5mm from top
	translate([-5,dy-scircle/2+3,-1]) cube ([10,6,haut+2]); // bnottom hole, 3mm from bottom
}
