wall_height = 1;
wall_thickness = 1;

cylinder_radius = 10;
cylinder_height = 8;

vertical_blocks = 5;
horizontal_blocks = 25;



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


 

function PI() = 3.14159;

module a_quarter_arc(radius, angle, width = 1) {
    outer = radius + width;
    intersection() {
        difference() {
            offset(r = width) circle(radius, $fn=96); 
            circle(radius, $fn=96);
        }
        polygon([[0, 0], [outer, 0], [outer, outer * sin(angle)], [outer * cos(angle), outer * sin(angle)]]);
    }
}

module arc(radius, angles, width = 1) {
    angle_from = angles[0];
    angle_to = angles[1];
    angle_difference = angle_to - angle_from;
    outer = radius + width;
    rotate(angle_from)
        if(angle_difference <= 90) {
            a_quarter_arc(radius, angle_difference, width);
        } else if(angle_difference > 90 && angle_difference <= 180) {
            arc(radius, [0, 90], width);
            rotate(90) a_quarter_arc(radius, angle_difference - 90, width);
        } else if(angle_difference > 180 && angle_difference <= 270) {
            arc(radius, [0, 180], width);
            rotate(180) a_quarter_arc(radius, angle_difference - 180, width);
        } else if(angle_difference > 270 && angle_difference <= 360) {
            arc(radius, [0, 270], width);
            rotate(270) a_quarter_arc(radius, angle_difference - 270, width);
       }
}

module horizontal_wall(radius, angle_from, length, thickness = 1, height = 1) {
    angle_difference = 180 * length / (PI() * radius);
    angle_to = angle_from + angle_difference;
    linear_extrude(thickness) arc(radius, [angle_from, angle_to], height);
}

module vertical_wall(radius, angle_from, length, thickness = 1, height = 1) {
     translate([0, 0, thickness]) mirror([0, 0, 1]) horizontal_wall(radius, angle_from, thickness, length + thickness, height);
}

module maze_cylinder(cylinder_r_h, blocks_v_h, maze_vector, wall_thickness = 1, wall_height = 1) {
    cylinder_r = cylinder_r_h[0];
    cylinder_h = cylinder_r_h[1];
    v_blocks = blocks_v_h[0];
    h_blocks = blocks_v_h[1];
    
    step_angle = 360 / h_blocks;
    
    horizontal_wall_length = 2 * PI() * cylinder_r / h_blocks;
    vertical_wall_length = cylinder_h / v_blocks;
    
    vertical_wall_angle = wall_thickness * 180 / (PI() * cylinder_r);
    
    for(vi = [0:len(maze_vector) - 1]) {
        cord = maze_vector[vi];
        i = cord[0] - 1;
        j = cord[1] - 1;
        v = cord[3];
        
        if(v == 1 || v == 3) {
            translate([0, 0, -j * vertical_wall_length]) 
                horizontal_wall(cylinder_r, i * step_angle, horizontal_wall_length, wall_thickness, wall_height);
        }
        if(v == 2 || v == 3) {
            translate([0, 0, -j * vertical_wall_length]) 
                vertical_wall(cylinder_r, i * step_angle + step_angle - vertical_wall_angle, vertical_wall_length, wall_thickness, wall_height);
        }
    } 
    
    translate([0, 0, -cylinder_h])
         horizontal_wall(cylinder_r, 0, 2 * PI() * cylinder_r, wall_thickness, wall_height);
     
     translate([0, 0, -cylinder_h]) cylinder(h=cylinder_h + wall_thickness, r=cylinder_r, $fn=96);
}

module maze_ring(cylinder_r_h, blocks_v_h, wall_thickness = 1, wall_height = 1) {
    maze_vector = go_maze(1, 1, vertical_blocks, horizontal_blocks, replace([horizontal_blocks, 1, 0, UP_RIGHT_WALL()], [horizontal_blocks, 1, 0, UP_WALL()], init_maze(vertical_blocks, horizontal_blocks)));
    
    cylinder_r = cylinder_r_h[0];
    cylinder_h = cylinder_r_h[1];    

    difference() {
        maze_cylinder([cylinder_radius, cylinder_height], [vertical_blocks, horizontal_blocks], maze_vector, wall_thickness, wall_height);
        
        translate([0, 0, -cylinder_h - wall_thickness]) 
            cylinder(h=cylinder_h + wall_thickness * 3, r=cylinder_r - wall_height / 2, $fn=96);
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



maze_ring([cylinder_radius, cylinder_height], [vertical_blocks, horizontal_blocks], wall_thickness, wall_height);
