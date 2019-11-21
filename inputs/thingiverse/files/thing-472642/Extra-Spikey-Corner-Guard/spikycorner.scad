
c = 35;
t = 1.5;
s = 3.5;

intersection()
{
rotate( [ 45, -asin( 1 / sqrt( 3 ) ), 0 ] )
difference()
{
	union()
	{
		cube( [ c, c, c ], center = true );
		translate( [ 1, 1, 1 ]*(c/4.5) )
			for ( a = [ 0, 120, 240 ] ) rotate( a, [ 1, 1, 1 ] )
				translate( [ 0, 0, 1 ] * (6.5*c/35) )
					rotate( [ 45, asin( 1 / sqrt( 3 ) ), 0 ] )
						rotate( 45+180, [ -1, 1, 1 ] )
							cube( 11*c/35, center = true );
	}

		rotate( [ 0, 0, 0 ] )
			translate( [ 0, 0, 1 ] * c/2 ) rotate( [ 0, 0, 45 ] )
				translate( [ 1,0, 0 ] * 4.5*c/35 )
					for ( a = [ -1, +1 ] ) translate( (a+0.0)*[0,1,0] * c/2*0.5 )
					cylinder( r = s/2, h = c, center = true );
		rotate( [ 270, 0, 0 ] )
			translate( [ 0, 0, 1 ] * c/2 ) rotate( [ 0, 0, 270+45 ] )
				translate( [ 1,0, 0 ] * 4.5*c/35 )
					for ( a = [ -1, +1 ] ) translate( (a+0.0)*[0,1,0] * c/2*0.5 )				cylinder( r = s/2, h = c, center = true );
		rotate( [ 0, 90, 0 ] )
			translate( [ 0, 0, 1 ] * c/2 ) rotate( [ 0, 0, 90+45 ] )
				translate( [ 1,0, 0 ] * 4.5*c/35 )
					for ( a = [ -1, +1 ] ) translate( (a+0.0)*[0,1,0] * c/2*0.5 )					cylinder( r = s/2, h = c, center = true );

	cube( [ c-t*2, c-t*2, c-t*2 ], center = true );
}
translate( [ 0, 0, c*0.27+100 ] ) cube( 200, center = true );
}
