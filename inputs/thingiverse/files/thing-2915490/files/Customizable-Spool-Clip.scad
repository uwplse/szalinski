// preview[view:north east, tile:top diagonal]

/* [Basics] */
spool_type = -1; // [-1:Choose a spool type,1:Ultimaker 750-gram, 2:Ultimaker 350-gram, 3:MatterHackers Pro 1kg, 4:MatterHackers Build 1kg, 5:XYZPrinting PLA, 0:User-measured (set spool dimensions below)]

// What label do you want on the clip? ("ABS", "PLA", etc.) You can leave this blank if you want a clip without a label.
label_text = "PLA";

// What size do you want the text to be? (Larger numbers are bigger)
label_size = 6; // [6, 5, 4]

/* [Label tweaks] */

// Do you want the label text to be raised from the clip, or embossed into it?
label_direction = -1; // [1:Raised text, -1:Embossed text]

// Height by which the text is raised from the clip (or embossed into the clip if you chose that option)
label_height_or_depth = 0.8;

// Do you want the spool dimensions to be embossed on the back of the clip?
dimension_label = 1; // [1:Yes, 0:No]

/* [User-measured Spool Measurements] */

// What filament size does this spool hold? (You only have to set this if you choose a Spool Type of User-Measured.)
custom_spool_filament_size = 2.85; // [1.75,2.85]
// How wide is the spool, in millimeters? (You only have to set this if you chose a Spool Type of User-measured. See the instructions to determine how to measure this.)
custom_spool_width = 50; 
// What's the height of the outer lip of the spool, in millimeters? (You only have to set this if you chose a Spool Type of User-measured. See the instructions to determine how to measure this.)
custom_spool_lip_height = 10;
// What's the width of the outer lip of the spool, in millimeters? (You only have to set this if you chose a Spool Type of User-measured. See the instructions to determine how to measure this.)
custom_spool_lip_thickness = 3;

/* [Filament Hole Fine-Tuning] */
// What kind of holes should the clip have? Round holes look best, but they tend to print out smaller than designed, and the shrinkage varies from printer to printer; you may need to experiment to find the best hole sizes for your printer. Multi-sided holes are squares, pentagons, etc.; they look odd, but they have much more predictable sizes on most printers, making them easier.
hole_type = 1; // [0:Round holes, 1:Multi-sided holes]
// Do you want to use the suggested hole clearances, or your own custom ones?
hole_clearances = 0; // [0:Suggested clearances, 1:Custom clearances]
// How many millimeters bigger than the filament thickness should the smallest hole be? (You only have to set this if you chose a Hole Clearances type of Custom. Suggested clearance: 0.30 for round holes, 0.15 for multi-sided holes.)
custom_small_hole_clearance = 0.15; 
// How many millimeters bigger than the filament thickness should the middle hole be? (You only have to set this if you chose a Hole Clearances type of Custom. Suggested clearance: 0.42 for round holes, 0.28 for multi-sided holes.)
custom_middle_hole_clearance = 0.28;
// How many millimeters bigger than the filament thickness should the largest hole be? (You only have to set this if you chose a Hole Clearances type of Custom. Suggested clearance: 0.55 for round holes, 0.40 for multi-sided holes.)
custom_large_hole_clearance = 0.40; 


/* [Hidden] */

// BEGIN BOILERPLATE CODE: Parameter conversion
// Convert strings to floating point for compatibility with Customizer
// Conversion code by jesse (https://www.thingiverse.com/thing:2247435)
function atoi(str, base=10, i=0, nb=0) =
	i == len(str) ? (str[0] == "-" ? -nb : nb) :
	i == 0 && str[0] == "-" ? atoi(str, base, 1) :
	atoi(str, base, i + 1,
		nb + search(str[i], "0123456789ABCDEF")[0] * pow(base, len(str) - i - 1));

function substr(str, pos=0, len=-1, substr="") =
	len == 0 ? substr :
	len == -1 ? substr(str, pos, len(str)-pos, substr) :
	substr(str, pos+1, len-1, str(substr, str[pos]));
    
function atof(str) = len(str) == 0 ? 0 : let( expon1 = search("e", str), expon = len(expon1) ? expon1 : search("E", str)) len(expon) ? atof(substr(str,pos=0,len=expon[0])) * pow(10, atoi(substr(str,pos=expon[0]+1))) : let( multiplyBy = (str[0] == "-") ? -1 : 1, str = (str[0] == "-" || str[0] == "+") ? substr(str, 1, len(str)-1) : str, decimal = search(".", str), beforeDecimal = decimal == [] ? str : substr(str, 0, decimal[0]), afterDecimal = decimal == [] ? "0" : substr(str, decimal[0]+1) ) (multiplyBy * (atoi(beforeDecimal) + atoi(afterDecimal)/pow(10,len(afterDecimal)))); 

function aorftof(numorstr) = (numorstr + 1 == undef) ? atof(numorstr) : numorstr;
function aoritoi(numorstr) = (numorstr + 1 == undef) ? atoi(numorstr) : numorstr;
// END BOILERPLATE CODE: Parameter conversion

// Customizers may convert numeric parameters into strings; so convert them back
spool_type_index = aoritoi(spool_type);
label_text_size = aoritoi(label_size);
label_text_direction = aoritoi(label_direction);
label_text_height_or_depth = aorftof(label_height_or_depth);
usermeasured_spool_filament_size = aorftof(custom_spool_filament_size);
usermeasured_spool_width = aorftof(custom_spool_width); 
usermeasured_spool_lip_height = aorftof(custom_spool_lip_height);
usermeasured_spool_lip_thickness = aorftof(custom_spool_lip_thickness);
use_polyholes = aoritoi(hole_type);
use_custom_hole_offsets = aoritoi(hole_clearances);
small_hole_offset = use_custom_hole_offsets ? aorftof(custom_small_hole_clearance) : (use_polyholes ? 0.15 : 0.30);
medium_hole_offset = use_custom_hole_offsets ? aorftof(custom_middle_hole_clearance) : (use_polyholes ? 0.28 : 0.42);
large_hole_offset = use_custom_hole_offsets ? aorftof(custom_large_hole_clearance) : (use_polyholes ? 0.40 : 0.55);
use_backlabel = aoritoi(dimension_label);
usermeasured_spool_diameter = 200 + 0; // Not implemented yet

// Each entry in the spool_dimensions_all vector is the filament size, width,
// lip height, and lip thickness of a spool. For the Customizer to work
// properly, this must match the special comment on the spool_type
// variable declaration.
spool_dimensions_all = [
    [usermeasured_spool_filament_size, usermeasured_spool_width, usermeasured_spool_lip_height, usermeasured_spool_lip_thickness, usermeasured_spool_diameter], // User-measured spool
    [2.85, 52.0, 3.0, 1.1, 200], // Ultimaker 750g spool
    [2.85, 32.1, 3.0, 1.1, 200], // Ultimaker 350g spool
    [2.85, 71.2, 6.5, 1.5, 200], // MatterHackers 1kg PRO PLA spool
    [2.85, 66.7, 8.0, 1.6, 200], // MatterHackers 1kg BUILD PLA spool
    [1.75, 53.0, 1.7, 0.5, 170], // XYZPrinting PLA spool
];

spool_dimensions = spool_dimensions_all[spool_type_index];
filament_size = spool_dimensions[0];
spool_width = spool_dimensions[1];
spool_lip_height = spool_dimensions[2];
spool_lip_thickness = spool_dimensions[3];
spool_diameter = spool_dimensions[4];
spool_side_thickness = 3+0; // Not implemented yet

small_hole_diameter = filament_size + small_hole_offset;
medium_hole_diameter = filament_size + medium_hole_offset;
large_hole_diameter = filament_size + large_hole_offset;

// Thickness of the crossbar, sidebars, and catchbars, in mm
// For raised text, we can use a thin crossbar; for embossed text, we need to thicken the crossbar so the label doesn't weaken it
crossbar_thickness = (label_text_direction > 0) ? 2 : 2 + label_text_height_or_depth;
sidebar_thickness = 2 + 0;
catchbar_thickness = 2 + 0;

// Width of the whole clip
clip_width = 10 + 0;

crossbar_length = spool_width + (sidebar_thickness * 2); 

sidebar_length = spool_lip_height + 1 + crossbar_thickness + catchbar_thickness;

catchbar_length = spool_lip_thickness + sidebar_thickness;


spacing_between_holes = 1.5;
clearance_around_holes = 1.5;

holeblock_length = small_hole_diameter + medium_hole_diameter + large_hole_diameter + (clearance_around_holes * 2) + (spacing_between_holes * 2);
holeblock_height = crossbar_thickness + (clearance_around_holes * 2)+ large_hole_diameter;


// BEGIN BOILERPLATE CODE: Assertion checking and error message display
// DisplayErrorsInPreview code by kickahaota (https://www.thingiverse.com/thing:2918930)
// Assertions we want to verify before making the real object
function isdef(x) = (x != undef);
function isnumeric(x) = isdef(x) && ( x + 0 == x);
function isinteger(x) = isdef(x) && ( floor(x) == x) ;
module showfailedassertions() {
    for(idx = [0 : len(assertions)-1]) {
        if (!assertions[idx][0]) {
            translate([0, -12*idx, 0]) linear_extrude(height=1) text(text=assertions[idx][1]);
        }
    }
}

function anyassertionfailed(idx = len(assertions)-1) = (!(assertions[idx][0]) ? 1 : (idx <= 0) ? 0 : anyassertionfailed(idx-1)); 
// END BOILERPLATE CODE: Assertion checking and error message display

// Conditions that must be met for the tower to be printed
assertions = [
    [ ((spool_type_index >= -1) && (spool_type_index < len(spool_dimensions_all))), "Incorrect spool type -- may be a customizer problem; please leave a comment" ],
    [ spool_type_index >= 0, "Please choose a spool type to begin" ] ,
    [ ((label_text_size >= 2) && (label_text_size <= 10)), "Label text size must be between 2 and 10" ],
    [ abs(label_text_direction) == 1, "Incorrect label text direction -- may be a customizer problem; please leave a comment" ],
    [ label_text_height_or_depth > 0.5, "Label height/depth must be positive and must be at least 0.5 millimeters" ],
    [ ((small_hole_offset >= 0) && (small_hole_offset <= 1.0)), "Small hole clearance must be between 0 and 1 millimeter" ],
    [ ((medium_hole_offset >= 0) && (medium_hole_offset <= 1.0)), "Medium hole clearance must be between 0 and 1 millimeter" ],
    [ ((large_hole_offset >= 0) && (large_hole_offset <= 1.0)), "Large hole clearance must be between 0 and 1 millimeter" ],
    [ small_hole_offset <= medium_hole_offset, "Medium hole clearance must be at least as large as small hole clearance" ],
    [ medium_hole_offset <= large_hole_offset, "Large hole clearance must be at least as large as medium hole clearance" ],
    [ ((0 == use_polyholes) || (1 == use_polyholes)), "Incorrect hole type -- may be a customizer problem; please leave a comment" ],
// We only have to care about the custom spool parameters if the custom spool type is actually selected
    [ ((spool_type_index != 0) || ((usermeasured_spool_filament_size >= 1.0) && (usermeasured_spool_filament_size <= 5.0))), "Custom spool filament size must be between 1 and 5 millimeters" ],
    [ ((spool_type_index != 0) || (usermeasured_spool_width >= 10.0)), "Custom spool width must be at least 10 millimeters" ] ,
    [ ((spool_type_index != 0) || (usermeasured_spool_lip_height >= 0)), "Custom spool lip height must be positive or zero" ],
    [ ((spool_type_index != 0) || (usermeasured_spool_lip_thickness >= 0)), "Custom spool lip thickness must be positive or zero" ]
];

// Using this holes should come out approximately right when printed
module polyhole(h, d) {
    n = max(round(2 * d),3);
    rotate([0,0,180])
        cylinder(h = h, r = (d / 2) / cos (180 / n), $fn = n);
}

module crossbar() {
    translate([-crossbar_length/2, -clip_width/2, 0]) {
        cube([crossbar_length, clip_width, crossbar_thickness]);
    }
}

module label() {
    
    // For raised text, we want to start right at the surface of the clip (actually just a teeny bit below the
    // surface to avoid rounding errors that might disconnect the text from the clip), and extrude outwards. 
    // For embossed text, we want to start at the appropriate depth 
    translate([0, 0, ((label_text_direction > 0) ? -0.001 : label_text_height_or_depth)]) {
        rotate([180,0, 180]) {
            linear_extrude(height=label_text_height_or_depth + 0.002) {
                text(text=label_text, size=label_text_size, font="Helvetica:Bold", halign="center", valign="center");
            }
        }
    }
}

module backlabel() {
    backlabel_thickness = 0.4;
    distance_from_holeblock = 1.2;
    if (use_backlabel)
    {
        translate([-(holeblock_length/2) - distance_from_holeblock, 0, crossbar_thickness - backlabel_thickness]) {
            linear_extrude(height=backlabel_thickness + 0.001) {
                text(text=str(spool_width, "mm"), size=4, font="Helvetica:Bold", halign="right", valign="center");
            }
        }
        translate([(holeblock_length/2) + distance_from_holeblock, 0, crossbar_thickness - backlabel_thickness]) {
            linear_extrude(height=backlabel_thickness + 0.001) {
                text(text=str(spool_lip_height, "[", spool_lip_thickness, "]"), size=4, font="Helvetica:Bold", halign="left", valign="center");
            }
        }
    }
}

module sidebar() {
    translate([-crossbar_length/2, -clip_width/2, 0]) {
        cube([sidebar_thickness, clip_width, sidebar_length]);
    }
}

module sidebars() {
    sidebar();
    mirror([1,0,0]) { sidebar(); }
}

module catchbar() {
    translate([-crossbar_length/2, -clip_width/2, sidebar_length-catchbar_thickness]) {
        cube([catchbar_length, clip_width, catchbar_thickness]);
    }
}

module catchbars() {
    catchbar();
    mirror([1,0,0]) { catchbar(); }
}

module hole(height, diameter)
{
    if (use_polyholes > 0)
    {
        polyhole(height, diameter);
    }
    else
    {
        cylinder(h=height, d=diameter, $fn=30);
    }
}
        
module holeblock() {
    z_translate = crossbar_thickness + clearance_around_holes + (large_hole_diameter / 2);
    translate([-holeblock_length/2, -clip_width/2, 0]) {
        difference() {
            cube([holeblock_length, clip_width, holeblock_height]);
            translate([clearance_around_holes + (small_hole_diameter/2), 0, z_translate]) {
                rotate([270,0,0]) {
                    hole(clip_width, small_hole_diameter);
                }
            }
            translate([clearance_around_holes + small_hole_diameter + spacing_between_holes + (medium_hole_diameter/2), 0, z_translate]) {
                rotate([270,0,0]) {
                    hole(clip_width, medium_hole_diameter);
                }
            }
            translate([clearance_around_holes + small_hole_diameter + medium_hole_diameter + (2*spacing_between_holes) + (large_hole_diameter/2), 0, z_translate]) {
                rotate([270,0,0]) {
                    hole(clip_width, large_hole_diameter);
                }
            }
        }
    }
}

module wholeclipminuslabel()
{
    difference()
    {
        union()
        {
            crossbar();
            sidebars();
            catchbars();
            holeblock();
        }
        backlabel();
    }
}

module spoolside() {
    translate([-spool_width/2, spool_diameter/2, spool_diameter/2])
    {
        rotate([0,90,0])
        {
            cylinder(r=spool_diameter/2, h=spool_side_thickness, $fn=100);
        }
    }
}

module spool()
{
    %union() {
        union()
        {
            spoolside();
            mirror([1,0,0]) { spoolside(); }
        };
        translate([-spool_diameter/2, spool_diameter/2, sidebar_length+10])
        {
            cube(spool_diameter);
        };
    }
}
module wholething()
{
    translate([0,0,clip_width/2])
    {
        rotate([90,0,0])
        {
            if (label_text_direction > 0)
            {
                // Raised label text -- just print the union of all the parts in the usual way
                wholeclipminuslabel();
                label();
            }
            else
            {
                // Embossed label text -- carve the label's text out of the rest of the clip
                difference()
                {
                    wholeclipminuslabel();
                    label();
                }
            }
        }
    }
}

// Actually render the thing, or explain why we can't
if (anyassertionfailed())
{
    rotate([0,0,135]) showfailedassertions();
}
else
{
    wholething();
}
