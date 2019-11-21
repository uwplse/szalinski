maze_rows = 5;
block_width = 40;
wall_width = 20;
wall_height = 2.5;
shadow = "YES"; //[YES, NO]
line_steps = 8;

/* [Hidden] */

NO_WALL = 0;    
UPPER_WALL = 1; 
RIGHT_WALL = 2; 
UPPER_RIGHT_WALL = 3;

function cartesian_to_polar(xy) = 
    [
        sqrt(xy[0] * xy[0] + xy[1] * xy[1]), 
        atan2(xy[1], xy[0])
    ];

function spherical_to_cartesian(r_theta_phi) = 
    [
        r_theta_phi[0] * cos(r_theta_phi[2]) * cos(r_theta_phi[1]), 
        r_theta_phi[0] * cos(r_theta_phi[2]) * sin(r_theta_phi[1]), 
        r_theta_phi[0] * sin(r_theta_phi[2])
    ];

function stereographic_projection_polar_to_spherical(r, polar) = 
    [
        2 * r * sin(atan2(polar[0], (r * 2))),
        polar[1],
        atan2(polar[0], (r * 2))
    ];

function stereographic_projection_xy_to_xyz(r, xy) =
    spherical_to_cartesian(
        stereographic_projection_polar_to_spherical(
            r, cartesian_to_polar(xy)
        )
    );

function cube_line_pts(xs, ys, height) = concat(
    [for(i = [0:3]) [xs[i], ys[i], 0]], 
    [for(i = [0:3]) [xs[i], ys[i], height]]
);

function horizontal_line_pts(p, length, width, height, offset) = 
    cube_line_pts(
        [
            p[0], p[0] + length, 
            p[0] + length, p[0]
        ], 
        [ 
            p[1] - offset, p[1] - offset, p[1] - offset + width , 
            p[1] - offset + width
        ], 
        height
    );

function vertical_line_pts(p, length, width, height, offset) = 
    cube_line_pts(
        [
            p[0] - offset, p[0] - offset + width , 
            p[0] - offset + width, p[0] - offset
        ], 
        [ 
            p[1], p[1], p[1] + length, 
            p[1] + length
        ],
        height
    );
    
function block_data(x, y, wall_type, visited) = [x, y, wall_type, visited];
function get_x(block_data) = block_data[0];
function get_y(block_data) = block_data[1];
function get_wall_type(block_data) = block_data[2];

// create a starting maze for being visited later.
function starting_maze(rows, columns) =  [
    for(y = [1:rows]) 
        for(x = [1:columns]) 
            block_data(
                x, y, 
                // all blocks have upper and right walls except the exit
                UPPER_RIGHT_WALL, 
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
    

module draw_block(wall_type, block_width, wall_thickness, wall_height, line_steps) {

    cubefaces = [
      [0,1,2,3],  
      [4,5,1,0],  
      [7,6,5,4],  
      [5,6,2,1],  
      [6,7,3,2],  
      [7,4,0,3]   
    ];
    
    leng = (block_width + wall_thickness) / line_steps;
    
    function upper_wall_pts_lt(hpts) = [
        for(i = [0:line_steps - 1]) [
            for(hp = hpts) hp + [leng * i, 0, 0]
        ]
    ];
    
    function right_wall_pts_lt(vpts) = [
        for(i = [0:line_steps - 1]) [
            for(vp = vpts) vp + [0, leng * i, 0]
        ]
    ]; 

    if(wall_type == UPPER_WALL || wall_type == UPPER_RIGHT_WALL) {
        // draw a upper wall
        hpts = horizontal_line_pts(
        [-wall_thickness / 2, block_width], leng, wall_thickness, wall_height, wall_thickness / 2);
        
        
        for(i = [0:line_steps - 1]) {            
            polyhedron([
                for(hp = hpts) hp + [leng * i, 0, 0]
            ], cubefaces);
        }

    }
    
    if(wall_type == RIGHT_WALL || wall_type == UPPER_RIGHT_WALL) {
        // draw a right wall
        vpts = vertical_line_pts(
        [block_width, -wall_thickness / 2], leng, wall_thickness, wall_height, wall_thickness / 2);
        
        for(i = [0:line_steps - 1]) {
            polyhedron([
                for(vp = vpts) vp + [0, leng * i, 0]
            ], cubefaces);
        }
    }
} 

module draw_stereographic_projection_block(sphere_r, tranlt_pt, wall_type, block_width, wall_thickness, wall_height, line_steps) {
    cubefaces = [
      [0,1,2,3],  
      [4,5,1,0],  
      [7,6,5,4],  
      [5,6,2,1],  
      [6,7,3,2],  
      [7,4,0,3]   
    ];
    
     leng = (block_width + wall_thickness) / line_steps;
     
    face_offset = 0.1;
    
    if(wall_type == UPPER_WALL || wall_type == UPPER_RIGHT_WALL) {
        hpts = horizontal_line_pts(
        [-wall_thickness / 2, block_width], leng, wall_thickness, wall_height, wall_thickness / 2);

        for(i = [0:line_steps - 1]) {        
            inner1 = [
                for(j = [0:3]) 
                    stereographic_projection_xy_to_xyz(sphere_r - wall_height, hpts[j] + [leng * i, 0, 0] + tranlt_pt) +
                    [0, 0, wall_height]
            ];
            inner2 = [
                for(j = [0:3]) 
                    stereographic_projection_xy_to_xyz(sphere_r - wall_height + face_offset, hpts[j] + [leng * i, 0, 0] + tranlt_pt) +
                    [0, 0, wall_height]
            ];
            
           
            outer1 = [for(j = [0:3]) stereographic_projection_xy_to_xyz(sphere_r - face_offset, hpts[j] + [leng * i, 0, 0] + tranlt_pt)];
            outer2 = [for(j = [0:3]) stereographic_projection_xy_to_xyz(sphere_r, hpts[j] + [leng * i, 0, 0] + tranlt_pt)];
            
            hull() {
                polyhedron(concat(inner2, inner1), cubefaces);
                polyhedron(concat(outer2, outer1), cubefaces);
            }
        }
    }
    
    if(wall_type == RIGHT_WALL || wall_type == UPPER_RIGHT_WALL) {
        vpts = vertical_line_pts(
        [block_width, -wall_thickness / 2], leng, wall_thickness, wall_height, wall_thickness / 2);
       
        for(i = [0:line_steps - 1]) {
            inner1 = [
                for(j = [0:3]) 
                    stereographic_projection_xy_to_xyz(sphere_r - wall_height, vpts[j] + [0, leng * i, 0] + tranlt_pt) +
                    [0, 0, wall_height]
            ];
            
            inner2 = [
                for(j = [0:3]) 
                    stereographic_projection_xy_to_xyz(sphere_r - wall_height + face_offset, vpts[j] + [0, leng * i, 0] + tranlt_pt) +
                    [0, 0, wall_height]
            ];
            
            outer1 = [for(j = [0:3]) stereographic_projection_xy_to_xyz(sphere_r - face_offset, vpts[j] + [0, leng * i, 0] + tranlt_pt)]; 
            outer2 = [for(j = [0:3]) stereographic_projection_xy_to_xyz(sphere_r, vpts[j] + [0, leng * i, 0] + tranlt_pt)]; 
            
            hull() {
                polyhedron(concat(inner2, inner1), cubefaces);
                polyhedron(concat(outer2, outer1), cubefaces);
            }
        }
    }    
} 

module draw_stereographic_projection_maze(rows, columns, blocks, block_width, wall_thickness, wall_height, line_steps) {
    sphere_r = block_width * rows / 6;
    for(block = blocks) {
        draw_stereographic_projection_block(
            sphere_r,
            [get_x(block) - 1 - columns / 2, get_y(block) - 1 - rows / 2, 0] * block_width,
            get_wall_type(block), 
            block_width, 
            wall_thickness,
            wall_height, 
            line_steps
        );
    }
} 

module draw_maze(rows, columns, blocks, block_width, wall_thickness, wall_height, line_steps) {
    
    for(block = blocks) {
        // move a block to a right position.
        translate([get_x(block) - 1 - columns / 2, get_y(block) - 1 - rows / 2] * block_width) 
            draw_block(
                get_wall_type(block), 
                block_width, 
                wall_thickness,
                wall_height, 
                line_steps
            );
    }
} 

// create a starting maze for being visited later.
function starting_maze(rows, columns) =  [
    for(y = [1:rows]) 
        for(x = [1:columns]) 
            block_data(
                x, y, 
                UPPER_RIGHT_WALL, 
                false 
            )
];


function append_left_down_walls(rows, columns, blocks) = concat(
        concat(
            blocks, 
            [for(r = [1:rows]) block_data(0, r, RIGHT_WALL, true)]
        ), 
        [for(c = [1:columns]) block_data(c, 0, UPPER_WALL, true)]
    );

module main() {
    maze_blocks = append_left_down_walls(maze_rows, maze_rows, go_maze(
        1, 1,  
        starting_maze(maze_rows, maze_rows),  
        maze_rows, maze_rows
    ));
    
    draw_stereographic_projection_maze(    
        maze_rows, 
        maze_rows, 
        maze_blocks, 
        block_width, 
        wall_width,
        wall_height, 
        line_steps 
    );

    if(shadow == "YES") {
        color("black") draw_maze(
            maze_rows, 
            maze_rows, 
            maze_blocks, 
            block_width, 
            wall_width,
            wall_height, 
            1
        );
    }
}

main();