// png: 100x100 pixels
filename = "";  // [image_surface:100x100]
width = 100;
puzzle_x_blocks = 4; 
maze_x_blocks = 10;  
ditch_width = 1;
spacing = 0.4;

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

// give a [x, y] point and length. draw a line in the x direction
module x_line(point, length, thickness = 1) {
    offset = thickness / 2;
    translate([point[0] - offset, point[1] - offset, 0]) 
        square([length + thickness, thickness]);
}

// give a [x, y] point and length. draw a line in the y direction
module y_line(point, length, thickness = 1) {
    offset = thickness / 2;
    translate([point[0] - offset, point[1] - offset, 0])  
        square([thickness, length + thickness]);
}

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
 


// Puzzle

module puzzle_piece(side_length, spacing) {
	$fn = 48;
	
	circle_radius = side_length / 10;
	half_circle_radius = circle_radius / 2;
	side_length_div_4 = side_length / 4;
	bulge_circle_radius = circle_radius - spacing;

	difference() {
		square(side_length - spacing);
		
		// left
		translate([half_circle_radius, side_length_div_4, 0]) 
			circle(circle_radius);
		translate([half_circle_radius, side_length_div_4 * 3, 0]) 
			circle(circle_radius);
			
		// top
		translate([side_length_div_4, side_length - half_circle_radius, 0]) 
			circle(circle_radius);
		translate([side_length_div_4 * 3, side_length - half_circle_radius, 0]) 
			circle(circle_radius);		
	}

	// right
	translate([side_length + half_circle_radius, side_length_div_4, 0]) 
		circle(bulge_circle_radius);
	translate([side_length + half_circle_radius, side_length_div_4 * 3, 0]) 
		circle(bulge_circle_radius);

	// bottom
	translate([side_length_div_4, -half_circle_radius, 0]) 
		circle(bulge_circle_radius);
	translate([side_length_div_4 * 3, -half_circle_radius, 0]) 
		circle(bulge_circle_radius);
}

module puzzle(xs, ys, piece_side_length, spacing) {
    $fn = 48;
	circle_radius = piece_side_length / 10;
	half_circle_radius = circle_radius / 2;
	side_length_div_4 = piece_side_length / 4;
	
	intersection() {
		union() for(x = [0 : xs - 1]) {
			for(y = [0 : ys - 1]) {
				translate([piece_side_length * x, piece_side_length * y, 0]) 
					puzzle_piece(piece_side_length, spacing);
					
				if(x == 0) {
					// left
					translate([half_circle_radius, side_length_div_4 + piece_side_length * y, 0]) 
						circle(circle_radius);
					translate([half_circle_radius, side_length_div_4 * 3 + piece_side_length * y, 0]) 
						circle(circle_radius);			
				}
				if(y == ys - 1) {
					// top
					translate([side_length_div_4 + piece_side_length * x, piece_side_length * (y + 1) - half_circle_radius, 0]) 
						circle(circle_radius);
					translate([side_length_div_4 * 3 + piece_side_length * x, piece_side_length * (y + 1) - half_circle_radius, 0]) 
						circle(circle_radius);	
				}
			}
		}
		
		square([piece_side_length * xs - spacing, piece_side_length * ys - spacing]);
	}
}

module image_to_surface(filename, width) {
    $fn = 48;
    origin_width = 100;
	half_origin_width = 50;
	scale_factor = width / origin_width;

	scale([scale_factor, scale_factor, 1])  union() {
		color("white") intersection() {			   
		   linear_extrude(4) square(origin_width); 
		   scale([1, 1, 10]) surface(file = filename);
		} 
		
		color("black") linear_extrude(2) square(origin_width);  
	}
}    

module image_to_maze_puzzle(filename, width, puzzle_x_blocks, maze_x_blocks, ditch_width, spacing) {
    wall_height = 8;
	       
	piece_side_length = width / puzzle_x_blocks;
	puzzle_y_blocks = puzzle_x_blocks;
	maze_y_blocks = maze_x_blocks;
	block_width = width / maze_x_blocks;

	maze_vector = go_maze(1, 1, maze_y_blocks, maze_x_blocks, 
	    replace([maze_x_blocks, maze_y_blocks, 0, UP_RIGHT_WALL()], 
		        [maze_x_blocks, maze_y_blocks, 0, UP_WALL()], 
				init_maze(maze_y_blocks, maze_x_blocks))
	);

	difference() { 
		intersection() {
			image_to_surface(filename, width);
			linear_extrude(15) 
				 puzzle(puzzle_x_blocks, puzzle_y_blocks, piece_side_length, spacing);    		 
		}
 
		// maze
		translate([0, 0, ditch_width]) 
			linear_extrude(wall_height) 
				maze(maze_y_blocks, maze_x_blocks, maze_vector, block_width, ditch_width);
	}
}
 
image_to_maze_puzzle(filename, width, puzzle_x_blocks, maze_x_blocks, ditch_width, spacing);
