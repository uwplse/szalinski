module rot_z_diffs(n, deg) {
    if(n == 0) {
        children(0);
    } else {
        rot_z_diffs(n - 1, deg) {
            difference() {
                rotate([0, 0, deg]) {
                    children(0);
                }
                children(1);
            }
            children(1);
        }
    }
}

module sunburst(radius, height, n_rays, ray_width, ray_depth) {
    rot_z_diffs(n_rays, 360 / n_rays) {
        cylinder(r = radius, h = height);
        translate([radius - ray_depth / 2, 0, height / 2]) {
            cube([ray_depth, ray_width, height + 2], center = true);
        }
    }
}

sunburst(10, 5, 20, 1, 4);