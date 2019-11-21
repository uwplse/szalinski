//!OpenSCAD

height = 24;
bottom_radius = 35/2;
top_radius = 13/2;
screw_hole = 5/2;
screw_head = 12/2;
thickness = 6;

difference() {
    cylinder(height, top_radius, bottom_radius);
    cylinder(height*3, r=screw_hole, center=true);
    translate([0, 0, thickness])
    cylinder(height, r=screw_head);
    
    //translate([-bottom_radius, -bottom_radius, 0])
    //cube([bottom_radius, bottom_radius*2, height]);
}