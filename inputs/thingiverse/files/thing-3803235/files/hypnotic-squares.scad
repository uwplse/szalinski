
x_grids = 12;
y_grids = 5;
grid_size = 15;
final_size = 3;
line_width = 1;
fn = 12;

module hypnotic_squares(x_grids, y_grids, grid_size, final_size, line_width) {
    function random() = rands(0, 1, 1)[0];

    dirs = [-1, 0, 1];
    max_steps = ceil((grid_size - final_size) / (line_width * 2));
    start_steps = 2 + round(random() * (max_steps - 2));
    half_lw = line_width / 2;
    
    module hollow_square(x, y, size) {
        translate([x - half_lw, y - half_lw])  
            hollow_out(line_width) 
                square(size + line_width);
    }

    module draw(x, y, size, xMovement, yMovement, steps) {
        hollow_square(x, y, size);
     
        if(steps >= 0) {
            new_size = (grid_size) * (steps / start_steps) + final_size;

            new_x = x + (size - new_size) / 2;
            new_y = y + (size - new_size) / 2;
            draw(
                new_x - ((x - new_x) / (steps + 3)) * xMovement, 
                new_y - ((y - new_y) / (steps + 3)) * yMovement, 
                new_size, 
                xMovement, 
                yMovement, 
                steps - 1)
            ;
        }
    }

    rand_lt = [for(x = 0; x < x_grids; x = x + 1) 
                  [for(y = 0; y < y_grids; y = y + 1) 
                      [random(), random()]
                  ]
              ];
              
    module grids() {
        translate([0, half_lw]) 
            for(x = [0:x_grids - 1]) {
                for(y = [0:y_grids - 1]) {
                    draw(
                        x * grid_size, 
                        y * grid_size, 
                        grid_size, 
                        dirs[floor(rand_lt[x][y][0] * 3)], 
                        dirs[floor(rand_lt[x][y][1] * 3)],
                        start_steps - 1
                    );
                }
            }    
    }

    bend_extrude(
        size = [grid_size * x_grids, grid_size * y_grids + line_width], 
        thickness = line_width, 
        angle = 360, 
        frags = $fn
    ) grids();
}


hypnotic_squares(x_grids, y_grids, grid_size, final_size, line_width, $fn = fn);

r = (0.5 * grid_size * x_grids / fn) / sin(180 / fn);
box_extrude(
    height = grid_size * y_grids + line_width, 
    shell_thickness  = line_width
) circle(r - line_width / 2, $fn = fn);
    
/**
 * The dotSCAD library
 * @copyright Justin Lin, 2017
 * @license https://opensource.org/licenses/lgpl-3.0.html
 *
 * @see https://github.com/JustinSDK/dotSCAD
*/

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

/**
* bend_extrude.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-bend_extrude.html
*
**/

module bend_extrude(size, thickness, angle, frags = 24) {
    x = size[0];
    y = size[1];
    frag_width = x / frags ;
    frag_angle = angle / frags;
    half_frag_width = 0.5 * frag_width;
    half_frag_angle = 0.5 * frag_angle;
    r = half_frag_width / sin(half_frag_angle);
    s =  (r - thickness) / r;
    
    module get_frag(i) {
        offsetX = i * frag_width;
        linear_extrude(thickness, scale = [s, 1]) 
            translate([-offsetX - half_frag_width, 0, 0]) 
                intersection() {
                    translate([x, 0, 0]) mirror([1, 0, 0]) children();
                    translate([offsetX, 0, 0]) 
                        square([frag_width, y]);
                }
    }

    offsetY = -r * cos(half_frag_angle) ;

    rotate(angle - 90)
        mirror([0, 1, 0])
            mirror([0, 0, 1])
                for(i = [0 : frags - 1]) {
                rotate(i * frag_angle + half_frag_angle) 
                        translate([0, offsetY, 0])
                            rotate([-90, 0, 0]) 
                                get_frag(i) 
                                    children();  
                }
}


/**
* box_extrude.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-box_extrude.html
*
**/

module box_extrude(height, shell_thickness, offset_mode = "delta", chamfer = false) {
    linear_extrude(shell_thickness)
        children();
        
    linear_extrude(height) 
        difference() {
            children();
            if(offset_mode == "delta") {
                offset(delta = -shell_thickness, chamfer = chamfer) 
                    children(); 
            } else {
                offset(r = -shell_thickness) 
                    children(); 
            } 
        }    
}

    

