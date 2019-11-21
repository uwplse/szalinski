/*
Creates a 3 dimensional raindrop shape.

parameters:
	radius		radius of the sphere on the bottom of the raindrop shape
	centered	boolean value. sets the bottom sphere as centered (true) on [0, 0, 0],
	or sets the entire object in the positive [x, y, z] quadrant
*/

// Radius in millimeters.
radius = 50; // [1:100]

// Height is a multiple of the radius.
height = 2.8; // [2:20]

// Steps are the number of cylinders to make up the upper pointy end.
steps = 20; // [2:50]

// Controls how many facets go around the curve.
facets = 30; // [5:100]

// A silly bonus feature for revealing how the script works.
loops = 1; // [0:4]

raindrop3D( radius, height, steps, loops, facets );

module raindrop3D(radius, height, steps, loops, facets){

	sphere(radius, $fn = facets );

	for( i = [ 0 : steps * loops - 1 ] ){
		translate([0, 0, radius * height / steps * i])
			cylinder(h = 1 / steps * height * radius, // This is fine.
					r1 = (cos( 180 * i / steps )/2+0.5) * radius,
					r2 = (cos( 180 * (i+1) / steps )/2+0.5) * radius,
          $fn = facets );
	}

}//end of module raindrop3D
