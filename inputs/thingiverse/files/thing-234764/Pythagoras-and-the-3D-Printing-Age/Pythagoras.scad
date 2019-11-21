// Pythagoras Thing
// Version 1.0
// Luigi Cisana, 22 Jan, 2014

// Leg a
leg_a=80; // [20:120]
// Leq b
leg_b=30; // [20:120]
// Height
heigth = 2; // [1:120]

// Number of facets, set a low value for a draft version
fn = 120; // [30:200]

/* [Hidden] */
a = leg_a;
b = leg_b;
c = sqrt(pow(a,2)+pow(b,2));
h = heigth;
ro = (a+b)/8;
e = (a+b)/75;

echo("c =", c, "ro =", ro, "e =", e);

/****** Main *********/
linear_extrude(height=h , center = false, convexity = 10, twist = 0) {
	semi_circles_a();
	semi_circles_b();
	semi_circles_c();
}

triangle();

//translate ([-3,3]) cylinder(h = 5.5, r=1, $fn=fn);

/****** Modules *********/

module semi_circles_a () {
	difference () {
		translate ([a/2,-0.1]) circle(r = a/2,$fn=fn);
		translate ([0,-a]) square ([a,a], center=false);
	}
} 

module semi_circles_b () {
	difference () {
		translate ([0.1,-b/2]) circle(r = b/2,$fn=fn);
		translate ([0,-b]) square ([b,b], center=false);
	}
}

module semi_circles_c () {
	translate ([0,-b]) {
		rotate(a=[0,0,asin(b/c)]) {
			difference () {
				translate ([c/2,0]) circle(r = c/2,$fn=fn);
				translate ([0,0]) square ([c,c], center=false);
			}
		}
	}
}

module triangle() {
	linear_extrude(height=h , center = false, convexity = 10, twist = 0) {
		difference () {
			circle(r = ro, $fn=fn);
			circle(r = ro*0.85, $fn=fn);
			translate ([-ro,0]) square ([2*ro,ro], center=false);
			translate ([-ro,-2*ro]) square ([ro,2*ro], center=false);	
		}
		
		translate ([0,0]) circle( r = e, $fn=fn);
		translate ([a,0]) circle( r = e, $fn=fn);
		translate ([0,-b]) circle( r = e, $fn=fn);
	}
}









