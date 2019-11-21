// height of links (width of belt)
h=30;//[20:50]		
// gap between bar and enclosing shape to provide smooth rotation
g=0.85;//[.5:1]				

		
// width of links
width_of_links=4;//[2:10]	
			
ooratio = 1.1;	// roundness of round links: 1 - round, 0.1 is extremely skinny, 0.7 is what I use
// spacing between links
spacing_between_links=13;//[10:20]				
m=2;				// 2mm radius on corners of rectangle links
oorm=width_of_links-m/2;	// inner rectangle width for minkowski for rectangle links
irm=radius_of_bar-m;			// inner rectangle height "
numlinksinrow=12;		// number of links in a row
rl=numlinksinrow*spacing_between_links; 	// row length
rw=35.5;			// spacing between rows in 'snake', must be correct to align rows properly
numrows=2;		// number of rows in 'snake', minus 1. i.e. 0=1 row, 1=2 rows, etc.

half=0;			// 1=chop in half to check alignments

psnake=1;			// 1=print a 'snake' of links that fills a Replicator
ptest=0;			// 1=print a few links to check alignment

linksnake=numlinksinrow+3;
links=(numrows+1)*linksnake+numlinksinrow;
length=links*spacing_between_links+h;

radius_of_bar=2;	
round=1;
octagon=2;
shape=round;	// shape of links

or=radius_of_bar+g;			// radius of cylinder around bar

module bar() {
	if (shape==round) {
		translate([0,0,-2*radius_of_bar]) scale([1,ooratio,1]) cylinder(r=width_of_links,h=2*h);
		}
	else {
		translate([-oorm,-irm,-2*radius_of_bar]) minkowski() {
			cube([2*oorm,2*irm,2*h]);
			cylinder(r=m, h=1, $fn=8);
			}
		}
	}

module x() {
	difference() {
		union() {
			cylinder(r=radius_of_bar, h=h, $fn=16);
			translate([0,-h,0]) cylinder(r=radius_of_bar, h=h, $fn=32);
			rotate([45,0,0]) bar();
			}
		union() {
			//translate([-1.5*width_of_links,-2*width_of_links,-1.5*width_of_links]) cube([spacing_between_links+2*width_of_links,4*width_of_links,1.5*width_of_links]);
			//translate([-1.5*width_of_links,-2*h,h]) cube([spacing_between_links+2*width_of_links,2*width_of_links+2*h,h/2+g]);
			}
		}
	}

module v() {
	difference() {
		union() {
			cylinder(r=radius_of_bar, h=h, $fn=16);
			rotate([45,0,0]) 
				if (shape==round) {
					translate([0,0,-2*radius_of_bar]) scale([1,ooratio,1]) cylinder(r=width_of_links,h=h);
					}
				else {
					translate([-oorm,-irm,-radius_of_bar]) minkowski() {
						cube([2*oorm,2*irm,h]);
						cylinder(r=m, h=1, $fn=8);
						}
					}
			}
		union() {
			//translate([-1.5*width_of_links,-width_of_links,-1.5*width_of_links]) cube([spacing_between_links+2*width_of_links,2*width_of_links,1.5*width_of_links]);
			translate([-1.5*width_of_links,-width_of_links-h,h/2]) cube([spacing_between_links+2*width_of_links,2*width_of_links+h,h/2+g]);
			translate([0,-spacing_between_links,0]) cylinder(r=or,h=h, $fn=32);
			}
		}
	}

module vblock() {
	v();
	translate([0,0,h]) rotate([0,180,0]) v();
	}

module xblock() {
	x();
	translate([0,0,h]) rotate([0,180,0]) x();
	}

module cblock() {
	difference() {
		union() {
			v();
			translate([0,0,h]) rotate([0,180,0]) v();
			}
		translate([0,-spacing_between_links-radius_of_bar+g,0]) cube([width_of_links,2*(radius_of_bar)-g,h]);
		}
	}

module vrow() {
	for ( i = [0 : spacing_between_links : rl] ) {
		translate([0,-i,0]) vblock();
		}
	}

module oswoop() {
translate([0,rl+2*spacing_between_links,0]) vrow();
translate([0,spacing_between_links,0]) vblock();
rotate([0,0,45]) {
	vblock();
	translate([0,-spacing_between_links,0]) rotate([0,0,45]) {
		vblock();
		translate([0,-spacing_between_links,0]) rotate([0,0,45]) {
			vblock();
			translate([0,-spacing_between_links,0]) rotate([0,0,45]) {
				vblock();
				translate([0,-spacing_between_links,0]) vrow();
				translate ([0,-rl-2*spacing_between_links,0]) rotate([0,0,-45]) {
					vblock();
					translate([0,-spacing_between_links,0]) rotate([0,0,-45]) {
						vblock();
						translate([0,-spacing_between_links,0]) rotate([0,0,-45]) {
							vblock();
							}
						}
					}
				}
			}
		}
	}
}

module swoop() {
translate([0,rl+2*spacing_between_links,0]) vrow();
translate([0,spacing_between_links,0]) vblock();
rotate([0,0,60]) {
	vblock();
	translate([0,-spacing_between_links,0]) rotate([0,0,60]) {
		vblock();
		translate([0,-spacing_between_links,0]) rotate([0,0,60]) {
			vblock();
			rotate([0,0,3]) translate([0,-spacing_between_links,0]) vrow();
			translate ([9.5,-rl-2*spacing_between_links+.4,0]) rotate([0,0,-60]) {
				vblock();
				translate([0,-spacing_between_links,0]) rotate([0,0,-60]) {
					vblock();
					}
				}
			}
		}
	}
}

module snake() {
	for ( j = [0:rw:numrows*rw]) {
		translate([j,0,0]) swoop();
		}
	translate([(1+numrows)*rw,rl+2*spacing_between_links-0.4,0]) vrow();
	translate([(1+numrows)*rw,spacing_between_links,0]) cblock();
	}

difference() {
	union() {
		if (psnake) snake();
		if (ptest) {
			vblock();
			//translate([0,-spacing_between_links,0]) rotate([0,0,60]) xblock();	
			translate([0,-spacing_between_links,0]) vblock();	
			translate([0,spacing_between_links,0]) cblock();	
			translate([0,-2*spacing_between_links,0]) rotate([0,0,60]) cblock();	
			}
		}
	translate([-1000,-1000,-h]) cube([2000,2000,h]);
	if (half) translate([-1000,-1000,h/2]) cube([2000,2000,h]);	// uncomment to chop in half to check alignments
	translate([-1000,-1000,h]) cube([2000,2000,h]);
	}

