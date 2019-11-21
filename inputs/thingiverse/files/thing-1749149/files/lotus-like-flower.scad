spirals = 10;
petals_per_spiral = 4; 

function fibonacci(nth) = 
    nth == 0 || nth == 1 ? nth : (
	    fibonacci(nth - 1) + fibonacci(nth - 2)
	);
	
	
module petal(radius, thickness) {
    $fn = 24;
	translate([-radius * 1.5, 0, radius * 2]) rotate([90, 120, 90]) intersection() {
		difference() {
			sphere(radius * 2);
			sphere(radius * 2 - thickness);
		}

		linear_extrude(radius * 5) hull() {
			translate([radius * 1.25, 0, 0]) circle(radius / 3);
			translate([-1.1 * radius, 0, 0]) circle(radius / 3);
			circle(radius * 0.85);
		}
	}
}
	
module golden_spiral_for_pentals(from, to) {
    if(from <= to) {
		f1 = fibonacci(from);
		f2 = fibonacci(from + 1);
		
		offset = f1 - f2;

		translate([0, 0, offset * 1.8]) rotate([-5, 40, 10])
		    petal(-offset, -offset / 6);

		translate([0, offset, 0]) rotate(90) 
			golden_spiral_for_pentals(from + 1, to);

	}
}

module lotus_like_flower(spirals, petals_per_spiral) {
    $fn = 24;

    step_angle = 360 / spirals;
	for(i = [0:spirals - 1]) {
		rotate(step_angle * i) 
		    golden_spiral_for_pentals(1, petals_per_spiral);
	}

	fib_diff = fibonacci(petals_per_spiral) - fibonacci(petals_per_spiral - 1);


	translate([0, 0, -fib_diff]) scale([1, 1, fib_diff]) sphere(1);
	translate([0, 0, -fib_diff * 2.25]) difference() {
		sphere(fib_diff);
		translate([-fib_diff, -fib_diff, -fib_diff * 2]) cube(fib_diff * 2);
	}
}

lotus_like_flower(spirals, petals_per_spiral + 1);
