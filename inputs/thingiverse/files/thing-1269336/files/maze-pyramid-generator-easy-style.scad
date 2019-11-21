square_block = 15; 
wall_thickness = 1;
block_width = 2;

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

module maze_pyramid(square_block, block_width = 2, wall_thickness = 1) {

	maze_vector = go_maze(1, 1, square_block, square_block, replace([square_block, square_block, 0, UP_RIGHT_WALL()], [square_block, square_block, 0, UP_WALL()], init_maze(square_block, square_block)));

	diameter = square_block * block_width / 1.4142135623730950488016887242097 + wall_thickness * 2;
	half_wall_thickness = wall_thickness / 2;
	offset = square_block * block_width / 2;
	
	intersection() {
		linear_extrude(diameter) 
			maze(square_block, square_block, maze_vector, block_width, wall_thickness);

		translate([offset, offset, 0])     
			rotate([0, 0, 45]) 
				cylinder(diameter, diameter, 0, $fn=4);
	}

	translate([-half_wall_thickness, -half_wall_thickness, 0])     
	    linear_extrude(wall_thickness) 
		    square(square_block * block_width + wall_thickness);

}
	
maze_pyramid(square_block, block_width, wall_thickness);