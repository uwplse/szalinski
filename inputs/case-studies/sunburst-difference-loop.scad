radius = 10;
height = 5;
n_rays = 20;
ray_width = 1;
ray_depth = 4;

difference() {
    cylinder(r = radius, h = height);
    
    for(i=[0:n_rays]) {
        rotate([0, 0, i * (360 / n_rays)]) {
            translate([radius - ray_depth / 2, 0, height / 2]) {
                cube([ray_depth, ray_width, height + 2], center = true);
            }
        }
    }
}