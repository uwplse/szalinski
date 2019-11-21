// AM8 Z frame alignment jig
tolerance = 0.2;    // makes up for tolerance in print thickness

// distance from rear of printer to rear of Z frame
// 127mm for standard AM8 design
magic_distance = 127;

// main bracket thickness
thickness = 3;
// height of 'ridge' in center of bracket above thickness
ridge_height = 2;
// height of "hook" on end of bracket above thickness
hook_height = 5;


difference() {
    union() {
        // base
        linear_extrude(height=thickness)
            polygon([[-10,0],[-10,(magic_distance-30)],[-30,(magic_distance-10)],[-30,magic_distance],[30,magic_distance],[30,(magic_distance-10)],[10,(magic_distance-30)],[10,0]]);
        // ridge
        ridge_width = 6-tolerance;
        linear_extrude(height=ridge_height+thickness)
            polygon([[-ridge_width/2,20+tolerance],[-ridge_width/2,magic_distance-20],[ridge_width/2,magic_distance-20],[ridge_width/2,20+tolerance]]);
        linear_extrude(height=thickness+hook_height)
            polygon([[-10,0],[-10,-4],[10,-4],[10,0]]);
    }
    
    translate([0,10,-0.1]) cylinder(d=5.5,h=thickness+0.2);
    translate([0,magic_distance-10,-0.1]) cylinder(d=5.5,h=thickness+0.2);
    
}

