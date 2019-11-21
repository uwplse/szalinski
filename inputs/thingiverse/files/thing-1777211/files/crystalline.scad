// experimental generator for:
//  splinters
//  basaltish columns
//  irregular crystals and cristalline like structures
//  irregular spheres
//  asteroids
//  failed planets.

// the more points, the more spherical the resulting shape becomes
points=24;	// [6:2:128]

// measured between the most widely apart points
diameter=50;	// [2:200]

// the impression on surface made.
stanchions=0;	// [0:square foot, 1:circular foot]

// size of stanchion footprint
footprint=0.1;	// [0.1:0.1:20]

hull()  {
	for (i=[1:points/2])   {
		orientation=rands(0, 360, 3);
		rotate([orientation[0], orientation[1], orientation[2]])
		if (stanchions) {
			cylinder(diameter, footprint, footprint);
		} else {
			cube([diameter, footprint, footprint], center=true);
		}
	}
}
