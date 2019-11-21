// Base square size
square_size = 50;  //[1:100]

// Outer radius
outer_rad = 10; // [1:100]

// Loop iterations - This value times 4 = number of "corners"
iterations = 1;  // [1,2,3,4,5,6,7,8,9]

// Which direction to twist?
which_twists = 1; // [1:positive, 2:negative, 3:both]

// Degrees of twist
twist_deg = 90; // [0:720]

// Base shell thickness
base_shell_thickness = 3; // [0.5:10]

// Height
vase_h = 120; // [1:300]

// Floor thickness
floor_thickness = 10; // [0:300]

// Flare / taper
scale_factor = 1; // [0,0.25,0.5,0.75,1,1.25,1.5,1.75,2]

// Smoothness
smoothness = 18; // [4:36]
$fn = smoothness;

inner_rad = outer_rad - base_shell_thickness;

module base_solid() {
    if ((which_twists == 1) || (which_twists == 3)) {
        linear_extrude(height = vase_h, twist = twist_deg, slices = 60, scale = scale_factor) {
            offset(r = outer_rad) {
                for (i = [0 : iterations - 1]) {
                    rotate([0,0,(i - 1) * 90/iterations]) square(square_size, center = true);
                }
            }
        }
    }
    
    if ((which_twists == 2) || (which_twists == 3)) {
        linear_extrude(height = vase_h, twist = -1 * twist_deg, slices = 60, scale = scale_factor) {
            offset(r = outer_rad) {
                for (i = [0 : iterations - 1]) {
                    rotate([0,0,(i - 1) * 90/iterations]) square(square_size, center = true);
                }
            }
        }
    }
}

module negative_space() {
    difference() {
        union(){
            if ((which_twists == 1) || (which_twists == 3)) {
                linear_extrude(height = vase_h + 0.001, twist = twist_deg, slices = 60, scale = scale_factor) {
                    offset(r = inner_rad) {
                        for (i = [0 : iterations - 1]) {
                            rotate([0,0,(i - 1) * 90/iterations]) square(square_size, center = true);
                        }
                    }
                }
            }
            
            if ((which_twists == 2) || (which_twists == 3)) {
                linear_extrude(height = vase_h + 0.001, twist = twist_deg * -1, slices = 60, scale = scale_factor) {
                    offset(r = inner_rad) {
                        for (i = [0 : iterations - 1]) {
                            rotate([0,0,(i - 1) * 90/iterations]) square(square_size, center = true);
                        }
                    }   
                }
            }
        }
        cube([(square_size + outer_rad) * 2, (square_size + outer_rad)* 2, floor_thickness * 2], center = true);
    }
}


difference(){
    base_solid();
    negative_space();
}


