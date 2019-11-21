/*
 * Customizable Fan Cover - https://www.thingiverse.com/thing:2802474
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2018-02-22
 * updated 2018-03-27
 * version v1.2
 *
 * Changelog
 * --------------
 * v1.2:
 *      - better quality of rounded corners and crosshair pattern
 * v1.1:
 *      - added support line option for crosshair and square pattern
 * v1.0:
 *      - final design
 * --------------
 *
 * This work is licensed under the Creative Commons - Attribution - Non-Commercial - ShareAlike license.
 * https://creativecommons.org/licenses/by-nc-sa/3.0/
 */


 // Parameter Section //
//-------------------//

/* [Global Settings] */

// Choose between presets of known and common fan sizes.
fan_preset = "40"; //[25:25mm,30:30mm,40:40mm,50:50mm,60:60mm,70:70mm,80:80mm,92:92mm,120:120mm,140:140mm,custom:Custom Fan Settings]

// If you want save to save about 40% filament and about 20% printing time, you can choose the reduced frame option.
frame_option = "reduced"; //[full,reduced]

// Minimum Border Size. I recommend to use two/four/six... times of your line width setting of your slicer. Simplify3D uses 0.48mm line width by default if you are using a 0.4mm nozzle. Cura uses 0.4mm line width.
min_border_size_in_millimeter = 1.92;

// Choose between a grill pattern
grill_pattern = "honeycomb"; //[honeycomb,grid,line,triangle,crosshair,square,dot,aperture]

// Set the angle of the pattern around the center of the cover.
grill_pattern_rotation = 0; //[0:5:360]

// Size of the pattern lines. I recommend to use two/four/six... times of your line width setting of your slicer. Simplify3D uses 0.48mm line width by default if you are using a 0.4mm nozzle. Cura uses 0.4mm line width.
line_size_in_millimter = 0.96; //[0.3:0.02:4]

// Space between two lines of your pattern. If you choose aperture pattern, this value set the size of the center octagon.
line_space_in_millimeter = 6; //[1:0.1:50]

// If you need countersunk holes, you can activate it here. Bottom = first layer. Top = last layer. 
screw_hole_chamfer = "no"; //[no,top,bottom,top_and_bottom]

// Activate or deactivate rounded corners. The radius will be automatically calculated.
rounded_corners = "yes"; //[yes,no]

// number of straight lines supporting the crosshair or square pattern.
number_of_support_lines = 2;  //[1:1:36]

/* [Custom Fan Settings] */

// Cover size. E.g. 80 for a 80mm Fan
cover_size_in_millimeter = 40;

// E.g. 2.9 for M2.5, 3.3 for M3, 4.4 for M4
screw_hole_diameter_in_millimeter = 3.3;

// 25mm fan: 20 | 30mm fan: 24 | 40mm fan: 32 | 50mm fan: 40 | 60mm fan: 50 | 70mm fan: 61.5 | 80mm fan: 71.5 | 92mm fan: 82.5 | 120mm fan: 105 | 140mm fan: 126 
screw_hole_distance_in_millimeter = 32;

// Height of the outer frame of the cover
cover_height_in_millimeter = 3;

// Height of the pattern inside the cover frame
grill_pattern_height_in_millimeter = 1;

/* [Hidden] */
min_border_size = min_border_size_in_millimeter;
line_size = line_size_in_millimter;
line_space = line_space_in_millimeter;

 // Program Section //
//-----------------//

if(fan_preset == "25") {
    fan_cover(cover_size = 25, screw_hole_dia = 2.9, screw_hole_distance = 20, cover_h = 2, grill_pattern_h = 1);
}
if(fan_preset == "30") {
    fan_cover(cover_size = 30, screw_hole_dia = 3.3, screw_hole_distance = 24, cover_h = 2.5, grill_pattern_h = 1.1);
}
if(fan_preset == "40") {
    fan_cover(cover_size = 40, screw_hole_dia = 3.3, screw_hole_distance = 32, cover_h = 2.7, grill_pattern_h = 1.2);
}
if(fan_preset == "50") {
    fan_cover(cover_size = 50, screw_hole_dia = 4.4, screw_hole_distance = 40, cover_h = 2.9, grill_pattern_h = 1.3);
}
if(fan_preset == "60") {
    fan_cover(cover_size = 60, screw_hole_dia = 4.4, screw_hole_distance = 50, cover_h = 3, grill_pattern_h = 1.3);
}
if(fan_preset == "70") {
    fan_cover(cover_size = 70, screw_hole_dia = 4.4, screw_hole_distance = 61.5, cover_h = 3, grill_pattern_h = 1.4);
}
if(fan_preset == "80") {
    fan_cover(cover_size = 80, screw_hole_dia = 4.4, screw_hole_distance = 71.5, cover_h = 3.2, grill_pattern_h = 1.5);
}
if(fan_preset == "92") {
    fan_cover(cover_size = 92, screw_hole_dia = 4.4, screw_hole_distance = 82.5, cover_h = 3.5, grill_pattern_h = 1.6);
}
if(fan_preset == "120") {
    fan_cover(cover_size = 120, screw_hole_dia = 4.4, screw_hole_distance = 105, cover_h = 4, grill_pattern_h = 1.8);
}
if(fan_preset == "140") {
    fan_cover(cover_size = 140, screw_hole_dia = 4.4, screw_hole_distance = 126, cover_h = 4.5, grill_pattern_h = 2.0);
}
if(fan_preset == "custom") {
    fan_cover(cover_size = cover_size_in_millimeter, screw_hole_dia = screw_hole_diameter_in_millimeter, screw_hole_distance = screw_hole_distance_in_millimeter, cover_h = cover_height_in_millimeter, grill_pattern_h = grill_pattern_height_in_millimeter);
}


 // Module Section //
//----------------//

module fan_cover(cover_size, screw_hole_dia, screw_hole_distance, cover_h, grill_pattern_h) {
    corner_size = cover_size - screw_hole_distance;
    corner_r = rounded_corners == "yes" ? corner_size / 2 : 0;
    screw_pos = (cover_size - corner_size) / 2;
    color("DodgerBlue") difference() {
        union() {
            linear_extrude(height = cover_h, convexity = 20) {
                difference() {
                    offset(r=corner_r, $fn = ceil(corner_r * 8)) {
                        offset(r=-corner_r) {
                            square([cover_size, cover_size], center = true);
                        }
                    }
                    if(frame_option == "reduced") {
                        offset(r=corner_r, $fn = ceil(corner_r * 8)) {
                            offset(r=-corner_r) {
                                square([cover_size - min_border_size*2, cover_size - min_border_size*2], center = true);
                            }
                        }
                    }
                    if(frame_option == "full") {
                        circle(d = cover_size - min_border_size * 2, $fn = cover_size);
                    }
                } 
                if(frame_option == "reduced") {
                    for(y = [-1:2:1]) {
                        for(x = [-1:2:1]) {
                            translate([screw_pos * x, screw_pos * y, -2]) {
                                circle(d = corner_size, $fn = ceil(corner_r * 8));
                            }
                        }
                    }
                }
            }
            linear_extrude(height = grill_pattern_h, convexity = 20) {
                intersection() {
                    offset(r=corner_r, $fn = ceil(corner_r * 8)) {
                        offset(r=-corner_r) {
                            square([cover_size, cover_size], center = true);
                        }
                    }
                    rotate(grill_pattern_rotation) {
                        if(grill_pattern == "honeycomb") {
                            honeycomb_pattern(cover_size, line_size, line_space);
                        }
                        if(grill_pattern == "grid") {
                            grid_pattern(cover_size, line_size, line_space);
                        }
                        if(grill_pattern == "line") {
                            line_pattern(cover_size, line_size, line_space);
                        }
                        if(grill_pattern == "triangle") {
                            triangle_pattern(cover_size, line_size, line_space);
                        }
                        if(grill_pattern == "crosshair") {
                            crosshair_pattern(cover_size, line_size, line_space);
                        }
                        if(grill_pattern == "square") {
                            square_pattern(cover_size, line_size, line_space);
                        }
                        if(grill_pattern == "dot") {
                            dot_pattern(cover_size, line_size, line_space);
                        }
                        if(grill_pattern == "aperture") {
                            aperture_pattern(cover_size, line_size, line_space);
                        }
                        
                    }
                }
            }
        }
        for(y = [-1:2:1]) {
            for(x = [-1:2:1]) {
                translate([screw_pos * x, screw_pos * y, -2]) {
                    screw_hole(cover_h, screw_hole_dia);
                }
            }
        }
    }
}

module screw_hole(cover_h, screw_hole_dia) {
    cylinder(h = cover_h + 4, d = screw_hole_dia, $fn = 16);
    if(screw_hole_chamfer == "bottom" || screw_hole_chamfer == "top_and_bottom") {
        translate([0, 0, 2.9 - screw_hole_dia]) {
            cylinder(h = screw_hole_dia, d1 = screw_hole_dia * 4, d2 = screw_hole_dia);
        }
    }
    if(screw_hole_chamfer == "top" || screw_hole_chamfer == "top_and_bottom") {
        translate([0, 0, cover_h + screw_hole_dia/4]) {
            cylinder(h = screw_hole_dia, d2 = screw_hole_dia * 4, d1 = screw_hole_dia);
        }
    }
}

module grid_pattern(size, line_size, line_space) {
    num = ceil(size / (line_size + line_space) * 1.42);
    for(x = [floor(-num / 2) : ceil(num / 2)]) {
        translate([x * (line_size + line_space), 0]) {
            square([line_size, num *(line_size + line_space)], center=true);
        }
        rotate(90) {
            translate([x * (line_size + line_space), 0]) {
                square([line_size, num *(line_size + line_space)], center = true);
            }
        }
    }
}

module triangle_pattern(size, line_size, line_space) {
    num = ceil(size / (line_size + line_space) * 1.42);
    for(x = [floor(-num / 2):ceil(num / 2)]) {
        translate([x * (line_size + line_space), 0]) {
            square([line_size, num *(line_size + line_space)], center = true);
        }
        rotate(60) {
            translate([x * (line_size + line_space), 0]) {
                square([line_size, num *(line_size + line_space)], center = true);
            }
        }
        rotate(120) {
            translate([x * (line_size + line_space), 0]) {
                square([line_size, num *(line_size + line_space)], center = true);
            }
        }
    }
}

module line_pattern(size, line_size, line_space) {
    num = ceil(size / (line_size + line_space)*1.42);
    for(x = [floor(-num / 2):ceil(num / 2)]) {
        translate([x * (line_size + line_space), 0]) {
            square([line_size, num *(line_size + line_space)], center=true);
        }
    }
}

module crosshair_pattern(size, line_size, line_space) {
    line = (line_size + line_space) * 2;
    num = ceil(size / line * 1.42);
    for(n = [1:num]) {
        difference() {
            circle(d = n * line + line_size * 2, $fn = ceil(n * line + line_size * 2));
            circle(d = n * line, $fn = ceil(n * line + line_size * 2));
        }
    }
    for(rot=[0:90 / number_of_support_lines * 2:180]) {
        rotate(rot + 45) square([size * 2, line_size], center = true);
    }
}

module square_pattern(size, line_size, line_space) {
    line = (line_size + line_space) * 2;
    num = ceil(size / line * 1.42); 
    for(n = [1:num]) {
        difference() {
            square([n * line + line_size * 2, n * line + line_size * 2], center = true);
            square([n * line, n * line], center = true);
        }
    }
    for(rot=[0:90 / number_of_support_lines * 2:180]) {
        rotate(rot + 45) square([size * 2, line_size], center = true);
    }
}

module honeycomb_pattern(size, line_size, line_space) {
    min_rad = (line_space / 2 * sqrt(3)) / 2 + line_size / 2;
    y_offset = sqrt(min_rad * min_rad * 4 - min_rad * min_rad);
    num_x = ceil(size / min_rad / 2) * 1.42;
    num_y = ceil(size / y_offset) * 1.42;
    difference() {
        square([size * 1.42, size * 1.42], center = true);
        for(y = [floor(-num_y / 2) : ceil(num_y / 2)]) {
            odd = (y % 2 == 0) ? 0 : min_rad;
            for(x = [floor(-num_x / 2) : ceil(num_x / 2)]) {
                translate([x * min_rad * 2 + odd, y * y_offset]) {
                    rotate(30) {
                        circle(d=line_space, $fn=6);
                    }
                }
            }
        }
    }
}

module dot_pattern(size, line_size, line_space) {
    rad = line_space / 2;
    y_offset = sqrt((rad + line_size / 2) * (rad + line_size / 2) * 4 - (rad + line_size / 2) * (rad + line_size / 2));
    num_x = ceil(size / rad / 2) * 1.42;
    num_y = ceil(size / y_offset) * 1.42;
    difference() {
        square([size * 1.42, size * 1.42], center = true);
        for(y = [floor(-num_y / 2) : ceil(num_y / 2)]) {
            odd = (y % 2 == 0) ? 0 : rad + line_size / 2;
            for(x = [floor(-num_x / 2) : ceil(num_x / 2)]) {
                translate([x * (rad + line_size / 2) * 2 + odd, y * y_offset]) {
                    rotate(30) {
                        circle(d=line_space);
                    }
                }
            }
        }
    }
}

module aperture_pattern(size, line_size, line_space) {
    circle(d = line_space, $fn = 8);
    for(rot = [1:2:15]) {
        rotate(360 / 16 * rot) {
            translate([line_space / 2 * cos(360 / 16) - line_size, -line_size]) {
                square([line_size, size]);
            }
        }
    }
}
