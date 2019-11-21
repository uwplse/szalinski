//
//	Parametric Monolith
//	By Theron Trowbridge
//	2011-01-11
//	theron.trowbridge@gmail.com
//	
//	Modeled after Tycho Magnetic Anomoly monoliths from the 2001: A Space Odyssey series
//	Automatic adjustment to be centered on build platform for MakerBot 3D printer
//

/////////////////////
//	Parameters	//
////////////////////
ratio = [ 1, 2, 3 ];	//	The first three primes - change for other shapes
scale_factor = 10;		//	10 is about largest for MakerBot, reduce to make smaller

/////////////////////
//	monolith()	//
////////////////////
module monolith()
{
	x = pow( ratio[0], 2 );
	y = pow( ratio[1], 2 );
	z = pow( ratio[2], 2 );

	cube([x,y,z]);
}

//	Render the monolith
rotate( a=90, v=[1,0,0] ) {	//	Rotate 90 degrees on X axis (lay it flat
	rotate( a=90, v=[0,0,1] ) {	//	Rotate 90 degrees on Z axis (make it face us)
		translate( v=[ 0,
					pow( ratio[1], 2) / 2 * scale_factor * -1,
					pow( ratio[2], 2) / 2 * scale_factor * -1 ] ) {	//	Move it to be on Y and Z axis
			scale( v=[ scale_factor, scale_factor, scale_factor ] ) {	//	Scale it to desired size
				monolith();
			}
		}
	}
}
