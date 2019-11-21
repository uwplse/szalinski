//translate([54.7, -78, -280.02]) import("Corner.stl");
//translate([435.9305, -329.8393, 0]) import("100_Straight.stl");

// Type of piece
piece_type = "Corner"; // [Edge, Corner]
// Depth of the slot (original=9.8, 1/2"=12.7mm)
inner_depth = 12.7;
// Width of the slot (original=4, 0.093"=2.3622mm)
inner_width = 2.3622;
// Thickness of the walls around the slot (original=1.4, preferred=2)
wall_thickness = 2;
// Height (or length) of the piece (original Edge=100, default Corner=26.5)
height = 25.4;
// Radius of the chamfered edges (original=5)
corner_radius = 5;
// Adjust higher to make inner triangular supports wider (original=1, preferred=3)
triangle_multiplier = 3;
// Adjust higher to made the corner area (between the slots) wider (original=0, preferred=3)
additional_corner = 3;

total_thickness = inner_width + 2 * wall_thickness;
total_offset = total_thickness-corner_radius;

adj_corner_radius = corner_radius > total_thickness ? total_thickness : corner_radius;

//color([1,0,0])
translate([0-(inner_depth+total_thickness+additional_corner), 0-total_thickness, 0])
if (piece_type == "Edge") {
    chamfered_edge_piece(inner_depth, inner_width, height, wall_thickness, adj_corner_radius, triangle_multiplier, additional_corner, 0);
}
else {
    chamfered_corner_piece(inner_depth, inner_width, height, wall_thickness, adj_corner_radius, triangle_multiplier, additional_corner);
}

module chamfered_corner_piece(inner_depth, inner_width, height, wall_thickness, corner_radius, triangle_multiplier, additional_corner) {
    extra = corner_radius - total_thickness < 0 ? 0 : corner_radius - total_thickness;
    triangle_cutoff = 1;
    
    translate([total_thickness+inner_depth-corner_radius+additional_corner, total_thickness-corner_radius, corner_radius])
    difference() {
        sphere(r=corner_radius, $fn=50);
        translate([-corner_radius, -corner_radius*2, -corner_radius])
        cube(size = [corner_radius*2, corner_radius*2, corner_radius*2]);
        translate([-corner_radius, -corner_radius, 0])
        cube(size = [corner_radius*2, corner_radius*2, corner_radius*2]);
        translate([-corner_radius*2, -corner_radius, -corner_radius])
        cube(size = [corner_radius*2, corner_radius*2, corner_radius*2]);
        
        translate([-corner_radius+extra, -wall_thickness, -extra])
        cube(size = [corner_radius, corner_radius, corner_radius]);
        translate([-wall_thickness, -corner_radius+extra, -extra])
        cube(size = [corner_radius, corner_radius, corner_radius]);
        translate([-corner_radius+extra, -corner_radius+extra, -corner_radius+wall_thickness])
        cube(size = [corner_radius, corner_radius, corner_radius]);
    }
    
    union() {
        translate([0, 0, corner_radius])
        chamfered_edge_piece(inner_depth, inner_width, height+additional_corner, wall_thickness, corner_radius, triangle_multiplier, additional_corner, triangle_cutoff);
        
        rotate(a=90, v=[1,0,0])
        rotate(a=-90, v=[0,0,1])
        translate([-(inner_depth+total_thickness+additional_corner), inner_depth+additional_corner, -total_thickness+corner_radius])
        chamfered_edge_piece(inner_depth, inner_width, height+additional_corner, wall_thickness, corner_radius, triangle_multiplier, additional_corner, triangle_cutoff);
        
        mirror([1, 0, 0])
        rotate(a=90, v=[0,1,0])
        translate([-(inner_depth+total_thickness+additional_corner), 0, -(inner_depth+total_thickness)+corner_radius-additional_corner])
        chamfered_edge_piece(inner_depth, inner_width, height+additional_corner, wall_thickness, corner_radius, triangle_multiplier, additional_corner, triangle_cutoff);
        
    }
}

module chamfered_edge_piece(inner_depth, inner_width, height, wall_thickness, corner_radius, triangle_multiplier, additional_corner, triangle_cutoff) {
    total_thickness = inner_width + 2 * wall_thickness;
    difference()
    {
        edge_piece(inner_depth, inner_width, height, wall_thickness, triangle_multiplier, additional_corner, triangle_cutoff);
        chamfer_edge(inner_depth, inner_width, height, wall_thickness, corner_radius, additional_corner);
    }
}

module chamfer_edge(inner_depth, inner_width, height, wall_thickness, corner_radius, additional_corner) {
    //translate([0-corner_radius+0.01, 0-corner_radius, 0])
    total_thickness = inner_width + 2 * wall_thickness;
    translate([(inner_depth+total_thickness-corner_radius+additional_corner)+0.01, total_thickness - corner_radius, 0])
    difference() {
        difference() {
            cube([corner_radius, corner_radius, height]);
            cylinder(r=corner_radius,h=height, $fn=50);
            translate([-corner_radius*2, 0, 0]) cube([corner_radius*2, corner_radius*2, height+1]);
            translate([-corner_radius, -corner_radius*2, 0]) cube([corner_radius*2, corner_radius*2, height+1]);
        }
    }

}

module triangle(triangle_height, triangle_x, triangle_y) {
    linear_extrude(height = triangle_height)
    polygon(
        [[0,0],    // Triangle side
        [triangle_x,0],
        [triangle_x,triangle_y]],
        [[0,1,2]]
    );
}

module edge_piece(inner_depth, inner_width, height, wall_thickness, triangle_multiplier, additional_corner, triangle_cutoff) {
    total_thickness = inner_width + (2 * wall_thickness);
    triangle_edge = wall_thickness*triangle_multiplier;
    overall_depth = inner_depth + total_thickness + additional_corner;
    straight(inner_depth, inner_width, height, wall_thickness, additional_corner);
    rotate(a=90, v=[0,0,1])
    translate([0-inner_depth-additional_corner, 0-overall_depth, 0]) straight(inner_depth, inner_width, height, wall_thickness, additional_corner);
    rotate(a=90, v=[0,0,1])
    translate([-triangle_edge, -(inner_depth + additional_corner), triangle_cutoff])
    triangle(height-triangle_cutoff, triangle_edge, triangle_edge);
}

module straight(inner_depth, inner_width, height, wall_thickness, additional_corner) {
    total_thickness = inner_width + (2 * wall_thickness);
    overall_depth = inner_depth + total_thickness + additional_corner;
    difference () {
        cube([overall_depth, total_thickness, height]);
        translate([-1, wall_thickness, -1])
        cube([inner_depth+1, inner_width, height+2]);
    }
}