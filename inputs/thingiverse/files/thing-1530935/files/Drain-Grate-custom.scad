// Thickness of drain cover
thk = 3.75;

// Diameter of top of grate
top_diameter = 58;

// Diameter of bottom of grate
bottom_diameter = 74;

// Grate height
top_height = 30;

// Base height
bottom_height=20;

// Base lip width
base_extension = 8;

// Number of spokes
num_spokes = 24;

$fn = 80;

drain();

// Individual spoke for drain cover (to be repeated and rotated)
module spoke() {
	translate( [bottom_diameter/2, thk/2, 0] )
		rotate( [90, 0, 0] )
			linear_extrude( height=thk )
                // Use -.1 to nudge down
				polygon( points=[ [-thk, -.1],
	 				[-bottom_diameter/2+top_diameter/2-thk/2, top_height-thk],
					[-bottom_diameter/2+top_diameter/2, top_height],
                    // Use -.1 to nudge down
					[0, -.1] ] );
}

// Drain cover
module drain() {

	// create spokes
	for (snum=[1:num_spokes]) {
		rotate( [0, 0, snum*(360/num_spokes)] )
			spoke(top_diameter, bottom_diameter, top_height);
	}

	// top
	num_top_spokes = ceil(num_spokes/2);
	translate( [0, 0, top_height-thk] ) {
		difference() {
			cylinder( d=top_diameter, h=thk );
			cylinder( d=top_diameter-thk*2, h=thk );
		}

		union() {
			for (snum=[1:num_top_spokes]) {
				rotate( [0, 0, snum*(360/num_top_spokes)] )
					translate( [0, -thk/2, 0] )
							cube( [top_diameter/2, thk, thk] );
			}
			cylinder( d=top_diameter/3, h=thk );
		}

	}

	// solid base
	// Note - the 0.1 fudge is to make this 2-Manifold compliant
	translate( [0, 0, -thk-0.1] ) {
		difference() {
			cylinder( d=bottom_diameter+base_extension*2, h=thk+0.1 );
			cylinder( d=bottom_diameter-thk*2, h=thk+0.1 );
		}
	}

	// solid bottom
	translate( [0, 0, -thk-bottom_height] ) {
		difference() {
			cylinder( d=bottom_diameter, h=bottom_height );
			cylinder( d=bottom_diameter-thk*2, h=bottom_height );
		}
	}


}
