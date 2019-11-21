wall_thickness = 2;
bigger_outer_radius = 25;
bigger_height = 25;
smaller_outer_radius = 14.5;
smaller_height = 25;
transition_height = 10;
$fn = 100;


difference() {
    cylinder(bigger_height, bigger_outer_radius, bigger_outer_radius);
    cylinder(bigger_height, bigger_outer_radius - wall_thickness, bigger_outer_radius - wall_thickness);
}

translate([0, 0, bigger_height])
difference() {
    cylinder(transition_height, bigger_outer_radius, smaller_outer_radius);
    cylinder(transition_height, bigger_outer_radius - wall_thickness, smaller_outer_radius - wall_thickness);
}

translate([0, 0, bigger_height+transition_height])
difference() {
    cylinder(smaller_height, smaller_outer_radius, smaller_outer_radius);
    cylinder(smaller_height, smaller_outer_radius - wall_thickness, smaller_outer_radius - wall_thickness);
}