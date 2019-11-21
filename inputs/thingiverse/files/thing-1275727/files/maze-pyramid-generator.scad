side_length = 50; 
wall_thickness = 1;
wall_height = 2; 

cblocks = 9;  
levels = 5; 

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

// give a [x, y] point and length. draw a line in the x direction
module x_line(point, length, thickness = 1) {
    offset = thickness / 2;
    translate([point[0] - offset, point[1] - offset, 0]) 
        square([length + thickness, thickness]);
}

// create a equilateral triangle
module equilateral_triangle(side_length, center = false) {
    radius = 0.57735026918962576450914878050196 * side_length;
	circle(r = radius, center = center, $fn = 3); 
}

// create a holly equilateral triangle
module holly_equilateral_triangle(side_length, thickness = 1, center = true) {
    difference() {
	    offset(delta = thickness) equilateral_triangle(side_length, center = center);
	    equilateral_triangle(side_length, center = center);
    }
}

// Given a side length of a equilateral triangle, return the length of incenter to vertex.
function triangle_incenter_to_vertex_length(triangle_side_length) = 0.57735026918962576450914878050196 * triangle_side_length;

// used by `sector_cutter` module. Accepted angle is from 0 to 90 degree.
module a_quarter_sector_cutter(radius, angle) {
    outer = radius;
    polygon([[0, 0], [outer, 0], [outer, outer * sin(angle)], [outer * cos(angle), outer * sin(angle)]]);
}

// userd by `holly_equilateral_triangle_sector` for difference
module sector_cutter(radius, angles) {
    angle_from = angles[0];
    angle_to = angles[1];
    angle_difference = angle_to - angle_from;
    
    rotate(angle_from)
        if(angle_difference <= 90) {
            a_quarter_sector_cutter(radius, angle_difference);
        } else if(angle_difference > 90 && angle_difference <= 180) {
            sector_cutter(radius, [0, 90]);
            rotate(90) a_quarter_sector_cutter(radius, angle_difference - 90);
        } else if(angle_difference > 180 && angle_difference <= 270) {
            sector_cutter(radius, [0, 180]);
            rotate(180) a_quarter_sector_cutter(radius, angle_difference - 180);
        } else if(angle_difference > 270 && angle_difference <= 360) {
            sector_cutter(radius, [0, 270]);
            rotate(270) a_quarter_sector_cutter(radius, angle_difference - 270);
       }
}

// For a triangle, a different angle has a different length from incenter to its side.
function triangle_incenter_to_side_length(incenter_to_vertex_length, angle) = 
    (angle >= 0 && angle <= 60) ? 0.5 * incenter_to_vertex_length / cos(angle) : (
	    (angle > 60 && angle <= 120) ? triangle_incenter_to_side_length(incenter_to_vertex_length, 120 - angle) : triangle_incenter_to_side_length(incenter_to_vertex_length, angle - 120)
	);

// draw a line from incenter to side for a equilateral triangle
module triangle_incenter_to_side_line(side_length, angle, incenter_to_side_blocks, level, thickness = 1) {
    block_length = triangle_incenter_to_side_length(triangle_incenter_to_vertex_length(side_length), angle + 60) / incenter_to_side_blocks ;
	
	rotate([0, 0, angle]) 
	    translate([block_length * (level - 1) + thickness, 0, 0])
		    x_line([0, 0], block_length - thickness / 2, thickness);
}

// draw a side between `angles[0]` and `angles[1]`
module holly_equilateral_triangle_sector(side_length, angles, thickness = 1) {
	intersection() {
        holly_equilateral_triangle(side_length, thickness);
	    sector_cutter(triangle_incenter_to_vertex_length(side_length) + thickness * 2, [angles[0], angles[1]]);
	}
}

module triangle_maze(side_length, cblocks, levels, thickness = 1) {
    full_circle_angle = 360;
    arc_angle = full_circle_angle / cblocks;
	incenter_to_side_blocks = levels - 2;
	
	divided_side_length = side_length / levels;
	
	maze = go_maze(1, 1, cblocks, incenter_to_side_blocks, replace([incenter_to_side_blocks, cblocks, 0, UP_RIGHT_WALL()], [incenter_to_side_blocks, cblocks, 0, UP_WALL()], init_maze(cblocks, incenter_to_side_blocks)));
	  
	// maze
    for(i = [0:len(maze) - 1]) { 
        cord = maze[i];
		cr = cord[0]; 
		cc = cord[1] - 1;    
        v = cord[3];
        
		angle = cc * arc_angle;
		
        if(v == 1 || v == 3) {
			triangle_incenter_to_side_line(side_length, angle, levels, cr + 2, thickness);
        } 
		
        if(v == 2 || v == 3) {
		    sl = divided_side_length * (cr + 2);
			offset_angle = angle - arc_angle / 18;
			
			holly_equilateral_triangle_sector(sl, [offset_angle,  offset_angle + arc_angle], thickness);   
        } 
		
		if(v == 0 || v == 1) {
		    sl = divided_side_length * (cr + 2);		
			factor = abs((arc_angle * (cc + 1)) % 120 - 60) / 60; 
			offset_angle = angle - arc_angle / 18;
			
			holly_equilateral_triangle_sector(sl, [offset_angle, offset_angle + arc_angle * (sl - divided_side_length + factor) / (sl - factor * (cr + 2))], thickness);    
		}		
	}
	
	// inner triangle
	rotate([0, 0, 240]) 
		holly_equilateral_triangle_sector(divided_side_length, [-45, 315 - arc_angle], thickness);
	
	triangle_incenter_to_side_line(side_length, 300, levels, 2, thickness = 1);

	holly_equilateral_triangle_sector(divided_side_length * 2, [arc_angle / 4, 360], thickness);
}

// a maze triangle, but with two doors near two vertices 
module triangle_maze_for_pyramid(side_length, cblocks, levels, wall_thickness = 1) {
	arc_angle = 360 / cblocks;
	divided_side_length = side_length / levels;

	offset_angle = arc_angle - arc_angle * (side_length - divided_side_length + 1) / (side_length - levels + 2);
	
	difference() {		
		triangle_maze(side_length, cblocks, levels, wall_thickness);
		holly_equilateral_triangle_sector(side_length, [120, 120 + offset_angle + 0.5], wall_thickness);
		holly_equilateral_triangle_sector(side_length, [360 - offset_angle, 360], wall_thickness);
	}
}

// a maze triangle with two doors and tilted 54.5 degrees, for matching one side of a pyramid
module tilted_triangle_maze_for_pyramid(side_length, cblocks, levels, wall_height, wall_thickness = 1) {
	incenter_to_vertex_length = triangle_incenter_to_vertex_length(side_length);
	offset = incenter_to_vertex_length / 2 + wall_thickness;
	offset_angle = 54.5;
	
	translate([0, - side_length / 2 - wall_thickness * 1.6, 0]) 
	    rotate([offset_angle, 0, 0]) 
		    translate([0, offset , 0]) 
			    rotate([0, 0, 210]) 
				    linear_extrude(wall_height) 
		                triangle_maze_for_pyramid(side_length, cblocks, levels, wall_thickness);
}

// tilted triangle mazes facing each other
module two_rotated_triangle_mazes_for_pyramid(side_length, cblocks, levels, wall_height, wall_thickness = 1) {
	tilted_triangle_maze_for_pyramid(side_length, cblocks, levels, wall_height, wall_thickness);
	mirror([0, 1, 0]) 
	    tilted_triangle_maze_for_pyramid(side_length, cblocks, levels, wall_height, wall_thickness);
}

module maze_pyramid(side_length, cblocks, levels, wall_height, wall_thickness = 1) {
	incenter_to_vertex_length = triangle_incenter_to_vertex_length(side_length);

	l = 0.78 * side_length;

	rotate([0, 0, 45]) 
	    cylinder(r1 = l, r2 = 0, h = l, $fn = 4);

	two_rotated_triangle_mazes_for_pyramid(side_length, cblocks, levels, wall_height, wall_thickness);

	rotate([0, 0, 90]) 
	    two_rotated_triangle_mazes_for_pyramid(side_length, cblocks, levels, wall_height, wall_thickness);
}


maze_pyramid(side_length, cblocks, levels, wall_height, wall_thickness);

if(ring == "YES") {
	translate([0, 0, 0]) rotate([90, 0, 0]) rotate_extrude(convexity = 10, $fn = 48)
		translate([side_length / 8, 0, 0])
			circle(r = side_length / 22, $fn = 48);
}