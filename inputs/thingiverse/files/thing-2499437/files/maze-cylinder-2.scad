radius = 40; 
height = 80;
block_width = 8;

wall_thickness = 5;
wall_height = 5;
wall_top_scale = 0.25;

shell_thickness = 2;
fn = 24;
bottom_included = "YES"; // [YES, NO]

/**
* hollow_out.scad
*
* Hollows out a 2D object. 
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

/**
* bend.scad
*
* Bends a 3D object into an arc shape. 
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-bend.html
*
**/ 


module bend(size, angle, frags = 24) {
    x = size[0];
    y = size[1];
    z = size[2];
    frag_width = x / frags;
    frag_angle = angle / frags;
    half_frag_width = 0.5 * frag_width;
    half_frag_angle = 0.5 * frag_angle;
    r = half_frag_width / sin(half_frag_angle);
    h = r * cos(half_frag_angle);
    
    tri_frag_pts = [
        [0, 0], 
        [half_frag_width, h], 
        [frag_width, 0], 
        [0, 0]
    ];

    module triangle_frag() {
        translate([0, -z, 0]) 
            linear_extrude(y) 
                polygon(tri_frag_pts);    
    }
    
    module get_frag(i) {
        translate([-frag_width * i - half_frag_width, -h + z, 0]) 
            intersection() {
                translate([frag_width * i, 0, 0]) 
                    triangle_frag();
                rotate([90, 0, 0]) 
                    children();
            }
    }

    for(i = [0 : frags - 1]) {
        rotate(i * frag_angle + half_frag_angle) 
            get_frag(i) 
                children();  
    }

    // hook for testing
    test_bend_tri_frag(tri_frag_pts, frag_angle);
}

// override it to test
module test_bend_tri_frag(points, angle) {

}

module line(point1, point2, width = 1, height = 1, top_scale = 0.25) {
    angle = 90 - atan((point2[1] - point1[1]) / (point2[0] - point1[0]));
    offset_x = 0.5 * width * cos(angle);
    offset_y = 0.5 * width * sin(angle);

    offset1 = [-offset_x, offset_y];
    offset2 = [offset_x, -offset_y];

    hull() {
        translate(point1) 
            linear_extrude(height, scale = top_scale) 
                square(width, center = true);
        translate(point2) 
            linear_extrude(height, scale = top_scale) 
                square(width, center = true);
    }
}

module polyline(points, width = 1, height = 1, top_scale = 0.25) {
    module polyline_inner(points, index) {
        if(index < len(points)) {
            line(points[index - 1], points[index], width, height, top_scale);
            polyline_inner(points, index + 1);
        }
    }

    polyline_inner(points, 1);
}

// 牆面常數

NO_WALL = 0;       // 無牆
UP_WALL = 1;       // 上牆
RIGHT_WALL = 2;    // 右牆
UP_RIGHT_WALL = 3; // 都有

function block_data(x, y, wall_type, visited) = [x, y, wall_type, visited];
function get_x(block_data) = block_data[0];
function get_y(block_data) = block_data[1];
function get_wall_type(block_data) = block_data[2];

module draw_block(wall_type, block_width, wall_thickness, wall_height, wall_top_scale) {
    if(wall_type == UP_WALL || wall_type == UP_RIGHT_WALL) {
        polyline(
            [[0, block_width], [block_width, block_width]], wall_thickness, wall_height, wall_top_scale
        ); 
    }

    if(wall_type == RIGHT_WALL || wall_type == UP_RIGHT_WALL) {
        polyline(
            [[block_width, block_width], [block_width, 0]], wall_thickness, wall_height, wall_top_scale
        ); 
    }
}

module draw_maze(rows, columns, blocks, block_width, wall_thickness, wall_height, wall_top_scale) {
    for(block = blocks) {
        translate([get_x(block) - 1, get_y(block) - 1] * block_width) 
            draw_block(
                get_wall_type(block), 
                block_width, 
                wall_thickness,
                wall_height,
                wall_top_scale
            );
    }

    polyline(
        [[0, 0], [block_width * columns, 0]], 
        wall_thickness, wall_height, wall_top_scale);
    
    polyline(
        [[0, 0], [0, block_width * (rows - 1)]], 
        wall_thickness, wall_height, wall_top_scale);
} 

   
function starting_maze(rows, columns) =  [
    for(y = [1:rows]) 
        for(x = [1:columns]) 
            block_data(
                x, y, 
                y == rows && x == columns ? UP_WALL : UP_RIGHT_WALL, 
                false 
            )
];

function indexOf(x, y, maze, i = 0) =
    i > len(maze) ? -1 : (
        [get_x(maze[i]), get_y(maze[i])] == [x, y] ? i : 
            indexOf(x, y, maze, i + 1)
    );

function visited(x, y, maze) = maze[indexOf(x, y, maze)][3];

function visitable(x, y, maze, rows, columns) = 
    y > 0 && y <= rows &&     
    x > 0 && x <= columns &&  
    !visited(x, y, maze);     

function set_visited(x, y, maze) = [
    for(b = maze) 
        [x, y] == [get_x(b), get_y(b)] ? 
            [x, y, get_wall_type(b), true] : b
];

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

function next_x(x, dir) = x + [1, 0, -1, 0][dir];

function next_y(y, dir) = y + [0, 1, 0, -1][dir];

function go_right_from(x, y, maze) = [
    for(b = maze) [get_x(b), get_y(b)] == [x, y] ? (
        get_wall_type(b) == UP_RIGHT_WALL ? 
            [x, y, UP_WALL, visited(x, y, maze)] : 
            [x, y, NO_WALL, visited(x, y, maze)]

    ) : b
]; 

function go_up_from(x, y, maze) = [
    for(b = maze) [get_x(b), get_y(b)] == [x, y] ? (
        get_wall_type(b) == UP_RIGHT_WALL ? 
            [x, y, RIGHT_WALL, visited(x, y, maze)] :  
            [x, y, NO_WALL, visited(x, y, maze)]

    ) : b
]; 

function go_left_from(x, y, maze) = [
    for(b = maze) [get_x(b), get_y(b)] == [x - 1, y] ? (
        get_wall_type(b) == UP_RIGHT_WALL ? 
            [x - 1, y, UP_WALL, visited(x - 1, y, maze)] : 
            [x - 1, y, NO_WALL, visited(x - 1, y, maze)]
    ) : b
]; 

function go_down_from(x, y, maze) = [
    for(b = maze) [get_x(b), get_y(b)] == [x, y - 1] ? (
        get_wall_type(b) == UP_RIGHT_WALL ? 
            [x, y - 1, RIGHT_WALL, visited(x, y - 1, maze)] : 
            [x, y - 1, NO_WALL, visited(x, y - 1, maze)]
    ) : b
]; 

function try_block(dir, x, y, maze, rows, columns) =
    dir == 0 ? go_right_from(x, y, maze) : (
        dir == 1 ? go_up_from(x, y, maze) : (
            dir == 2 ? go_left_from(x, y, maze) : 
                 go_down_from(x, y, maze)   

        ) 
    );


function visitable_dirs_from(x, y, maze, rows, columns) = [
    for(dir = [0, 1, 2, 3]) 
        if(visitable(next_x(x, dir), next_y(y, dir), maze, rows, columns)) 
            dir
];  

function go_maze(x, y, maze, rows, columns) = 
    len(visitable_dirs_from(x, y, maze, rows, columns)) == 0 ? 
        set_visited(x, y, maze)     
        : walk_around_from(          
            x, y, 
            rand_dirs(),            
            set_visited(x, y, maze), 
            rows, columns
        );

function walk_around_from(x, y, dirs, maze, rows, columns, i = 4) =
    i > 0 ? 
        walk_around_from(x, y, dirs, 
            try_routes_from(x, y, dirs[4 - i], maze, rows, columns),  
            , rows, columns, 
            i - 1) 
        : maze;

function try_routes_from(x, y, dir, maze, rows, columns) = 
    visitable(next_x(x, dir), next_y(y, dir), maze, rows, columns) ?     
        go_maze(
            next_x(x, dir), next_y(y, dir), 
            try_block(dir, x, y, maze, rows, columns),
            rows, columns
        ) 
        
        : maze;

module maze_cylinder() {
    maze_rows = round(height / block_width);
    maze_columns = round(2 * 3.14159 * radius / block_width);

    maze_blocks = go_maze(
        1, maze_rows,   
        starting_maze(maze_rows, maze_columns),  
        maze_rows, maze_columns 
    );

    union() {
        bend(size = [block_width * maze_columns, block_width * maze_rows + wall_thickness, wall_height], angle = 360, frags = fn) 
        translate([0, wall_thickness / 2, 0]) draw_maze(
            maze_rows, 
            maze_columns, 
            maze_blocks, 
            block_width, 
            wall_thickness,
            wall_height,
            wall_top_scale
        );

        linear_extrude(maze_rows * block_width + wall_thickness) 
            hollow_out(shell_thickness = shell_thickness) 
                circle(radius - wall_height + 0.5, $fn = fn);
        if(bottom_included == "YES") {
            linear_extrude(shell_thickness) 
                circle(radius - wall_height, $fn = fn);
        }
    }
}

maze_cylinder();
