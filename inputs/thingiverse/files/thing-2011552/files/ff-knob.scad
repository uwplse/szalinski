// fine focus knob for CPC 800

// stock knob dimensions
OD_inner = 20.2; 
OD_outer = 22.1;
rib_width = 4.7;
rib_locations = [0, 45, 90, 135, 180, 225, 270, 315];
rib_ht = 0.5 * ( OD_outer - OD_inner );

// fine focus knob dimensions
tol = 0.2;
OD = 70.0;
rO = 0.5 * OD;
thk = 10.0;
rI = 0.5 * OD_inner + tol;
rR = rI + rib_ht + tol;

// rib cutouts
b1 = rib_width + 0.5* tol;
half_b1 = 0.5 * b1;
b2 = rib_width - 0.2 - 0.5*tol;
half_b2 = 0.5 * b2;
knurl = 0.8;

$fn = 180;

difference() {
	cylinder( h = thk, r1 = rO, r2 = rO ); // main solid wheel
	cylinder( h = thk+0.1, r1 = rI, r2 = rI ); // cut out the small cylinder
	// next, cut out for the ribs
	for( a = rib_locations )
		rotate( a )
			linear_extrude( height = thk+0.1 )
				polygon( points = [ [-half_b1, rI - 0.5], [-half_b2, rR], 
									[half_b2, rR], [ half_b1, rI - 0.5] ] );

	// next, cut out notches around outside perimeter for grip
	for( i = [0: 4: 360] )
		rotate( i )
			linear_extrude( height = thk+0.1 )
				polygon( points = [ [rO - knurl, 0 ], [rO+knurl, -2*knurl], 
							[rO + knurl, 2*knurl] ] );
	
} // difference