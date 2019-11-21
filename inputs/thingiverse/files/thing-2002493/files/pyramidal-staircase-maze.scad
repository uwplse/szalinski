maze_rows = 8;
block_width = 10;
stairs_width = 5;

// draw a line between point [x1, y1] and [x2, y2].
module line(point1, point2, width = 1, cap_round = true) {
    angle = 90 - atan((point2[1] - point1[1]) / (point2[0] - point1[0]));
    offset_x = 0.5 * width * cos(angle);
    offset_y = 0.5 * width * sin(angle);

    offset1 = [-offset_x, offset_y];
    offset2 = [offset_x, -offset_y];

    if(cap_round) {
        translate(point1) rotate(45) circle(d = width * sqrt(2), $fn = 4);
        translate(point2) rotate(45) circle(d = width * sqrt(2), $fn = 4);
    }

    polygon(points=[
        point1 + offset1, point2 + offset1,  
        point2 + offset2, point1 + offset2
    ]);
}

// Constants for wall types

NO_WALL = 0;       
UPPER_WALL = 1;    
RIGHT_WALL = 2;    
UPPER_RIGHT_WALL = 3; 

function block_data(x, y, wall_type, visited) = [x, y, wall_type, visited];
function get_x(block_data) = block_data[0];
function get_y(block_data) = block_data[1];
function get_wall_type(block_data) = block_data[2];

module draw_block(wall_type, block_width, wall_thickness) {
    if(wall_type == UPPER_WALL || wall_type == UPPER_RIGHT_WALL) {
        // draw a upper wall
        line(
            [0, block_width], [block_width, block_width], wall_thickness
        ); 
    }
    
    if(wall_type == RIGHT_WALL || wall_type == UPPER_RIGHT_WALL) {
        // draw a right wall
        line(
            [block_width, block_width], [block_width, 0], wall_thickness
        ); 
    }
}

module draw_maze(rows, columns, blocks, block_width, wall_thickness) {
    for(block = blocks) {
        // move a block to a right position.
        translate([get_x(block) - 1, get_y(block) - 1] * block_width) 
            draw_block(
                get_wall_type(block), 
                block_width, 
                wall_thickness
            );
    }

    // the lowermost wall
    line([0, 0], [block_width * columns, 0], 
         wall_thickness);
    // the leftmost wall
    line([0, block_width], [0, block_width * rows], 
         wall_thickness);
} 

// create a starting maze for being visited later.
function starting_maze(rows, columns) =  [
    for(y = [1:rows]) 
        for(x = [1:columns]) 
            block_data(
                x, y, 
                // all blocks have upper and right walls except the exit
                y == rows && x == columns ? UPPER_WALL : UPPER_RIGHT_WALL, 
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
    
// 0（right）、1（upper）、2（left）、3（down）
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
function next_x(x, dir) = x + [1, 0, -1, 0][dir];
// get y value by dir
function next_y(y, dir) = y + [0, 1, 0, -1][dir];

// go right and carve the right wall
function go_right_from(x, y, maze) = [
    for(b = maze) [get_x(b), get_y(b)] == [x, y] ? (
        get_wall_type(b) == UPPER_RIGHT_WALL ? 
            [x, y, UPPER_WALL, visited(x, y, maze)] : 
            [x, y, NO_WALL, visited(x, y, maze)]
        
    ) : b
]; 

// go up and carve the upper wall
function go_up_from(x, y, maze) = [
    for(b = maze) [get_x(b), get_y(b)] == [x, y] ? (
        get_wall_type(b) == UPPER_RIGHT_WALL ? 
            [x, y, RIGHT_WALL, visited(x, y, maze)] :  
            [x, y, NO_WALL, visited(x, y, maze)]
        
    ) : b
]; 

// go left and carve the right wall of the left block
function go_left_from(x, y, maze) = [
    for(b = maze) [get_x(b), get_y(b)] == [x - 1, y] ? (
        get_wall_type(b) == UPPER_RIGHT_WALL ? 
            [x - 1, y, UPPER_WALL, visited(x - 1, y, maze)] : 
            [x - 1, y, NO_WALL, visited(x - 1, y, maze)]
    ) : b
]; 

// go down and carve the upper wall of the down block
function go_down_from(x, y, maze) = [
    for(b = maze) [get_x(b), get_y(b)] == [x, y - 1] ? (
        get_wall_type(b) == UPPER_RIGHT_WALL ? 
            [x, y - 1, RIGHT_WALL, visited(x, y - 1, maze)] : 
            [x, y - 1, NO_WALL, visited(x, y - 1, maze)]
    ) : b
]; 

// 0（right）、1（upper）、2（left）、3（down）
function try_block(dir, x, y, maze, rows, columns) =
    dir == 0 ? go_right_from(x, y, maze) : (
        dir == 1 ? go_up_from(x, y, maze) : (
            dir == 2 ? go_left_from(x, y, maze) : 
                 go_down_from(x, y, maze)   // 這時 dir 一定是 3
            
        ) 
    );


// find out visitable dirs from (x, y)
function visitable_dirs_from(x, y, maze, rows, columns) = [
    for(dir = [0, 1, 2, 3]) 
        if(visitable(next_x(x, dir), next_y(y, dir), maze, maze_rows, columns)) 
            dir
];  
    
// go maze from (x, y)
function go_maze(x, y, maze, rows, columns) = 
    //  have visitable dirs?
    len(visitable_dirs_from(x, y, maze, rows, columns)) == 0 ? 
        set_visited(x, y, maze)      // road closed
        : walk_around_from(          
            x, y, 
            rand_dirs(),             
            set_visited(x, y, maze), 
            rows, columns
        );

// try four directions
function walk_around_from(x, y, dirs, maze, rows, columns, i = 4) =
    // all done?
    i > 0 ? 
        // not yet
        walk_around_from(x, y, dirs, 
            // try one direction
            try_routes_from(x, y, dirs[4 - i], maze, rows, columns),  
            , rows, columns, 
            i - 1) 
        : maze;
        
function try_routes_from(x, y, dir, maze, rows, columns) = 
    // is the dir visitable?
    visitable(next_x(x, dir), next_y(y, dir), maze, rows, columns) ?     
        // try the block 
        go_maze(
            next_x(x, dir), next_y(y, dir), 
            try_block(dir, x, y, maze, rows, columns),
            rows, columns
        ) 
        // road closed so return maze directly
        : maze;   

module pyramid_with_stairs(base_width, stairs_width, rows) {
    height = base_width * sqrt(2) / 2;

    module floor(i) {
        base_w = base_width - (base_width / rows) * (i - 1) + stairs_width;
        floor_h = height / rows * 2;
                
        stairsteps = rows;
        staircase_h = floor_h / stairsteps;
        staircase_w = stairs_width / stairsteps * 2;
        
        translate([0, 0, floor_h / 2 * (i - 1)]) 
            for(j = [1:stairsteps]) {
                square_w = base_w - j * staircase_w;
                translate([0, 0, staircase_h * (j - 1)])  
                    linear_extrude(staircase_h) 
                        square([square_w, square_w], center = true);
            }
    }
    
    for(i = [1:2:rows - 1]) {
        floor(i);
    }
}

module pyramidal_staircase_maze(maze_rows, block_width, stairs_width) {
    maze_blocks = go_maze(
        1, 1,   // starting point
        starting_maze(maze_rows, maze_rows),  
        maze_rows, maze_rows
    ); 
    
    intersection() {
        pyramid_with_stairs(
            maze_rows * block_width, stairs_width, maze_rows);

        linear_extrude(maze_rows * block_width * sqrt(2) / 2)  difference() {
            
            square([block_width * maze_rows + stairs_width, block_width * maze_rows + stairs_width], center = true);
            
            translate([-(maze_rows * block_width) / 2, -(maze_rows * block_width) / 2, 0]) 

            
            draw_maze(
                maze_rows, 
                maze_rows, 
                maze_blocks, 
                block_width, 
                stairs_width
            );
        }
    }
}

pyramidal_staircase_maze(maze_rows, block_width, stairs_width);