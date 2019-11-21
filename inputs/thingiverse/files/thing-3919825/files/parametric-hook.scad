// detail level (100=very fine)
$fn=100; 

// the width of the hook (on the build plate)
width = 1.2;

// the height of the hook (on the build plate)
height = 2;

// the length of the straight part
length = 10.0;

// the inside radius of the top part
top_radius = 1.2;

// covered angle of the top part (0 degree is where the straight part ends)
top_angle = 290;

// the inside radius of the bottom part
bottom_radius = 5.0  ;

// covered angle of the bottom part (0 degree is where the straight part ends)
bottom_angle = 270; // 

union() {
    
    translate([-width/2, 0, 0])
        cube([width,length,height]);

    translate([-bottom_radius-width/2, length, 0])
        rotate_extrude(convexity = 10, angle=bottom_angle)
            translate([bottom_radius, 0, 0])
                square([width, height]);


    translate([top_radius+width/2, 0, 0])
    rotate([0,0,180])
        rotate_extrude(convexity = 10, angle=top_angle)
            translate([top_radius, 0, 0])
            square([width, height]);
}
