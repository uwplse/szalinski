x_cells = 10;
y_cells = 10;
cell_radius = 3;
wall_thickness = 1;
wall_height = 2;
bottom = "YES"; // [YES, NO]
 
module line(point1, point2, width = 1, cap_round = true) {
    angle = 90 - atan((point2[1] - point1[1]) / (point2[0] - point1[0]));
    offset_x = 0.5 * width * cos(angle);
    offset_y = 0.5 * width * sin(angle);

    offset1 = [-offset_x, offset_y];
    offset2 = [offset_x, -offset_y];

    if(cap_round) {
        translate(point1) circle(d = width, $fn = 24);
        translate(point2) circle(d = width, $fn = 24);
    }

    polygon(points=[
        point1 + offset1, point2 + offset1,  
        point2 + offset2, point1 + offset2
    ]);
}

module polyline(points, width = 1) {
    module polyline_inner(points, index) {
        if(index < len(points)) { 
            line(points[index - 1], points[index], width);
            polyline_inner(points, index + 1);
        }
    }
	
    polyline_inner(points, 1);
}


// maze

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

  
// create a maze
module hex_maze(y_cells, x_cells, maze_vector, cell_radius, wall_thickness) {

	// style : upper/rights/right
	module cell(x_cell, y_cell, style) {
		module upper_wall() {
			polyline(
				[for(a = [240:60:300]) 
					[cell_radius * cos(a), cell_radius * sin(a)]], 
				wall_thickness
			);
		}
		
		module down_wall() {
			polyline(
				[for(a = [60:60:120]) 
					[cell_radius * cos(a), cell_radius * sin(a)]], 
				wall_thickness
			);
		}
		
		module up_left_wall() {
			polyline( 
				[for(a = [180:60:270]) 
					[cell_radius * cos(a), cell_radius * sin(a)]], 
				wall_thickness
			);  
		}
		
		module down_left_wall() {
			polyline( 
				[for(a = [120:60:180]) 
					[cell_radius * cos(a), cell_radius * sin(a)]], 
				wall_thickness
			);  	
		}
		
		module up_right_wall() {
			polyline( 
				[for(a = [300:60:360]) 
					[cell_radius * cos(a), cell_radius * sin(a)]], 
				wall_thickness
			);  
		}
		
		module down_right_wall() {
			polyline(
				[for(a = [0:60:60]) 
					[cell_radius * cos(a), cell_radius * sin(a)]], 
				wall_thickness
			); 
		}
		
		module right_walls() {
			up_right_wall();
			down_right_wall();
		}
		
		module cell_border_wall() {
			if(y_cell == 0 && x_cell % 2 == 0) {
				if(x_cell != 0) {
					up_left_wall();
				}
				up_right_wall();
			}
			
			if(x_cell == 0) {
				if(y_cell != 0) {
					up_left_wall();
				}
				down_left_wall();
			}
			
			if(y_cell == (y_cells - 1)) {
				down_wall();
				if(x_cell % 2 != 0) {
				    down_left_wall();
				}
			}		
		}
		
		module cell_inner_wall() {
			if(style == "upper") {
				upper_wall();
			} else if(style == "rights") {
				right_walls();
			} else if(style == "right") {
				if(x_cell % 2 == 0) {
					up_right_wall();
				} else {
					down_right_wall();
				}
			}
		}
		
		module cell_wall() {
			cell_inner_wall();
			cell_border_wall();
		}

		grid_h = 2 * cell_radius * sin(60);
		grid_w = cell_radius + cell_radius * cos(60);

		translate([grid_w * x_cell, grid_h * y_cell + (x_cell % 2 == 0 ? 0 : grid_h / 2), 0]) 
			cell_wall();
	}
	
	// create the wall of maze

	for(i = [0:len(maze_vector) - 1]) {
		cord = maze_vector[i];
		x = (cord[0] - 1) ;
		y = (cord[1] - 1);
		v = cord[3];
		
		if(v == 1 || v == 3) {
			cell(x, y, "upper");
			 
		}
		if(v == 2 || v == 3) {
			cell(x, y, "rights");
		}  
		if(v == 0 || v == 1) {
			cell(x, y, "right"); 
		}
	}  
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
    
/*
 * create a maze
 *
 */
 
maze_vector = go_maze(1, 1, y_cells, x_cells, replace([x_cells, y_cells, 0, UP_RIGHT_WALL()], [x_cells, y_cells, 0, UP_WALL()], init_maze(y_cells, x_cells)));

linear_extrude(wall_height) 
    hex_maze(y_cells, x_cells, maze_vector, cell_radius, wall_thickness);

	
	
module bottom(y_cells, x_cells, cell_radius, wall_thickness) {
	grid_h = 2 * cell_radius * sin(60);
	grid_w = cell_radius + cell_radius * cos(60);	
	for(x_cell = [0:x_cells - 1]) {
		for(y_cell = [0:y_cells - 1]) {
			translate([grid_w * x_cell, grid_h * y_cell + (x_cell % 2 == 0 ? 0 : grid_h / 2), 0])  
				circle(cell_radius + wall_thickness, $fn = 6);
		}
	}
}

if(bottom == "YES") {
    linear_extrude(wall_thickness) bottom(y_cells, x_cells, cell_radius, wall_thickness);
}





	