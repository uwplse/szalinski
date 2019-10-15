$fn = 32 * 1;

gap = 3.7;

width = 20;
wall_height = 3 * 1;

module rounded_rect(x, y, z, r = 1) {
    hull() {
        translate([r, r, r]) sphere(r);
        translate([x-r, r, r]) sphere(r);
        translate([x-r, y-r, r]) sphere(r);
        translate([r, y-r, r]) sphere(r);
    
    
        translate([r, r, z-r]) sphere(r);
        translate([x-r, r, z-r]) sphere(r);
        translate([x-r, y-r, z-r]) sphere(r);
        translate([r, y-r, z-r]) sphere(r);
    }
}

rotate([0, 90]) {
    for( i = [0 : 3]) {
        translate([0, i * 20, 0]) {
            union() {
                rounded_rect(width, 14, wall_height);
                    
                translate([0, 0, wall_height + gap])
                    rounded_rect(width, 14, wall_height);
            }
            translate([0, 0, 0]) rounded_rect(width, 4, (wall_height * 2) + gap);
        }
    }
}