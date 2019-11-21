
l = 60;
b = 60;
h = 8;
t = 3;
s = 4;

difference()
{
hull()
{
for ( a = [ -1, +1 ] )
	tx( l/2*a ) ty( b/4 )
		cbox( t, b/2, t );

	ty( -b/2 )
		cbox( l/2, t, t );
}

for ( a = [ -1, +1 ] )
	ty( a * l/4 )
		ccyl( d = s, h = 100, $fn = 16 );

for ( a = [ -1, +1 ] )
	ty( a * l/4 ) tz( t/2 )
		ccyl( d1 = s, d2 = s+t*2, h = t, $fn = 16 );
}


for ( a = [ -1, +1 ] )
	tx( l/2*a ) tz( h / 2 ) ty( b/4 )
		cbox( t, b/2, t+h );

	ty( -b/2 ) tz( h / 2 )
		cbox( l/2, t, t+h );

	

intersection()
{
union()
{
for ( a = [ -1, +1 ] )
	tx( l/2*a ) tz( h + t / 2 ) ty( b/4 )
		rx( 90 )
			ccyl( d = t*2.5, h = b/2, $fn = 4 );

	ty( -b/2 ) tz( h + t / 2 )
		ry( 90 )
			ccyl( d = t*2.5, h = l/2, $fn = 4 );
}

cbox( l*2, b*2, h*2 + t*2 );
}


/// lazy.scad 1.1
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
module cbox( x, y, z ) cube( [ x, y, z ], center = true );

// centered cylinder
module ccyl( d, h, d1, d2, r, r1, r2 )
 cylinder( h = h, r = ( d == undef ? r : d/2 ), r1 = ( d1 == undef ? r1 : d1/2 ), r2 = ( d2 == undef ? r2 : d2 / 2 ), center = true );

/// end lazy.scad
