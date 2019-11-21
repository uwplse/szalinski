

dim = [ 30, 50 ];
//dim = [ 38, 64 ];

c = 0.3;

w = dim[0]+c;
h = dim[1]+c;
l = 20;
t = 2;
b = 27.5+c*2;

difference()
{
	cube( [ w+t*2, h+t*2, l ], center = true );

	cube( [ w, h, l*2 ], center = true );
}

translate( [ w/2+t+b/2, 0, 0 ] )
difference()
{
	union()
	{
		for ( a = [ -1, +1 ] )
		{
			translate( [ 0, a*( b/2+t/2 ), 0 ] )
				cube( [ b, t, l ], center = true );
			translate( [ -b/2, a*( b/2+t ), 0 ] )
				cylinder( r = t, h = l, center = true, $fn = 4 );
		}

		for ( a = [ 0, 90, 270 ] ) rotate( [ 0, 0, a ] )
		{
			if ( a == 0 )
		translate( [ -b/2+1.5, 0, 0 ] )
			cube( [ 5, 4.5, l ], center = true );

		translate( [-b/2+0.75, 0, 0 ] )
			cube( [ 1+2.5, 12-c, l ], center = true );

		translate( [ -b/2+0.15, 0, 0 ] )
			cube( [ 1+1.25, 16-c, l ], center = true );
		}
	}

	//translate( [ w/2+t+3.5+2, 0, 0 ] )
	//	cube( [ 5.5, 10, 10 ], center = true );

	for ( a = [ 90, 270 ] ) rotate( [ 0, 0, a ] )
	{
		translate( [ -b/2-1, 0, 0 ] ) rotate( [ 0, 90, 0 ] )
			cylinder( r = 2.65, h = 40, center = true, $fn = 6 );

		translate( [ -b/2-1.75, 0, 0 ] ) rotate( [ 0, 90, 0 ] )
			cylinder( r2 = 2.65, r1 = 10, h = 7, center = true, $fn = 6 );
	}
}
