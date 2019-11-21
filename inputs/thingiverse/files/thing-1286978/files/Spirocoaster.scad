// Spirocoaster.scad
// Paddy Freer & Michael Barlow
// All units are in mm

num_sides = 8;          // Number of sides on each shape
num_shapes = 15;        // The number of times that each shape is duplicated
coaster_diameter = 80;  // This is the diameter of the entire shape
thickness = 2;          // The thickness of the walls
height = 2;             // Height of entire model
center_hole_diameter=8; // subtracted shape in the middle

outer_radius = coaster_diameter/4;
inner_radius = outer_radius - thickness;
center_hole_radius = center_hole_diameter/2;

$fn=num_sides;
linear_extrude(height)
difference() {
    for(i=[0:num_shapes]){
        position_angle=(i+1)*360/num_shapes;
        rotate([0, 0, 90-position_angle]) translate([0,outer_radius,0]) 
            difference(){
                circle(r=outer_radius);
                circle(r=inner_radius);
            }
    }
    circle(r=center_hole_radius);
}