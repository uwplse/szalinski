// the most important setting: your t-stop type
// type 1: top panel and the side are level with each other; type 2: top panel protrude out front and not level with side panel as seen on the Anet A8 printer
t_corner_type = 1;

// other customizable values
// thickness of printer's top panel (not the t-stop), == top cavity width
printer_top_thickness = 8;
// same as thickness is a good default. lower to reduce material/print time and higher to add stability
t_corner_top_cavity_depth = 8;
// width of printer's side panel (not the t-stop), == side cavity width
printer_side_thickness = 8;
// same as thickness is a good default. lower to reduce material/print time and higher to add stability
t_corner_side_cavity_depth = 8;
// thickness of t-stop wall
wall_thickness = 3;
// overall size of the t-stop. normally double the thickness should be enough but you can increase size to add stability
t_corner_size = 16;
// 0.3 should be a good default for tolerance
tolerance = 0.3;

// function to calculate the base of a right triangle.
// we'll use this function to calculate how much we have to translate the cube that will cut
// into the left side of t-stop body
function right_tri_base(side1, side2)
    = sqrt(side1 * side1 + side2 * side2);

// function to calculate leg of a right triangle.
function right_tri_side(other_side, base)
    = sqrt(base * base - other_side * other_side);

// extrude a polygon from yz plane to the x axis
module polygon_yz_extrude(i_points, i_height) {
    rotate([90, 0, 90])
    linear_extrude(height = i_height, twist = 0, center = false, convexity = 0, slices = 10, scale = 1.0)
    polygon(i_points);
}

// extrude a polygon from xz plane to the y axis
module polygon_xz_extrude(i_points, i_height) {
    translate([0, i_height, 0])
    rotate([90, 0, 0])
    linear_extrude(height = i_height, twist = 0, center = false, convexity = 0, slices = 10, scale = 1.0)
    polygon(i_points);
}

if (t_corner_type == 1) {
    // auto-generate values
    t_corner_width = (t_corner_size * 2) + printer_side_thickness;
    t_corner_height = t_corner_size + t_corner_top_cavity_depth;
    t_corner_depth = printer_top_thickness + (wall_thickness * 2);
    
    difference() {
        // create t-stop body
        cube([t_corner_width, t_corner_depth, t_corner_height]);
        // cut into the body from the top to create top cavity
        translate([0, wall_thickness, t_corner_height - t_corner_top_cavity_depth])
            cube([t_corner_width, printer_top_thickness + tolerance, t_corner_top_cavity_depth]);
        // cut into the body from the front to create side cavity
        translate([t_corner_size, 0, 0])
            cube([printer_side_thickness + tolerance, t_corner_side_cavity_depth + wall_thickness + tolerance * 2, t_corner_height]);
        
        // cut into the left side at an angle to save material and make it look better
        polygon_xz_extrude([[0, 0], [0, t_corner_height - t_corner_top_cavity_depth - wall_thickness], [t_corner_size - wall_thickness, 0]], t_corner_width);
        // cut into the right side at an angle to save material and make it look better
        polygon_xz_extrude([[t_corner_width, 0], [t_corner_width - t_corner_size + wall_thickness, 0], [t_corner_width, t_corner_size - wall_thickness]], t_corner_width);
    }
}
else if (t_corner_type == 2) {
    // auto-generate values
    t_corner_width = (t_corner_size * 2) + printer_side_thickness;
    t_corner_height = t_corner_size + t_corner_top_cavity_depth;
    t_corner_depth = printer_top_thickness + wall_thickness  + printer_side_thickness;
    
    difference() {
        // create t-stop body
        cube([t_corner_width, t_corner_depth, t_corner_height]);
        // cut into the body from the top to create top cavity
        translate([0, printer_side_thickness, t_corner_height - t_corner_top_cavity_depth])
            cube([t_corner_width, printer_top_thickness + tolerance, t_corner_top_cavity_depth]);
        // cut into the body from the front to create side cavity
        translate([t_corner_size, 0, 0])
            cube([printer_side_thickness + tolerance, t_corner_side_cavity_depth + tolerance, t_corner_height]);
        
        // cut into the left side at an angle to save material and make it look better
        polygon_xz_extrude([[0, 0], [0, t_corner_height - t_corner_top_cavity_depth - wall_thickness], [t_corner_size - wall_thickness, 0]], t_corner_width);
        // cut into the right side at an angle to save material and make it look better
        polygon_xz_extrude([[t_corner_width, 0], [t_corner_width - t_corner_size + wall_thickness, 0], [t_corner_width, t_corner_size - wall_thickness]], t_corner_width);
        
        // cut the right side to save material and make it look better
        translate([t_corner_width, 0, 0])
            rotate([0, 0, 90])
            linear_extrude(height = t_corner_height, twist = 0, center = false, convexity = 0, slices = 10, scale = 1.0)
            polygon([[0, 0], [0, t_corner_size - wall_thickness], [t_corner_side_cavity_depth - wall_thickness, 0]]);
        // cut the left side to save material and make it look better
        linear_extrude(height = t_corner_height, twist = 0, center = false, convexity = 0, slices = 10, scale = 1.0)
            polygon([[0, 0], [t_corner_size - wall_thickness, 0], [0, t_corner_side_cavity_depth - wall_thickness]]);
            
        // cut a slope at the back to save material and make it look better
        polygon_yz_extrude([[t_corner_depth + tolerance, 0], [t_corner_side_cavity_depth + wall_thickness * 2, 0], [t_corner_depth, t_corner_height - t_corner_top_cavity_depth - wall_thickness]], t_corner_width);
    }
}
