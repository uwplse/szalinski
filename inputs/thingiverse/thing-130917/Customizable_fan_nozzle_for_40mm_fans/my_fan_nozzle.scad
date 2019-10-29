
nozzle_edges = 6;
nozzle_edgeradius = 3;
nozzle_edgerotate = false;
nozzle_length = 24;
nozzle_dillation = 24;
nozzle_wall = 1;
nozzle_scale = 0.75;
nozzle_tilt = 18;

mntholes_numberof = 2;
mntholes_angles = [ 90, 270, 0, 180 ];

$fn = 50;

module nozzle_shape( r, h )
{
	if ( nozzle_edges < 20 && nozzle_edgeradius > 0 )
		for ( a = [0:nozzle_edges] )
			rotate( [ 0, 0, 360/nozzle_edges * a ] )
				translate( [ r- nozzle_edgeradius, 0, 0 ] )
					cylinder( r = nozzle_edgeradius, h = h, center = true, $fn = 16 );
	else
		cylinder( r = r, h = h, center = true, $fn = nozzle_edges );
}

difference()
{
	union()
	{
		for ( a = [1:mntholes_numberof] )
			rotate( [ 0, 0, mntholes_angles[a-1] ] )
			{
				translate( [ 10, 8, 0 ] )
					cube( [ 20, 16, 2 ], center = true );
				translate( [ 8, 10, 0 ] )
					cube( [ 16, 20, 2 ], center = true );
				translate( [ 16, 16, 0 ] )
					cylinder( r = 4, h = 2, center = true, $fn = 16 );
			}

		hull()
		{
			cylinder( r = 20.5, h = 2, center = true );
			rotate( [ 0, nozzle_tilt, 0 ] )
			translate( [ 0, 0, nozzle_length ] )
				scale( [ nozzle_scale, 1 / nozzle_scale, 1 ] )
					rotate( [ 0, 0, nozzle_edgerotate ? 180 / nozzle_edges : 0 ] )
						nozzle_shape( r = nozzle_dillation/2+nozzle_wall*max(nozzle_scale,1/nozzle_scale), h = 1 );
		}
	}

	for ( a = [1:mntholes_numberof] )
		rotate( [ 0, 0, mntholes_angles[a-1] ] )
			translate( [ 16, 16, 0 ] )
				cylinder( r = 1.6, h = 5, center = true, $fn = 16 );

	hull()
	{
		translate( [ 0, 0, -1.5 ] )
		cylinder( r = 20.5 - nozzle_wall, h = 1, center = true );
			rotate( [ 0, nozzle_tilt, 0 ] )
		translate( [ 0, 0, nozzle_length ] )
			//cylinder( r = nozzle_dillation * cos( 180 / nozzle_edges )/2, h = 1.5, center = true );
			scale( [ nozzle_scale, 1 / nozzle_scale, 1 ] )
				rotate( [ 0, 0, nozzle_edgerotate ? 180 / nozzle_edges : 0 ] )
					nozzle_shape( r = nozzle_dillation/2, h = 1.5 );
	}
}

