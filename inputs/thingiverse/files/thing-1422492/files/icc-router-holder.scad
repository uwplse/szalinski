// Trying to build icc device
// All measurements are in mm
/*
 Original
 Width = 6.5 inch
 Raised = 5.5 inch
 Edge = 0.5 inch
 Depth = 3.0 inch
 Height = 3.9 inch
 Holes = 2.0 inch apart
 Holes = 0.5 inch from edge (front/back)

 6.5 inch = 165.1 mm
 5.5 inch = 139.7 mm
 3.0 inch = 76.2 mm
 1.0 inch = 25.4 mm
 0.5 inch = 12.7 mm

 cube ( width (x), depth (y), height (z) )

*/

// Variables
width = 165.1;
// height=15; // Flat ICC
height = 25.4;
depth = 76.2;
right_offset = width/2;
left_offset = right_offset*-1;
right_hole = right_offset-(12.7/2);
left_hole = right_hole*-1;
hole_radius = 2.5;
stud_radius = 2.5;
stud_depth = 6;
stud_x = 40;
stud_y = 20;
inch = 25.4;
neg_inch = inch*-1;
hole_height = (height/2)*-1;
support_thickness = 2;
hole_depth = support_thickness * 3;
slice_depth = 25.4;
slice_width = 135;
slice_offset = (depth/2);

// Modules

module stud () {
    color("Lime") 
    
    cylinder(h=stud_depth, r=stud_radius, center=true);
    
    translate( [0, 0, hole_depth] )
     cylinder(h=stud_depth, r=stud_radius*2, center=true);
}

module baseframe() {
    
    difference() {
        
           // Base Cube
       cube([ width, depth,  height ], center=true);
        
        // Right Side Support
        translate([ right_offset, 0, support_thickness ])
        cube([ inch, depth+1, height ], center = true);
        
        // Peg 1
        translate([ right_hole, inch, hole_height ])
        cylinder(h=hole_depth, r=hole_radius, center=true);

        // Peg 2
        translate([ right_hole, neg_inch, hole_height ])
        cylinder(h=hole_depth, r=hole_radius, center=true);
        
        // Left Side Support
        translate([ left_offset, 0, support_thickness ]) 
        cube([ inch, depth+1, height ], center = true);
        
        // Peg 1
        translate([ left_hole, inch, hole_height ])
        cylinder(h=hole_depth, r=hole_radius, center=true);

        // Peg 2
        translate([ left_hole, neg_inch, hole_height ])
        cylinder(h=hole_depth, r=hole_radius, center=true);
    }
}
    

// Main

translate([0,0,0]) {
    
    difference() {
        
        // Back Frame
        baseframe();
        
        cube([ width-inch-support_thickness, depth-2,  height-2 ], center=true);
        
        translate([0,0,-20])
       cube([ width-inch-support_thickness, depth-2,  height-2 ], center=true);
        
    }
    
    union() {
        
        // Studs
        translate( [stud_x, stud_y, 15] )
        stud();

        translate( [-stud_x, stud_y, 15] )
        stud();

    }
}





/* END */