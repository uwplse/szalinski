//random maze generator with back
//Mark G. Peeters added back and commnents 1-12-16
//http://www.thingiverse.com/thing:1264082
//Original work by JustinSDK
//https://www.thingiverse.com/thing:1185425
//preview[view:south, tilt:top]
//Y direction
rows = 7;
//x direction
columns = 7;

wall_thickness = 7;
wall_height = 8;
block_width = 8;
base_thickness=5;
fillet_radius = 3.5;

/*hidden*/
echo("maze size X=",columns*block_width+wall_thickness);
echo("maze size Y=",rows*block_width+wall_thickness);
echo("maze path width=",block_width-wall_thickness);

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
    y_line([rows * block_width, 0], columns * block_width, wall_thickness);
    y_line([0, 0], (rows - 1) * block_width, wall_thickness);
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

// give a index (exclusivly), slice a vector 
function head_to(i, vs) =
    i >= len(vs) ? vs : (
        i == 0 ? [] : concat(head_to(i - 1, vs), [vs[i - 1]])
    );

// give a index (exclusivly), slice a vector 
function tail_from(i, vs, index = 0, new_vs = []) =
    i >= len(vs) ? [] : (
        index < i ? tail_from(i, vs, index + 1) : (
            index < len(vs) ? tail_from(i, vs, index + 1, concat(new_vs, [vs[index]])) : new_vs
        )
    );

// replace v1 in the vector with v2 
function replace(v1, v2, vs, index = 0) =
    index == len(vs) ? vs : (
        vs[index] == v1 ? concat(concat(head_to(index, vs), [v2]), tail_from(index + 1, vs)) : replace(v1, v2, vs, index + 1)
    );
    
/* 
 * functions for generating a maze vector
 *
 */

// initialize rows of a maze
function init_row(n, length) =
    length == 0 ? [] : concat(init_row(n, length - 1), [[length, n, 0, UP_RIGHT_WALL()]]);
    
// initialize a maze
function init_maze(rows, columns) =
    rows == 0 ? [] : concat(init_maze(rows - 1, columns), init_row(rows, columns));
    
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

module maze_half(rows, columns, maze_vector, block_width = 5, wall_thickness = 1) {
        
    difference() {
    /*

        union() {
            linear_extrude(wall_height)
            maze(rows, columns, maze_vector, block_width, wall_thickness);
            translate([-wall_thickness/2,-wall_thickness/2,0])
            cube([
                columns*block_width+wall_thickness,
                rows*block_width+wall_thickness,
                base_thickness
            ]);
        }

                    
    */
        difference() {
            translate([-wall_thickness/2,-wall_thickness/2,0])
            cube([
                columns*block_width+wall_thickness,
                rows*block_width+wall_thickness,
                wall_height+(fillet_radius*0.95)
            ]);
            minkowski() {
                difference() {
                    translate([-wall_thickness/2,-wall_thickness/2,0])
                    cube([
                        columns*block_width+wall_thickness,
                        rows*block_width+wall_thickness,
                        wall_height
                    ]);
                    union() {
                        linear_extrude(wall_height)
                        maze(rows, columns, maze_vector, block_width, wall_thickness);
                        translate([-wall_thickness/2,-wall_thickness/2,0])
                        cube([
                            columns*block_width+wall_thickness,
                            rows*block_width+wall_thickness,
                            base_thickness
                        ]);
                    }            
                };
                sphere(r=fillet_radius, $fa=15, $fs=0.1);
            };
        };

        translate([wall_thickness/2,wall_thickness/2,-wall_height/2])
            cylinder(h=wall_height, r=fillet_radius, $fa=15, $fs=0.1);
        translate([(columns-1)*block_width+wall_thickness/2,(rows-1)*block_width+wall_thickness/2,-wall_height/2])
            cylinder(h=wall_height, r=fillet_radius, $fa=15, $fs=0.1);
    }
}
 

union() {
    maze_half(rows, columns, 
        go_maze(
            1, 
            1, 
            rows, 
            columns, 
            replace(
                [columns, rows, 0, UP_RIGHT_WALL()], 
                [columns, rows, 0, UP_WALL()], 
                init_maze(rows, columns)
            )
        ), 
        block_width, 
        wall_thickness);
    scale([1,1,-1]) translate([0,0,0.1])
    maze_half(rows, columns, 
        go_maze(
            1, 
            1, 
            rows, 
            columns, 
            replace(
                [columns, rows, 0, UP_RIGHT_WALL()], 
                [columns, rows, 0, UP_WALL()], 
                init_maze(rows, columns)
            )
        ), 
        block_width, 
        wall_thickness);

}