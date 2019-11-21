
filter_height = 6;
wall_thickness = 1.2;
lens_radius = 17;
camera_radius = 10.5;
camera_base_height = 10;

connection_height = (lens_radius - camera_radius) * 1.2;
echo("total camera clearance: ", camera_base_height + connection_height);

base(camera_radius, wall_thickness, camera_base_height);

translate([0, 0, camera_base_height]) {
    linear_extrude(
            height = connection_height,
            scale = (lens_radius + wall_thickness) / (camera_radius + wall_thickness)
    )ring(camera_radius, wall_thickness);

    translate([0, 0, connection_height])
        lens_holder(lens_radius, wall_thickness, filter_height);
}
module lens_holder(
    lens_radius,
    wall_thickness,
    filter_height
) {
    
    linear_extrude(height = wall_thickness)
        ring(lens_radius - wall_thickness , wall_thickness * 2);
    translate([0, 0, wall_thickness])
        linear_extrude(height = filter_height)
            ring(lens_radius, wall_thickness);
}

module ring(inner_radius, wall_thickness) {
    difference() {
        circle(inner_radius + wall_thickness);
        circle(inner_radius);
    }
}

module base(camera_radius, wall_thickness, camera_base_height) {
    linear_extrude(height = camera_base_height)
        ring(camera_radius, wall_thickness);
}
