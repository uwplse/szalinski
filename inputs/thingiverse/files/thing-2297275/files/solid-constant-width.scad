/*
 * I had the idea while watching Angus video:
 *   https://youtu.be/2eUWT9cI23o
 *
 * Author: Gael Lafond
 * Date: 05/05/2017
 */

precision = 180;

module solidOfConstantWidth(width = 10) {
	// x^2 + x^2 = (width/2)^2
	x = sqrt((width/2)*(width/2) / 2);

	//color([1, 0.7, 0.7, 0.5]) {
	//	sphere(width/2, center = true, $fn = precision);
	//}

	intersection() {
		translate([-x, -x, -x]) {
			sphere(width, center = true, $fn = precision);
		}

		translate([x, x, -x]) {
			sphere(width, center = true, $fn = precision);
		}

		translate([-x, x, x]) {
			sphere(width, center = true, $fn = precision);
		}

		translate([x, -x, x]) {
			sphere(width, center = true, $fn = precision);
		}
	}
}

solidOfConstantWidth(30, $fn = precision);
