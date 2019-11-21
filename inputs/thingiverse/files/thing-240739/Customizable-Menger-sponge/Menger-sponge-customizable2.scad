// Menger sponge with diagonal cut or external support
//
// Bill Owens, February 2014
// released into the public domain
//
// version 2 - added "both" option for cut cube with support (cut side up) and
//              order==0 to print a cube (for a complete set)

// for Thingiverse Customizer

/* Global */

// Size of the basic cube
side = 45;

// Order/level of the Menger sponge
order = 3; // [0,1,2,3]

// Diagonally cut cube, or whole with external support?
choice = "both"; // [cut:Diagonal cut,support:External support,both:Diagonal cut facing up with support]

// Intersection depth between the support and the cube - cannot be zero
tol = 0.1;

/* Hidden */
long = side+5;  // long enough to cut through the cube
tside = side/3;	// second order cube (one Third)
nside = side/9;	// third order cube (one Ninth)
sside = side/27; // fourth order cube (one twenty-Seventh)
lift = side*sqrt(3)/2;	// half of the long diagonal

module ordertwo() {
	translate([0,tside,tside]) cube(size=[long,nside,nside], center=true);
	translate([0,0,tside]) cube(size=[long,nside,nside], center=true);
	translate([0,-tside,tside]) cube(size=[long,nside,nside], center=true);
	translate([0,tside,0]) cube(size=[long,nside,nside], center=true);
	translate([0,-tside,0]) cube(size=[long,nside,nside], center=true);
	translate([0,tside,-tside]) cube(size=[long,nside,nside], center=true);
	translate([0,0,-tside]) cube(size=[long,nside,nside], center=true);
	translate([0,-tside,-tside]) cube(size=[long,nside,nside], center=true);
}

module orderthree() {
	translate([0,tside,tside]) orderthreea();
	translate([0,0,tside]) orderthreea();
	translate([0,-tside,tside]) orderthreea();
	translate([0,tside,0]) orderthreea();
	translate([0,-tside,0]) orderthreea();
	translate([0,tside,-tside]) orderthreea();
	translate([0,0,-tside]) orderthreea();
	translate([0,-tside,-tside]) orderthreea();
}

module orderthreea() {
	translate([0,nside,nside]) cube(size=[long,sside,sside], center=true);
	translate([0,0,nside]) cube(size=[long,sside,sside], center=true);
	translate([0,-nside,nside]) cube(size=[long,sside,sside], center=true);
	translate([0,nside,0]) cube(size=[long,sside,sside], center=true);
	translate([0,-nside,0]) cube(size=[long,sside,sside], center=true);
	translate([0,nside,-nside]) cube(size=[long,sside,sside], center=true);
	translate([0,0,-nside]) cube(size=[long,sside,sside], center=true);
	translate([0,-nside,-nside]) cube(size=[long,sside,sside], center=true);
}

module mengersponge() {
	difference() {
		cube(side, center=true);	
        if (order > 0) {
		cube(size=[tside,tside,long], center=true);	// order one cuts
		cube(size=[long,tside,tside], center=true);
		cube(size=[tside,long,tside], center=true);
		if (order > 1) {
			ordertwo();								// order two cuts
			rotate([0,90,0]) ordertwo();
			rotate([0,0,90]) ordertwo();
		}
		if (order > 2) {
			orderthree();							// order three cuts
			rotate([0,90,0]) orderthree();
			rotate([0,0,90]) orderthree();
		}
        }
	}
}

if(choice=="support") {
	union() {
		translate([0,0,lift-tol])	
		rotate([45,90-atan(sqrt(2)),0])  
		mengersponge();
		difference() {
			cylinder(r=side/2, h=side/2*.7-1);
			cylinder(r1=0, r2=side/2, h=side/2*.7);
			rotate([0,45,0]) translate([side/2*1.03,0,side/4]) cube(size=[side,4,side], center=true);
			rotate([0,45,120]) translate([side/2*1.03,0,side/4]) cube(size=[side,4,side], center=true);
			rotate([0,45,-120]) translate([side/2*1.03,0,side/4]) cube(size=[side,4,side], center=true);
		}
	}
} else if (choice=="cut") {
	difference() {
        rotate([45,90-atan(sqrt(2)),0])  
		mengersponge();
        translate([0,0,-side/2]) cube(size=[side*2,side*2,side], center=true);
	}
} else if (choice=="both") {
    difference() {
	union() {
		translate([0,0,lift-tol])	
		rotate([45,90-atan(sqrt(2)),0])  
		mengersponge();
		difference() {
			cylinder(r=side/2, h=side/2*.7-1);
			cylinder(r1=0, r2=side/2, h=side/2*.7);
			rotate([0,45,0]) translate([side/2*1.03,0,side/4]) cube(size=[side,4,side], center=true);
			rotate([0,45,120]) translate([side/2*1.03,0,side/4]) cube(size=[side,4,side], center=true);
			rotate([0,45,-120]) translate([side/2*1.03,0,side/4]) cube(size=[side,4,side], center=true);
		}
	}
        translate([0,0,lift-tol+side/2]) cube(size=[side*2,side*2,side], center=true);
	}
}



