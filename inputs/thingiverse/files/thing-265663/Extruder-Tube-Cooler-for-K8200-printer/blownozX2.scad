
h = 45;
w = 16;
l = 40;
t = 1.0;
o = 0.65;

c = 0.3;
b = 27.5+c*2;
s = 5;

difference()
{
	hull()
	{
		translate( [ 0, 0, 5 ] )
		cube( [ w+t*2, l+t*2, 10 ], center = true );
		translate( [ 0, (l*o+t*2)/4, h-5 ] )
		cube( [ w+t*2, l*o+t*2, 10 ], center = true );
	}
	hull()
	{
		translate( [ 0, 0, 4.9 ] )
		cube( [ w+t*0, l+t*0, 10.2 ], center = true );
		translate( [ 0, (l*o+t*2)/4, h-5 ] )
		cube( [ w+t*0, l*o+t*0, 10.1 ], center = true );
	}
}
 
difference()
{
	translate( [ 0, l/2+b/2+s, t+t ] )
	{
		translate( [ 0, 0, +1.5 ] )
			cube( [ w+t*2, 4.5, 5 ], center = true );

		translate( [ 0,0, 0.75 ] )
			cube( [ w+t*2, 12-c, 1+2.5 ], center = true );

		translate( [ 0,0, 0.15 ] )
			cube( [ w+t*2, 16-c, 1+1.25 ], center = true );

		translate( [ 0,-s/2-1, -t ] )
			cube( [ w+t*2, b+s-2-t/2, t*2 ], center = true );

	}
	translate( [ 0, l/2+b/2+s, 0 ] )
		cylinder( r = 2.65, h = 100, center = true, $fn = 12 );
}

	translate( [ 0, t+l/2, t*2 ] )
		intersection()
		{
		rotate( [ 0, 90, 0 ] ) 
			cylinder( r = t*2, h = w+t*2, center = true, $fn = 4 );
		translate( [ 0, 5, 0 ] )
			cube( [ 100, 10+t/2, 100 ], center = true );
		}