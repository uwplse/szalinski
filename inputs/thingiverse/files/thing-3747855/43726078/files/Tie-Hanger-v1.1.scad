
/* [General] */

// Thickness of the part in the Z dimension. Increase to make a sturdier part.
thickness=4; // [2:10]

// Thickness of the walls in the X and Y dimensions. Increase to make a sturdier part.
wall_thickness=5; // [3:8]

/* [Hook] */

// Inner diameter of the hook. Recommended to set this at least 0.5mm larger than the target rod.
hook_size=35.5; // [2:0.5:100]

// How much extra space to put in the hook opening. If set to 0, the opening will be exactly the same as Hook Size. Positive values will result in a larger opening, negative values will result in a smaller opening. Values lower than -(Hook Size / 2) would violate the geometry of the hook, so will automatically be changed to the lowest valid value.
hook_extra_space=0; // [-50:50]


/* [Tie Sections] */

// The number of tie rows on the hanger.
tie_count=8; // [1:20]

// Whether or not the hanger is double-sided.
double_sided=true; // [true,false]

// The width of each tie section flat area.
tie_section_width=40; // [20:60]

// The height of the hook at the end of each tie section.
tie_section_hook_height=2.5; // [1:0.5:5]

// The height of the gap above the tie section hook. Too small values will make it difficult to use.
tie_section_gap_height=9; // [1:10]

// Only works when Double Sided = true. Shift each layer of the tie section outward by this amount so that the ties are staggered.
tie_section_shift=0.5; // [0:50]

// https://www.thingiverse.com/thing:3747855 remix of https://www.thingiverse.com/thing:1759354
//Calculated
top_bar_y=wall_thickness/2;
each_bar_y_multiplier=-(wall_thickness+tie_section_hook_height+tie_section_gap_height);
tie_section_left_x=double_sided?(-(tie_section_width+wall_thickness*2)):-(tie_section_width+wall_thickness*2)/2;
tie_section_right_x=double_sided?(tie_section_width+wall_thickness*2):(tie_section_width+wall_thickness*2)/2;
real_hook_extra_space=(hook_extra_space<-(hook_size/2))?-(hook_size/2):hook_extra_space;


union() {
    // Main hook
    union() {
        // oster addition
        translate([2, 0, 0]) {
          cylinder(d=5,h=thickness);
        }
        // oster addition
        translate([-2, 0, 0]) {
          cylinder(d=5,h=thickness);
        }

        // Hook surround
        difference() {
            // Outside
            hull() {
                // Bottom of hook should be at 0,0
                translate([0,hook_size/2+wall_thickness,0]) cylinder(d=hook_size+wall_thickness*2,h=thickness,$fn=40);
                // Top of the hook should be above
                translate([0,hook_size/2+wall_thickness+hook_size/2+real_hook_extra_space,0]) cylinder(d=hook_size+wall_thickness*2,h=thickness,$fn=40);
            }
            // Inside (subtracted)
            hull() {
                translate([0,hook_size/2+wall_thickness,0]) cylinder(d=hook_size,h=thickness*3,center=true,$fn=40);
                translate([0,hook_size/2+wall_thickness+hook_size/2+real_hook_extra_space,0]) cylinder(d=hook_size,h=thickness*3,center=true,$fn=40);
            }
            // Opening (subtracted)
            translate([-(hook_size/2+wall_thickness+1),0,-1]) cube([hook_size/2+wall_thickness+1,hook_size+wall_thickness*1+real_hook_extra_space,thickness*3]);
        }
        
        // Ball on end of hook
        translate([-(hook_size+wall_thickness)/2,(hook_size+wall_thickness+real_hook_extra_space),0]) cylinder(d=wall_thickness,h=thickness,$fn=40);
    }
    
    // Straight across top bar
    translate([0,top_bar_y,0]) {
        hull() {
            translate([tie_section_left_x,0,0]) cylinder(d=wall_thickness,h=thickness,$fn=40);
            translate([tie_section_right_x,0,0]) cylinder(d=wall_thickness,h=thickness,$fn=40);
        }
    }
    
    middle_support_x=double_sided?0:(tie_section_width+wall_thickness*2)/2;
    middle_support_left_x=double_sided?middle_support_x-tie_count*tie_section_shift:middle_support_x;
    middle_support_right_x=double_sided?middle_support_x+tie_count*tie_section_shift:middle_support_x;
    // Middle support 1 (left)
    hull() {
        translate([middle_support_x,top_bar_y,0]) cylinder(d=wall_thickness,h=thickness,$fn=40);
        translate([middle_support_left_x,top_bar_y+tie_count*each_bar_y_multiplier,0]) cylinder(d=wall_thickness,h=thickness,$fn=40);
    }
    // Middle support 2 (right)
    hull() {
        translate([middle_support_x,top_bar_y,0]) cylinder(d=wall_thickness,h=thickness,$fn=40);
        translate([middle_support_right_x,top_bar_y+tie_count*each_bar_y_multiplier,0]) cylinder(d=wall_thickness,h=thickness,$fn=40);
    }
    
    // Each tie section
    for (i = [0:tie_count]) {
        this_section_left_x=double_sided?tie_section_left_x-(i*tie_section_shift):tie_section_left_x;
        this_section_right_x=double_sided?tie_section_right_x+(i*tie_section_shift):tie_section_right_x;
        translate([0,top_bar_y + (i*each_bar_y_multiplier),0]) {
            // Cross bar for tie section
            hull() {
                translate([this_section_left_x,0,0]) cylinder(d=wall_thickness,h=thickness,$fn=40);
                translate([this_section_right_x,0,0]) cylinder(d=wall_thickness,h=thickness,$fn=40);
            }
            // Left hook
            hull() {
                translate([this_section_left_x,0,0]) cylinder(d=wall_thickness,h=thickness,$fn=40);
                translate([this_section_left_x,tie_section_hook_height,0]) cylinder(d=wall_thickness,h=thickness,$fn=40);
            }
            // Right hook
            hull() {
                translate([this_section_right_x,0,0]) cylinder(d=wall_thickness,h=thickness,$fn=40);
                translate([this_section_right_x,tie_section_hook_height,0]) cylinder(d=wall_thickness,h=thickness,$fn=40);
            }
        }
    }
}
