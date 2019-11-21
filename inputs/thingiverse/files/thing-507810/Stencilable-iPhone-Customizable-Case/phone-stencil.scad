// preview[view:south, tilt:top]

/*[Main Controls]*/
phone_model = 3; //[3:iPhone 5s, 2:iPhone 5c, 1:iPhone 5, 0:iPhone 4s]

//this adds a pattern to the back of your case, which you can edit in the "Pattern" tab above
use_pattern = 1; //[0:Off,1:On]

//this adds a stencil to the back of your case, which you can edit in the "Stencil" tab above
use_stencil = 0; //[0:Off,1:On]

//these help difficult prints stick to your build plate
use_mouse_ears = 0; //[0:Off,1:On]

//change this a little bit if your case comes out too tight or too loose (up or down .1 can make a big difference)
printer_tolerance = 0.4; //[0.2,0.25,0.3,0.35,0.4,0.45,0.5,0.55,0.6,0.65,0.7,0.75,0.8,0.85,0.9,0.95,1]

/*[Pattern]*/
//set the base shape that will tile to create your pattern
pattern_element_shape = 6; //[3:Triangle,4:Square,5:Pentagon,6:Hexagon,7:Heptagon (7-sided),8:Octogon,9:Nonagon (9-sided),10:Decagon (10-sided),11:Hendecagon (11-sided),12:Dodecagon (12-sided),30:Circle (30-sided)]

//in mm:
pattern_element_radius = 8; //[4:22]

//in percent of radius
pattern_element_overlap = 0; //[0:100]

//in degrees:
pattern_element_rotation = 0; //[0:180]

//in percent of radius
pattern_line_thickness = 20; //[0:50]

/*[Stencil]*/

//paste your stencil-o-matic code here
input = "no_input";

//what style should your stencil be?
stencil_fill_type = 0; //[0:Outline,1:Solid,2:Pattern]

//select a stencil shape
stencil_shape = 4; //[1:Circle,2:Square,3:Star,4:Cat,5:Dog,6:Heart,7:Makerbot Logo,0:Custom]

//use this to draw your own stencil shape if you selected "Custom" from the "stencil shape" dropdown
stencil_drawing = (input=="no_input"?  [[179,268],[[199.26,15.12],[189.19,15.56],[181.5,16.45],[175.52,17.83],[169.55,19.42],[163.57,21.55],[157.55,24.22],[151.62,27.5],[145.87,31.09],[140.35,35.49],[135,40.71],[130.05,46.71],[125.52,53],[121.87,59.06],[119.06,64.5],[117.12,69.21],[115.55,73.5],[114.31,77.65],[113.16,82],[112.07,87.29],[110.96,93.7],[110.36,99.39],[110.49,102.95],[111.13,105],[136.96,105],[158.46,104.73],[163.39,103.42],[163.83,101.08],[164.04,97.67],[164.46,93.04],[165.44,87.75],[167.04,82.4],[168.96,77.59],[171.9,73.02],[175.98,68.21],[180.98,63.93],[186.13,60.62],[192.15,58.45],[201.05,58],[208.86,58.34],[214.1,59.16],[217.74,60.82],[221.73,63.19],[225.41,66.46],[228.34,70.28],[230.39,74.63],[231.97,79.15],[232.75,85.01],[232.85,92.65],[232.01,100.96],[229.51,107.41],[225.45,113.48],[218.91,119.91],[211.35,126.37],[203.83,132.63],[197.2,138.54],[191.77,144.13],[187.33,150.15],[183.1,157.07],[179.62,164.83],[176.98,172.85],[175.42,181.69],[175.22,192.28],[175.5,203.5],[199,203.5],[222.5,203.5],[222.74,198.5],[223.25,193.21],[224.15,187.5],[225.64,181.94],[227.6,177],[230.92,172.02],[235.69,166.37],[243.47,159.38],[254,151.21],[264.03,143.56],[270.61,137.84],[274.46,133.36],[277.95,128.69],[281.05,123.47],[283.96,117.69],[286.32,111.7],[288.09,106],[289.06,98.48],[289.47,88],[289.05,76.45],[287.17,68],[284.48,60.83],[281.31,54.14],[276.58,47.41],[270.1,40.14],[262.4,33.38],[254.68,28.12],[246.8,24.2],[238.72,20.92],[230.05,18.48],[220.76,16.55],[210.43,15.49],[199.26,15.12]],[[198.05,226.08],[178.93,226.28],[170.25,226.66],[169.27,232.87],[169,254.48],[169.27,277.23],[170.58,282.39],[179.4,282.82],[198.38,283],[218.91,282.73],[225.8,281.8],[226.73,274.94],[227,254.5],[226.73,234.06],[225.8,227.2],[218.87,226.29],[198.05,226.08]]]: input);

//in percent of phone width
stencil_horizontal_position = 50; //[0:100]

//in percent of phone height
stencil_vertical_position = 50; //[0:100]

//in percent of phone max dimension
stencil_size = 40; //[10:100]

//in degrees
stencil_rotation = 0; //[0:360]

//flip the shape left-to-right
stencil_mirror = 0; //[0:No, 1:Yes]

/*[Stencil Pattern]*/

//set the base shape that will tile to create your stencil pattern
stencil_pattern_element_shape = 3; //[3:Triangle,4:Square,5:Pentagon,6:Hexagon,7:Heptagon (7-sided),8:Octogon,9:Nonagon (9-sided),10:Decagon (10-sided),11:Hendecagon (11-sided),12:Dodecagon (12-sided),30:Circle (30-sided)]

//in mm:
stencil_pattern_element_radius = 6; //[6:22]

//in percent of radius
stencil_pattern_element_overlap = 0; //[0:100]

//in degrees:
stencil_pattern_element_rotation = 0; //[0:180]

//in percent of radius
stencil_pattern_line_thickness = 30; //[0:50]

/*[Custom Dimensions]*/
//toggle whether to use the settings below
use_custom_dimensions = 0; //[0:Off,1:On]

custom_phone_width = 100;
custom_phone_length = 100;
custom_phone_thickness = 10;
custom_corner_radius = 10;
custom_corner_resolution = 8;
custom_bottom_fillet_radius = 1.6;
custom_bottom_fillet_resolution = 8;
custom_case_pattern_thickness = .8;
custom_case_wall_thickness = 1.6;
custom_overhang_thickness = .8;
custom_overhang_width = 1.6;
custom_overhang_fillet_resolution = 2;
custom_top_inner_edge_chamfer_radius = .6;
custom_top_outer_edge_chamfer_radius = .6;
custom_bottom_outer_edge_chamfer_radius = .6;
custom_back_camera_x_position = 0;
custom_back_camera_y_position = 0;
custom_back_camera_x_size = 20;
custom_back_camera_y_size = 20;
custom_back_camera_corner_radius = 5;
custom_back_camera_corner_resolution = 8;
custom_back_extra_port_x_position = 0;
custom_back_extra_port_y_position = 30;
custom_back_extra_port_x_size = 30;
custom_back_extra_port_y_size = 30;
custom_back_extra_port_corner_radius = 5;
custom_back_extra_port_corner_resolution = 8;
custom_right_port_y_position = 0;
custom_right_port_length = 30;
custom_right_port_corner_radius = 5;
custom_right_port_corner_resolution = 8;
custom_left_port_y_position = 0;
custom_left_port_length = 50;
custom_left_port_corner_radius = 5;
custom_left_port_corner_resolution = 8;
custom_top_port_x_position = -10;
custom_top_port_length = 70;
custom_top_port_corner_radius = 5;
custom_top_port_corner_resolution = 8;
custom_bottom_port_x_position = 20;
custom_bottom_port_length = 40;
custom_bottom_port_corner_radius = 5;
custom_bottom_port_corner_resolution = 8;

/*[hidden]*/
custom_back_camera_pos = [custom_back_camera_x_position, custom_back_camera_y_position];
custom_back_camera_size = [custom_back_camera_x_size, custom_back_camera_y_size];
custom_back_extra_port_pos = [custom_back_extra_port_x_position, custom_back_extra_port_y_position];
custom_back_extra_port_size = [custom_back_extra_port_x_size, custom_back_extra_port_y_size];
custom_right_port_pos = [0, custom_right_port_y_position];
custom_left_port_pos = [0, custom_left_port_y_position];
custom_top_port_pos = [custom_top_port_x_position, 0];
custom_bottom_port_pos = [custom_top_port_x_position, 0];
actual_pattern_line_thickness = max((floor(pattern_line_thickness * pattern_element_radius / 100 / .4) * .4), .8);
actual_stencil_pattern_line_thickness = max((floor(stencil_pattern_line_thickness * stencil_pattern_element_radius / 100 / .4) * .4), .8);
preview_tab = "final";
mouse_ear_size = 10;

// //bottom cut to be flush with bottom of phone
// translate([0,-(profile_width + iphone4s_length / 2 + tolerance + .8),0])
// 	cube([100, profile_width * 2, profile_height * 2], center = true);

// //top cut to be flush with top of phone
// translate([0,profile_width + iphone4s_length / 2 + tolerance + .8,0])
// 	cube([100, profile_width * 2, profile_height * 2], center = true);

// }



if(use_custom_dimensions == 0)
{
	phone_case
	(
		phone_width = preset_phone_params()[phone_model][1][0],
		phone_length = preset_phone_params()[phone_model][1][1],	
		phone_corner_radius = preset_phone_params()[phone_model][1][3],
		phone_corner_res = preset_phone_params()[phone_model][1][4],
		phone_thickness = preset_phone_params()[phone_model][1][2],
		phone_bottom_fillet_radius = preset_phone_params()[phone_model][1][5],
		phone_bottom_fillet_res = preset_phone_params()[phone_model][1][6],
		floor_thickness = .8,
		wall_thickness = 1.6,
		overhang_thickness = .8,
		overhang_width = preset_phone_params()[phone_model][1][7],
		overhang_fillet_res = 2,
		inner_edge_chamfer_radius = .6,
		top_outer_edge_chamfer_radius = .6,
		bottom_outer_edge_chamfer_radius = .6,
		tolerance = printer_tolerance,
		pattern_toggle = use_pattern,
		my_pattern_sides = pattern_element_shape,
		my_pattern_size = pattern_element_radius,
		my_pattern_overlap_percent = pattern_element_overlap, 
		my_pattern_rotation = pattern_element_rotation,
		my_pattern_line_thickness = actual_pattern_line_thickness,
		stencil_toggle = use_stencil,
		my_stencil_fill_type = stencil_fill_type,
		my_stencil_shape = stencil_shape,
		my_stencil_custom = stencil_drawing,
		my_stencil_pos = [stencil_horizontal_position, stencil_vertical_position],
		my_stencil_size = stencil_size,
		my_stencil_rotation = stencil_rotation,
		my_stencil_mirror = stencil_mirror,
		my_stencil_pattern_sides = stencil_pattern_element_shape,
		my_stencil_pattern_size = stencil_pattern_element_radius,
		my_stencil_pattern_overlap_percent = stencil_pattern_element_overlap, 
		my_stencil_pattern_rotation = stencil_pattern_element_rotation,
		my_stencil_pattern_line_thickness = actual_stencil_pattern_line_thickness,	
		back_port_1_pos = preset_phone_params()[phone_model][2][0][0][0],
		back_port_1_size = preset_phone_params()[phone_model][2][0][0][1],
		back_port_1_corner_radius = preset_phone_params()[phone_model][2][0][0][2],
		back_port_1_corner_res = 8,
		back_port_2_pos = preset_phone_params()[phone_model][2][0][1][0],
		back_port_2_size = preset_phone_params()[phone_model][2][0][1][1],
		back_port_2_corner_radius = preset_phone_params()[phone_model][2][0][1][2],
		back_port_2_corner_res = 8,
		right_port_pos = preset_phone_params()[phone_model][2][1][0][0],
		right_port_length = preset_phone_params()[phone_model][2][1][0][1],
		right_port_corner_radius = preset_phone_params()[phone_model][2][1][0][2],
		right_port_corner_res = 8,
		left_port_pos = preset_phone_params()[phone_model][2][2][0][0],
		left_port_length = preset_phone_params()[phone_model][2][2][0][1],
		left_port_corner_radius = preset_phone_params()[phone_model][2][2][0][2],
		left_port_corner_res = 8,
		top_port_pos = preset_phone_params()[phone_model][2][3][0][0],
		top_port_length = preset_phone_params()[phone_model][2][3][0][1],
		top_port_corner_radius = preset_phone_params()[phone_model][2][3][0][2],
		top_port_corner_res = 8,
		bottom_port_pos = preset_phone_params()[phone_model][2][4][0][0],
		bottom_port_length = preset_phone_params()[phone_model][2][4][0][1],
		bottom_port_corner_radius = preset_phone_params()[phone_model][2][4][0][2],
		bottom_port_corner_res = 8,
		preview_pattern = preview_tab == "final" ? false : true //this allows for a fast preview render, but will not actually create geometry (F6) if it's turned on
	);

	if(use_mouse_ears == 1)
	{
		if(preview_tab == "final")
		{
			linear_extrude(height = .4)
			difference()
			{
				union()
				{
					translate([preset_phone_params()[phone_model][1][0] / 2, preset_phone_params()[phone_model][1][1] / 2])
						circle(r = mouse_ear_size);
					translate([-(preset_phone_params()[phone_model][1][0] / 2), preset_phone_params()[phone_model][1][1] / 2])
						circle(r = mouse_ear_size);
					translate([-(preset_phone_params()[phone_model][1][0] / 2), -(preset_phone_params()[phone_model][1][1] / 2)])
						circle(r = mouse_ear_size);
					translate([preset_phone_params()[phone_model][1][0] / 2, -(preset_phone_params()[phone_model][1][1] / 2)])
						circle(r = mouse_ear_size);	
				}
				2d_rounded_square
				(
					[
						preset_phone_params()[phone_model][1][0],
						preset_phone_params()[phone_model][1][1]
					],
					preset_phone_params()[phone_model][1][3],
					preset_phone_params()[phone_model][1][4]
				);

			}
		}
		else
		{
			translate([0,0,.2])
			difference()
			{
				union()
				{
					translate([preset_phone_params()[phone_model][1][0] / 2, preset_phone_params()[phone_model][1][1] / 2])
						circle(r = mouse_ear_size);
					translate([-(preset_phone_params()[phone_model][1][0] / 2), preset_phone_params()[phone_model][1][1] / 2])
						circle(r = mouse_ear_size);
					translate([-(preset_phone_params()[phone_model][1][0] / 2), -(preset_phone_params()[phone_model][1][1] / 2)])
						circle(r = mouse_ear_size);
					translate([preset_phone_params()[phone_model][1][0] / 2, -(preset_phone_params()[phone_model][1][1] / 2)])
						circle(r = mouse_ear_size);	
				}
				2d_rounded_square
				(
					[
						preset_phone_params()[phone_model][1][0],
						preset_phone_params()[phone_model][1][1]
					],
					preset_phone_params()[phone_model][1][3],
					preset_phone_params()[phone_model][1][4]
				);

			}
		}
	}
}
else
{
	phone_case
	(
		custom_phone_width,
		custom_phone_length,
		custom_corner_radius,
		custom_corner_resolution,
		custom_phone_thickness,
		custom_bottom_fillet_radius,
		custom_bottom_fillet_resolution,
		custom_case_pattern_thickness,
		custom_case_wall_thickness,
		custom_overhang_thickness,
		custom_overhang_width,
		custom_overhang_fillet_resolution,
		custom_top_inner_edge_chamfer_radius,
		custom_top_outer_edge_chamfer_radius,
		custom_bottom_outer_edge_chamfer_radius,
		printer_tolerance,
		use_pattern,
		pattern_element_shape,
		pattern_element_radius,
		pattern_element_overlap, 
		pattern_element_rotation,
		actual_pattern_line_thickness,
		use_stencil,
		stencil_fill_type,
		stencil_shape,
		stencil_drawing,
		[stencil_horizontal_position, stencil_vertical_position],
		stencil_size,
		stencil_rotation,
		stencil_mirror,
		stencil_pattern_element_shape,
		stencil_pattern_element_radius,
		stencil_pattern_element_overlap, 
		stencil_pattern_element_rotation,
		actual_stencil_pattern_line_thickness,		
		custom_back_camera_pos,
		custom_back_camera_size,
		custom_back_camera_corner_radius,
		custom_back_camera_corner_resolution,
		custom_back_extra_port_pos,
		custom_back_extra_port_size,
		custom_back_extra_port_corner_radius,
		custom_back_extra_port_corner_resolution,
		custom_right_port_pos,
		custom_right_port_length ,
		custom_right_port_corner_radius,
		custom_right_port_corner_resolution,
		custom_left_port_pos,
		custom_left_port_length ,
		custom_left_port_corner_radius,
		custom_left_port_corner_resolution,
		custom_top_port_pos,
		custom_top_port_length ,
		custom_top_port_corner_radius,
		custom_top_port_corner_resolution,
		custom_bottom_port_pos ,
		custom_bottom_port_length ,
		custom_bottom_port_corner_radius,
		custom_bottom_port_corner_resolution,
		preview_pattern = preview_tab == "final" ? false : true
	);

	if(use_mouse_ears == 1)
	{
		if(preview_tab == "final")
		{
			linear_extrude(height = .4)
			difference()
			{
				union()
				{
					translate([custom_phone_width / 2, custom_phone_length / 2])
						circle(r = mouse_ear_size);
					translate([-(custom_phone_width / 2), custom_phone_length / 2])
						circle(r = mouse_ear_size);
					translate([-(custom_phone_width / 2), -(custom_phone_length / 2)])
						circle(r = mouse_ear_size);
					translate([custom_phone_width / 2, -(custom_phone_length / 2)])
						circle(r = mouse_ear_size);	
				}
				2d_rounded_square
				(
					[
						custom_phone_width,
						custom_phone_length
					],
					custom_corner_radius,
					custom_corner_resolution
				);

			}
		}
		else
		{
			translate([0,0,.2])
			difference()
			{
				union()
				{
					translate([custom_phone_width / 2, custom_phone_length / 2])
						circle(r = mouse_ear_size);
					translate([-(custom_phone_width / 2), custom_phone_length / 2])
						circle(r = mouse_ear_size);
					translate([-(custom_phone_width / 2), -(custom_phone_length / 2)])
						circle(r = mouse_ear_size);
					translate([custom_phone_width / 2, -(custom_phone_length / 2)])
						circle(r = mouse_ear_size);	
				}
				2d_rounded_square
				(
					[
						custom_phone_width,
						custom_phone_length
					],
					custom_corner_radius,
					custom_corner_resolution
				);

			}
		}
	}
}

//PRESET PHONE PARAMS STRUCTURE
// [i]				:	id number of phone

//phone name
// [i][0]			:	name

//phone dimensions
// [i][1][0]		:	width
// [i][1][1]		:	length
// [i][1][2]		:	thickness
// [i][1][3]		:	corner_radius
// [i][1][4]		:	corner_res
// [i][1][5]		:	bottom_edge_fillet_radius
// [i][1][6]		:	bottom_edge_fillet_res
// [i][1][7]		:	min_overhang_width

//phone ports

////back side ports
// [i][2][0][0][0]	:	back_port_1_pos
// [i][2][0][0][1]	:	back_port_1_size
// [i][2][0][0][2]	:	back_port_1_corner_radius
// [i][2][0][1][0]	:	back_port_2_pos
// [i][2][0][1][1]	:	back_port_2_size
// [i][2][0][1][2]	:	back_port_2_corner_radius

////right side ports
// [i][2][1][0][0]	:	right_port_pos
// [i][2][1][0][1]	:	right_port_length
// [i][2][1][0][2]	:	right_port_corner_radius

////left side ports
// [i][2][2][0][0]	:	left_port_pos
// [i][2][2][0][1]	:	left_port_length
// [i][2][2][0][2]	:	left_port_corner_radius

////top side ports
// [i][2][3][0][0]	:	top_port_pos
// [i][2][3][0][1]	:	top_port_length
// [i][2][3][0][2]	:	top_port_corner_radius

////bottom side ports
// [i][2][4][0][0]	:	bottom_port_pos
// [i][2][4][0][1]	:	bottom_port_length
// [i][2][4][0][2]	:	bottom_port_corner_radius

function preset_phone_params() = 
	[
		[
			"iPhone 4s",
			[
				58.55,
				115.15,
				9.4,
				8.77,
				8,
				0,
				0,
				1.6
			],
			[
				[
					[
						[17.905, 47.805],
						[19.75, 15.6],
						9,
					],
					[
						undef,//[0, 28.425],
						undef,//[18, 18],
						undef,//9
					]
				],
				[
					[
						undef,
						undef,
						undef
					]
				],
				[
					[
						[0,32.8],
						32,
						4.7
					]
				],
				[
					[
						[0,0],
						45,
						4.7
					]
				],
				[
					[
						[0,0],
						45,
						4.7
					]
				]
			]
		],
		[
			"iPhone 5",
			[
				58.57,
				123.83,
				7.65,
				8.77,
				8,
				0,
				0,
				1.6
			],
			[
				[
					[
						[15.28, 53.835],
						[23.05, 15.06],
						7.8
					],
					[
						undef, //back_port_2_pos [x,y]
						undef, //back_port_2_size [x,y]
						undef //back_port_2_corner_radius
					]
				],
				[
					[
						undef, //right_port_pos [x,y]
						undef, //right_port_length y
						undef //right_port_corner_radius
					]
				],
				[
					[
						[0, 34.675], //left_port_pos [x,y]
						32.76, //left_port_length y
						3.825 //left_port_corner_radius
					]
				],
				[
					[
						[0, 0], //top_port_pos [x,y]
						45, //top_port_length x
						3.825 //top_port_corner_radius
					]
				],
				[
					[
						[0, 0], //bottom_port_pos [x,y]
						45, //bottom_port_length x
						3.825 //bottom_port_corner_radius
					]
				]
			]
		],
		[
			"iPhone 5c",
			[
				59.18 + .15, //width
				124.44 + .2, //length
				8.97 + .05, //thickness
				9.59, //corner_radius
				8, //corner_res
				3.74, //bottom_edge_fillet_radius
				8, //bottom_edge_fillet_res
				1.6, //overhang_width
			],
			[
				[
					[
						[15.34, 54.58], //back_port_1_pos [x,y]
						[26.5, 17.8], //back_port_1_size [x,y]
						8.54, //back_port_1_corner_radius
					],
					[
						undef, //back_port_2_pos [x,y]
						undef, //back_port_2_size [x,y]
						undef, //back_port_2_corner_radius
					]
				],
				[
					[
						undef, //right_port_pos [x,y]
						undef, //right_port_length y
						undef, //right_port_corner_radius
					]
				],
				[
					[
						[0, 30.345], //left_port_pos [x,y]
						41.13, //left_port_length y
						4.9, //left_port_corner_radius
					]
				],
				[
					[
						[0, 0], //top_port_pos [x,y]
						45, //top_port_length x
						4.9, //top_port_corner_radius
					]
				],
				[
					[
						[0, 0], //bottom_port_pos [x,y]
						45, //bottom_port_length x
						4.9, //bottom_port_corner_radius
					]
				]
			]
		],
		[
			"iPhone 5s", //template for phone profiles
			[
				58.57, //width
				123.83, //length
				7.6, //thickness
				8.77, //corner_radius
				8, //corner_res
				0, //bottom_edge_fillet_radius
				0, //bottom_edge_fillet_res
				1.6, //overhang_width
			],
			[
				[
					[
						[15.28, 53.835],
						[23.05, 15.06],
						7.8
					],
					[
						undef, //back_port_2_pos [x,y]
						undef, //back_port_2_size [x,y]
						undef, //back_port_2_corner_radius
					]
				],
				[
					[
						undef, //right_port_pos [x,y]
						undef, //right_port_length y
						undef, //right_port_corner_radius
					]
				],
				[
					[
						[0, 31.72], //left_port_pos [x,y]
						38.37, //left_port_length y
						3.8, //left_port_corner_radius
					]
				],
				[
					[
						[0, 0], //top_port_pos [x,y]
						45, //top_port_length x
						3.8 //top_port_corner_radius
					]
				],
				[
					[
						[0, 0], //bottom_port_pos [x,y]
						45, //bottom_port_length x
						3.8, //bottom_port_corner_radius
					]
				]
			]
		],
		// [
		// 	"name of phone", //template for phone profiles
		// 	[
		// 		undef, //width
		// 		undef, //length
		// 		indef, //thickness
		// 		undef, //corner_radius
		// 		undef, //corner_res
		// 		undef, //bottom_edge_fillet_radius
		// 		undef, //bottom_edge_fillet_res
		// 		undef, //overhang_width
		// 	],
		// 	[
		// 		[
		// 			[
		// 				undef, //back_port_1_pos [x,y]
		// 				undef, //back_port_1_size [x,y]
		// 				undef, //back_port_1_corner_radius
		// 			],
		// 			[
		// 				undef, //back_port_2_pos [x,y]
		// 				undef, //back_port_2_size [x,y]
		// 				undef, //back_port_2_corner_radius
		// 			]
		// 		],
		// 		[
		// 			[
		// 				undef, //right_port_pos [x,y]
		// 				undef, //right_port_length y
		// 				undef, //right_port_corner_radius
		// 			]
		// 		],
		// 		[
		// 			[
		// 				undef, //left_port_pos [x,y]
		// 				undef, //left_port_length y
		// 				undef, //left_port_corner_radius
		// 			]
		// 		],
		// 		[
		// 			[
		// 				undef, //top_port_pos [x,y]
		// 				undef, //top_port_length x
		// 				undef, //top_port_corner_radius
		// 			]
		// 		],
		// 		[
		// 			[
		// 				undef, //bottom_port_pos [x,y]
		// 				undef, //bottom_port_length x
		// 				undef, //bottom_port_corner_radius
		// 			]
		// 		]
		// 	]
		// ],
	];

// phone_case();

module phone_case
(
	phone_width = 100,
	phone_length = 100,	
	phone_corner_radius = 10,
	phone_corner_res = 8,
	phone_thickness = 10,
	phone_bottom_fillet_radius = 3,
	phone_bottom_fillet_res = 4,
	floor_thickness = 1,
	wall_thickness = 1,
	overhang_thickness = 1,
	overhang_width = 1,
	overhang_fillet_res = 2,
	inner_edge_chamfer_radius = .5,
	top_outer_edge_chamfer_radius = .5,
	bottom_outer_edge_chamfer_radius = .5,
	tolerance = .3,
	pattern_toggle,
	my_pattern_sides = 6,
	my_pattern_size = 8,
	my_pattern_overlap_percent = 40, 
	my_pattern_rotation = 0,
	my_pattern_line_thickness = 1.6,
	stencil_toggle,
	my_stencil_fill_type,
	my_stencil_shape,
	my_stencil_custom,
	my_stencil_pos,
	my_stencil_size,
	my_stencil_rotation,
	my_stencil_mirror,
	my_stencil_pattern_sides,
	my_stencil_pattern_size,
	my_stencil_pattern_overlap_percent, 
	my_stencil_pattern_rotation,
	my_stencil_pattern_line_thickness,
	back_port_1_pos = [0, 0],
	back_port_1_size = [20,20],
	back_port_1_corner_radius = 0,
	back_port_1_corner_res = 8,
	back_port_2_pos = [0, 30],
	back_port_2_size = [10, 10],
	back_port_2_corner_radius = 0,
	back_port_2_corner_res = 8,
	right_port_pos = [0, 0],
	right_port_length,
	right_port_corner_radius = 4,
	right_port_corner_res = 8,
	left_port_pos = [0, 0],
	left_port_length,
	left_port_corner_radius = 0,
	left_port_corner_res = 8,
	top_port_pos = [0, 0],
	top_port_length,
	top_port_corner_radius = 0,
	top_port_corner_res = 8,
	bottom_port_pos = [0, 0],
	bottom_port_length,
	bottom_port_corner_radius = 0,
	bottom_port_corner_res = 8,
	preview_pattern = false//this allows for a fast preview render, but will not actually create geometry (F6) if it's turned on
)
{
	difference()
	{
		phone_bumper
		(
			phone_width,
			phone_length,	
			phone_corner_radius,
			phone_corner_res,
			phone_thickness,
			phone_bottom_fillet_radius,
			phone_bottom_fillet_res,
			floor_thickness,
			wall_thickness,
			overhang_thickness,
			overhang_width,
			overhang_fillet_res,
			inner_edge_chamfer_radius,
			top_outer_edge_chamfer_radius,
			bottom_outer_edge_chamfer_radius,
			tolerance
		);

		if(right_port_length != undef && right_port_length > 0)
		{
			translate([phone_width / 2, right_port_pos[1], phone_thickness + floor_thickness])
			rotate([0, 90, 0])
			phone_port
			(
				[phone_thickness * 2, right_port_length],
				right_port_corner_radius,
				right_port_corner_res,
				phone_width,
				center = true
			);
		}

		if(left_port_length != undef && left_port_length > 0)
		{
			translate([-phone_width / 2, left_port_pos[1], phone_thickness + floor_thickness])
			rotate([0, 90, 0])
			phone_port
			(
				[phone_thickness * 2, left_port_length],
				left_port_corner_radius,
				left_port_corner_res,
				phone_width,
				center = true
			);
		}

		if(top_port_length != undef && top_port_length > 0)
		{
			translate([top_port_pos[0], phone_length / 2, phone_thickness + floor_thickness])
			rotate([90, 0, 0])
			phone_port
			(
				[top_port_length, phone_thickness * 2],
				top_port_corner_radius,
				top_port_corner_res,
				phone_width,
				center = true
			);
		}

		if(bottom_port_length != undef && bottom_port_length > 0)
		{
			translate([bottom_port_pos[0], -phone_length/ 2, phone_thickness + floor_thickness])
			rotate([90, 0, 0])
			phone_port
			(
				[bottom_port_length, phone_thickness * 2],
				bottom_port_corner_radius,
				bottom_port_corner_res,
				phone_width,
				center = true
			);
		}
	}

	if(preview_pattern)
	{
		translate([0,0,floor_thickness / 2])
			scale([1,1,floor_thickness])
				2d_phone_back
				(
					phone_width,
					phone_length,
					phone_corner_radius,
					phone_corner_res,
					pattern_toggle,
					my_pattern_sides,
					my_pattern_size,
					my_pattern_overlap_percent, 
					my_pattern_rotation,
					my_pattern_line_thickness,
					stencil_toggle,
					my_stencil_fill_type,
					my_stencil_shape,
					my_stencil_custom,
					my_stencil_pos,
					my_stencil_size,
					my_stencil_rotation,
					my_stencil_mirror,
					my_stencil_pattern_sides,
					my_stencil_pattern_size,
					my_stencil_pattern_overlap_percent, 
					my_stencil_pattern_rotation,
					my_stencil_pattern_line_thickness,
					back_port_1_pos,
					back_port_1_size,
					back_port_1_corner_radius,
					back_port_1_corner_res,
					back_port_2_pos,
					back_port_2_size,
					back_port_2_corner_radius,
					back_port_2_corner_res
				);
	}
	else
	{
		linear_extrude(height = floor_thickness, convexity = 10)
			2d_phone_back
			(
				phone_width,
				phone_length,
				phone_corner_radius,
				phone_corner_res,
				pattern_toggle,
				my_pattern_sides,
				my_pattern_size,
				my_pattern_overlap_percent, 
				my_pattern_rotation,
				my_pattern_line_thickness,
				stencil_toggle,
				my_stencil_fill_type,
				my_stencil_shape,
				my_stencil_custom,
				my_stencil_pos,
				my_stencil_size,
				my_stencil_rotation,
				my_stencil_mirror,
				my_stencil_pattern_sides,
				my_stencil_pattern_size,
				my_stencil_pattern_overlap_percent, 
				my_stencil_pattern_rotation,
				my_stencil_pattern_line_thickness,
				back_port_1_pos,
				back_port_1_size,
				back_port_1_corner_radius,
				back_port_1_corner_res,
				back_port_2_pos,
				back_port_2_size,
				back_port_2_corner_radius,
				back_port_2_corner_res
			);
	}

}


module 2d_phone_back
(
	phone_width = 100,
	phone_length = 100,
	phone_corner_radius = 10,
	phone_corner_res = 4,
	pattern_toggle = 0,
	my_pattern_sides = 6,
	my_pattern_size = 8,
	my_pattern_overlap_percent = 40, 
	my_pattern_rotation = 0,
	my_pattern_line_thickness = 1.6,
	stencil_toggle = 0,
	my_stencil_fill_type = 0,
	my_stencil_shape,
	my_stencil_custom,
	my_stencil_pos = [0, 0],
	my_stencil_size,
	my_stencil_rotation,
	my_stencil_mirror = 0,
	my_stencil_pattern_sides = 6,
	my_stencil_pattern_size = 8,
	my_stencil_pattern_overlap_percent = 40, 
	my_stencil_pattern_rotation = 0,
	my_stencil_pattern_line_thickness = 1.6,
	back_port_1_pos = [0, 0],
	back_port_1_size,
	back_port_1_corner_radius = 0,
	back_port_1_corner_res = 8,
	back_port_2_pos = [0, 0],
	back_port_2_size,
	back_port_2_corner_radius = 0,
	back_port_2_corner_res = 8,
)
{
	my_max_dim = max(phone_width, phone_length);

	intersection()
	{
		2d_rounded_square
		(
			[phone_width, phone_length],
			phone_corner_radius,
			phone_corner_res
		);

		difference()
		{
			union()
			{
				difference()
				{
					union()
					{
						if(pattern_toggle == 0)
						{
							2d_rounded_square
							(
								[phone_width, phone_length],
								phone_corner_radius,
								phone_corner_res
							);
						}
						else
						{
							honeycomb
							(
								phone_width,
								phone_length,
								my_pattern_size,
								my_pattern_overlap_percent,
								my_pattern_line_thickness,
								my_pattern_sides,
								my_pattern_rotation
							);					
						}

						if(stencil_toggle == 1)
						{
							2d_outset(my_pattern_line_thickness)
								translate([(my_stencil_pos[0] / 100 * phone_width) - phone_width / 2, (my_stencil_pos[1] / 100 * phone_length) - phone_length / 2])
								rotate([0,0,my_stencil_rotation])
								scale([my_stencil_mirror == 1 ? -1 : 1,1,1])
								scale([my_stencil_size * my_max_dim / 100, my_stencil_size * my_max_dim / 100])
								2d_unit_stencil(my_stencil_shape, my_stencil_custom, 100);
						}
					}
					if(stencil_toggle == 1)
					{
						if(my_stencil_fill_type == 0 || my_stencil_fill_type == 2)
						{
							translate([(my_stencil_pos[0] / 100 * phone_width) - phone_width / 2, (my_stencil_pos[1] / 100 * phone_length) - phone_length / 2])
							rotate([0,0,my_stencil_rotation])
							scale([my_stencil_mirror == 1 ? -1 : 1,1,1])
							scale([my_stencil_size * my_max_dim / 100, my_stencil_size * my_max_dim / 100])
							2d_unit_stencil(my_stencil_shape, my_stencil_custom, 100);
						}
					}
				}

				if(stencil_toggle == 1 && my_stencil_fill_type == 2)
				{
					intersection()
					{
						2d_outset(my_pattern_line_thickness)
							translate([(my_stencil_pos[0] / 100 * phone_width) - phone_width / 2, (my_stencil_pos[1] / 100 * phone_length) - phone_length / 2])
							rotate([0,0,my_stencil_rotation])
							scale([my_stencil_mirror == 1 ? -1 : 1,1,1])
							scale([my_stencil_size * my_max_dim / 100, my_stencil_size * my_max_dim / 100])
							2d_unit_stencil(my_stencil_shape, my_stencil_custom, 100);
							// polygon(points = my_stencil_shape[0], paths = [my_stencil_shape[1][0]]);
						honeycomb
						(
							phone_width,
							phone_length,
							my_stencil_pattern_size,
							my_stencil_pattern_overlap_percent,
							my_stencil_pattern_line_thickness,
							my_stencil_pattern_sides,
							my_stencil_pattern_rotation
						);
					}	
				}

				if(back_port_1_size != undef)
				{
					if(len(back_port_1_size) >= 2)
					{
						translate
						(
							[
								back_port_1_pos[0],
								back_port_1_pos[1],
								0
							]
						)
						{
							2d_rounded_square
							(
								[
									back_port_1_size[0] + my_pattern_line_thickness * 2,
									back_port_1_size[1] + my_pattern_line_thickness * 2
								],
								back_port_1_corner_radius + my_pattern_line_thickness,
								back_port_1_corner_res
							);
						}
					}
				}

				if(back_port_2_size != undef)
				{
					if(len(back_port_2_size) >= 2)
					{
						translate
						(
							[
								back_port_2_pos[0],
								back_port_2_pos[1],
								0
							]
						)
						{
							2d_rounded_square
							(
								[
									back_port_2_size[0] + my_pattern_line_thickness * 2,
									back_port_2_size[1] + my_pattern_line_thickness * 2
								],
								back_port_2_corner_radius + my_pattern_line_thickness,
								back_port_2_corner_res
							);
						}
					}
				}
			}

			if(back_port_1_size != undef)
			{
				if(len(back_port_1_size) >= 2)
				{
					translate
					(
						[
							back_port_1_pos[0],
							back_port_1_pos[1],
							0
						]
					)
					{
						2d_rounded_square
						(
							[
								back_port_1_size[0],
								back_port_1_size[1]
							],
							back_port_1_corner_radius,
							back_port_1_corner_res
						);
					}
				}
			}

			if(back_port_2_size != undef)
			{
				if(len(back_port_2_size) >= 2)
				{
					translate
					(
						[
							back_port_2_pos[0],
							back_port_2_pos[1],
							0
						]
					)
					{
						2d_rounded_square
						(
							[
								back_port_2_size[0],
								back_port_2_size[1]
							],
							back_port_2_corner_radius,
							back_port_2_corner_res
						);
					}
				}
			}
		}
	}
}



module phone_bumper
(
	phone_width,
	phone_length,	
	phone_corner_radius,
	phone_corner_res,
	phone_thickness,
	phone_bottom_fillet_radius,
	phone_bottom_fillet_res,
	floor_thickness,
	wall_thickness,
	overhang_thickness,
	overhang_width,
	overhang_fillet_res,
	inner_edge_chamfer_radius,
	top_outer_edge_chamfer_radius,
	bottom_outer_edge_chamfer_radius,
	tolerance
)
{
	epsilon = .1;

	//top right corner
	translate([phone_width / 2 - phone_corner_radius, (phone_length / 2 - phone_corner_radius),0])
	{
		phone_corner
		(
			phone_corner_radius,
			phone_corner_res,
			phone_thickness,
			phone_bottom_fillet_radius,
			phone_bottom_fillet_res,
			floor_thickness,
			wall_thickness,
			overhang_thickness,
			overhang_width,
			overhang_fillet_res,
			inner_edge_chamfer_radius,
			top_outer_edge_chamfer_radius,
			bottom_outer_edge_chamfer_radius,
			tolerance
		);
	}

	//right side
	translate([phone_width / 2, 0,0])
	{
		rotate([90,0,0])
		{
			linear_extrude(height = phone_length - phone_corner_radius * 2 + epsilon * 2, center = true, convexity = 12)
			{
				phone_profile
				(
					phone_thickness,
					phone_bottom_fillet_radius,
					phone_bottom_fillet_res,
					floor_thickness,
					wall_thickness,
					overhang_thickness,
					overhang_width,
					overhang_fillet_res,
					inner_edge_chamfer_radius,
					top_outer_edge_chamfer_radius,
					bottom_outer_edge_chamfer_radius,
					tolerance
				);
			}
		}
	}

	//bottom right corner
	translate([phone_width / 2 - phone_corner_radius, -(phone_length / 2 - phone_corner_radius),0])
	{
		rotate([0,0,-90])
		{
			phone_corner
			(
				phone_corner_radius,
				phone_corner_res,
				phone_thickness,
				phone_bottom_fillet_radius,
				phone_bottom_fillet_res,
				floor_thickness,
				wall_thickness,
				overhang_thickness,
				overhang_width,
				overhang_fillet_res,
				inner_edge_chamfer_radius,
				top_outer_edge_chamfer_radius,
				bottom_outer_edge_chamfer_radius,
				tolerance
			);
		}
	}

	//bottom side
	translate([0, -(phone_length / 2), 0])
	{
		rotate([90,0,-90])
		{
			linear_extrude(height = phone_width - phone_corner_radius * 2 + epsilon * 2, center = true, convexity = 12)
			{
				phone_profile
				(
					phone_thickness,
					phone_bottom_fillet_radius,
					phone_bottom_fillet_res,
					floor_thickness,
					wall_thickness,
					overhang_thickness,
					overhang_width,
					overhang_fillet_res,
					inner_edge_chamfer_radius,
					top_outer_edge_chamfer_radius,
					bottom_outer_edge_chamfer_radius,
					tolerance
				);
			}
		}
	}

	//bottom left corner
	translate([-(phone_width / 2 - phone_corner_radius), -(phone_length / 2 - phone_corner_radius),0])
	{
		rotate([0,0,180])
		{
			phone_corner
			(
				phone_corner_radius,
				phone_corner_res,
				phone_thickness,
				phone_bottom_fillet_radius,
				phone_bottom_fillet_res,
				floor_thickness,
				wall_thickness,
				overhang_thickness,
				overhang_width,
				overhang_fillet_res,
				inner_edge_chamfer_radius,
				top_outer_edge_chamfer_radius,
				bottom_outer_edge_chamfer_radius,
				tolerance
			);
		}
	}

	//left side
	translate([-(phone_width / 2), 0,0])
	{
		rotate([90,0,180])
		{
			linear_extrude(height = phone_length - phone_corner_radius * 2 + epsilon * 2, center = true, convexity = 12)
			{
				phone_profile
				(
					phone_thickness,
					phone_bottom_fillet_radius,
					phone_bottom_fillet_res,
					floor_thickness,
					wall_thickness,
					overhang_thickness,
					overhang_width,
					overhang_fillet_res,
					inner_edge_chamfer_radius,
					top_outer_edge_chamfer_radius,
					bottom_outer_edge_chamfer_radius,
					tolerance
				);
			}
		}
	}

	//top left corner
	translate([-(phone_width / 2 - phone_corner_radius), (phone_length / 2 - phone_corner_radius),0])
	{
		rotate([0,0,90])
		{
			phone_corner
			(
				phone_corner_radius,
				phone_corner_res,
				phone_thickness,
				phone_bottom_fillet_radius,
				phone_bottom_fillet_res,
				floor_thickness,
				wall_thickness,
				overhang_thickness,
				overhang_width,
				overhang_fillet_res,
				inner_edge_chamfer_radius,
				top_outer_edge_chamfer_radius,
				bottom_outer_edge_chamfer_radius,
				tolerance
			);
		}
	}

	//top side
	translate([0, (phone_length / 2), 0])
	{
		rotate([90,0,90])
		{
			linear_extrude(height = phone_width - phone_corner_radius * 2 + epsilon * 2, center = true, convexity = 12)
			{
				phone_profile
				(
					phone_thickness,
					phone_bottom_fillet_radius,
					phone_bottom_fillet_res,
					floor_thickness,
					wall_thickness,
					overhang_thickness,
					overhang_width,
					overhang_fillet_res,
					inner_edge_chamfer_radius,
					top_outer_edge_chamfer_radius,
					bottom_outer_edge_chamfer_radius,
					tolerance
				);
			}
		}
	}
}


module phone_port
(
	size = [10,10],
	corner_radius = 4,
	corner_res = 4,
	thickness = 2,
	center = false
)
{
	linear_extrude(height = thickness, center = center)
	{
		2d_rounded_square
		(
			size,
			min (corner_radius, min(size[0],size[1]) / 2),
			corner_res
		);
	}
}

module phone_corner
(
	phone_corner_radius,
	phone_corner_res,
	phone_thickness,
	phone_bottom_fillet_radius,
	phone_bottom_fillet_res,
	floor_thickness,
	wall_thickness,
	overhang_thickness,
	overhang_width,
	overhang_fillet_res,
	inner_edge_chamfer_radius,
	top_outer_edge_chamfer_radius,
	bottom_outer_edge_chamfer_radius,
	tolerance
)
{
	intersection()
	{
		cube(phone_corner_radius * 2);

		rotate_extrude(convexity = 10, $fn = phone_corner_res * 4)
			translate([phone_corner_radius,0])
				phone_profile
				(
					phone_thickness,
					phone_bottom_fillet_radius,
					phone_bottom_fillet_res,
					floor_thickness,
					wall_thickness,
					overhang_thickness,
					overhang_width,
					overhang_fillet_res,
					inner_edge_chamfer_radius,
					top_outer_edge_chamfer_radius,
					bottom_outer_edge_chamfer_radius,
					tolerance
				);
	}
}



module phone_profile
(
	phone_thickness = 10,
	phone_bottom_fillet_radius = 3,
	phone_bottom_fillet_res = 8,
	floor_thickness = 1,
	wall_thickness = 1,
	overhang_thickness = .8,
	overhang_width = 1.6,
	overhang_fillet_res = 2,
	inner_edge_chamfer_radius = .6,
	top_outer_edge_chamfer_radius = .6,
	bottom_outer_edge_chamfer_radius = .6,
	tolerance = .3
)
{
	profile_cut_depth = max(overhang_width, phone_bottom_fillet_radius) + tolerance;

	profile_width = profile_cut_depth + wall_thickness;
	profile_height = floor_thickness + tolerance + phone_thickness + tolerance + overhang_thickness;

	overhang_fillet_radius = overhang_width + tolerance;
	bottom_edge_fillet_radius = phone_bottom_fillet_radius + tolerance;

	epsilon = .1;

	translate([-(profile_cut_depth - tolerance),0,0])
	{
		difference()
		{
			translate([profile_width / 2, profile_height / 2])
				square([profile_width, profile_height], center = true);

			//top outer chamfer
			translate([(profile_width - top_outer_edge_chamfer_radius / 2), profile_height - top_outer_edge_chamfer_radius / 2])
				rotate([0,0,-45])
					translate([-top_outer_edge_chamfer_radius,0])
						square([top_outer_edge_chamfer_radius * 2, top_outer_edge_chamfer_radius * 2]);

			//top inner chamfer
			translate([inner_edge_chamfer_radius / 2 + profile_cut_depth - overhang_width - tolerance, profile_height - inner_edge_chamfer_radius / 2])
				rotate([0,0,45])
					translate([-inner_edge_chamfer_radius,0])
						square([inner_edge_chamfer_radius * 2, inner_edge_chamfer_radius * 2]);

			//bottom outer chamfer
			translate([(profile_width - bottom_outer_edge_chamfer_radius / 2), bottom_outer_edge_chamfer_radius / 2])
				rotate([0,0,-135])
					translate([-bottom_outer_edge_chamfer_radius,0])
						square([bottom_outer_edge_chamfer_radius * 2, bottom_outer_edge_chamfer_radius * 2]);

			//overhang fillet
			translate([profile_cut_depth, profile_height - overhang_thickness])
				translate([-(overhang_width + tolerance), -(overhang_width + tolerance)])
					circle(r = overhang_width + tolerance, $fn = overhang_fillet_res * 4);


			//inner cutout
			translate([-epsilon, floor_thickness + (bottom_edge_fillet_radius > tolerance ? bottom_edge_fillet_radius :	0)])
				square([profile_cut_depth + epsilon, (phone_thickness + tolerance * 2) - (overhang_fillet_radius > tolerance ? overhang_fillet_radius :	0) - (bottom_edge_fillet_radius > tolerance ? bottom_edge_fillet_radius :	0)]);

			//overhang cutout
			translate([-(wall_thickness + tolerance + overhang_width) , floor_thickness + phone_bottom_fillet_radius + tolerance])
				square([profile_width, profile_height]);

			//bottom edge fillet
			translate([0, floor_thickness])
				translate([0, phone_bottom_fillet_radius + tolerance])
					circle(r = phone_bottom_fillet_radius + tolerance, $fn = phone_bottom_fillet_res * 4);
		}
	}
}

module honeycomb
(
	w,
	l,
	r,
	rmod,
	th,
	sides,
	rot
)
{	
	epsilon = .01;

	columns = l/(r*3)+1;
	rows = w/(r*sqrt(3)/2*2);

	translate([-w/2,l/2,0])
		rotate([0,0,-90])
			
			for(i = [-1:rows+1]){
				
				translate([0,r*sqrt(3)/2*i*2,0])
				//scale([1*(1+(i/10)),1,1])
					for(i = [0:columns]){
						translate([r*i*3,0,0])
							for(i = [0:1]){
								translate([r*1.5*i,r*sqrt(3)/2*i,0])
									rotate([0,0,rot])
									difference(){
										if(sides < 5){
											circle(r = r+th+(r*rmod/50)+ epsilon, center = true, $fn = sides);
										} else {
											circle(r = r+(r*rmod/50)+ epsilon, center = true, $fn = sides);
										}
										circle(r = r-th+(r*rmod/50), center = true, $fn = sides);
									}
							}
					}
			}
}

module 2d_unit_stencil(index, custom_shape, custom_shape_max_dim)
{
	if(index == 0 && len(custom_shape[1][0]) >= 3)
	{
		scale([1 / custom_shape_max_dim, 1 / custom_shape_max_dim])
			polygon(points = custom_shape[0], paths = [custom_shape[1][0]]);
	}
	else
	{
		if(index == 0 || index == undef)
		{
			scale([1 / custom_shape_max_dim, 1 / custom_shape_max_dim])
				polygon(points = custom_shape[0], paths = [custom_shape[1][0]]);
		}
		else
		{
			if(index == 1)
			{
				circle(r = .5, $fn = 32);
			}
			else
			{
				if(index == 2)
				{
					square([1,1], center = true, $fn = 32);
				}
				else
				{
					if(index == 3)
					{
						polygon
						(
							points = [[0.158850,0.218638],[0.475528,0.154508],[0.257024,-0.083512],[0.293892,-0.404508],[0.000000,-0.270251],[-0.293892,-0.404508],[-0.257024,-0.083512],[-0.475528,0.154508],[-0.158850,0.218638],[0.000000,0.500000]],
							paths = [[0,1,2,3,4,5,6,7,8,9]]
						);
					}
					else
					{
						if(index == 4)
						{
							translate([0,-.5,0])
							polygon
							(
								points = [[0.083266,0.920822],[0.080107,0.928329],[0.076776,0.935912],[0.073265,0.943523],[0.069570,0.951117],[0.065686,0.958645],[0.061606,0.966062],[0.057324,0.973320],[0.052836,0.980372],[0.048135,0.987173],[0.043216,0.993674],[0.038074,0.999830],[0.035729,0.989977],[0.034006,0.979513],[0.032775,0.968662],[0.031909,0.957647],[0.031279,0.946693],[0.030755,0.936024],[0.030210,0.925864],[0.029515,0.916435],[0.028540,0.907963],[0.027158,0.900670],[0.025240,0.894782],[0.022657,0.890521],[0.021149,0.889797],[0.018949,0.890089],[0.016137,0.891218],[0.012798,0.893006],[0.009013,0.895274],[0.004866,0.897844],[0.000438,0.900537],[-0.004187,0.903175],[-0.008927,0.905579],[-0.013700,0.907571],[-0.018422,0.908973],[-0.023011,0.909605],[-0.025028,0.908536],[-0.026432,0.905311],[-0.027336,0.900204],[-0.027854,0.893486],[-0.028100,0.885432],[-0.028189,0.876312],[-0.028233,0.866401],[-0.028346,0.855970],[-0.028643,0.845293],[-0.029238,0.834641],[-0.030243,0.824288],[-0.031773,0.814506],[-0.032436,0.811696],[-0.033347,0.808606],[-0.034446,0.805234],[-0.035675,0.801573],[-0.036974,0.797621],[-0.038285,0.793373],[-0.039549,0.788825],[-0.040706,0.783973],[-0.041698,0.778812],[-0.042466,0.773339],[-0.042950,0.767549],[-0.043092,0.761438],[-0.042723,0.754917],[-0.041775,0.748569],[-0.040335,0.742391],[-0.038487,0.736379],[-0.036317,0.730529],[-0.033911,0.724838],[-0.031353,0.719303],[-0.028731,0.713918],[-0.026128,0.708682],[-0.023632,0.703590],[-0.021326,0.698638],[-0.019298,0.693823],[-0.017522,0.688955],[-0.015952,0.683902],[-0.014642,0.678747],[-0.013643,0.673572],[-0.013009,0.668461],[-0.012792,0.663497],[-0.013044,0.658762],[-0.013818,0.654341],[-0.015166,0.650314],[-0.017142,0.646767],[-0.019797,0.643781],[-0.023184,0.641440],[-0.026025,0.640267],[-0.032114,0.637936],[-0.041009,0.634537],[-0.052268,0.630157],[-0.065449,0.624887],[-0.080110,0.618813],[-0.095810,0.612027],[-0.112106,0.604615],[-0.128557,0.596668],[-0.144721,0.588273],[-0.160155,0.579520],[-0.174419,0.570497],[-0.188510,0.558935],[-0.203587,0.542890],[-0.219378,0.522983],[-0.235612,0.499837],[-0.252017,0.474074],[-0.268323,0.446317],[-0.284257,0.417186],[-0.299549,0.387305],[-0.313926,0.357295],[-0.327118,0.327779],[-0.338854,0.299379],[-0.348861,0.272717],[-0.353207,0.258732],[-0.356408,0.244597],[-0.358469,0.230305],[-0.359396,0.215852],[-0.359195,0.201231],[-0.357873,0.186437],[-0.355435,0.171465],[-0.351888,0.156310],[-0.347239,0.140966],[-0.341492,0.125428],[-0.334654,0.109690],[-0.326732,0.093748],[-0.316833,0.079234],[-0.304276,0.067614],[-0.289382,0.058632],[-0.272475,0.052030],[-0.253876,0.047548],[-0.233909,0.044930],[-0.212895,0.043918],[-0.191157,0.044254],[-0.169017,0.045680],[-0.146798,0.047939],[-0.124821,0.050772],[-0.103410,0.053921],[-0.082474,0.056697],[-0.060405,0.058806],[-0.037588,0.060226],[-0.014413,0.060935],[0.008733,0.060914],[0.031462,0.060139],[0.053388,0.058590],[0.074122,0.056245],[0.093276,0.053084],[0.110463,0.049084],[0.125295,0.044224],[0.137385,0.038484],[0.147233,0.032487],[0.155684,0.026895],[0.162867,0.021738],[0.168912,0.017050],[0.173950,0.012862],[0.178109,0.009205],[0.181519,0.006111],[0.184310,0.003612],[0.186611,0.001739],[0.188553,0.000524],[0.190265,0.000000],[0.191876,0.000197],[0.193102,0.001251],[0.193613,0.003195],[0.193470,0.005909],[0.192734,0.009271],[0.191465,0.013162],[0.189723,0.017461],[0.187571,0.022047],[0.185067,0.026800],[0.182274,0.031600],[0.179251,0.036325],[0.176060,0.040855],[0.172762,0.045070],[0.165316,0.052959],[0.156718,0.060342],[0.147318,0.067217],[0.137466,0.073581],[0.127511,0.079428],[0.117804,0.084758],[0.108694,0.089565],[0.100531,0.093847],[0.093666,0.097600],[0.088447,0.100822],[0.085226,0.103507],[0.084351,0.105654],[0.085806,0.106953],[0.089154,0.107222],[0.094121,0.106644],[0.100433,0.105404],[0.107812,0.103686],[0.115985,0.101675],[0.124677,0.099554],[0.133611,0.097509],[0.142514,0.095723],[0.151109,0.094381],[0.159121,0.093666],[0.166277,0.093764],[0.178951,0.095388],[0.188669,0.097721],[0.195826,0.100608],[0.200816,0.103894],[0.204032,0.107423],[0.205869,0.111040],[0.206720,0.114590],[0.206980,0.117917],[0.207043,0.120867],[0.207303,0.123283],[0.208155,0.125011],[0.209991,0.125895],[0.216007,0.127170],[0.221042,0.128797],[0.225182,0.130749],[0.228514,0.133000],[0.231123,0.135524],[0.233095,0.138294],[0.234518,0.141285],[0.235476,0.144470],[0.236057,0.147822],[0.236346,0.151315],[0.236430,0.154924],[0.236395,0.158620],[0.235851,0.161375],[0.234345,0.164647],[0.231936,0.168293],[0.228685,0.172169],[0.224651,0.176130],[0.219894,0.180032],[0.214473,0.183731],[0.208448,0.187082],[0.201878,0.189941],[0.194824,0.192164],[0.187344,0.193606],[0.179499,0.194122],[0.178374,0.196044],[0.176703,0.201503],[0.174608,0.210047],[0.172212,0.221222],[0.169638,0.234574],[0.167007,0.249648],[0.164443,0.265992],[0.162068,0.283151],[0.160005,0.300672],[0.158375,0.318101],[0.157303,0.334983],[0.156909,0.350866],[0.158783,0.354645],[0.163983,0.362117],[0.181805,0.386330],[0.193152,0.402168],[0.205270,0.419892],[0.217521,0.439049],[0.229268,0.459189],[0.239871,0.479860],[0.248692,0.500610],[0.255093,0.520988],[0.258436,0.540542],[0.259124,0.558521],[0.258068,0.574109],[0.255459,0.587644],[0.251488,0.599466],[0.246347,0.609912],[0.240228,0.619323],[0.233323,0.628037],[0.225823,0.636393],[0.217920,0.644730],[0.209806,0.653387],[0.201673,0.662704],[0.193712,0.673018],[0.190479,0.680158],[0.190386,0.687578],[0.192937,0.695131],[0.197637,0.702666],[0.203990,0.710037],[0.211501,0.717093],[0.219674,0.723688],[0.228013,0.729671],[0.236023,0.734896],[0.243208,0.739213],[0.249072,0.742473],[0.253121,0.744529],[0.254996,0.745823],[0.256464,0.747683],[0.257570,0.750044],[0.258359,0.752839],[0.258876,0.756002],[0.259166,0.759466],[0.259272,0.763166],[0.259241,0.767034],[0.259117,0.771005],[0.258945,0.775012],[0.258770,0.778989],[0.258637,0.782870],[0.258682,0.786793],[0.258965,0.790919],[0.259408,0.795210],[0.260477,0.804138],[0.260952,0.808701],[0.261286,0.813281],[0.261405,0.817841],[0.261233,0.822343],[0.260694,0.826750],[0.259714,0.831026],[0.258217,0.835133],[0.256021,0.838878],[0.253246,0.841739],[0.249987,0.843827],[0.246337,0.845252],[0.242390,0.846124],[0.238239,0.846555],[0.233979,0.846654],[0.229703,0.846533],[0.225504,0.846303],[0.221476,0.846072],[0.217714,0.845954],[0.214310,0.846057],[0.206308,0.857845],[0.197858,0.868486],[0.188949,0.877987],[0.179569,0.886355],[0.169707,0.893598],[0.159353,0.899724],[0.148494,0.904740],[0.137121,0.908654],[0.125222,0.911473],[0.112786,0.913205],[0.099802,0.913857],[0.086258,0.913437]],
								paths = [[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,287,288,289,290,291,292,293,294,295,296,297,298,299,300,301,302,303,304,305,306,307,308,309,310,311,312,313,314,315,316,317,318,319,320,321]]
							);
						}
						else
						{
							if(index == 5)
							{
								translate([0,-.5,0])
								polygon
								(
									points = [[0.214769,0.999967],[0.233610,0.998491],[0.251091,0.992824],[0.264295,0.985496],[0.291107,0.962279],[0.299199,0.959167],[0.311654,0.957166],[0.334319,0.959246],[0.367133,0.968733],[0.371305,0.977100],[0.382527,0.983655],[0.390574,0.983982],[0.403944,0.980479],[0.409614,0.975795],[0.411297,0.967831],[0.410093,0.960024],[0.416119,0.953508],[0.423041,0.939110],[0.427735,0.920957],[0.431130,0.894401],[0.430138,0.877309],[0.428056,0.870198],[0.421546,0.858314],[0.413006,0.848831],[0.391431,0.830010],[0.347178,0.783897],[0.272816,0.715358],[0.249542,0.686087],[0.243767,0.675569],[0.238785,0.659747],[0.238019,0.642795],[0.240686,0.624786],[0.246002,0.605795],[0.278063,0.521498],[0.284857,0.498713],[0.289594,0.475394],[0.291490,0.451614],[0.289761,0.427447],[0.285200,0.404839],[0.272402,0.368896],[0.256565,0.342343],[0.224691,0.303123],[0.213115,0.283312],[0.209393,0.271794],[0.206262,0.253289],[0.205442,0.211027],[0.210716,0.163393],[0.217687,0.131143],[0.227334,0.120500],[0.254792,0.105901],[0.266567,0.097965],[0.273016,0.086953],[0.271952,0.074811],[0.269276,0.070957],[0.260962,0.065742],[0.225854,0.058772],[0.223210,0.053624],[0.223200,0.042247],[0.220529,0.035049],[0.215845,0.029442],[0.201457,0.020480],[0.182584,0.014527],[0.161879,0.011588],[0.133187,0.012844],[0.119505,0.017464],[0.106409,0.027214],[0.096398,0.038870],[0.089086,0.052176],[0.084087,0.066877],[0.079485,0.099439],[0.081096,0.204014],[0.025572,0.175869],[-0.000594,0.159484],[-0.023963,0.136235],[-0.031462,0.124948],[-0.034705,0.116245],[-0.033685,0.104382],[-0.028458,0.096554],[-0.024050,0.093313],[-0.013652,0.090391],[0.010444,0.090545],[0.022410,0.088905],[0.027993,0.086625],[0.037309,0.079094],[0.047640,0.067011],[0.054276,0.053850],[0.056521,0.039057],[0.055232,0.028015],[0.034509,0.021402],[-0.016468,0.010108],[-0.059580,0.003473],[-0.104614,0.000000],[-0.126413,0.000105],[-0.178421,0.005644],[-0.207775,0.009925],[-0.234936,0.016318],[-0.259811,0.026513],[-0.271364,0.033565],[-0.292642,0.052630],[-0.302344,0.065066],[-0.338525,0.058431],[-0.360897,0.057084],[-0.384245,0.061140],[-0.404273,0.070127],[-0.414608,0.076823],[-0.430904,0.092131],[-0.437114,0.100581],[-0.446281,0.118664],[-0.451946,0.137782],[-0.456059,0.166978],[-0.455576,0.180705],[-0.452177,0.195295],[-0.446213,0.210010],[-0.438038,0.224111],[-0.428005,0.236861],[-0.416465,0.247521],[-0.403772,0.255355],[-0.390279,0.259623],[-0.376337,0.259588],[-0.362299,0.254512],[-0.365892,0.215499],[-0.376599,0.206511],[-0.380776,0.200999],[-0.386726,0.187768],[-0.388479,0.179981],[-0.389490,0.161894],[-0.387096,0.145806],[-0.376766,0.123640],[-0.365569,0.112092],[-0.351070,0.104662],[-0.342622,0.102904],[-0.323405,0.104120],[-0.330357,0.123515],[-0.333958,0.144469],[-0.335186,0.165784],[-0.334376,0.193639],[-0.326326,0.227496],[-0.315466,0.256079],[-0.299834,0.285966],[-0.290128,0.300460],[-0.266732,0.326672],[-0.179408,0.392272],[-0.106814,0.455311],[-0.061761,0.499546],[-0.040222,0.523294],[-0.005434,0.567177],[0.015585,0.586334],[-0.013136,0.595722],[-0.035261,0.608974],[-0.044221,0.617057],[-0.047713,0.622632],[-0.052605,0.636713],[-0.055966,0.673013],[-0.053096,0.723710],[-0.046138,0.746680],[-0.034200,0.771292],[-0.018069,0.795976],[0.001471,0.819161],[0.023637,0.839278],[0.035459,0.847695],[0.041719,0.879468],[0.049382,0.902860],[0.062412,0.927909],[0.082420,0.951650],[0.105945,0.968810],[0.136881,0.984294],[0.174566,0.995844],[0.209366,0.999889]],
									paths = [[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167]]
								);
							}
							else
							{
								if(index == 6)
								{
									translate([0,-.5,0])
									polygon
									(
										points = [[-0.024897,0.771800],[-0.062056,0.816890],[-0.108713,0.851484],[-0.162103,0.875055],[-0.219463,0.887075],[-0.278027,0.887019],[-0.335033,0.874357],[-0.387715,0.848564],[-0.433310,0.809111],[-0.469053,0.755472],[-0.492180,0.687120],[-0.499927,0.603527],[-0.494870,0.541554],[-0.481662,0.486261],[-0.461388,0.436896],[-0.435132,0.392709],[-0.403979,0.352949],[-0.369013,0.316865],[-0.331320,0.283705],[-0.291983,0.252719],[-0.252087,0.223155],[-0.212717,0.194263],[-0.174958,0.165291],[-0.139893,0.135488],[-0.105912,0.104824],[-0.080041,0.081848],[-0.059397,0.063219],[-0.041098,0.045596],[-0.022260,0.025637],[0.000000,0.000000],[0.022260,0.025637],[0.041098,0.045596],[0.059397,0.063219],[0.080041,0.081848],[0.105912,0.104824],[0.139893,0.135488],[0.174958,0.165291],[0.212717,0.194263],[0.252087,0.223155],[0.291983,0.252719],[0.331320,0.283705],[0.369013,0.316865],[0.403979,0.352949],[0.435132,0.392709],[0.461388,0.436896],[0.481662,0.486261],[0.494870,0.541554],[0.499927,0.603527],[0.492180,0.687120],[0.469053,0.755472],[0.433310,0.809111],[0.387715,0.848564],[0.335033,0.874357],[0.278027,0.887019],[0.219463,0.887075],[0.162103,0.875055],[0.108713,0.851484],[0.062056,0.816890],[0.024897,0.771800],[0.000000,0.716742]],
										paths = [[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59]]
									);
								}
								else
								{
									if(index == 7)
									{
										translate([0,-.5])
										polygon
										(
											points = [[-0.241359,0.078300],[-0.239642,0.099592],[-0.239642,0.802544],[-0.096716,0.802544],[-0.095994,0.085157],[-0.092206,0.065308],[-0.087877,0.053280],[-0.078678,0.037049],[-0.066280,0.023051],[-0.056576,0.015427],[-0.040067,0.006854],[-0.021210,0.001713],[0.000000,0.000000],[0.021206,0.001713],[0.040068,0.006854],[0.056585,0.015427],[0.066293,0.023051],[0.078696,0.037049],[0.087896,0.053280],[0.092224,0.065308],[0.096009,0.085157],[0.096729,0.802544],[0.239680,0.802544],[0.239680,0.099592],[0.242725,0.071684],[0.249008,0.053280],[0.255103,0.042218],[0.262724,0.032121],[0.276726,0.019048],[0.287310,0.012187],[0.304994,0.004759],[0.317989,0.001713],[0.339291,0.000000],[0.353267,0.000783],[0.372495,0.004890],[0.384159,0.009584],[0.399931,0.019556],[0.409301,0.028157],[0.420985,0.043172],[0.429335,0.060084],[0.433048,0.072411],[0.436019,0.099592],[0.435578,0.794419],[0.432047,0.823287],[0.424986,0.850713],[0.414396,0.876696],[0.400280,0.901234],[0.372494,0.935331],[0.338923,0.963757],[0.301746,0.984058],[0.260963,0.996237],[0.216575,1.000296],[-0.216550,1.000296],[-0.260951,0.996237],[-0.301739,0.984058],[-0.338911,0.963757],[-0.372469,0.935331],[-0.400270,0.901234],[-0.420120,0.863885],[-0.432026,0.823287],[-0.435993,0.779445],[-0.435993,0.099592],[-0.434325,0.078300],[-0.431359,0.065308],[-0.424127,0.047628],[-0.417450,0.037049],[-0.404721,0.023051],[-0.394898,0.015427],[-0.384151,0.009330],[-0.366299,0.003045],[-0.353244,0.000761],[-0.331929,0.000190],[-0.311361,0.003045],[-0.298850,0.006854],[-0.276710,0.019048],[-0.262703,0.032121],[-0.255085,0.042218],[-0.246509,0.059174],[-0.242695,0.071684]],
											paths = [[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78]]
										);
									}
									else
									{
										
									}
								}
							}
						}
					}
				}
			}
		}
	}
}


module 2d_outset	(	radius = .4	)
{
	if(radius > 0)
	{
		minkowski()
		{
			child();
			circle	(
				r = radius
			);
		}
	}
	else
	{
		child();
	}	
}

module 2d_rounded_square
(	
	size = [1,1],
	corner_radius = .4,
	corner_res = 4
)
{
	my_corner_radius = min(corner_radius, min(size[0] / 2, size[1] / 2) - .05);

	2d_outset(my_corner_radius, $fn = corner_res * 4)
		square	(
			size =	[	
						size[0] - my_corner_radius * 2,
						size[1] - my_corner_radius * 2
					],
			center = true
		);
}
