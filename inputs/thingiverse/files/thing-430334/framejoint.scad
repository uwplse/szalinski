// beam width
w = 11;

// beam support length
l = 20;

// hole diameter
p = 3.5;

// material thickness
t = 3;

// 3 or 4 way joint
n = 4; // [ 2, 3, 4 ]

$fn = 8;


difference()
{
	union()
	{
		for ( z = [ 1 : n ] ) rz( z * 90 )
			for ( x = [ -1, +1 ] )
				txy( x*( t/2 + w/2 ), l/2 + w/2 + t )
					cbox( t, l, w );

		for ( a = [ -1, +1 ], b = [ -1, +1 ] )
			txy( a*w/2+a*t/2, b*w/2+b*t/2 )
				ccyl( r = t*1.5, h = w, $fn = 4 );

		cbox( w+t+t, w+t+t, w );
	}

	for ( a = [ -1, 0, +1 ] )
		tx( a*( l/3*2 + w/2 + t ) )
			rx( 90 )
				rz( 180/8 )
					ccyl( r = p/2, h = w+t*3 );

	for ( a = [ +1, 0, -1 ] )
		ty( a*( l/3*2 + w/2 + t ) )
			ry( 90 )
				rz( 180/8 )
					ccyl( r = p/2, h = w+t*3 );

	cbox( w, w, w*2 );
}


/// lazy.scad 1.2
/// a collection of useful macros for the lazy OpenSCAD programmer
/// http://www.thingiverse.com/thing:512443
// single axis translations
module tx( x ) translate( [ x, 0, 0 ] ) for(c=[0:$children-1])child(c);
module ty( y ) translate( [ 0, y, 0 ] ) for(c=[0:$children-1])child(c);
module tz( z ) translate( [ 0, 0, z ] ) for(c=[0:$children-1])child(c);
// 2d translations
module txy( x, y ) translate( [ x, y, 0 ] ) for(c=[0:$children-1])child(c);
module tyz( y, z ) translate( [ 0, y, z ] ) for(c=[0:$children-1])child(c);
module txz( x, z ) translate( [ x, 0, z ] ) for(c=[0:$children-1])child(c);
// 3d translation
module txyz( x, y, z ) translate( [ x, y, z ] ) for(c=[0:$children-1])child(c);
// single axis rotations
module rx( a ) rotate( [ a, 0, 0 ] ) for(c=[0:$children-1])child(c);
module ry( a ) rotate( [ 0, a, 0 ] ) for(c=[0:$children-1])child(c);
module rz( a ) rotate( [ 0, 0, a ] ) for(c=[0:$children-1])child(c);
// centered box (cube)
module cbox( x, y, z, t, xyz ) assign( s = (xyz==undef?[x,y,z]:xyz) ) if ( t == undef || t == 0 ) cube( s, center = true ); else difference() { cbox( xyz = (t>0?s:s-2*[t,t,t]) ); cbox( xyz = (t>0?s-2*[t,t,t]:s) ); }
// centered cylinder
module ccyl( d, h, d1, d2, r, r1, r2 )
cylinder( h = h, r = ( d == undef ? r : d/2 ), r1 = ( d1 == undef ? r1 : d1/2 ), r2 = ( d2 == undef ? r2 : d2 / 2 ), center = true );
/// end lazy.scad

