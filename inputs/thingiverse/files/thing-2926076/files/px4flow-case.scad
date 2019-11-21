r_fillet = 2; // radius of fillets
t = 2; // thickness of case
$fs = 1;
board_width=35;
board_length = 45.5;
board_height = 21;
r_hole = 1.6;
sep = t + 1; // separation of outer wall of case from board

*color("green") translate([sep, sep, 28.5 + sep]) rotate([-90, 0, 0]) import("PX4Flow.STL", convexity=5);
case_width = board_width + sep*2;
case_length = board_length + sep*2;

module outset(r) {
    minkowski() {
        circle(r=r);
        children();
    }
}

module inverse() {
	difference() {
		square(1e5,center=true);
		children();
	}
}

module fillet(r=1) {
	inset(r=r) render() outset(r=r) children();
}

module rounding(r=1) {
	outset(r=r) inset(r=r) children();
}

module inset(r) {
    inverse() outset(r) inverse() children();
}

module mount_holes() {
    translate([sep, sep]) union() {
        translate([2.5, 2.3]) circle(r_hole);
        translate([2.5, 32.7]) circle(r_hole);
        translate([26.5, 32.7]) circle(r_hole);
        translate([26.5, 2.3]) circle(r_hole);
    }
}

module mount_supports() {
    linear_extrude(27) translate([sep, sep]) union() {
        d = 2  + sep + t;
        translate([2.5, 2.3]) square([d, d], center=true);
        translate([2.5, 32.7]) square([d, d], center=true);
        translate([27.5, 32.7]) square([d, d], center=true);
        translate([26.5, 2.3]) square([d, d], center=true);
    }
}

module sensor_holes() {
    translate([sep, sep]) union() {
        translate([12.5, 17.6]) circle(9);
        translate([34.8, 17.6]) circle(11);
    }
}

module sensor_cowlings() {
    translate([sep, sep]) union() {
        translate([12.5, 17.6]) linear_extrude(5, scale=1) difference() {
            outset(t) circle(9);
            circle(9);
        }
        translate([34.8, 17.6 ]) linear_extrude(12, scale=0.8) difference() {
            outset(t) circle(11);
            circle(11);
        }
    }
}

module base() {
    rounding(r_fillet) square([case_length, case_width]);
}

module side() {
    linear_extrude(board_height + 2*sep + 6) difference() {
        base();
        rounding(r_fillet) inset(t) base();
    }
}

module bottom_plate() {
    linear_extrude(t) difference() {
        base();
        sensor_holes();
    }
}

module top_plate() {
    union() {
        linear_extrude(t) difference() {
            base();
            mount_holes();
        }
        linear_extrude(t*1.5) difference() {
            rounding(r_fillet) inset(t + 0.2) base();
            mount_holes();
        }
        linear_extrude(7) difference() {
            outset(1.6) mount_holes();
            mount_holes();
        }
    }
}

module access_ports() {
    translate([37, 32, 23]) cube([10, 10, 50]);
    translate([17, 32, 23]) cube([10, 10, 50]);
}

module bottom_case() {
    render() difference() {
        union() {
            bottom_plate();
            side();
            mount_supports();
            sensor_cowlings();
        }
        access_ports();
    }
}

bottom_case();
//color("blue") translate([0, case_width, 35]) rotate([180, 0, 0]) top_plate();
translate([60, 0, 0]) top_plate();
