large_decoration_height = 8; //[0:30]
small_decoration_height = 7; //[0:30]
large_decoration_width = 24; //[10:40]
small_decoration_width = 15; //[7:35]
handle_width = 15; //[5:25]
hilt_width = 10; //[5:25]
hilt_length = 70; //[30:130]
handle_height = 5; //[0:30]
blade_length = 120; //[20:250]
blade_side_height = 2; //[0:30]
blade_center_height = 6; //[0:30]

// preview[view:south west, tilt:top diagonal]

//bottom
	rotate([0,0,45])
	translate([-large_decoration_width/2,-large_decoration_width/2,0])
	cube(size=[large_decoration_width,large_decoration_width,large_decoration_height]);

//handle
translate([0,-handle_width/2,0])
cube(size = [40,handle_width,handle_height]);

//hilt
translate([40 - hilt_width/2,-hilt_length/2,0])
cube(size = [hilt_width,hilt_length,handle_height]);

//where the two parts of the handle intersect
translate([40,0,0])
	rotate([0,0,45])
	translate([-large_decoration_width/2,-large_decoration_width/2,0])
	cube(size=[large_decoration_width,large_decoration_width,large_decoration_height]);

//right of hilt
translate([40,-hilt_length/2,0])
	rotate([0,0,45])
	translate([-small_decoration_width/2,-small_decoration_width/2,0])
	cube(size=[small_decoration_width,small_decoration_width,small_decoration_height]);

//left of hilt
translate([40,hilt_length/2,0])
	rotate([0,0,45])
	translate([-small_decoration_width/2,-small_decoration_width/2,0])
	cube(size=[small_decoration_width,small_decoration_width,small_decoration_height]);

//blade
translate([40,0,0])
polyhedron(
	points=[
			//bottom
			[0,-7.5,0], //0
			[blade_length-7.5,-7.5,0], //1
			[blade_length-7.5,7.5,0], //2
			[0,7.5,0], //3
			[blade_length,0,0], //4
			//middle
			[0,-7.5,blade_side_height], //5
			[blade_length-7.5,-7.5,blade_side_height], //6
			[blade_length-7.5,7.5,blade_side_height], //7
			[0,7.5,blade_side_height], //8
			[blade_length,0,blade_side_height], //9
			//top
			[0,0,blade_center_height], //10
			[blade_length-7.5,0,blade_center_height] //11
			],
	triangles=[
			//~-~bottom~-~
			[0,1,2],
			[0,2,3],
			//bottom point
			[1,4,2],
			//~-~walls~-~
			//right
			[0,5,1],
			[5,6,1],
			//right point
			[1,6,4],
			[4,6,9],
			//left
			[8,3,2],
			[7,8,2],
			//left point
			[7,2,4],
			[7,4,9],
			//back
			[0,3,5],
			[5,3,8],
			//~-~top~-~
			//right
			[10,6,5],
			[11,6,10],
			//right point
			[11,9,6],
			//left
			[10,8,7],
			[7,11,10],
			//left point
			[11,7,9],
			//back
			[10,5,8]
			]
	
);
