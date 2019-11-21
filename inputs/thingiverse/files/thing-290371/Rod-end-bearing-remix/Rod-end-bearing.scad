// Remix by foofoodog of thing 269297 to make it more proportion based and less parameter based.
/* [Basic] */
// hole diameter
rod = 3.5;
// between ball and socket
gap = .3;
/* [Advanced] */
width_mul = 2;
height_mul = 1.75;
length_mul = 4;
$fn = 48;
// radius of holes
function hole() = rod / 2;
// derived width
function width() = rod * width_mul;
// derived height
function height() = rod * height_mul;
// shaft length
function length() = rod * length_mul;
// shaft placement
function offset() = (length() / 2) + (width() - hole());
// routines
render() main();
module main() {
	socket();
	ball();
	shaft();
}
module socket() { // 1. create housing, 2. remove ball
	orb = height() + gap;
	difference() {
		housing(); // 1.
		sphere(orb); // 2.
	}
}
module ball() { // 1. create ball, 2. drill ball, 3. trim ball
	intersection() {
		difference() { 
			sphere(height()); // 1.
			cylinder(r = hole(), h = height(), center = true); // 2.
		}
		housing(); // 3.
	}
}
module shaft() { // 1. position shaft, 2. create shaft, 3. drill shaft, 4. trim shaft
	loc = [offset(), 0, 0];
	box = [length(), height(), height()];
	rot = [0, 90, 0];
	pin = length() + rod;
	difference() {
		translate(loc) { // 1.
			difference() {
				cube(box, center = true); // 2.
				rotate(rot) cylinder(r = hole(), h = pin, center = true); // 3.
			}
		}
		housing(); // 4.
	}
}
module housing() {
	cylinder(r = width(), h = height(), center = true);
}