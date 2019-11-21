lid_diameter = 86;
wall_thickness = 6.5;
thickness = 8;
rounding = 4;

/* [Hidden] */

top_diameter = lid_diameter;
inner_diameter = top_diameter-wall_thickness*2;
indent_diameter = (top_diameter-inner_diameter)/2;

module ci(diameter, thickness) {
    scale([1,1,thickness]) {
        translate([0,0,0.5]) {
            cylinder(d=diameter, $fn=60, center=true);
        }
    }
}

difference() {
    union() {
        ci(top_diameter, thickness);
    };
    translate([0,0,thickness]) {
        rotate_extrude(angle=1, $fn=60) {
            translate([(top_diameter-indent_diameter)/2,0,0]) {
                circle(d=indent_diameter);
            }
        };
        translate([0,0,-1.9]) {
            rotate_extrude(angle=1, $fn=60) {
                translate([(top_diameter)/2-indent_diameter+1,0,0]) {
                    square(20,0);
                }
            }
        };
        translate([0,0,-10+rounding-thickness]) {
            difference() {
            rotate_extrude(angle=1, $fn=60) {
                translate([top_diameter/2-rounding,0,0]) {
                    square(10,0);
                }
            }
            translate([0,0,10])
            rotate_extrude(angle=1, $fn=60) {
                translate([top_diameter/2-rounding,0,0]) {
                    circle(d=rounding*2, $fn=60);
                }
            }
            }
        }
    }
}
