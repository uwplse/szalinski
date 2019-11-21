

/* [Tube Foot] */

// original 66.5, new 141.5
total_height_text_box = 141.5;

// Thickness of the main tube body
shell_width = 2;

// Tube thickness to accept the tube above it, the rest of the tube can be thicker
top_shell_width = 1.5;

// Diameter of the outside of the tube
outer_diameter_textbox = 41.75;

// Foot diameter, make it bigger to spread the weight.
foot_diameter_text_box = 51.5;

// Hight of the foot relief 
foot_relief_height_text_box = 10;

// Hole diameter at bottom of foot
foot_hole_diameter_text_box = 25;

// Vertical line length
friction_line_height_text_box = 30;

// Width of vertical friction line
friction_line_width_text_box = 1;

// Depth of vertical friction line, increase for more friction
friction_line_depth_text_box = 0.25;

// offset of vertical friction line
friction_line_top_offset_text_box = 4.5;

main_height_text_box = total_height_text_box - foot_relief_height_text_box;

top_innertube_height = friction_line_height_text_box + 2*friction_line_top_offset_text_box;


module build_tube(){
    difference(){
        union(){
        
            // Full tube
            translate([0, 0, foot_relief_height_text_box]) cylinder(main_height_text_box, r=outer_diameter_textbox/2, center=false);

            // Fiction line
            translate([0, 0, foot_relief_height_text_box + main_height_text_box - friction_line_top_offset_text_box - friction_line_height_text_box/2]) cube([friction_line_width_text_box, outer_diameter_textbox + 2*friction_line_depth_text_box, friction_line_height_text_box], center=true);
            
            // Fiction line
            rotate([0,0,90]) translate([0, 0, foot_relief_height_text_box + main_height_text_box - friction_line_top_offset_text_box - friction_line_height_text_box/2]) cube([friction_line_width_text_box, outer_diameter_textbox + 2*friction_line_depth_text_box, friction_line_height_text_box], center=true);
            
            // Main foot
            cylinder(foot_relief_height_text_box, r1=foot_diameter_text_box/2, r2=outer_diameter_textbox/2, center=false);
            
        }
            
        
        // Make top part of tube correct shell width to fit with original parts
        translate([0, 0, foot_relief_height_text_box + main_height_text_box - top_innertube_height]) cylinder(top_innertube_height, r=(outer_diameter_textbox - 2*top_shell_width)/2, center=false);
            
        // Hollow part of tube
        translate([0, 0, shell_width]) cylinder(main_height_text_box + foot_relief_height_text_box, r= (outer_diameter_textbox - 2*shell_width)/2, center=false);
        
        // Bottom foot hole
        cylinder(foot_relief_height_text_box * 3, r=foot_hole_diameter_text_box/2, center=true);

    }
}

build_tube();
    
    