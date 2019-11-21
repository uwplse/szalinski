upper_plate_radius = 19.75;
screw_distance_from_center = 16.5;
screw_hole_diameter = 6; // M3 head is usually 5.5mm
ptfe_hole_diameter = 4.5;
height = 10;
HOLE_BUFFER_HEIGHT = 5;

function polar_to_cartesian(distance_from_center, angle) =
    [distance_from_center * cos(angle), distance_from_center * sin(angle)];

module polar_translate(distance_from_center, angle, z=0) {
    xy = polar_to_cartesian(distance_from_center, angle);
    translate([xy[0], xy[1], z]) children();
}

module polar_equilateral(distance_from_center, height){
    linear_extrude(height = height){
        triangle_points = [
            polar_to_cartesian(distance_from_center, 0),
            polar_to_cartesian(distance_from_center, 120),
            polar_to_cartesian(distance_from_center, 240)
        ];
        polygon(triangle_points);
    };
}

intersection(){
    difference(){
        cylinder(r = upper_plate_radius, h = height);
        
        // Screw Holes
        for(angle=[0:120:359]){
            polar_translate(screw_distance_from_center, angle, -HOLE_BUFFER_HEIGHT)
                cylinder(d = screw_hole_diameter, h = height + (HOLE_BUFFER_HEIGHT * 2), $fn = 60);
        }
        
        // PTFE Tube/Filament Hole
        translate([0, 0, -HOLE_BUFFER_HEIGHT])
            cylinder(d = ptfe_hole_diameter, h = height + (HOLE_BUFFER_HEIGHT * 2), $fn = 60);
    }
    // Trianguar Cut
    translate([0, 0, -HOLE_BUFFER_HEIGHT])
        polar_equilateral(screw_distance_from_center + 3, height + (HOLE_BUFFER_HEIGHT * 2));
}
