echo(version=version());
// Parameters used to generate model (Values are measured in mm)

//Preset settings for default 65mm wide baths
comb_preset = 8; //[8, 9, 15, 17, Custom]
// Label or name you want to appear on the side
text_label = "Your Text Here"; 

// Include square blocks on bottom of support
locking_block_supports = "yes"; // [yes, no]
// Thickness of each tooth  (in mm)
tooth_thickness = 1.5; 

 
/*[Custom Dimensions]*/
// Number of wells
custom_tooth_count = 8; 
// Width of each tooth  (in mm)
custom_tooth_width = 5.6; 
// Spacing between teeth.  (in mm)
custom_tooth_gap = 1.6; 
// Length of teeth (measured in mm perpendicular from bottom of support)
tooth_length = 17.75;  
// Height of upper support on teeth  (in mm)
tooth_support = 6;

/////////////////////
// OPENSCAD CODE
/////////////////////
union(ep_comb) { 

// Primary support bar 
    translate([0, 0, 0])
    linear_extrude(height = 5, scale = 0.95)
    square([body_x, body_y], center = true);

//Handles
     // Handle Center
        translate([0, 0, body_z])
        linear_extrude(height = 7, scale = 0.6)
        square([20, 4], center = true);
    // Handle left
        translate([(-body_x/2)+11.75, 0, body_z])
        linear_extrude(height = 5, scale = 0.6)
        square([20, 4], center = true);
    // Handle right
        translate([(body_x/2)-11.75, 0, body_z])
        linear_extrude(height = 5, scale = 0.6)
        square([20, 4], center = true);

// Left support square
	// Support base 
        translate([(-body_x/2)+2.5, 0, 0])
    	linear_extrude(height = 2)
    	square([5, 15], center = true);
	// Angled Support
        translate([(-body_x/2)+2.5, 0, 2])
        linear_extrude(height = 3, scale = 0.3)
        square([5, 15], center = true);
    
// Right support square
	// Support base 
        translate([(body_x/2)-support_x, 0, 0])
    	linear_extrude(height = 2)
    	square([5, 15], center = true);
    // Angled Support
        translate([(body_x/2)-support_x, 0, 2])
        linear_extrude(height = 3, scale = 0.3)
        square([5, 15], center = true);

// Text placed on body of comb
    logo(text_label); 

// Locking Blocks.
	if(locking_block_supports == "yes")
	{
    
    // Right
        translate([(body_x/2)-support_x, 0, -support_z]) linear_extrude(height = support_z) square([support_x, support_y], center = false); 

    // Left
        translate([-body_x/2, 0, -support_z]) linear_extrude(height = support_z) square([support_x, support_y], center = false); 
	}

/* Teeth Presets */
// 8 Teeth
if(comb_preset == 8)
    {
        tooth_count = 8;
        tooth_width = 5.6;
        tooth_gap = 1.2;
        translate([tooth_margin, 0, -tooth_length/2]) union() {
            for(i = [0:tooth_count-1]) {
                translate([i * (tooth_width + tooth_gap), 0, 0]) 
                cube([tooth_width, tooth_thickness, tooth_length], center=true);
            }
        }
    // Teeth support  
        translate([0, 0, -tooth_support])
        linear_extrude(height = tooth_support)
        square([(tooth_width*tooth_count)+(tooth_gap*(tooth_count-1)), tooth_thickness], center = true);
    
        tooth_margin = -(((tooth_count-1)*tooth_width)/2+((tooth_count-1)*tooth_gap)/2); 
	}
// 9 Teeth
if(comb_preset == 9)
    {
        tooth_count = 9;
        tooth_width = 5.0;
        tooth_gap = 1.2;
        translate([tooth_margin, 0, -tooth_length/2]) union() {
            for(i = [0:tooth_count-1]) {
                translate([i * (tooth_width + tooth_gap), 0, 0]) 
                cube([tooth_width, tooth_thickness, tooth_length], center=true);
            }
        }
    // Teeth support  
        translate([0, 0, -tooth_support])
        linear_extrude(height = tooth_support)
        square([(tooth_width*tooth_count)+(tooth_gap*(tooth_count-1)), tooth_thickness], center = true);
    
        tooth_margin = -(((tooth_count-1)*tooth_width)/2+((tooth_count-1)*tooth_gap)/2); 
	}
// 15 Teeth
if(comb_preset == 15)
    {
        tooth_count = 15;
        tooth_width = 2.8;
        tooth_gap = 1;
        translate([tooth_margin, 0, -tooth_length/2]) union() {
            for(i = [0:tooth_count-1]) {
                translate([i * (tooth_width + tooth_gap), 0, 0]) 
                cube([tooth_width, tooth_thickness, tooth_length], center=true);
            }
        }
    // Teeth support  
        translate([0, 0, -tooth_support])
        linear_extrude(height = tooth_support)
        square([(tooth_width*tooth_count)+(tooth_gap*(tooth_count-1)), tooth_thickness], center = true);
    
        tooth_margin = -(((tooth_count-1)*tooth_width)/2+((tooth_count-1)*tooth_gap)/2); 
	}
// 17 Teeth
if(comb_preset == 17)
    {
        tooth_count = 17;
        tooth_width = 2.3;
        tooth_gap = 1;
        translate([tooth_margin, 0, -tooth_length/2]) union() {
            for(i = [0:tooth_count-1]) {
                translate([i * (tooth_width + tooth_gap), 0, 0]) 
                cube([tooth_width, tooth_thickness, tooth_length], center=true);
            }
        }
    // Teeth support  
        translate([0, 0, -tooth_support])
        linear_extrude(height = tooth_support)
        square([(tooth_width*tooth_count)+(tooth_gap*(tooth_count-1)), tooth_thickness], center = true);
    
        tooth_margin = -(((tooth_count-1)*tooth_width)/2+((tooth_count-1)*tooth_gap)/2); 
	}
// Custom Teeth
if(comb_preset == "Custom")
    {
        tooth_count = custom_tooth_count;
        tooth_width = custom_tooth_width;
        tooth_gap = custom_tooth_gap;
        translate([tooth_margin, 0, -tooth_length/2]) union() {
            for(i = [0:tooth_count-1]) {
                translate([i * (tooth_width + tooth_gap), 0, 0]) 
                cube([tooth_width, tooth_thickness, tooth_length], center=true);
            }
        }
    // Teeth support  
        translate([0, 0, -tooth_support])
        linear_extrude(height = tooth_support)
        square([(tooth_width*tooth_count)+(tooth_gap*(tooth_count-1)), tooth_thickness], center = true);
    
        tooth_margin = -(((tooth_count-1)*tooth_width)/2+((tooth_count-1)*tooth_gap)/2); 
	}

}

body_x = 84.84;
body_z = 5;
body_y = 5;

support_x = 2.72;
support_y = 2.55;
support_z = 2.64;


module logo(t, s = 2.5, style = "") {
  translate([0, -body_y/2+.75, 1])
    rotate([90, 0, 0]) color("red")
    linear_extrude(height = 1)
    text(t, size = s, font = str("Liberation Sans", style),  halign = "center");
}
/*
* Customizable Electrophoresis Comb (width-65mm)
* 
* Copyright (c) 2016 Adm Chrysler
* www.admchrysler.com / chrysler@cornell.edu
* Licensed under the Creative Commons
* Attribution - Non-Commercial - Share Alike license.
*
*/
