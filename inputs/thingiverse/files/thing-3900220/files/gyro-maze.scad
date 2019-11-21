
cblocks = 8; 
wall_thickness = 1.5;
spacing = 0.6;
$fn = 48;

gyro_maze(cblocks, wall_thickness, spacing);

module gyro_maze(cblocks, wall_thickness, spacing) {
    // Don't change these variables. They require more math.
    radius = 15;
    wall_height = 1;
    levels = 4;
    h = radius / 3;

    module maze() {
        translate([0, 0, radius / 3 - wall_height])
        linear_extrude(wall_height) 
        scale(1.029) {
            difference() {
                regular_polygon_maze(radius - wall_thickness, cblocks, levels - 1, wall_thickness, $fn); 
                circle(radius / 3.5);
            }
            circle(radius / 3.5 - wall_thickness / 1.45);
        }
    }

    intersection() {
        gyro(radius, levels, spacing);
        union() {
            maze();
            mirror([0, 0, 1]) maze();
        }
    }

    difference() {
        gyro(radius, levels, spacing);
        
        translate([0, 0, h - wall_height])
        linear_extrude(wall_height) 
            square(radius * 2, center = true);

        translate([0, 0, -h])
        linear_extrude(wall_height) 
            square(radius * 2, center = true);        
    }
}

module gyro(radius, layers, spacing) {
	h = radius / 3;
    half_r = radius / 2.75;
    r_step = (radius - half_r) / (layers - 1);
    
    module rings() {
        ring_thickness = r_step - spacing;
        circle(half_r);
        for(i = [1:layers - 1]) {
            hollow_out(ring_thickness) 
                circle(half_r + r_step * i);        
        }
    }

    rotate_extrude()
    intersection() {
        translate([0, -h]) 
            square([radius, h * 2]);
        rings();
    }
}

module ring_regular_polygon(radius, thickness, sides) {
    hollow_out(thickness) 
        circle(radius + thickness / 2, $fn = sides);
}

module ring_regular_polygon_sector(radius, angle, thickness, width, sides) {
	intersection() {
		ring_regular_polygon(radius, thickness + 0.2, sides);
		rotate([0, 0, angle]) 
            line2d([0, 0], [0, radius * 3 + width], width);
	}
}

module regular_polygon_to_polygon_wall(radius, length, angle, thickness, sides) {
    intersection() {
        difference() {
		    circle(radius + length, $fn = sides);
			circle(radius, $fn = sides);
	    }
	    rotate([0, 0, angle]) 
            line2d([0, 0], [0, (radius + length) * 2 + thickness], thickness);
	}
}

module regular_polygon_maze(radius, cblocks, levels, thickness = 1, sides) {    
    arc_angle = 360 / cblocks;
	r = radius / (levels + 1);
	
	maze = go_maze(1, 1, 
        starting_maze(cblocks, levels),
        cblocks, levels, y_circular = true
    );

	difference() {
		render() union() {
			for(i = [1 : levels + 1]) {
			    ring_regular_polygon(r * i, thickness, sides);
			}
		  
		  
			for(i = [0:len(maze) - 1]) { 
				block = maze[i];
				cr = get_x(block); 
				cc = get_y(block) - 1;    
				
				angle = cc * arc_angle;
				 
				if(upper_wall(block) || upper_right_wall(block)) { 
				    regular_polygon_to_polygon_wall(r * cr, r, cc * arc_angle , thickness, sides);
				} 
			}
	    }
		
		render() union() {
		    // maze entry
			// ring_regular_polygon_sector(r, arc_angle / 1.975 , thickness, r / 3, sides);   

	        // road to the next level
			for(i = [0:len(maze) - 1]) { 
				block = maze[i];
				cr = get_x(block); 
				cc = get_y(block) - 1;   
				
				if(no_wall(block) || upper_wall(block)) { 
				    ring_regular_polygon_sector(r * (cr + 1), (cc + 0.5) * arc_angle , thickness, thickness * 0.75 , sides);
				}  
			}
		}
	}
}

// NO_WALL = 0;       
// UPPER_WALL = 1;    
// RIGHT_WALL = 2;    
// UPPER_RIGHT_WALL = 3; 

function no_wall(block) = get_wall_type(block) == 0;
function upper_wall(block) = get_wall_type(block) == 1;
function right_wall(block) = get_wall_type(block) == 2;
function upper_right_wall(block) = get_wall_type(block) == 3;

function block(x, y, wall_type, visited) = [x, y, wall_type, visited];
function get_x(block) = block[0];
function get_y(block) = block[1];
function get_wall_type(block) = block[2];

// create a starting maze for being visited later.
function starting_maze(rows, columns) =  [
    for(y = [1:rows]) 
        for(x = [1:columns]) 
            block(
                x, y, 
                // all blocks have upper and right walls
                3, 
                // unvisited
                false 
            )
];

// find out the index of a block with the position (x, y)
function indexOf(x, y, maze, i = 0) =
    i > len(maze) ? -1 : (
        [get_x(maze[i]), get_y(maze[i])] == [x, y] ? i : 
            indexOf(x, y, maze, i + 1)
    );

// is (x, y) visited?
function visited(x, y, maze) = maze[indexOf(x, y, maze)][3];

// is (x, y) visitable?
function visitable(x, y, maze, rows, columns) = 
    y > 0 && y <= rows &&     // y bound
    x > 0 && x <= columns &&  // x bound
    !visited(x, y, maze);     // unvisited

// setting (x, y) as being visited
function set_visited(x, y, maze) = [
    for(b = maze) 
        [x, y] == [get_x(b), get_y(b)] ? 
            [x, y, get_wall_type(b), true] : b
];
    
// 0(right)¡B1(upper)¡B2(left)¡B3(down)
function rand_dirs() =
    [
        [0, 1, 2, 3],
        [0, 1, 3, 2],
        [0, 2, 1, 3],
        [0, 2, 3, 1],
        [0, 3, 1, 2],
        [0, 3, 2, 1],
        [1, 0, 2, 3],
        [1, 0, 3, 2],
        [1, 2, 0, 3],
        [1, 2, 3, 0],
        [1, 3, 0, 2],
        [1, 3, 2, 0],
        [2, 0, 1, 3],
        [2, 0, 3, 1],
        [2, 1, 0, 3],
        [2, 1, 3, 0],
        [2, 3, 0, 1],
        [2, 3, 1, 0],
        [3, 0, 1, 2],
        [3, 0, 2, 1],
        [3, 1, 0, 2],
        [3, 1, 2, 0],
        [3, 2, 0, 1],
        [3, 2, 1, 0]
    ][round(rands(0, 24, 1)[0])]; 

// get x value by dir
function next_x(x, dir, columns, circular) = 
    let(nx = x + [1, 0, -1, 0][dir])
    circular ? 
        nx < 1 ? nx + columns : (
            nx > columns ? nx % columns : nx
        )
        :
        nx;
    
// get y value by dir
function next_y(y, dir, rows, circular) = 
    let(ny = y + [0, 1, 0, -1][dir])
    circular ? 
        ny < 1 ? ny + rows : (
            ny > rows ? ny % rows : ny
        )
        :
        ny;
    
// go right and carve the right wall
function go_right_from(x, y, maze) = [
    for(b = maze) [get_x(b), get_y(b)] == [x, y] ? (
        upper_right_wall(b) ? 
            [x, y, 1, visited(x, y, maze)] : 
            [x, y, 0, visited(x, y, maze)]
        
    ) : b
]; 

// go up and carve the upper wall
function go_up_from(x, y, maze) = [
    for(b = maze) [get_x(b), get_y(b)] == [x, y] ? (
        upper_right_wall(b) ? 
            [x, y, 2, visited(x, y, maze)] :  
            [x, y, 0, visited(x, y, maze)]
        
    ) : b
]; 

// go left and carve the right wall of the left block
function go_left_from(x, y, maze, columns) = 
    let(
        x_minus_one = x - 1,
        nx = x_minus_one < 1 ? x_minus_one + columns : x_minus_one
    )
    [
        for(b = maze) [get_x(b), get_y(b)] == [nx, y] ? (
            upper_right_wall(b) ? 
                [nx, y, 1, visited(nx, y, maze)] : 
                [nx, y, 0, visited(nx, y, maze)]
        ) : b
    ]; 

// go down and carve the upper wall of the down block
function go_down_from(x, y, maze, rows) = [
    let(
        y_minus_one = y - 1,
        ny = y_minus_one < 1 ? y_minus_one + rows : y_minus_one
    )
    for(b = maze) [get_x(b), get_y(b)] == [x, ny] ? (
        upper_right_wall(b) ? 
            [x, ny, 2, visited(x, ny, maze)] : 
            [x, ny, 0, visited(x, ny, maze)]
    ) : b
]; 

// 0(right)¡B1(upper)¡B2(left)¡B3(down)
function try_block(dir, x, y, maze, rows, columns) =
    dir == 0 ? go_right_from(x, y, maze) : 
    dir == 1 ? go_up_from(x, y, maze) : 
    dir == 2 ? go_left_from(x, y, maze, columns) : 
    /*dir 3*/  go_down_from(x, y, maze, rows);


// find out visitable dirs from (x, y)
function visitable_dirs_from(x, y, maze, rows, columns, x_circular, y_circular) = [
    for(dir = [0, 1, 2, 3]) 
        if(visitable(next_x(x, dir, columns, x_circular), next_y(y, dir, rows, y_circular), maze, rows, columns)) 
            dir
];  
    
// go maze from (x, y)
function go_maze(x, y, maze, rows, columns, x_circular = false, y_circular = false) = 
    //  have visitable dirs?
    len(visitable_dirs_from(x, y, maze, rows, columns, x_circular, y_circular)) == 0 ? 
        set_visited(x, y, maze)      // road closed
        : walk_around_from(          
            x, y, 
            rand_dirs(),             
            set_visited(x, y, maze), 
            rows, columns,
            x_circular, y_circular
        );

// try four directions
function walk_around_from(x, y, dirs, maze, rows, columns, x_circular, y_circular, i = 4) =
    // all done?
    i > 0 ? 
        // not yet
        walk_around_from(x, y, dirs, 
            // try one direction
            try_routes_from(x, y, dirs[4 - i], maze, rows, columns, x_circular, y_circular),  
            rows, columns, 
            x_circular, y_circular,
            i - 1) 
        : maze;
        
function try_routes_from(x, y, dir, maze, rows, columns, x_circular, y_circular) = 
    // is the dir visitable?
    visitable(next_x(x, dir, columns, x_circular), next_y(y, dir, rows, y_circular), maze, rows, columns) ?     
        // try the block 
        go_maze(
            next_x(x, dir, columns, x_circular), next_y(y, dir, rows, y_circular), 
            try_block(dir, x, y, maze, rows, columns),
            rows, columns,
            x_circular, y_circular
        ) 
        // road closed so return maze directly
        : maze;   

// ==========
module build_square_maze(rows, columns, blocks, block_width, wall_thickness, left_border = true, bottom_border = true) {
    module build_block(block, block_width, wall_thickness) {
        translate([get_x(block) - 1, get_y(block) - 1] * block_width) {
            if(upper_wall(block) || upper_right_wall(block)) {
                // draw a upper wall
                line2d(
                    [0, block_width], [block_width, block_width], wall_thickness
                ); 
            }
            
            if(right_wall(block) || upper_right_wall(block)) {
                // draw a right wall
                line2d(
                    [block_width, block_width], [block_width, 0], wall_thickness
                ); 
            }
        }
    }
    
    for(block = blocks) {
        build_block(
            block, 
            block_width, 
            wall_thickness
        );
    }

    if(left_border) {
        line2d([0, 0], [0, block_width * rows], wall_thickness);
    }

    if(bottom_border) {
        line2d([0, 0], [block_width * columns, 0], wall_thickness);
    }
}         

// ==========

module build_hex_maze(y_cells, x_cells, maze_vector, cell_radius, wall_thickness, left_border = true, bottom_border = true) {
	function cell_position(x_cell, y_cell) =
		let(
			grid_h = 2 * cell_radius * sin(60),
			grid_w = cell_radius + cell_radius * cos(60)
		)
		[grid_w * x_cell, grid_h * y_cell + (x_cell % 2 == 0 ? 0 : grid_h / 2), 0];

    module hex_seg(begin, end) {
		polyline2d(
			[for(a = [begin:60:end]) 
				[cell_radius * cos(a), cell_radius * sin(a)]], 
			wall_thickness,
			startingStyle = "CAP_ROUND", endingStyle = "CAP_ROUND"
		);
	}

	module build_upper_right() { hex_seg(0, 60); }
	module build_upper() { hex_seg(60, 120); }
	module build_upper_left() { hex_seg(120, 180);	}		
	module build_down_left() { hex_seg(180, 240); }
	module build_down() { hex_seg(240, 300); }
	module build_down_right() { hex_seg(300, 360); }	

	module build_cell(block) {
		module build_right_wall(x_cell) {
			if(x_cell % 2 != 0) {
				build_down_right();
			}
			else {
				build_upper_right();
			}
		}

		module build_row_wall(x_cell, y_cell) {
			if(x_cell % 2 != 0) {
				build_upper_right();
				build_upper_left();
			}
			else {
				build_down_right();
			}
		}

		x = get_x(block) - 1;
		y = get_y(block) - 1;

		translate(cell_position(x, y)) {
			build_row_wall(x, y); 

			if(upper_wall(block) || upper_right_wall(block)) {
				build_upper();
			}
			if(right_wall(block) || upper_right_wall(block)) {
				build_right_wall(x);
			}  
		}
		
	}
	
	// create the wall of maze
	for(block = maze_vector) {
		build_cell(block);
	}  

    if(left_border) {
		for(y = [0:y_cells - 1]) {
			translate(cell_position(0, y)) {
				build_upper_left();
				build_down_left();
			}
		}
	}

    if(bottom_border) {
		for(x = [0:x_cells - 1]) {
			translate(cell_position(x, 0)) {
				build_down();
				if(x % 2 == 0) {
					build_down_left();
					build_down_right();
				}
			}
		}	
	}
}

// ==========

function block_walls(block, block_width) = 
    let(
        loc = [get_x(block) - 1, get_y(block) - 1] * block_width,
        upper = upper_wall(block) || upper_right_wall(block) ? [[0, block_width] + loc, [block_width, block_width] + loc] : [],
        right = right_wall(block) || upper_right_wall(block) ? [[block_width, block_width] + loc, [block_width, 0] + loc] : []
    )
    concat(upper, right); 
  
function maze_walls(blocks, rows, columns, block_width, left_border = true, bottom_border = true) = 
    let(
        left_walls = left_border ? [for(y = [0:rows - 1]) [[0, block_width * (y + 1)], [0, block_width * y]]] : [],
        buttom_walls = bottom_border ? [for(x = [0:columns - 1]) [[block_width * x, 0], [block_width * (x + 1), 0]]] : []
    )
     concat(
        [
            for(block = blocks) 
            let(pts = block_walls(block, block_width))
            if(pts != []) pts
        ]
        , left_walls, buttom_walls
    );

// ==========
    
/**
 * The dotSCAD library
 * @copyright Justin Lin, 2017
 * @license https://opensource.org/licenses/lgpl-3.0.html
 *
 * @see https://github.com/JustinSDK/dotSCAD
*/

/**
* line2d.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-line2d.html
*
**/


module line2d(p1, p2, width, p1Style = "CAP_SQUARE", p2Style =  "CAP_SQUARE") {
    half_width = 0.5 * width;    

    atan_angle = atan2(p2[1] - p1[1], p2[0] - p1[0]);
    leng = sqrt(pow(p2[0] - p1[0], 2) + pow(p2[1] - p1[1], 2));

    frags = __nearest_multiple_of_4(__frags(half_width));
        
    module square_end(point) {
        translate(point) 
        rotate(atan_angle) 
            square(width, center = true);

        // hook for testing
        test_line2d_cap(point, "CAP_SQUARE");
    }

    module round_end(point) {
        translate(point) 
        rotate(atan_angle) 
            circle(half_width, $fn = frags);    

        // hook for testing
        test_line2d_cap(point, "CAP_ROUND");                
    }
    
    if(p1Style == "CAP_SQUARE") {
        square_end(p1);
    } else if(p1Style == "CAP_ROUND") {
        round_end(p1);
    }

    translate(p1) 
    rotate(atan_angle) 
    translate([0, -width / 2]) 
        square([leng, width]);
    
    if(p2Style == "CAP_SQUARE") {
        square_end(p2);
    } else if(p2Style == "CAP_ROUND") {
        round_end(p2);
    }

    // hook for testing
    test_line2d_line(atan_angle, leng, width, frags);
}

// override them to test
module test_line2d_cap(point, style) {
}

module test_line2d_line(angle, length, width, frags) {
}



function __frags(radius) = $fn > 0 ? 
            ($fn >= 3 ? $fn : 3) : 
            max(min(360 / $fa, radius * PI * 2 / $fs), 5);

function __nearest_multiple_of_4(n) =
    let(
        remain = n % 4
    )
    (remain / 4) > 0.5 ? n - remain + 4 : n - remain;


/**
* hollow_out.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-hollow_out.html
*
**/

module hollow_out(shell_thickness) {
    difference() {
        children();
        offset(delta = -shell_thickness) children();
    }
}

