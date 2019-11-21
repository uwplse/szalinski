// Inside diameter of the pipe
inner_diameter = 98.5;
// Wall thickness for this flange
thickness = 2;
// Distance from pipe to flap
height = 14;
// Diameter of hole for mounting screw
screw_diameter = 8;
// Distance between screw hole centers
screw_distance = 96.6372;
// Shortest distance between screw hole and inside pipe edge
screw_offset = 6;
// Radius for the bottom corners
bottom_corner_radius = 5;
// Amount to snip off the top (in case of a tight fit)
top_snip = 5;

// Internal variables
$fa = 0.25*1; // Smooth arcs
inner_radius = inner_diameter/2;
outer_radius = inner_radius + thickness;
outer_diameter = outer_radius*2;
screw_radius = screw_diameter/2;
screw_hole_r = inner_radius+screw_offset+screw_radius;
screw_hole_theta = asin(screw_distance/(2*screw_hole_r));
screw_hole_x = screw_distance/2;
screw_hole_y = screw_hole_r*cos(screw_hole_theta);
bottom_edge_y = max(outer_radius,screw_hole_y)+thickness;
bottom_edge_x = max(outer_radius,screw_hole_x)+thickness;

difference() {
    // Build the flange as a solid first
    union() {
        // Wedge-shaped cylinder
        intersection() {
            // Outer-diameter cylinder
            cylinder(r=outer_radius, h=height);
            // Wedge shape
            translate([-outer_radius,0,0])
                rotate([0,90,0])
                linear_extrude(
                    height=outer_diameter
                )
                polygon(points = [
                    [ -0, -outer_radius],
                    [  0,  outer_radius],
                    [-14, -outer_radius]
                ]);
            // Top snip
            translate([0,-top_snip,height/2-1])
            cube([outer_diameter,outer_diameter,height+2], center=true);
        };
        // bottom piece of flange
        hull() {
            linear_extrude(height = thickness)
                polygon(points = [
                    [-outer_radius, 0],
                    [ outer_radius, 0],
                    [ bottom_edge_x, -bottom_edge_y],
                    [-bottom_edge_x, -bottom_edge_y]
                ]);
            translate([ bottom_edge_x, -bottom_edge_y, 0])
                cylinder(r=bottom_corner_radius, h=thickness);
            translate([-bottom_edge_x, -bottom_edge_y, 0])
                cylinder(r=bottom_corner_radius, h=thickness);
        }
    };
    
    // Bore out the inner diameter and screw holes now
    translate([0,0,-1]) {
        union() {
            // Center of pipe
            cylinder(r=inner_radius, h=height+2);
            // Right side screw hole (half-circle)
            translate([screw_hole_x,-screw_hole_y,0])
                rotate([0,0,screw_hole_theta]) difference() {
                    cylinder(r=screw_radius, h=height+2);
                    translate([0,-screw_radius,-1])
                    cube(size=[screw_radius*2,screw_radius*2,height+4], center=true);
                };
            // Left side screw hole (half-circle)
            translate([-screw_hole_x,-screw_hole_y,0])
                rotate([0,0,-screw_hole_theta]) difference() {
                    cylinder(r=screw_radius, h=height+2);
                    translate([0,-screw_radius,-1])
                    cube(size=[screw_radius*2,screw_radius*2,height+4], center=true);
                };
        }
    }
}