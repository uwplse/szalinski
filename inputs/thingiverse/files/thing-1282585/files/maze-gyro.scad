radius = 20; 

spacing = 0.6;

wall_height = 1;
wall_thickness = 1.5;
cblocks = 25; 
rblocks = 4;

ring = "YES";

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


module x_line(point, length, thickness = 1) {
    offset = thickness / 2;
    translate([point[0] - offset, point[1] - offset, 0]) 
        square([length + thickness, thickness]);
}

module circle_maze(radius, cblocks, rblocks, thickness = 1) {
    full_circle_angle = 360;
    arc_angle = full_circle_angle / cblocks;
	length_rblock = radius / rblocks ;
	rows = rblocks - 2;
	
	maze = go_maze(1, 1, cblocks, rows, replace([rows, cblocks, 0, UP_RIGHT_WALL()], [rows, cblocks, 0, UP_WALL()], init_maze(cblocks, rows)));
	
	// inner circle
	rotate([0, 0, 180]) 
	    arc(length_rblock, [0, full_circle_angle - arc_angle], thickness);		
		
	rotate([0, 0, 315]) 	
	    x_line([length_rblock + thickness / 2, 0], length_rblock, thickness); 
		
	rotate([0, 0, arc_angle]) 
	    arc(length_rblock * 2, [0, full_circle_angle - arc_angle], thickness);
	
	// maze
    for(i = [0:len(maze) - 1]) { 
        cord = maze[i];
		cr = cord[0] + 2; 
		cc = cord[1] - 1;
        v = cord[3];
        
        if(v == 1 || v == 3) {
		    rotate([0, 0, cc * arc_angle])
                x_line([(cr - 1)* length_rblock + thickness / 2, 0], length_rblock, thickness); 
        }
        if(v == 2 || v == 3) {
		    rotate([0, 0, cc * arc_angle])
		        arc(cr * length_rblock, [0, arc_angle + 0.01], thickness);
        } 
		
		if(v == 0 || v == 1) {
		    r1 = length_rblock * 2;
			r2 = cr * length_rblock;
		    rotate([0, 0, cc * arc_angle])
		        arc(cr * length_rblock, [0, arc_angle * (r2 - r1) / r2], thickness);
		}
    }  	
}

module hollow_sphere(radius, thickness = 1) {
    difference() {
	    sphere(radius + thickness, $fn = 96);
        sphere(radius, $fn = 96);
	}
}

// a gyro base. Its height is equals to `radius`.
module gyro_base(radius) {
    double_radius = radius * 2;
	half_height = radius / 3;
	difference() {
		sphere(radius, $fn = 96);
		translate([0, 0, -radius - half_height]) 
		    cube(double_radius, center = true);
		translate([0, 0, radius + half_height]) 
		    cube(double_radius, center = true);
	}
}

// create mazes on two sides of the gyro base
module gyro_base_with_mazes(radius, cblocks, rblocks, wall_height = 1, wall_thickness = 1) {
    height = radius * 2 / 3;  

    r = sqrt(pow(radius, 2) - pow(height / 2, 2));
	

	difference() {
	    gyro_base(radius);
		
		translate([0, 0, height / 2 - wall_height])     
		    linear_extrude(wall_height) 
		         circle(r, $fn = 96);
				 
	    translate([0, 0, -height / 2])     
		    linear_extrude(wall_height) 
		         circle(r, $fn = 96);
	}
	
    translate([0, 0, height / 2 - wall_height]) 
        linear_extrude(wall_height) 
            circle_maze(r - wall_thickness, cblocks, rblocks, wall_thickness); 

    translate([0, 0, -height / 2 - wall_thickness / 2 + wall_height]) 
        linear_extrude(wall_height) 
            circle_maze(r - wall_thickness, cblocks, rblocks, wall_thickness); 
}

// use hollow spheres to cut out a space between each gyro circle
module maze_gyro(radius, cblocks, rblocks, ring = "YES", spacing = 0.6, wall_height = 1, wall_thickness = 1) {
    height = radius * 2 / 3;
    r = sqrt(pow(radius, 2) - pow(wall_height, 2));
	one_half_wall_thickness = 1.5 * wall_thickness;
    length_rblock = (r - one_half_wall_thickness) / rblocks;
	
	difference() {
		gyro_base_with_mazes(radius, cblocks, rblocks, wall_height, wall_thickness);
		
		for(i = [2 : rblocks]) { 
			r_hollow_sphere = sqrt(pow(length_rblock * (i - 1) + spacing * (rblocks - i + 3), 2) + pow(height / 2, 2));
			hollow_sphere(r_hollow_sphere, spacing);
		}
	}
	
	// ring
	if(ring == "YES") {
	    difference() {
	        translate([radius, 0, -height / 8]) rotate([0, 0, -90]) 
	            linear_extrude(height / 4) arc(length_rblock, [0, 360], height / 8);
			gyro_base(radius);
	    }
	}
}

maze_gyro(radius, cblocks, rblocks, ring, spacing, wall_height, wall_thickness);





