/*

        Super Customizable Lego Technic Beam
        Modified by Christopher Litsinger
        January 2018

    Inspired by TUSH - A remix of many!
    by spongybob1958, published Sep 7, 2017
    https://www.thingiverse.com/thing:2521463
*/

/* [Customize] */
//the maximum length of the overall rail
rail_length_max=80;
//the size of the gaps 
gap_length=3.03;
//the size of the peaks 
peak_length=2.535;
//how wide should the rail be
rail_width = 19.5;
//do you want screw tabs on the end?
screw_tabs = "no"; // [yes, no]
//do you want a center m4 hole?
center_hole="yes"; //[yes, no]
//what is the radius for the screws you're using to attach the rail
screw_radius = 3;

// preview[view:south, tilt:top]
// Model - Start

tab_offset = (screw_tabs == "yes") ? rail_width : 0;

segment_height = max(gap_length, peak_length);

num_segments = floor((rail_length_max - tab_offset)/(gap_length+peak_length));

module draw_tabs() {
    difference() {
        translate([num_segments*(gap_length+peak_length) + peak_length, rail_width/2, 0]) {
            cylinder(r=rail_width/2, h=segment_height*2, $fn=32);
            }
        translate([num_segments*(gap_length+peak_length) + peak_length - rail_width/2, 0, -1]) {
                cube([rail_width/2,rail_width, segment_height * 3]);
            }
        translate([num_segments*(gap_length+peak_length) + peak_length + screw_radius, rail_width/2, -1]) {
            cylinder(r=screw_radius, h=segment_height*3, $fn=32);
            }
        }
    difference() {
        translate([0, rail_width/2, 0]) {
            cylinder(r=rail_width/2, h=segment_height*2, $fn=32);
            }
        translate([0, 0, -1]) {
                cube([rail_width/2,rail_width, segment_height * 3]);
            }
        translate([-screw_radius, rail_width/2, -1]) {
            cylinder(r=screw_radius, h=segment_height*3, $fn=32);
            }
        }

}


module draw_center_hole() {
    translate([(num_segments*(gap_length+peak_length) + peak_length)/2, rail_width/2, -1]) {
        cylinder(r=1.989, h = segment_height *3, $fn=64);
        }
    translate([(num_segments*(gap_length+peak_length) + peak_length)/2, rail_width/2, segment_height - (segment_height/2)]) {
        cylinder(r=3.5, h=segment_height*2+1, $fn=6);
        }
}

difference() {
    union() {
        cube([(num_segments*(gap_length+peak_length) + peak_length), rail_width, segment_height]);
        for (ii = [0:num_segments]) {
                translate([ii*(gap_length+peak_length), 0, segment_height]) {
                    cube([(peak_length), rail_width, segment_height]);
                }
            }
        
        
        if (screw_tabs == "yes") {
            draw_tabs();
            }
        }    
    if (center_hole == "yes") draw_center_hole();
}
