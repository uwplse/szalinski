clockwise = "YES"; // [YES, NO]
thickness = 10;
height = 100;
init_angle = 720 * 3; 
ray_length = 15;
steps = 15;
step_distance = 50;
children_per_step = 10;
twist = 720;
scale = 0.1;

function PI() = 3.14159;
 
function find_parent_angles(angles, ray_length, step_distance, n, i = 1) =
    i == n ? angles :
        find_parent_angles(concat(angles, [angles[i - 1] + step_distance * 64800 / (PI() * angles[i - 1] * ray_length)]), ray_length, step_distance, n, i + 1);

module archimedean_spiral(thickness, init_angle, ray_length, step_distance, steps, children_per_step) {
    a = ray_length / 360;
	
    parent_angles = find_parent_angles([init_angle], ray_length, step_distance, steps);

	child_step_angles = [for(i = [1:steps - 1]) (parent_angles[i] - parent_angles[i - 1]) / children_per_step];
	
	radius_angles = [for(i = [1:steps - 2]) for(j = [0:children_per_step - 1]) [
	    (parent_angles[i - 1] + child_step_angles[i] * j) * a, 
		parent_angles[i - 1] + child_step_angles[i] * j
	]];
	
	radius_angles_end = len(radius_angles) - 1;
	
	points = [for(i = [0:radius_angles_end]) 
	    [
		    radius_angles[i][0] * cos(radius_angles[i][1]), 
		    radius_angles[i][0] * sin(radius_angles[i][1])
		]
	];
	
	inner_points = [for(i = [0:radius_angles_end]) 
	    [
		    (radius_angles[radius_angles_end - i][0] - thickness) * cos(radius_angles[radius_angles_end - i][1]), 
			(radius_angles[radius_angles_end - i][0] - thickness)  * sin(radius_angles[radius_angles_end - i][1])
		]
	];
	
	polygon(concat(points, inner_points));
}

linear_extrude(height, twist = twist, scale = scale) 
    mirror([0, clockwise == "YES" ? 1 : 0, 0])
	    archimedean_spiral(
		    thickness, 
			init_angle, 
			ray_length, 
			step_distance, 
			steps, 
			children_per_step
		);
	
	
