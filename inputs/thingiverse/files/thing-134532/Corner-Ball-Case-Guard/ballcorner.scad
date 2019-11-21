
r = 10;
r2 = 2 * r;

d = 2.5;
s = 4;

difference()
{
	union()
	{
		translate( [ 0, 0, r2*3/4 ] )
			sphere( r = r, center = true );
		translate( [ 0, 0, r2/2 ] )
			cylinder( r1 = r2, r2 = 0, h = r2, center = true, $fn = 3 );
	}

	translate( [ 0, 0, r2/2-d*sqrt(2) ] )
		cylinder( r1 = r2, r2 = 0, h = r2, center = true, $fn = 3 );

	cube( [ r*4, r*4, 1 ], center = true );

	for ( a = [ 0, 120, 240 ] ) rotate( a+60, [ 0, 0, 1 ] )
		translate( [ r2*cos(60), 0, 0 ] )
			rotate( [ 0, 60, 0 ] )
				translate( [ -1.25*s, 0, 0 ] )
			cylinder( r = s/2, h = d*3, center = true );
}