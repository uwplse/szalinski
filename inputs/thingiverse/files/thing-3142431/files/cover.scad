// Page width (mm)
width = 139.7;
// Page height (mm)
height = 215.9;
// Cover thickness (mm)
thickness = 1.5;
// Distance between page border and hole (mm)
border_distance = 2.5;
// Title line 1
title_line1 = "The petal";
// Title line 2
title_line2 = "falls twice";
// Title font size
font_size = 12;
// Title font name
font_name = "DejaVu Serif";
// How high should be the text
title_height = 1.5;
// Should the text be embossed? 
emboss = true;

module hole(height, x, y) {
    hull() {
        d = abs(x-y);
        cylinder(h=height, d=y, center=true);
        translate([d,0,0]) {
            cylinder(h=height, d=y, center=true);
        }
    }
}

module title(line1, line2, font_size = font_size, font_name = font_name, height = title_height, width = width, height = height) {
    translate([width/2,height*0.75, thickness]) {
        linear_extrude(height=1.5) text(line1, font = font_name, size=font_size, halign="center");
}

    translate([width/2,height*0.75-(font_size*1.5), thickness]) {
        linear_extrude(height=1.5) text(line2, font = font_name, size=font_size, halign="center");
    }
}

module this_title() {
    title(title_line1, title_line2, font_size);
}

$fs = 1;
hole_y = 4;
hole_x = 5;
hole_radius = hole_x/2;

difference() {
// draw the cover thing
    cube([width, height, thickness]);

//    // make the 4:1 holes
    for(pos = [2.25+hole_y/2:hole_y+2.25:height]) {
        translate([border_distance+hole_radius, pos]) {
            hole(thickness*4, hole_x, hole_y);
        }
    }
    
    if (emboss) translate([0,0,-1]) this_title();
}

if (!emboss) this_title();