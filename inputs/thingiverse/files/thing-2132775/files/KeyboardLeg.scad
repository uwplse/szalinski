// The knobs will require supports, and the round ends may need supports depending on the printer and material

//CUSTOMIZER VARIABLES

/* [Basic_Parameters] */

// Body width (not including nobs), in mm
body_width = 35.0;  // [10:0.1:80]

// Full length, in mm
full_length = 30.0;  // [10:0.1:80]

// Full height/thickness, in mm
full_height = 6.1;  // [2:0.1:20]

// Interior height/thickness, in mm
interior_height = 3.0;  // [2:0.1:20]

// Top lip length, in mm
top_lip_length = 5.0;  // [0:0.1:20]

// Bottom lip length, in mm
bottom_lip_length = 4.0;  // [0:0.1:20]

// Arm width, in mm
arm_width = 3.0;  // [1:0.1:20]

// Arm gap width, in mm
arm_gap_width = 2.85;  // [0:0.1:20]

// Arm gap length, in mm
arm_gap_length = 15.5;  // [0:0.1:20]

// Knob diameter, in mm
knob_diameter = 3.5;  // [0:0.05:20]

// Knob length, in mm
knob_length = 3.1;  // [0:0.05:20]

// Knob inset from end, in mm
knob_inset = 3.75;  // [0:0.05:20]

//CUSTOMIZER VARIABLES END



// Sanity checks

if ( (2*arm_gap_width + 2*arm_width) >= body_width)
{
    echo("<B>Error: Arms too wide for body</B>");
}

if ((top_lip_length + bottom_lip_length) > full_length)
{
    echo("<B>Error: Body too short</B>");
}


// our object, flat on xy plane for easy STL generation
keyboard_leg();

module keyboard_leg() { 
    
    knob_radius = knob_diameter / 2;
    round_diameter = full_height;
    round_radius = round_diameter / 2;
    interior_length = full_length - top_lip_length - bottom_lip_length;

    difference() {

        union() {
          
          // the main block
          translate([0,round_radius,0])
            cube([body_width,full_length-2*round_radius,full_height]);
          
          // round end on bottom of leg
          translate([0,full_length-round_radius,round_radius])
            rotate([0,90,0])
              cylinder(body_width, round_radius, round_radius, $fn=32 );
          
          // round end on top of leg
          translate([0,round_radius,round_radius])
            rotate([0,90,0])
              cylinder(body_width, round_radius, round_radius, $fn=32 );
          
          // knobs on arms
          translate([-knob_length,knob_inset,full_height/2])
            rotate([0,90,0])
              cylinder(knob_length, knob_radius, knob_radius, $fn=32 );
          translate([body_width,knob_inset,full_height/2])
            rotate([0,90,0])
              cylinder(knob_length, knob_radius, knob_radius, $fn=32 );
        
        }

        // main block hollow interior
        hollow_height = full_height - interior_height;
        hollow_y = full_length - interior_length;
        hollow_width = body_width - 2*arm_width;
        translate([arm_width,top_lip_length,interior_height])
          cube([hollow_width,interior_length,hollow_height+2]);
        
        // arm gaps
        translate([arm_width,-2,-1])
          cube([arm_gap_width,arm_gap_length+2,full_height+2]);
        translate([body_width - arm_width - arm_gap_width,-2,-1])
          cube([arm_gap_width,arm_gap_length+2,full_height+2]);

    }
}
