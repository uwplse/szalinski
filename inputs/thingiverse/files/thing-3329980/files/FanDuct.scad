/* [Fan Connection] */
// Extra space on x/y
tolerance = 0;
// x dimension of the fan air out
fan_size_x = 15;
// y dimension of the fan air out
fan_size_y = 20;
// how long to make the fan box connector section
box_length = 15;
/* [Other] */
// the z distance to be used in making the curve of the blower
curve_z = 5;
// outer wall thickness
shell_thickness = 1.5;
// 90 degree points straight at hot end, 0 points straight down
curve_angle = 60;
// x dimension of the blower opening
blower_x = 5;
// y dimension of the blower opening
blower_y = 40;
// how long to make the blower section
blower_l = 15;

size_x = tolerance + fan_size_x;
size_y = tolerance + fan_size_y;

// This makes the bend section
module bend(extra_angle = 0){
    intersection(){
        rotate_extrude(){
            translate([(size_x / 2) + curve_z,0,0] ){
                square([size_x, size_y], center = true);
            }
        }

        // tan(angle) = x_step/50
        // x_step = tan(angle) * 50
        linear_extrude(size_y, center = true){
            polygon(points=[[0, 50],[tan(curve_angle + extra_angle) * 50, 50], [0, 0]]);
        }
    }
}

// This makes the blower (air out)
module blower(){
    hull(){
        translate([0, -0.5, 0]){
            cube([size_x, 1, size_y], center = true);
        }
//        translate([(size_x / 2) - (blower_x / 2),-blower_l,0]){
        translate([0,-blower_l,0]){
            cube([blower_x, 1, blower_y], center = true);
        }
    }
}

// This creates base shape (box for fan, bend and blower) 
module inner_section(){
    translate([-box_length / 2, size_x / 2 + curve_z, 0]){
        cube([box_length, size_x, size_y], center = true);
    }
    bend();
    rotate(a = (90 - curve_angle), v = [0,0,1]){
        translate([((size_x - shell_thickness/4) / 2) + curve_z, 0.1, 0]){
            blower();
        }
    }
}

// This creates a hollow shell with openings at either end
module duct(){
    difference(){
        // create hollow shell
        minkowski(){
            inner_section();
            sphere(shell_thickness);
        }
        inner_section();
        
        // cut openings
        translate([-3 -box_length, 0, 0]){cube([6, 50, 50], center = true);}
        rotate(a = (90 - curve_angle), v = [0,0,1]){
            translate([(size_x / 2) + blower_x * 3,-blower_l - 3,0]){
                cube([blower_x * 6, 6, blower_y * 2], center = true);
            }
        }
    }
}

difference(){
    duct();
    // cut out to fit against fan
    translate([-size_x/2 - 7, curve_z + size_y/2, -shell_thickness-4]){
        rotate(v=[1,0,0], a=90){
            linear_extrude(size_x * 2, center = true){
                minkowski(){
                    square(12, center = true);
                    circle(5);
                }
            }
        }
    }
    // cut out for guide slot
    translate([-box_length/2 + 1, curve_z + size_x/2, size_y/2 + shell_thickness]){
        cube([box_length - 4, 5, 8], center = true);
    }
}