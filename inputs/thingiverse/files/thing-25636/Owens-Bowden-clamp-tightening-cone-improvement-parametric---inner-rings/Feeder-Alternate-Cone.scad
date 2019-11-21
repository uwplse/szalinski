
// (main) internal radius (bowden tube diameter)
ir=6;
// (main) cone height
ch=16;
// (main) outside radius (big one)
or1=9.2;
// (main) outside radius (small one)
or2=7.8;
// (optional) width of the vertical opening
gap=2;

// (optional) internal ripple width (at base of cone, will be zero on top)
rippler=0.3;
// (optional) internal ripple height
rippleh=1;
// (optional) internal ripple spacing (will be added to rippleh, ie one 1-mm shoulder with 2mm in between)
ripples=2;

// MoonCactus 2012 06 25 for "Bowden Clamp for Ultimaker (Feeder End)"
// http://www.thingiverse.com/thing:17027
//
// Most interesting values to tune are marked with two stars (**)
//

tol=0+0.01;	// to avoid equalities in shape removal, and let openscad preview work better ;)

$fn=0+40;		// high quality cylinders

difference()
{
	cylinder(r1=or1/2, r2=or2/2, h=ch);
	translate([0,0,-tol])
	{
		cylinder(r=ir/2,h=ch+2*tol);
		translate([-gap/2,0,0]) cube([gap,or1+tol,ch+2*tol]);
	}
	for(i=[-tol:(ripples+rippleh):ch-rippleh-2*tol])
		translate([0,0,i])
			cylinder(r=ir/2+rippler * (ch-i)/ch, h=rippleh);
}

