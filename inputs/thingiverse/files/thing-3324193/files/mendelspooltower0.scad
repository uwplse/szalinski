thickness = 10;
height = 225;
pad = 7;
tolerance = 0.5;
hole_distance = 60;
desired_radius = 4;
radius = desired_radius+tolerance/2;
x1 = pad + radius;
center_x = x1 + (hole_distance/2);
hole_z = x1;
x2 = x1 + hole_distance;
width = x2 + radius + pad;
module hole(x, z) {
    translate([x, thickness, z]) rotate([90, 0, 0])
        cylinder(h=height, r=radius);
}
difference() {
    difference() {
        cube([width, thickness, height]);
         union() {
            hole(x1, hole_z);
            hole(x2, hole_z);
            hole(center_x, height - pad - radius);
        }
    }
    rotate([90, 0, 0])
            translate([0, 0, -thickness])
                linear_extrude(height = thickness) {
                    offset = pad + radius;
                    polygon([[0, height], [center_x - offset, height], 
                        [0, 0]]);
                    polygon([[center_x + offset, height], 
                    [width + tolerance, height], [width + tolerance, 0]]);
                    cpad = 2*offset;
                    y=cpad;
                    polygon([[center_x, 3*height/4],
                        [cpad, y], [width-cpad, y]]);
                }
}
