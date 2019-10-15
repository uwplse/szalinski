$fn = 100;

// Tolerance to use for the different measurements to accomodate filament thickness.
tolerance = 1;

// Thickness of the vertical walls in the model.
wall_w = 5;
// Thickness of the horizontal walls in the model.
wall_h = 5;

// The width (in mm) of the LACK table's square leg.
lack_leg_width = 51;
leg_width = lack_leg_width + 2 * tolerance;


// The height (in mm) of the LACK table's surface.
lack_surface_height = 50;
surface_height = lack_surface_height + tolerance;

// The extra space (in mm) to add to the top LACK's leg to ensure large objects (like a 3D printer) fit between the stacked tables.
spacer_height = 60;

// The radius (in mm) of the hole that should fit the threaded pole of the LACK table's leg. Make the hole somewhat bigger to ensure it definitely fits inside.
lack_screw_radius = 5;
screw_radius = lack_screw_radius + tolerance;

module floor_area() {
    translate([wall_w, 0, 0]) {
        cube([leg_width, leg_width, wall_h]);
    }
}

module top_area() {
    translate([-wall_w, 0, 0]) {
        cube([leg_width + 2 * wall_w, leg_width + 2 * wall_w, spacer_height + wall_h]);
    }
}

module wall() {
    cube([wall_w, leg_width + wall_w, surface_height + wall_h]);
}

module bottom_wall() {
    union() {
        wall();
        rotate([5, 0, 0]) {
            translate([0, 0, 0.5]) {
                wall();
            }
        }
    }
}

module top_wall() {
    translate([-wall_w, wall_w, -surface_height / 2]) {
        difference(){
            difference(){
                wall();
                translate([0, 0, wall_h]) {
                    rotate([45, 0, 0]) {
                        translate([-wall_w, 0, 0]){
                            cube([wall_w*3, leg_width * 2, surface_height + wall_h]);
                        }
                    }
                }
            }
            cube([2 * wall_w, leg_width * 2, surface_height / 2]);
        }
    }
}

module screw_hole () {
    translate([(leg_width / 2) + wall_w, (leg_width) / 2, wall_h / 2]) {
        cylinder(r = screw_radius, h = wall_h + 1, center = true);
    }
}


// The bottom part
difference() {
    floor_area();
    screw_hole();
}

// The part that wraps around the table
bottom_wall();
rotate(-90) {
    translate([-(leg_width), (leg_width + wall_w), 0]) {
        rotate([180, 180, 0]) bottom_wall();
    }
}

// The top part that includes the mount up
rotate(180) {
    translate([-(leg_width + wall_w), -(leg_width + wall_w), surface_height + wall_h]) { 
        top_area();
        translate([0, 0, spacer_height]) {
            top_wall();
            rotate(-90) 
            translate([-(leg_width + wall_w), (leg_width + wall_w), 0]) {
                mirror([0, 1, 0]) {
                    top_wall();
                }
            }
        }
    }
}


