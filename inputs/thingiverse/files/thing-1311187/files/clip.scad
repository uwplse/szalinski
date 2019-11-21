// (mm) – should be slightly smaller than the actual stand
stand_opening_diameter = 13.5;

// (mm) – should be at least the size of the cable
cable_opening_diameter = 8;

// (mm)
height = 13;

// (degrees)
clip_opening_angle = 90;


module clip(height, major, minor, opening_angle=90) {
    spacing = 0.5; // extra space for cable
    wall_major = pow(major / 20, 1/2) * 20 / 5;
    wall_minor = wall_major * pow(minor / major, 1/3);
    rounding = min(wall_major, wall_minor) - 0.01;

    // Distance between centers
    distance = major/2 + minor/2 + spacing;
    
    union() {
        $fn = 100;
        difference() {
            hull() {
                translate([0, distance])
                    cylinder(d=minor + 2 * wall_minor, h=height);
                cylinder(d=major + 2 * wall_major, h=height);
            }

            union() {
                translate([0, distance])
                    cylinder(d=minor, h=height);
                translate([0, distance / 2, height / 2])
                    cube([minor, distance, height], center=true);
                cylinder(d=major, h=height);
                
                linear_extrude(h=height) {
                    r = major + wall_major;
                    dx = r * sin(opening_angle / 2);
                    dy = -r * cos(opening_angle / 2);
                    polygon(points=[[0, 0],
                                     [dx, dy],
                                     [r, -r],
                                     [-r, -r],
                                     [-dx, dy]]);
                }
            }
        }
        
        r = major / 2 + wall_major / 2;
        dx = r * sin(opening_angle / 2);
        dy = -r * cos(opening_angle / 2);
        translate([-dx, dy]) cylinder(d=wall_major, h=height, $fn=30);
        translate([dx, dy]) cylinder(d=wall_major, h=height, $fn=30);
    }
}


clip(height, stand_opening_diameter, cable_opening_diameter, clip_opening_angle);