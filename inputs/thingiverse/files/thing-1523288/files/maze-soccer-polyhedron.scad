height = 50; 
maze_in = "hexagon"; // [pentagon, hexagon, both]

// give a [x, y] point and length. draw a line in the x direction
module x_line(point, length, thickness = 1) {
    offset = thickness / 2;
    translate([point[0] - offset, point[1] - offset, 0]) 
        square([length + thickness, thickness]);
}

/*
 * constants, for clearness
 *
 */
 
// random directions, for picking up a direction to visit the next block
function PERMUTATION_OF_FOUR() = [
    [1, 2, 3, 4],
    [1, 2, 4, 3],
    [1, 3, 2, 4],
    [1, 3, 4, 2],
    [1, 4, 2, 3],
    [1, 4, 3, 2],
    [2, 1, 3, 4],
    [2, 1, 4, 3],
    [2, 3, 1, 4],
    [2, 3, 4, 1],
    [2, 4, 1, 3],
    [2, 4, 3, 1],
    [3, 1, 2, 4],
    [3, 1, 4, 2],
    [3, 2, 1, 4],
    [3, 2, 4, 1],
    [3, 4, 1, 2],
    [3, 4, 2, 1],
    [4, 1, 2, 3],
    [4, 1, 3, 2],
    [4, 2, 1, 3],
    [4, 2, 3, 1],
    [4, 3, 1, 2],
    [4, 3, 2, 1]
];

function NO_WALL() = 0;
function UP_WALL() = 1;
function RIGHT_WALL() = 2;
function UP_RIGHT_WALL() = 3;

function NOT_VISITED() = 0;
function VISITED() = 1;

/* 
 * modules for creating a maze
 *
 */

// create the outer wall of maze
module maze_outer_wall(rows, columns, block_width = 5, wall_thickness = 1) {
    x_line([0, rows * block_width], columns * block_width, wall_thickness);
    y_line([0, block_width], (rows - 1) * block_width, wall_thickness);
}

// create the inner wall of maze
module maze_inner_wall(maze, block_width = 5, wall_thickness = 1) {
    for(i = [0:len(maze) - 1]) {
        cord = maze[i];
        x = (cord[0] - 1) * block_width;
        y = (cord[1] - 1) * block_width;
        v = cord[3];
        
        if(v == 1 || v == 3) {
            x_line([x, y], block_width, wall_thickness);
        }
        if(v == 2 || v == 3) {
            y_line([x + block_width, y], block_width, wall_thickness);
        }
    }  
}

// create a maze
module maze(rows, columns, maze_vector, block_width = 5, wall_thickness = 1) {
     maze_outer_wall(rows, columns, block_width, wall_thickness);
     maze_inner_wall(maze_vector, block_width, wall_thickness);
}

/* 
 * utilities functions
 *
 */

// comare the equality of [x1, y1] and [x2, y2]
function cord_equals(cord1, cord2) = cord1 == cord2;

// is the point visited?
function not_visited(cord, vs, index = 0) =
    index == len(vs) ? true : 
        (cord_equals([vs[index][0], vs[index][1]], cord) && vs[index][2] == 1 ? false :
            not_visited(cord, vs, index + 1));
            
// pick a direction randomly
function rand_dirs() =
    PERMUTATION_OF_FOUR()[round(rands(0, 24, 1)[0])]; 

// replace v1 in the vector with v2 
function replace(v1, v2, vs) =
    [for(i = [0:len(vs) - 1]) vs[i] == v1 ? v2 : vs[i]];
	 
/* 
 * functions for generating a maze vector
 *
 */


// initialize a maze
function init_maze(rows, columns) = 
    [
	    for(c = [1 : columns]) 
	        for(r = [1 : rows]) 
		        [c, r, 0,  UP_RIGHT_WALL()]
	];
    
// find a vector in the maze vector
function find(i, j, maze_vector, index = 0) =
    index == len(maze_vector) ? [] : (
        cord_equals([i, j], [maze_vector[index][0], maze_vector[index][1]]) ? maze_vector[index] : find(i, j, maze_vector, index + 1)
    );

////
// NO_WALL = 0;
// UP_WALL = 1;
// RIGHT_WALL = 2;
// UP_RIGHT_WALL = 3;
function delete_right_wall(original_block) = 
    original_block == NO_WALL() || original_block == RIGHT_WALL() ? NO_WALL() : UP_WALL();

function delete_up_wall(original_block) = 
    (original_block == NO_WALL() || original_block == UP_WALL()) ? NO_WALL() : RIGHT_WALL();
    
function delete_right_wall_of(vs, is_visited, maze_vector) =
    replace(vs, [vs[0], vs[1] , is_visited, delete_right_wall(vs[3])] ,maze_vector);

function delete_up_wall_of(vs, is_visited, maze_vector) =
    replace(vs, [vs[0], vs[1] , is_visited, delete_up_wall(vs[3])] ,maze_vector);

function go_right(i, j, rows, columns, maze_vector) =
    go_maze(i + 1, j, rows, columns, delete_right_wall_of(find(i, j, maze_vector), VISITED(), maze_vector));
    
function go_up(i, j, rows, columns, maze_vector) =
    go_maze(i, j - 1, rows, columns, delete_up_wall_of(find(i, j, maze_vector), VISITED(), maze_vector));
    
function visit(v, maze_vector) =
    replace(v, [v[0], v[1], VISITED(), v[3]], maze_vector);
 
function go_left(i, j, rows, columns, maze_vector) =
    go_maze(i - 1, j, rows, columns, delete_right_wall_of(find(i - 1, j, maze_vector), NOT_VISITED(), maze_vector));
    
function go_down(i, j, rows, columns, maze_vector) =
    go_maze(i, j + 1, rows, columns, delete_up_wall_of(find(i, j + 1, maze_vector), NOT_VISITED(), maze_vector));
    
function go_maze(i, j, rows, columns, maze_vector) =
    look_around(i, j, rand_dirs(), rows, columns, visit(find(i, j, maze_vector), maze_vector));
    
function look_around(i, j, dirs, rows, columns, maze_vector, index = 0) =
    index == 4 ? maze_vector : 
        look_around( 
            i, j, dirs, 
            rows, columns, 
            build_wall(i, j, dirs[index], rows, columns, maze_vector), 
            index + 1
        ); 

function build_wall(i, j, n, rows, columns, maze_vector) = 
    n == 1 && i != columns && not_visited([i + 1, j], maze_vector) ? go_right(i, j, rows, columns, maze_vector) : ( 
        n == 2 && j != 1 && not_visited([i, j - 1], maze_vector) ? go_up(i, j, rows, columns, maze_vector)  : (
            n == 3 && i != 1 && not_visited([i - 1, j], maze_vector) ? go_left(i, j,rows, columns,  maze_vector)  : (
                n == 4 && j != rows && not_visited([i, j + 1], maze_vector) ? go_down(i, j, rows, columns, maze_vector) : maze_vector
            ) 
        )
    ); 

module ring_regular_polygon(radius, thickness, sides) {
    difference() { 
	    offset(delta = thickness) circle(radius, $fn = sides);
        circle(radius, $fn = sides);
	}
}

module ring_regular_polygon_sector(radius, angle, thickness, width, sides) {
	intersection() {
		ring_regular_polygon(radius - 0.1, thickness + 0.2, sides);
		rotate([0, 0, angle]) x_line([0, 0], radius * 3, width);
	}
}

module regular_polygon_to_polygon_wall(radius, length, angle, thickness, sides) {
    intersection() {
        difference() {
		    circle(radius + length, $fn = sides);
			circle(radius, $fn = sides);
	    }
	    rotate([0, 0, angle]) 
		    x_line([0, 0], (radius + length) * 2, thickness);
	}
}

module regular_polygon_maze(radius, cblocks, levels, thickness = 1, sides) {
    full_circle_angle = 360;
    arc_angle = full_circle_angle / cblocks;
	r = radius / (levels + 1);
	
	maze = go_maze(1, 1, cblocks, levels, replace([levels, cblocks - 1, 0, UP_RIGHT_WALL()], [levels, cblocks - 1, 0, UP_WALL()], init_maze(cblocks, levels)));
	
	
	difference() {
		 union() {
			for(i = [1 : levels + 1]) {
			    ring_regular_polygon(r * i, thickness, sides);
			}
		  
		  
			for(i = [0:len(maze) - 1]) { 
				cord = maze[i];
				cr = cord[0]; 
				cc = cord[1] - 1;    
				v = cord[3];
				
				angle = cc * arc_angle;
				 
				if(v == 1 || v == 3) { 
				    regular_polygon_to_polygon_wall(r * cr, r, cc * arc_angle , thickness, sides);
				} 
			}
	    }
		
		 union() {
		    // maze entry
			ring_regular_polygon_sector(r, arc_angle / 1.975 , thickness, r / 3, sides);   

	        // road to the next level
			for(i = [0:len(maze) - 1]) { 
				cord = maze[i];
				cr = cord[0]; 
				cc = cord[1] - 1;    
				v = cord[3];
				
				if(v == 0 || v == 1) { 
				
				    ring_regular_polygon_sector(r * (cr + 1), (cc + 0.5) * arc_angle , thickness, r / 3 , sides);
				}  
			}
		}
	}
}

// create a generalized pentagon by length.
// Parameters:
//     length : the side length
//     spacing : the gap between a pentagon or a hexagon
module generalized_pentagon(length, spacing = 0.5) {
    r = 0.5 * length / sin(36);
	s = (r - spacing / 2) / r;

    color("yellow") 
	    rotate(18) 		     
		     linear_extrude(length, scale = 1.42215)
		        scale([s, s, s])
			        children(); 
}

// create a generalized hexagon by length.
// Parameters:
//     length : the side length
//     spacing : the gap between a pentagon or a hexagon
module generalized_hexagon(length, spacing = 0.5) {
    r = 0.5 * length / sin(30);
	s = (r - spacing / 2) / r;

    color("white") 
	     linear_extrude(length - length * 0.02125, scale = 1.42215) 
		    scale([s, s, s])			
		        children();
}

// two generalized pentagons and two generalized hexagons.
// Parameters:
//     length : the side length
//     spacing : the gap between the pentagon and hexagon
module generalized_pentagon_based_sub_comp(length, spacing = 0.5) {
	pentagon_circle_r = 0.5 * length / sin(36);
	
	a = 37.325;
	
	offset_y = 0.5 * length * tan(54) + pentagon_circle_r * cos(a);
	offset_z = 0.5 * length * tan(60) * sin(a);
	
	translate([0, -offset_y, -offset_z]) 
	    rotate([a, 0, 0]) 
		    generalized_hexagon_based_sub_comp(length, spacing) {
			    children(0); 
				children(1); 
			}
}


// two generalized hexagons and one generalized pentagon.
// Parameters:
//     length : the side length
//     spacing : the gap between the pentagon and hexagon
module generalized_hexagon_based_sub_comp(length, spacing = 0.5) {
    children(1); 
	
	length_center_to_side = 0.5 * length * tan(54);
	
    a = -37.325;
	
	offset_y = 0.5 * length * (tan(54) * cos(a) + tan(60));
	offset_z = length_center_to_side * sin(a);
	
	rotate(120) translate([0, offset_y, offset_z]) 
	    rotate([a, 0, 0]) 
	        generalized_pentagon_hexagon(length, spacing) {
			    children(0);
			    children(1);
			}
			
}

// a generalized pentagon and a generalized hexagon.
// Parameters:
//     length : the side length
//     spacing : the gap between the pentagon and hexagon
module generalized_pentagon_hexagon(length, spacing = 0.5) {
	pentagon_circle_r = 0.5 * length / sin(36);
	
	children(0); 
	
	a = 37.325;
	
	offset_y = 0.5 * length * tan(54) + pentagon_circle_r * cos(a);
	offset_z = 0.5 * length * tan(60) * sin(a);
	
	rotate(144) translate([0, -offset_y, -offset_z]) 
	    rotate([a, 0, 0]) 
		    children(1); 
}

// a half of generalized soccer polyhedron.
// Parameters:
//     line_length : the side length of pentagons and hexagons
//     spacing : the gap between the pentagon and hexagon
module generalized_half_soccer_polyhedron(line_length, spacing = 0.5) {
	pentagon_circle_r = 0.5 * line_length / sin(36);
	offset_y = pentagon_circle_r * cos(36);

	children(0);
	
	for(i = [0:4]) {
		rotate(72 * i) 
		    generalized_pentagon_based_sub_comp(line_length, spacing) {
			    children(0);
				children(1);
			}
	}
}

// a generalized soccer polyhedron.
// Parameters:
//     line_length : the side length of pentagons and hexagons
//     spacing : the gap between the pentagon and hexagon
//     center : center it or not
module generalized_soccer_polyhedron(height, spacing = 0.5, center = true) {
    line_length = height / 6.65;
	
	offset_for_center = center ? height / 2: 0;
	
	translate([0, 0, -offset_for_center]) union() {
		translate([0, 0, -line_length + line_length * 6.64875]) 
		    generalized_half_soccer_polyhedron(line_length, spacing) {
			    generalized_pentagon(line_length, spacing) children(0);
			    generalized_hexagon(line_length, spacing) children(1);			
			}
			
		rotate(36) mirror([0, 0, 1]) translate([0, 0, -line_length]) 
		    generalized_half_soccer_polyhedron(line_length, spacing) {
			    generalized_pentagon(line_length, spacing) children(0);
			    generalized_hexagon(line_length, spacing) children(1);				
			}
	} 
}

// create a pentagon according the height of the soccer polyhedron
module pentagon_for_soccer_polyhedron(height) {
    line_length = height / 6.65;
    circle(0.5 * line_length / sin(36), $fn = 5);
}

// create a hexagon according the height of the soccer polyhedron
module hexagon_for_soccer_polyhedron(height) {
    line_length = height / 6.65;
    circle(0.5 * line_length / sin(30), $fn = 6);			
}

// create a pentagon according the height of the soccer polyhedron
module pentagon_maze_for_soccer_polyhedron(height) {
	wall_thickness = 0.68;
	radius_of_circle_wrapper = 0.5 * height / 6.6 / sin(36) - wall_thickness;
	
	cblocks = 6;
	levels = 3;
	sides = 5; 
	
	regular_polygon_maze(radius_of_circle_wrapper, cblocks, levels, wall_thickness, sides); 			
}

// create a hexagon according the height of the soccer polyhedron
module hexagon_maze_for_soccer_polyhedron(height) {
	wall_thickness = 0.68;
	radius_of_circle_wrapper = 0.5 * height / 6.6 / sin(30) - wall_thickness;
	
	cblocks = 6;
	levels = 3;
	sides = 6;
	
	regular_polygon_maze(radius_of_circle_wrapper, cblocks, levels, wall_thickness, sides);	
}

module maze_soccer_polyhedron(height, maze_in) {
    spacing = 1;
	
	sphere(height / 2 - 1); 
	
    if(maze_in == "pentagon"){
		generalized_soccer_polyhedron(height, spacing) {
			pentagon_maze_for_soccer_polyhedron(height);
			hexagon_for_soccer_polyhedron(height);
		}	
	} else if(maze_in == "hexagon"){
		generalized_soccer_polyhedron(height, spacing) {
			pentagon_for_soccer_polyhedron(height);
			hexagon_maze_for_soccer_polyhedron(height);
		}	
	} else if(maze_in == "both") {
		generalized_soccer_polyhedron(height, spacing) {
			pentagon_maze_for_soccer_polyhedron(height);
			hexagon_maze_for_soccer_polyhedron(height);
		}
	} 
}

maze_soccer_polyhedron(height, maze_in);
