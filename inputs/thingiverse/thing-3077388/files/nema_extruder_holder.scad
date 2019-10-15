// smoother circles
$fn = 90;

// height of the base
base_h = 5;

// radius of the small screw holes in the base and the wall (m3)
small_hole_d = 2;

// radius of the hole in the base for the head of the screw (m3)
big_hole_d = 3.2;

// width and length of the empty space for the nema motor.
// 42.5 is a snug fit.
base_size = 42.5;

// width of the vertical walls. Adjust according to the length of the screws you plan to use to tighten the nema motor in place.
vert_wall_w = 2.75;

// distance between the holes of the screws holding the motor
nema_holes_dist = 31;

// hole for the motor axle
nema_big_hole = 11.5;

vert_wall_l = base_size + 2*vert_wall_w;
vert_wall_h = base_size + base_h;

difference() {
    union() {
        cube([base_size, vert_wall_w, base_size + base_h]);
        
        translate([0, vert_wall_l - vert_wall_w, 0])
        cube([base_size, vert_wall_w, base_size + base_h]);
    }
 
    translate([0, -0.1, base_size + base_h])
    rotate( [-90, 0, 0] ) 
    cylinder( h = vert_wall_l + 0.2, r = base_size );   

}

module vertical_hole(r) {
    rotate( [0, 90, 0] ) 
            cylinder( h = vert_wall_w +0.2, r = r );
}

translate([base_size, 0, 0]) {
    difference() {
        cube( [ vert_wall_w, vert_wall_l, vert_wall_h ]) ;
        
        translate([-0.1, vert_wall_l/2 - nema_holes_dist/2, vert_wall_h - 5])
            vertical_hole(small_hole_d);
        
        translate([-0.1, vert_wall_l/2 + nema_holes_dist/2, vert_wall_h - 5])
            vertical_hole(small_hole_d);
        
        translate([-0.1, vert_wall_l/2 - nema_holes_dist/2, vert_wall_h - 5 - nema_holes_dist ])
            vertical_hole(small_hole_d);
        
        translate([-0.1, vert_wall_l/2 + nema_holes_dist/2, vert_wall_h - 5 - nema_holes_dist ])
            vertical_hole(small_hole_d);
        
        translate([-0.1, vert_wall_l/2, vert_wall_h - 5 - nema_holes_dist/2 ])
            vertical_hole(nema_big_hole);
    }
}

translate([ 42.5 + 2.75, 30, 0])
union() {
    //add missing material between z axis cover and base
    translate([-(42.5 + 2.75 - base_size), -8, 0])
        cube([42.5 + 2.75 - base_size, 16, 0.75 * base_h ]);
    cylinder( h = 0.75 * base_h, r = 8);
}

module base_hole() {
    union() {
        translate([0, 0 , base_h - 2.5])
            cylinder( h = base_h - 2.5 + 0.1, r = big_hole_d );
        translate([0, 0 , -0.1])
            cylinder( h = base_h + 0.2, r = small_hole_d );
    }
}

// base
difference() {
    cube([base_size , vert_wall_l, base_h]);
    
    hole_diff_y = 14;
    hole_diff_x = 24;
    
    first_x = 5;
    first_y = 7.25 + vert_wall_w;
    
    translate([first_x, first_y, 0])
        base_hole();
    
    translate([first_x + hole_diff_x, first_y + hole_diff_y, 0])
        base_hole();
}