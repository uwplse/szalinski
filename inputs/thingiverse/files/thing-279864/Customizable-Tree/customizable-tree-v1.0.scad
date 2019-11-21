use <write/Write.scad>
//use <utils/3dvector.scad>
use <utils/hsvtorgb.scad>

/**************************************************************************************/
/*							 		Customizer Controls								  */
/**************************************************************************************/

//preview[view:south, tilt:top diagonal]

/*[Tree]*/
//Use the Tabs above to play with different settings!

//The number of times that branches will iterate. Controls how many levels of branches there are.
maximum_branching_iterations = 7; //[1,2,3,4,5,6,7]

//The radius of the bottom of the trunk of the tree in mm
trunk_radius = 15; //[10:35]

/*[Branches]*/

//Controls the minimum number of branches that will generate from each branch
min_number_of_branches_from_each_branch = 2; //[1:4]

//Controls the maximum number of branches that will generate from each branch
max_number_of_branches_from_each_branch = 3; //[2:5]

//How far along a branch do new branches start splitting off
start_budding_position = 50; //[0:100]

//How far along a branch do new branches stop splitting off
stop_budding_position = 60; //[0:100]

//How much are the branches twisted?
branch_twist_angle = 90; //[0:90]

//Do lower branches keep growing after they have started branching? Usually results in a fuller tree.
branches_keep_growing = 1; //[1:Yes, 0:No]


/*[Shape]*/

//Pick a shape for your trunk and branches. Select "Custom" to draw your own below!
branch_cross_section_shape = 6; //[3:Triangle,4:Square,5:Pentagon,6:Hexagon,8:Octagon,32:Circle,0:Custom]

custom_shape = [[[0.000000,46.278908],[-15.319993,17.365068],[-47.552826,11.729756],[-24.788267,-11.775289],[-29.389259,-44.171944],[0.000001,-29.785017],[29.389269,-44.171940],[24.788267,-11.775290],[47.552826,11.729764],[15.319985,17.365074]],[[0,1,2,3,4,5,6,7,8,9]]]; //[draw_polygon:100x100]

//Pick a shape for your base
base_shape = 0; //[3:Triangle,4:Square,5:Pentagon,6:Hexagon,8:Octagon,32:Circle,0:Use Same Shape as Branch]


/*[Overhangs]*/

//If you set this to Yes, you'll need to print with supports
allow_all_overhangs = 0; //[0:No, 1:Yes]

//If the previous control is set to No, how much overhang angle, in degrees, do you want to allow?
allowed_overhang_angle = 50; //[30:65]

/*[Variation]*/

//Change this to get different variants based on your inputs.
seed = 0; //[0:360]

/*[Advanced Settings]*/

//These controls can result in trees which are unprintable or very difficult to print, but also allow for a wider variety of shaped trees. Only use these if you are willing to experiment.
use_advanced_settings = 0; //[0:No,1:Yes]

//these settings control the range of how big a new branch's base diameter is compared to its parents base diameter
root_min_ratio = 50; //[1:100]
root_max_ratio = 60; //[1:100]

//these settings control the range of how big a new branch's tip diameter is compared to its own base diameter
tip_min_ratio = 50;	//[1:100]
tip_max_ratio = 70;	//[1:100]

//these settings control the range of how long a new branch is compared to its parent branch
length_min_ratio = 70;	//[1:100]
length_max_ratio = 100;	//[1:100]

//these settings control the range of angles that a new branch will diverge from its parent branch. this number will get modified to ensure proper overhangs if the "allow all overhangs" option is turned off.
min_branching_angle = 40; //[0:360]
max_branching_angle = 55; //[0:360]

//this value is used to test if branches are above a minimum printable feature size in mm. you can set this lower if your printer can handle tiny towers. we don't suggest setting this smaller than your_nozzle_diameter X 2.
branch_diameter_cutoff = 1.6;

//this controls the length of the trunk of the tree
trunk_length = 40; //[10:60]


/*[Hidden]*/
//The size of the bounding box around the stand of the tree
base_size = trunk_radius * 2 + 20;
my_root_min_ratio = use_advanced_settings == 1 ? root_min_ratio / 100 : .5;
my_root_max_ratio = use_advanced_settings == 1 ? root_max_ratio / 100 : .6;
my_tip_min_ratio = use_advanced_settings == 1 ? tip_min_ratio / 100 : .5;
my_tip_max_ratio = use_advanced_settings == 1 ? tip_max_ratio / 100 : .7;
my_length_min_ratio = use_advanced_settings == 1 ? length_min_ratio / 100 : .7;
my_length_max_ratio = use_advanced_settings == 1 ? length_max_ratio / 100 : .9;
my_min_branching_angle = use_advanced_settings == 1 ? min_branching_angle : 45;
my_max_branching_angle = use_advanced_settings == 1 ? max_branching_angle : 55;
my_branch_diameter_cutoff = use_advanced_settings == 1 ? branch_diameter_cutoff : 1.6;
my_trunk_length = use_advanced_settings == 1 ? trunk_length : 40;

/**************************************************************************************/
/*											Code									  */
/**************************************************************************************/

//This makes the tree's platform
if(base_shape > 0)
{
	linear_extrude(height = 1)
		circle(r = base_size / 2, $fn = base_shape);
}
else
{
	if(branch_cross_section_shape > 0)
	{
		linear_extrude(height = 1)
			circle(r = base_size / 2, $fn = branch_cross_section_shape);
	}
	else
	{
		if(len(custom_shape[0]) < 32)
		{
			linear_extrude(height = 1)
				scale([1 / 100 * base_size, 1 / 100 * base_size])
					polygon(points=custom_shape[0], paths=[custom_shape[1][0]]);
		}
		else
		{
			linear_extrude(height = 1)
				scale([1 / 100 * base_size, 1 / 100 * base_size])
					polygon(points=reduce_shape_to_32_points(custom_shape)[0], paths=reduce_shape_to_32_points(custom_shape)[1]);
		}
	}
}

//This makes the tree itself
difference()
{
	if(branch_cross_section_shape > 0)
	{
		draw_vector_branch_from_polygon
		(
			iterations_total = maximum_branching_iterations,
			iterations_left = maximum_branching_iterations,

			direction = [0,0,1],
			root = [0, 0, 0],
	
			polygon_bounding_size = [trunk_radius * 2, trunk_radius * 2],
			twist = branch_twist_angle,
	
			branch_root_min_scale_ratio = my_root_min_ratio,
			branch_root_max_scale_ratio = my_root_max_ratio,
	
			branch_tip_min_scale_ratio = my_tip_min_ratio,
			branch_tip_max_scale_ratio = my_tip_max_ratio,
	
			branch_min_lengh_ratio = my_length_min_ratio,
			branch_max_lengh_ratio = my_length_max_ratio,
	
			min_branching = min_number_of_branches_from_each_branch,
			max_branching = max_number_of_branches_from_each_branch,
	
			min_branching_angle = my_min_branching_angle,
			max_branching_angle = my_max_branching_angle,
	
			budding_start_ratio = start_budding_position / 100,
			budding_end_ratio = (stop_budding_position > start_budding_position ? stop_budding_position : start_budding_position) / 100,
		
			extend_branch = branches_keep_growing,
	
			overhangs_allowed = allow_all_overhangs,
			overhang_angle_cutoff = allowed_overhang_angle,
	
			branch_cross_section_bounds_size_cutoff = my_branch_diameter_cutoff,
	
			last_branch_root_scale = 1,
			last_branch_length = my_trunk_length,
	
			random_seed = false,
			manual_seed = seed
	

		)
		{
			rotate([0,0,90])
			circle(r = trunk_radius, $fn = branch_cross_section_shape);
		}
	}
	else
	{
		if(len(custom_shape) == 0)
		{
			write("<----------Draw a Shape!",space=1.05,center = true,font = "write/orbitron.dxf");
		}
		else
		{
			if(len(custom_shape[1][0]) <= 32)
			{	
				draw_vector_branch_from_polygon
				(
					iterations_total = maximum_branching_iterations,
					iterations_left = maximum_branching_iterations,

					direction = [0,0,1],
					root = [0, 0, 0],
	
					polygon_bounding_size = [trunk_radius * 2, trunk_radius * 2],
					twist = branch_twist_angle,
	
					branch_root_min_scale_ratio = my_root_min_ratio,
					branch_root_max_scale_ratio = my_root_max_ratio,
	
					branch_tip_min_scale_ratio = my_tip_min_ratio,
					branch_tip_max_scale_ratio = my_tip_max_ratio,
	
					branch_min_lengh_ratio = my_length_min_ratio,
					branch_max_lengh_ratio = my_length_max_ratio,
	
					min_branching = min_number_of_branches_from_each_branch,
					max_branching = max_number_of_branches_from_each_branch,
	
					min_branching_angle = my_min_branching_angle,
					max_branching_angle = my_max_branching_angle,
	
					budding_start_ratio = start_budding_position / 100,
					budding_end_ratio = (stop_budding_position > start_budding_position ? stop_budding_position : start_budding_position) / 100,
	
					extend_branch = branches_keep_growing,
	
					overhangs_allowed = allow_all_overhangs,
					overhang_angle_cutoff = allowed_overhang_angle,
	
					branch_cross_section_bounds_size_cutoff = my_branch_diameter_cutoff,
	
					last_branch_root_scale = 1,
					last_branch_length = my_trunk_length,
	
					random_seed = false,
					manual_seed = seed
	

				)
				{
					scale([1 / 50 * trunk_radius, 1 / 50 * trunk_radius])
						rotate([0,0,90])
						polygon(points=custom_shape[0], paths=[custom_shape[1][0]]);
				}
			}
			else
			{
				draw_vector_branch_from_polygon
				(
					iterations_total = maximum_branching_iterations,
					iterations_left = maximum_branching_iterations,

					direction = [0,0,1],
					root = [0, 0, 0],
	
					polygon_bounding_size = [trunk_radius * 2, trunk_radius * 2],
					twist = branch_twist_angle,
	
					branch_root_min_scale_ratio = my_root_min_ratio,
					branch_root_max_scale_ratio = my_root_max_ratio,
	
					branch_tip_min_scale_ratio = my_tip_min_ratio,
					branch_tip_max_scale_ratio = my_tip_max_ratio,
	
					branch_min_lengh_ratio = my_length_min_ratio,
					branch_max_lengh_ratio = my_length_max_ratio,
	
					min_branching = min_number_of_branches_from_each_branch,
					max_branching = max_number_of_branches_from_each_branch,
	
					min_branching_angle = my_min_branching_angle,
					max_branching_angle = my_max_branching_angle,
	
					budding_start_ratio = start_budding_position / 100,
					budding_end_ratio = (stop_budding_position > start_budding_position ? stop_budding_position : start_budding_position) / 100,
	
					extend_branch = branches_keep_growing,
	
					overhangs_allowed = allow_all_overhangs,
					overhang_angle_cutoff = allowed_overhang_angle,
	
					branch_cross_section_bounds_size_cutoff = my_branch_diameter_cutoff,
	
					last_branch_root_scale = 1,
					last_branch_length = my_trunk_length,
	
					random_seed = false,
					manual_seed = seed
	

				)
				{
					scale([1 / 50 * trunk_radius, 1 / 50 * trunk_radius])
						rotate([0,0,90])
						polygon(points=reduce_shape_to_32_points(custom_shape)[0], paths=[reduce_shape_to_32_points(custom_shape)[1][0]]);
				}

			}
		}
	}
	translate([0,0,-150])
		cube([300,300,300], center = true);
} 


/**************************************************************************************/
/*									Modules and Functions							  */
/**************************************************************************************/

module draw_vector_branch_from_polygon
(
	iterations_total = 5,
	iterations_left = 5,

	direction = [0,0,1],
	root = [0, 0, 0],
	
	polygon_bounding_size,
	twist = 0,
	
	branch_root_min_scale_ratio = .5,
	branch_root_max_scale_ratio = .6,
	
	branch_tip_min_scale_ratio = .5,
	branch_tip_max_scale_ratio = .7,
	
	branch_min_lengh_ratio = .7,
	branch_max_lengh_ratio = .9,
	
	min_branching = 2,
	max_branching = 3,
	
	min_branching_angle = 40,
	max_branching_angle = 55,
	
	budding_start_ratio = .5,
	budding_end_ratio = 1,
	
	extend_branch = true,
	
	overhangs_allowed = false,
	overhang_angle_cutoff = 65,
	
	branch_cross_section_bounds_size_cutoff = 1.6,
	
	last_branch_root_scale = 1,
	last_branch_length = 40,
	
	random_seed = false,
	manual_seed = 0
)
{
		my_seed = random_seed == true ? rands(0, 10000, 1)[0] : manual_seed;
		
		current_iteration = iterations_total - iterations_left;

		_iterations_left = iterations_left;
		
		_iterations_total = iterations_total;

		my_length = last_branch_length * rands(branch_min_lengh_ratio, branch_max_lengh_ratio, 1, my_seed)[0];
		
		my_root_scale = last_branch_root_scale * rands(branch_root_min_scale_ratio, branch_root_max_scale_ratio, 1, my_seed)[0];

		my_tip_scale = rands(branch_tip_min_scale_ratio, branch_tip_max_scale_ratio, 1, my_seed)[0];
		
		my_direction = direction;
		
		my_vector = normalize_3DVector(my_direction) * my_length;
		
		my_root = root;
		
		polygon_size = polygon_bounding_size;

		my_twist = twist;

		num_branches = floor(rands(min_branching, max_branching + .9999, 1, my_seed)[0]);

		new_branches_branching_angle = rands(min_branching_angle, max_branching_angle, num_branches, my_seed);
		
		new_branches_budding_positions = rands(budding_start_ratio, budding_end_ratio , num_branches, my_seed);
		
		my_tip_size = my_tip_scale * my_root_scale * polygon_size;
		
		my_extend_branch = extend_branch;
		
		if(!(my_tip_size[0] < branch_cross_section_bounds_size_cutoff || my_tip_size[1] < branch_cross_section_bounds_size_cutoff))
		{
			if(polygon_size != undef)
			{		
				draw_capped_vector_from_polygon
				(
					my_vector,
					my_root,
					my_tip_scale,
					twist_poly = twist
				)
					scale(my_root_scale)
						child();
	
			if(iterations_left > 0)
			{
				if(num_branches > 1)
				{
					if(iterations_left > 3)
					{
						if(extend_branch == true || extend_branch == 1)
						{
							draw_vector_branch_from_polygon
							(
								direction = my_direction + random_3DVector(my_seed) * .4,
								root = my_root + my_vector,
								polygon_bounding_size = polygon_size,
								twist = my_twist,
								last_branch_root_scale = my_root_scale * .8,
								last_branch_length = my_length,
								iterations_total = _iterations_total,
								iterations_left = _iterations_left - 1,
								min_branching = max(0, _iterations_total - current_iteration * 2),
								max_branching = current_iteration + 2,
								extend_branch = my_extend_branch
							)
								child();
						}
					}
					for(i = [0:num_branches - 1])
					{
						assign
						(
							new_branch_direction = rotAxisAngle_3DVector(rotAxisAngle_3DVector(my_direction, random_3DVector(my_seed), new_branches_branching_angle[i]), my_direction, 360 / num_branches * i)
					
						)
						{
							if(overhangs_allowed == true || overhangs_allowed == 1)
							{
								echo("true");
								draw_vector_branch_from_polygon
								(
									direction = new_branch_direction,
									root = my_root + (my_vector * new_branches_budding_positions[i]),
									polygon_bounding_size = polygon_size,
									twist = my_twist,
									last_branch_root_scale = my_root_scale,
									last_branch_length = my_length,
									iterations_total = _iterations_total,
									iterations_left = _iterations_left - 1,
									min_branching = max(0, _iterations_total - current_iteration * 2),
									max_branching = current_iteration + 2,
									overhangs_allowed = true,
									extend_branch = my_extend_branch
								)
									child();
							}
							else
							{
								if(angleBetween_3DVector(new_branch_direction, [0,0,1]) < overhang_angle_cutoff)
								{
									draw_vector_branch_from_polygon
									(
										direction = new_branch_direction,
										root = my_root + (my_vector * new_branches_budding_positions[i]),
										polygon_bounding_size = polygon_size,
										twist = my_twist,
										last_branch_root_scale = my_root_scale,
										last_branch_length = my_length,
										iterations_total = _iterations_total,
										iterations_left = _iterations_left - 1,
										min_branching = max(0, _iterations_total - current_iteration * 2),
										max_branching = current_iteration + 2,
										overhangs_allowed = false,
										extend_branch = my_extend_branch
									)
										child();
								}
								else
								{
									assign
									(
										corrected_branch_direction =  	rotAxisAngle_3DVector
																		(
																			trackTo_3DVector
																			(
																				new_branch_direction,
																				[0,0,1],
																				abs
																				(
																					rands(overhang_angle_cutoff - 10, overhang_angle_cutoff, 1, my_seed)[0] - angleBetween_3DVector(new_branch_direction, [0,0,1])
																				) / angleBetween_3DVector(new_branch_direction, [0,0,1])
																			),
																			[0,0,1],
																			rands(-30, 30, 1, my_seed)[0]
																		)

									)
									{
										//echo("corrected_branch_direction: ", corrected_branch_direction);
										
										draw_vector_branch_from_polygon
										(
											direction = corrected_branch_direction,
											root = my_root + (my_vector * new_branches_budding_positions[i]),
											polygon_bounding_size = polygon_size,
											twist = my_twist,
											last_branch_root_scale = my_root_scale,
											last_branch_length = my_length,
											iterations_total = _iterations_total,
											iterations_left = _iterations_left - 1,
											min_branching = max(0, _iterations_total - current_iteration * 2),
											max_branching = current_iteration + 2,
											overhangs_allowed = false
										)
											child();
									}
								}
							}
						}
					}
				}
			}
		}
	}
	else
	{
		if(polygon_bounding_size == undef)
		{
			echo("You have to provide a bounding size of the polygon due to limitations of OpenSCAD");
		}
	}
}


module draw_capped_vector_from_polygon
(
	vector = [10, 10, 10],
	root = [0, 0, 0],
	scale_tip = .5,
	color_from_magnatude = true,
	magnatude_range = 100,
	twist_poly = 0
)
{
	xyLength = sqrt(pow(vector[0], 2) + pow(vector[1], 2));
	
	magnatude = abs(sqrt(pow(vector[0], 2) + pow(vector[1], 2) + pow(vector[2], 2)));
	
	zAngle = xyLength == 0 ? vector[0] > 0 ? 90 : -90 : acos(vector[1] / xyLength);
	
	xAngle = acos(xyLength / magnatude);
	
	realxAngle = vector[2] > 0 ? xAngle : -xAngle;
	
	realzAngle = vector[0] > 0 ? -zAngle : zAngle;
	
	vecRot = [realxAngle,realzAngle];
	
	//we move the vector to start at the root location
	translate(root)
	
	//we use the vectors magnatude compared to the magnatude range to tell the vector what color it is
	color(hsvToRGB(magnatude / magnatude_range * 360,1,1,1))
		//we start with the vector point along the y axis and then rotate it into place
		rotate([0, 0, vecRot[1]])
		{
			rotate([vecRot[0], 0, 0])
			{
				rotate([-90, 0, 0])
				{
					linear_extrude(height = magnatude, scale = scale_tip, twist = twist_poly)
					child();
					
					translate([0,0,magnatude])
					rotate([0, 0, -twist_poly])
					linear_extrude(height = magnatude / 10, scale = .5, twist = 0)
					scale([scale_tip, scale_tip])
					child();
				}
			}
		}
}


module draw_vector_from_polygon
(
	vector = [10, 10, 10],
	root = [0, 0, 0],
	scale_tip = .5,
	color_from_magnatude = true,
	magnatude_range = 100,
)
{
	xyLength = sqrt(pow(vector[0], 2) + pow(vector[1], 2));
	
	magnatude = abs(sqrt(pow(vector[0], 2) + pow(vector[1], 2) + pow(vector[2], 2)));
	
	zAngle = xyLength == 0 ? vector[0] > 0 ? 90 : -90 : acos(vector[1] / xyLength);
	
	xAngle = acos(xyLength / magnatude);
	
	realxAngle = vector[2] > 0 ? xAngle : -xAngle;
	
	realzAngle = vector[0] > 0 ? -zAngle : zAngle;
	
	vecRot = [realxAngle,realzAngle];
	
	//we move the vector to start at the root location
	translate(root)
	
	//we use the vectors magnatude compared to the magnatude range to tell the vector what color it is
	color(hsvToRGB(magnatude / magnatude_range * 360,1,1,1))
		//we start with the vector point along the y axis and then rotate it into place
		rotate([0, 0, vecRot[1]])
		{
			rotate([vecRot[0], 0, 0])
			{
				rotate([-90, 0, 0])
				{
					linear_extrude(height = magnatude, scale = scale_tip, twist = 90)
					child();
				}
			}
		}
}

function magnatude_3DVector(v) = sqrt(v[0] * v[0] + v[1] * v[1] + v[2] * v[2]);

function angleBetween_3DVector(u, v) = acos((u * v) / (magnatude_3DVector(u) * magnatude_3DVector(v)));

function normalize_3DVector(v) = [v[0]/magnatude_3DVector(v), v[1]/magnatude_3DVector(v), v[2]/magnatude_3DVector(v)];

function dotProduct_3DVector(u, v) = u * v;

function crossProduct_3DVector(u, v) = [u[1]*v[2] - v[1]*u[2], u[2]*v[0] - v[2]*u[0], u[0]*v[1] - v[0]*u[1]]; 
	
function rotMatrix_3DVector(axis, angle) =	[
												[
													((1 - cos(angle)) * pow(axis[0], 2)) + cos(angle),
													((1 - cos(angle)) * axis[0] * axis[1]) - (sin(angle) * axis[2]),
													((1 - cos(angle)) * axis[0] * axis[2]) + (sin(angle) * axis[1])
												],
												[
													((1 - cos(angle)) * axis[0] * axis[1]) + (sin(angle) * axis[2]),
													((1 - cos(angle)) * pow(axis[1], 2)) + cos(angle),
													((1 - cos(angle)) * axis[1] * axis[2]) - (sin(angle) * axis[0])
												],
												[
													((1 - cos(angle)) * axis[0] * axis[2]) - (sin(angle) * axis[1]),
													((1 - cos(angle)) * axis[1] * axis[2]) + (sin(angle) * axis[0]),
													((1 - cos(angle)) * pow(axis[2], 2)) + cos(angle)
												]
											];

function rotAxisAngle_3DVector(vec, axis, angle) = rotMatrix_3DVector(normalize_3DVector(axis), angle) * vec;

function trackTo_3DVector(cur, tar, influence) = rotAxisAngle_3DVector(cur, crossProduct_3DVector(cur, tar), angleBetween_3DVector(cur, tar) * influence);

function random_3DVector(seed = undef) =	[
												seed == undef ? rands(0, 1, 1)[0] : rands(0, 1, 1, rands(0, 10000, 1, seed - 100)[0])[0],
												seed == undef ? rands(0, 1, 1)[0] : rands(0, 1, 1, rands(0, 10000, 1, seed)[0])[0],
												seed == undef ? rands(0, 1, 1)[0] : rands(0, 1, 1, rands(0, 10000, 1, seed + 100)[0])[0]
											];
										
function shape_reducer(shape, reduce_to, index) = floor(len(shape[0]) / reduce_to) * index;

function reduce_shape_to_32_points(shape) =	[
												[
													[shape[0][shape_reducer(shape, 32, 0)][0], shape[0][shape_reducer(shape, 32, 0)][1]],
													[shape[0][shape_reducer(shape, 32, 1)][0], shape[0][shape_reducer(shape, 32, 1)][1]],
													[shape[0][shape_reducer(shape, 32, 2)][0], shape[0][shape_reducer(shape, 32, 2)][1]],
													[shape[0][shape_reducer(shape, 32, 3)][0], shape[0][shape_reducer(shape, 32, 3)][1]],
													[shape[0][shape_reducer(shape, 32, 4)][0], shape[0][shape_reducer(shape, 32, 4)][1]],
													[shape[0][shape_reducer(shape, 32, 5)][0], shape[0][shape_reducer(shape, 32, 5)][1]],
													[shape[0][shape_reducer(shape, 32, 6)][0], shape[0][shape_reducer(shape, 32, 6)][1]],
													[shape[0][shape_reducer(shape, 32, 7)][0], shape[0][shape_reducer(shape, 32, 7)][1]],
													[shape[0][shape_reducer(shape, 32, 8)][0], shape[0][shape_reducer(shape, 32, 8)][1]],
													[shape[0][shape_reducer(shape, 32, 9)][0], shape[0][shape_reducer(shape, 32, 9)][1]],
													[shape[0][shape_reducer(shape, 32, 10)][0], shape[0][shape_reducer(shape, 32, 10)][1]],
													[shape[0][shape_reducer(shape, 32, 11)][0], shape[0][shape_reducer(shape, 32, 11)][1]],
													[shape[0][shape_reducer(shape, 32, 12)][0], shape[0][shape_reducer(shape, 32, 12)][1]],
													[shape[0][shape_reducer(shape, 32, 13)][0], shape[0][shape_reducer(shape, 32, 13)][1]],
													[shape[0][shape_reducer(shape, 32, 14)][0], shape[0][shape_reducer(shape, 32, 14)][1]],
													[shape[0][shape_reducer(shape, 32, 15)][0], shape[0][shape_reducer(shape, 32, 15)][1]],
													[shape[0][shape_reducer(shape, 32, 16)][0], shape[0][shape_reducer(shape, 32, 16)][1]],
													[shape[0][shape_reducer(shape, 32, 17)][0], shape[0][shape_reducer(shape, 32, 17)][1]],
													[shape[0][shape_reducer(shape, 32, 18)][0], shape[0][shape_reducer(shape, 32, 18)][1]],
													[shape[0][shape_reducer(shape, 32, 19)][0], shape[0][shape_reducer(shape, 32, 19)][1]],
													[shape[0][shape_reducer(shape, 32, 20)][0], shape[0][shape_reducer(shape, 32, 20)][1]],
													[shape[0][shape_reducer(shape, 32, 21)][0], shape[0][shape_reducer(shape, 32, 21)][1]],
													[shape[0][shape_reducer(shape, 32, 22)][0], shape[0][shape_reducer(shape, 32, 22)][1]],
													[shape[0][shape_reducer(shape, 32, 23)][0], shape[0][shape_reducer(shape, 32, 23)][1]],
													[shape[0][shape_reducer(shape, 32, 24)][0], shape[0][shape_reducer(shape, 32, 24)][1]],
													[shape[0][shape_reducer(shape, 32, 25)][0], shape[0][shape_reducer(shape, 32, 25)][1]],
													[shape[0][shape_reducer(shape, 32, 26)][0], shape[0][shape_reducer(shape, 32, 26)][1]],
													[shape[0][shape_reducer(shape, 32, 27)][0], shape[0][shape_reducer(shape, 32, 27)][1]],
													[shape[0][shape_reducer(shape, 32, 28)][0], shape[0][shape_reducer(shape, 32, 28)][1]],
													[shape[0][shape_reducer(shape, 32, 29)][0], shape[0][shape_reducer(shape, 32, 29)][1]],
													[shape[0][shape_reducer(shape, 32, 30)][0], shape[0][shape_reducer(shape, 32, 30)][1]],
													[shape[0][shape_reducer(shape, 32, 31)][0], shape[0][shape_reducer(shape, 32, 31)][1]]
												],
												[
													[
														0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
													]
												]
											];