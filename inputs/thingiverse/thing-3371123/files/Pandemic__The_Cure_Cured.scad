// Number of dice holes
// 4 for regular Pandemic: The Cure
// 5 for Experimental Meds
holes = 5;

card_width = 22*holes;

card_height = 43;

die_size = 13.9;
die_buffer = 0.25;

depth = 5;

hole_size = die_size + (die_buffer * 2);

outside_border = 10;
buffer = (card_width - (outside_border * 2) - (hole_size * holes)) / (holes-1);

$fn = 50;

union() {
    difference() {
        cube([card_width, card_height, depth]);
        for (i = [0:(holes-1)]) {
            translate([outside_border + ((hole_size + buffer) * i), 10, 2])
                cube([hole_size, hole_size, depth]);
        }
        translate([-0.5, 35, 2])
            rotate([75, 0, 0])
                cube([card_width + 1, card_height, 1]);    
    }

    // Bevel
    union() {
        translate([0,-depth/2,0])
            cube([card_width, depth/2, depth/2]);
        translate([card_width/2,0,depth/2])
            rotate([0, 90, 0])
                cylinder(card_width, depth/2, depth/2, true);

        translate([0,card_height,0])
            cube([card_width, depth/2, depth/2]);
        translate([card_width/2,card_height,depth/2])
            rotate([0, 90, 0])
                cylinder(card_width, depth/2, depth/2, true);
    }
}
