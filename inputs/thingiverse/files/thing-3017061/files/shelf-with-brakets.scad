/* 
 * Parametric Shelf with Brackets and Round Corners
 * Copyright (C) 2018
 * License: CC-BY-SA
 */

/* shelf dimensions */
$height = 17;
$front_height = 14;
$width = 140;
$depth = 90;

/* braket dimensions */
$bracket_offset = 10;
$bracket_height = 40;
$bracket_width = 15;
$bracket_length = 50;
$bracket_hole_height = 15;

/* inset and corners */
$corner_radius = 10;
$round_left_corner = 0;
$round_right_corner = 1;
$inset_width = 10;
$inset_padding = 6;

$fn = 60;

module bracket() {
    difference() {
        cube([$bracket_length, $bracket_width, $bracket_height]);
        
        translate([$bracket_length+5, $bracket_width + 0.1, $bracket_height+10])
        rotate([90, 0, 0])
        cylinder(h=$bracket_width+1, r=$bracket_height+10);

        translate([-0.1, $bracket_width / 2, $bracket_hole_height])
        rotate([0, 90, 0])
        cylinder(r=2.4, h=30);

        translate([15, $bracket_width / 2, $bracket_hole_height])
        rotate([0, 90, 0])
        cylinder(r=4.25, h=30);
    }
}

module shelf() {
    difference() {
        hull() {
            cube([$corner_radius, $width, $height]);

            translate([$depth-$corner_radius, $corner_radius * $round_left_corner, 0])
            if ($round_left_corner) {
                cylinder(h=$front_height, r=$corner_radius);
            } else {
                cube([10, $corner_radius, $height]);
            }
            
            translate([$depth-$corner_radius, $width-$corner_radius, 0])
            if ($round_right_corner) {
                cylinder(h=$front_height, r=$corner_radius);
            } else {
                cube([$corner_radius, $corner_radius, $height]);
            }
        }
        
        translate([0, 0, -0.1])
        hull() {
            translate([0, $inset_padding+$corner_radius, 0])
                cylinder(h=$inset_width, r1=$corner_radius, r2=$corner_radius/2);
     
            translate([0, $width-$inset_padding-$corner_radius, 0])
                cylinder(h=$inset_width, r1=$corner_radius, r2=$corner_radius/2);
        
            translate([77 - $corner_radius, $inset_padding+$corner_radius, 0])
                cylinder(h=$inset_width, r1=$corner_radius, r2=$corner_radius/2);

            translate([77 - $corner_radius, $width-$inset_padding-$corner_radius, 0])
                cylinder(h=$inset_width, r1=$corner_radius, r2=$corner_radius/2);
        }
    }

    translate([0, $bracket_offset, $front_height])
        bracket();

    translate([0, $width-$bracket_offset-$bracket_width, $front_height])
        bracket();
}

rotate([0, -90, 0])
shelf();
