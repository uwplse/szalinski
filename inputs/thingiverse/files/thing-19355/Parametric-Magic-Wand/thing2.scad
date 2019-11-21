// threaded rod
//
// rod is threaded both on the inside and the outside.

h=100;		// height of each segment
cr=20;		// radius of the circle that forms the rod
w=10;		// distance of 'wiggle' in rod
nw=2;		// number of wiggles per rod segment
c = 2;		// 1 = counter-spirals, forming cross shapes, 0=spirals

// the core of each rod segment

module core() {
	linear_extrude(height = h, center = false, convexity = 10, twist = nw*360)
		translate([w, 0, 0]) circle(r = cr);
	if (c > 0) {
		linear_extrude(height = h, center = false, convexity = 10, twist = -nw*360) translate([w, 0, 0]) circle(r = cr);
		}
	if (c==2) {
		rotate([0,0,180]) {
			linear_extrude(height = h, center = false, convexity = 10, twist = nw*360)
				translate([w, 0, 0]) circle(r = cr);
			linear_extrude(height = h, center = false, convexity = 10, twist = -nw*360)
				translate([w, 0, 0]) circle(r = cr);
			}
		}
	}	

// the top rod segment, which has a sphere at the top, and
// a screw hole in the bottom

module top() {
	difference() {
		union() {
			core();
			translate([0,0,h]) sphere(r=cr+w); // cap top
			}
		translate([0,0,-g]) outer(); // screw hole in other end
		}
	}

// middle rod segments have screws on top, and holes on the bottom

module mid() {
	difference() {
		union() {
			core();
			translate([0,0,h-g]) inner(); // screw on top end
			}
		translate([0,0,-g]) rotate([0,0,180]) outer(); // screw hole in bottom end
		}
	}

// the bottom rod segment has a screw on top, and flat bottom.

module bottom() {
	core();
	translate([0,0,h-g]) inner(); // screw in top end
	}

ih = 20;	// height of the inner threaded screw
iw=5;		// number of 'wiggles' in the height of the screw

// draw the screw shape. Note the conical top, allowing it to
// fill holes that canprint without support (I hope). And it 
// should make it easier to put the screws into the holes.

module inner() {
	intersection() {
		linear_extrude(height=ih, center=false, convexity=10, twist=iw*360)
			translate([1,0,0]) circle(r=ih/2);
		cylinder(r1=ih, r2=0, h=ih);
		}
	}

gap = 0.1;	// gap between screw and hole. If it's too tight, increase it.

// Shape of the hole into which the screw screws. It's identical 
// to the inner shape, plus the gap added to the radius and height.

module outer() {
	intersection() {
		linear_extrude(height=ih, center=false, convexity=10, twist=iw*360)
			translate([1,0,0]) circle(r=ih/2+gap);
		cylinder(r1=ih+gap, r2=0, h=ih);
		}
	}

g=0.05;		//tiny number, added to keep faces from aligning
				//precisely, which upsets OpenSCAD when it happens.
spacing=60;	//spacing between plated rod segments.

// draw the rods next to each other for printing on a single plate.
// For TOM, it might be better to pack them more tightly, or the 
// rod will be rather small.

module plated() {
	translate([-2*spacing,0,0]) bottom();
	translate([-spacing,0,0]) mid();
	mid();
	translate([spacing,0,0]) mid();
	translate([2*spacing,0,0]) top();
	}

vspacing = h+gap+ih+10;	// vertical spacing

// Draw the rod segments stacked vertically, so you can see how
// it will look assembled.

module stacked() {	// view lined up for perspective
	translate([0,0,vspacing]) top();
	//translate([0,0,3*vspacing]) mid();
	//translate([0,0,vspacing]) mid();
	//translate([0,0,vspacing]) mid();
	bottom();
	}

//plated();
stacked();