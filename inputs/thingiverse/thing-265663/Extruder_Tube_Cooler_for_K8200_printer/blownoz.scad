
l = 40;
b = 16;
w = 40;
t = 1.0;
o = 0.65;

	hull()
	{
		translate( [ 0, 0, 5 ] )
		cube( [ b+t*2, w+t*2, 10 ], center = true );
		translate( [ 0, w*o/4, l-5 ] )
		cube( [ b+t*2, w*o+t*2, 10 ], center = true );
	}
 