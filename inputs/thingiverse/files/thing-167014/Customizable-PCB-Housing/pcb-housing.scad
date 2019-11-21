
pcb = [ 65, 40, 22 ];
//pcb = [ 80, 44, 16 ];

c = 0.3;

difference()
{
translate( [ 0, 0, 0 ] )
 box( pcb[0]+6, pcb[1]+6, pcb[2]+8 );
translate( [ 0, 0, 1 ] )
 box( pcb[0]+2, pcb[1]-4, pcb[2]+6 );
translate( [ 0, 0, 2 ] )
 box( pcb[0]+2, pcb[1]+2, pcb[2]+4 );

for ( a = [ -1, +1 ], b = [ -1, +1 ] )
	translate( [ a*pcb[0]/3, b*pcb[1]/3, 0 ] )
		cylinder( r = 3, h = pcb[2]*2, center = true );

translate( [ 0, 0, -pcb[2]/2+12+3 ] ) rotate( [ 0, 90, 0 ] ) scale( [ 1, pcb[1]/16, 1 ] )
 cylinder( r = 8, h = pcb[0]*2, center = true );

for ( a = [ -1, +1 ] )
	translate( [ a*pcb[0]/4, 0, -pcb[2]/2+7 ] ) rotate( [ 90, 0, 0 ] )
		cylinder( r = 2, h = pcb[1]*2, center = true, $fn = 12 );

translate( [ 0, 0, 12 ] )
	box( pcb[0]+10, pcb[1]+10, pcb[2]-8/2 );
}

for ( a = [ -1, +1 ] )
translate( [ a*(pcb[0]/2+7.1), 0, - pcb[2]/2-2 ] )
	difference()
	{
		box( 12, 25, 4 );
		cylinder( r = 2.5+c, h = 10, center = true );
	}

translate( [ 0, pcb[1]+10, -c/2 ] )
rotate( [ 180, 0, 0 ] )
difference()
{
union()
{
	translate( [ 0, 0, 3 ] )
		box( pcb[0]+2-2*c, pcb[1]+2-2*c, pcb[2]+2-c );
	for ( a = [ -1, +1 ], b = [ -1, +1 ] )
		translate( [ a*pcb[0]/4, b*pcb[1]/2, -pcb[2]/2+7 ] )
			sphere( r = 2.15, center = true, $fn = 24 );
}
translate( [ 0, 0, 1 ] )
	box( pcb[0]-2, pcb[1]-2, pcb[2] );
translate( [ 0, 0, 3-(pcb[2]+2-c)/2 ] ) rotate( [ 0, 90, 0 ] ) scale( [ 1.25, (pcb[1]-3)/16, 1 ] )
	cylinder( r = 8, h = pcb[0]*2, center = true );
}


module box( x, y, z, w = 0 )
{
	difference()
	{
		cube( [ x - ( w < 0 ? w*2 : 0 ), y - ( w < 0 ? w*2 : 0 ), z - ( w < 0 ? w*2 : 0 ) ], center = true );

		if ( w != 0 )
			cube( [ x - ( w > 0 ? w*2 : 0 ), y - ( w > 0 ? w*2 : 0 ), z - ( w > 0 ? w*2 : 0 ) ], center = true );
	}
}

