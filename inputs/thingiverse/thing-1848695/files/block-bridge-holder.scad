// What kind of block are you using?
block_type = 0; // [0:Cube,2:Cylinder]

// The width or diameter of the block
block_width = 32; // [0.5:0.5:100]

// The length of the block
block_length = 32; // [0.5:0.5:100]

// Tolerance to use
block_tolerance = .1; // [0.1:0.1:0.9]

module block(height=40, shrink=0) {
    if (block_type == 0) {
        cube([block_width+block_tolerance-shrink, block_length+block_tolerance-shrink, height]);
    } else {
        translate([block_width/2, block_width/2]) cylinder(d=block_width+block_tolerance-shrink, h=height, center=false);
    }
}

module base(base_x=50, base_y=50, base_height=8, cut=1) {
    difference() {
        difference() {
            cube([base_x, base_y, base_height]);
            translate([(base_x/2) - (block_width/2), (base_y/2) - (block_width/2), 0]) block();
        }
        if (cut == 1) {
            translate([(base_x-(hole_x/4)), 0, base_height]) rotate([0, 45, 0]) cube([hole_x/2, base_x+10, hole_x/2]);
            translate([base_x, base_y-(hole_x/4), base_height]) rotate([0, 45, 90]) cube([hole_x/2, base_x+10, hole_x/2]);
            translate([(-1*(hole_x/2))+1, 0, base_height]) rotate([0, 45, 0]) cube([hole_x/2, base_x+10, hole_x/2]);
            translate([base_x, (-1*(hole_y/2))+1, base_height]) rotate([0, 45, 90]) cube([hole_x/2, base_x+10, hole_x/2]);
        }
    }
}

module rail_top(base_x=50, base_y=50, hole_x=32, hole_y=32, rail_width=44, height=12) {
    under_rail_height = ((base_x/2)-(rail_width/2));
    difference() {
        base(base_x, base_y, hole_x, hole_y, base_height=height, cut=0);
        translate([(base_x/2)-(rail_width/2), 0, under_rail_height]) cube([rail_width, base_y, height]);
    }
    difference() {
        translate([(base_x/2) - (hole_x/2), (base_y/2) - (hole_y/2), 0]) block(height=under_rail_height);
        translate([(base_x/2) - ((block_width+block_type)/2) + 1, (base_y/2) + 1 - ((block_length+block_type)/2), 0]) block(height=under_rail_height, shrink=2);
        translate([(base_x/2) - (hole_x/2), (base_y/2) - (hole_y/2), 0]) block(height=under_rail_height/1.5);
    }
}

module render_assembled() {
    translate([-3, 0, 61]) rail_top();
    translate([0, 0, 0]) base(base_x=44);
    translate([6, 9, 0]) cube([32, 32, 64]);
}

module render_printable() {
    translate([0, 0, 0]) rail_top(hole_x=32.1, hole_y=32.1);
    translate([80, 0, 0]) base(base_y=44, hole_x=32.1, hole_y=32.1);
}

render_printable();
//render_assembled();
//block();