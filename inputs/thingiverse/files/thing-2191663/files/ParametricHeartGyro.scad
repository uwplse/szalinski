num_rings = 5;
ring_thickness = 2;
inner_ring_radius = 10;
ring_width = 15;
spacing = .75;
fn = 80;

module make_spheres() {
    for(i = [0 : num_rings - 1]) {
        difference() {
            radius = inner_ring_radius + i * (ring_thickness + spacing);
            sphere(radius, $fn = fn);
            sphere(radius - ring_thickness, $fn = fn);
        }
    }
}

module diff_blocks() {
    size = 3 * (inner_ring_radius + num_rings * (ring_thickness + spacing));
    x_trans = -size / 2;
    y_trans = -size / 2;
    z_trans = ring_width / 2;
    translate([x_trans, y_trans, z_trans]) cube(size);
    translate([x_trans, y_trans, -z_trans - size]) cube(size);
}

module heart() {
    size = inner_ring_radius / 2;
    extrude_height = 2 * (inner_ring_radius + num_rings * (ring_thickness + spacing));
    translate([-size / 3, -size / 3, -extrude_height / 2]) {
        linear_extrude(height = extrude_height) {
            union() {
                square(size);
                translate([size / 2, 0, 0])
                    circle(size / 2, $fn = fn);
                translate([0, size / 2, 0])
                    circle(size / 2, $fn = fn);
            }
        }
    }
}

module holes() {
    heart();
    rotate(a = [90, 135+180, 45])
        heart();
    rotate(a = [90, 135+180, 135])
        heart();
}

module handle() {
    translate([0, -ring_thickness / 1.5, 0])
    difference() {
        translate([inner_ring_radius - 2.5 * ring_thickness + num_rings * (ring_thickness + spacing), 0, 0])
        rotate([90, 0, 0])
        rotate_extrude()
        translate([ring_width / 2.5, 0, 0])
            circle(2, $fn = fn);
        sphere(inner_ring_radius + (num_rings - 1) * (ring_thickness + spacing), $fn = fn);
    }
}

union() {
    
    difference() {
        difference() {
            union() {
                make_spheres();
                handle();
            }
            diff_blocks();
        }
        holes();
    }
}