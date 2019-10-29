
/* [Global] */
// render the light or the filled version
light = 1; //[0:filled,1:light]

/* [Holes] */
// diameter of the washer you want to use
washer_diameter = 15.2; // [0.1:100]

// diameter of the screw hole
hole_diameter = 4.2; // [0.1:100]

// diameter of the nut you want to use
nut_diameter = 8.1; // [0.1:100]

/* [Sizes] */
// diameter of the center
center_diameter = 19; // [1:100]

// thickness of walls in light version
wall_thickness = 2; // [1:20]

/* [Feet] */
// number of feet to render
foot_count=3; // [2:30]

// distance of feet to the center
foot_distance = 20; // [1:5000]

// diameter of feet
foot_diameter = 30; // [1:250]

// thickness of the connectors from center to foot
foot_connector_thickness = 8; // [3:100]

/* [Hidden] */
center_height = 5;
washer_height = 2;
nut_height = 5;
foot_start_offset = ceil(floor(center_diameter/2)-(wall_thickness/2));
foot_inner_diameter = foot_diameter - wall_thickness;
foot_angle = 360/foot_count;

$fn=50;

difference() {
    cylinder(d=center_diameter, h=center_height+wall_thickness);
    if (light == 1) {
        difference() {
            cylinder(d=center_diameter-wall_thickness, h=center_height);
            cylinder(d=nut_diameter+1, h=center_height);
        }
    }
    translate([0, 0, 0]) cylinder(d=nut_diameter, h=nut_height, $fn=6);
    cylinder(d=hole_diameter, h=center_height+wall_thickness, $fn=50);
    translate([0, 0, 6]) cylinder(d=washer_diameter, h=washer_height);
}

module foot() {
    translate([foot_start_offset, -4, 1]) {
        difference() {
            cube([foot_distance, foot_connector_thickness, 6]);
            if (light == 1) {
                translate([0, wall_thickness/2, 0]) cube([foot_distance, foot_connector_thickness-wall_thickness, 4]);
            }
        }
    }

    translate([foot_start_offset+foot_distance, 0, -3]) {
        difference() {
            cylinder(d=foot_diameter, h=10);
            translate([-1*foot_diameter, -1*(foot_diameter/2), 0]) cube([foot_diameter, foot_diameter*2, 10]);
            if (light == 1) {
                union() {
                    difference() {
                        cylinder(d=foot_inner_diameter, h=8);
                        translate([-1*foot_diameter, -1*(foot_diameter/2), 0]) cube([foot_diameter+1, foot_diameter*2, 10]);
                    }
                }
            }
        }
    }
}

for (foot = [0:foot_count]) {
    rotate([0, 0, foot*foot_angle]) foot();
}