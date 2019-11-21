/*
 * =====================================
 *   This is public Domain Code
 *   Contributed by: Gael Lafond
 *   4 November 2018
 * =====================================
 *
 * Library used to create stars.
 *
 * Inspired from Juan Gonzalez-Gomez (Obijuan):
 *   https://www.thingiverse.com/thing:5052
 *
 * GPL license
 */

number_of_points = 5; // [2:100]
inner_radius = 15; // [1:100]
outer_radius = 30; // [1:100]
height = 5; // [1:100]

linear_extrude(height) {
	star(n=number_of_points, ri=inner_radius, ro=outer_radius);
}

/**
 * The 2*N points of an N-pointed star are calculated as follows:
 * There are two circunferences: the inner and outer. Outer points are located
 * on the outer circunference defined by "ro". The inner points are 360/(2*N) rotated
 * respect to the outers. They are located on the inner circunference defined by "ri".
 */

/**
 * Draw a 2D star polygon.
 * @param {integer} n: Number of points
 * @param {float} ri: Inner radius
 * @param {float} ro: Outer radius
 */
module star(n=5, ri=15, ro=30) {
	if (n > 1) {
		polygon([
			for (i = [0 : n-1], in = [true, false])
				in ?
					[ri*cos(-360*i/n + 360/(n*2)), ri*sin(-360*i/n + 360/(n*2))] :
					[ro*cos(-360*i/n), ro*sin(-360*i/n)]
		]);
	}
}
