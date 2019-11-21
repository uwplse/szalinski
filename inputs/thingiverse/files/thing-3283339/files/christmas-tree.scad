include <helix.scad>;
include <rotate_p.scad>;
include <cross_sections.scad>;
include <polysections.scad>;
include <helix_extrude.scad>;
include <shape_starburst.scad>;

$fn = 24;

r1 = 50;
r2 = 1;
levels = 12;
level_dist = 15;

burst_r1 = r1 * 2 / 10;
burst_r2 = r1 / 10;
burst_number = 5;
burst_height = r1 / 20;

module star(burst_r1, burst_r2, burst_number, burst_height) {
    a = 180 / burst_number;

    p0 = [0, 0, 0];
    p1 = [burst_r2 * cos(a), burst_r2 * sin(a), 0];
    p2 = [burst_r1, 0, 0];
    p3 = [0, 0, burst_height];

    module half_burst() {
        polyhedron(points = [p0, p1, p2, p3], 
            faces = [
                [0, 2, 1],
                [0, 1, 3],
                [0, 3, 2], 
                [2, 1, 3]
            ]
        );
    }

    module burst() {
        hull() {
            half_burst();
            mirror([0, 1, 0]) half_burst();
        }
    }

    module one_side() {
        union() {
            for(i = [0 : burst_number - 1]) {
                rotate(2 * a * i) burst();
            }
        }    
    }

    one_side();
    mirror([0, 0, 1]) one_side();
}

module christmas_tree() {
    union() {
        translate([0, 0, (levels + 0.75) * level_dist]) rotate([0, -90, 0]) star(burst_r1, burst_r2, burst_number, burst_height);

        difference() {
            cylinder(h = (levels + 0.25) * level_dist, r1 = r1, r2 = r2 * 0.8);
            scale(0.95) cylinder(h = (levels + 0.25) * level_dist, r1 = r1, r2 = r2 * 0.8);
        }
    }
    
    shape_pts = shape_starburst(3, 1, 8);

    translate([0, 0, burst_r1 / 2]) union() {
        helix_extrude(shape_pts, 
            radius = [r1, r2], 
            levels = levels, 
            level_dist = level_dist,
            vt_dir = "SPI_UP"
        );

        helix_extrude(shape_pts, 
            radius = [r1, r2], 
            levels = levels, 
            level_dist = level_dist,
            vt_dir = "SPI_UP",
            rt_dir = "CLK"
        );
    }
}

christmas_tree();

