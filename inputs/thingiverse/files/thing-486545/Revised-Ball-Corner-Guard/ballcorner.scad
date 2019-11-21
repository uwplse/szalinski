
r = 15;    // [ 10 : 40 ] 
t = 1.5;	  // [ 0.5 : 3.0 ]
s = 3.5;   // [ 0.0 : 6.0 ]
so = 0.00; // [ 0.0 : 0.2 ]
m = 0.85; // [ 0.7 : 1.0 ]
c = r/sin(45)/0.725+s+t;

echo( c );

intersection()
{
rotate( [ 45, -asin( 1 / sqrt( 3 ) ), 0 ] )
difference()
{
	union()
	{
		cube( [ c, c, c ], center = true );
		translate( [ 1, 1, 1 ]*(c/2+r/2-r*m) )
			rotate( [ -asin( 1 / sqrt( 3 ) ), 45, 0 ] )
		//	rotate( [ 180, 0, 90 ] )
		//	cylinder( r1 = r, r2 = 0, h = r*2, $fn = 3 );
			sphere( r = r, center = true );

	}

		rotate( [ 0, 0, 0 ] )
			translate( [ 0, 0, 1 ] * c/2 ) rotate( [ 0, 0, 45 ] )
				translate( [ 1,0, 0 ] * (t+s*0.5) )
					for ( a = [ -1, +1 ] ) translate( (a+so)*[0,1,0] * c/2*0.7 )
					cylinder( r = s/2, h = c, center = true );
		rotate( [ 270, 0, 0 ] )
			translate( [ 0, 0, 1 ] * c/2 ) rotate( [ 0, 0, 270+45 ] )
				translate( [ 1,0, 0 ] * (t+s*0.5) )   
					for ( a = [ -1, +1 ] ) translate( (a+so)*[0,1,0] * c/2*0.7 )				cylinder( r = s/2, h = c, center = true );
		rotate( [ 0, 90, 0 ] )
			translate( [ 0, 0, 1 ] * c/2 ) rotate( [ 0, 0, 90+45 ] )
				translate( [ 1,0, 0 ] * (t+s*0.5) )   
					for ( a = [ -1, +1 ] ) translate( (a+so)*[0,1,0] * c/2*0.7 )					cylinder( r = s/2, h = c, center = true );

	cube( [ c-t*2, c-t*2, c-t*2 ], center = true );
}
translate( [ 0, 0, c*0.27+100 ] ) cube( 200, center = true );
}

/*
difference()
{
	union()
	{
		translate( [ 0, 0, h ] )
			sphere( r = r, center = true );
		translate( [ 0, 0, h/2 ] )
			cylinder( r1 = r2, r2 = 0, h = h, center = true, $fn = 3 );
	}

	translate( [ 0, 0, h/2-d*sqrt(2) ] )
		cylinder( r1 = r2, r2 = 0, h = h, center = true, $fn = 3 );

	for ( a = [ 0, 120, 240 ] ) rotate( a+60, [ 0, 0, 1 ] )
		translate( [ r2*cos(60), 0, 0 ] )
			rotate( [ 0, 60, 0 ] )
				translate( [ -1.25*s, 0, 0 ] )
			cylinder( r = s/2, h = d*3, center = true );
}
*/

/*
//rotate( [ 45, 0, 0 ] ) rotate( 30, [ 0, 1, -1 ] )
{color( "red" ) cube( [ 50, 0.1, 0.1 ], center = true );
color( "green" ) cube( [ 0.1, 50, 0.1 ], center = true );
color( "blue" ) cube( [ 0.1, 0.1, 50 ], center = true );
}
//translate( [ 3, 0, 0 ] )
//rotate( [ 45, 0, 0 ] ) rotate( 33, [ 0, 1, -1 ] )
//translate( [ 4, -5, -5 ] )
color( "snow" ) cube( 20, center = true );
*/