
// all dimentions in mm

// The number of connectors wide for box 1
box1_w = 2; // [0:6]
// The number of connectors tall for box 1
box1_h = 2; // [0:6]
// The number of connectors wide for box 2 (0 to disable box)
box2_w = 2; // [0:6]
// The number of connectors tall for box 2 (0 to disable box)
box2_h = 2; // [0:6]
// The number of connectors wide for box 3 (0 to disable box)
box3_w = 0; // [0:6]
// The number of connectors tall for box 3 (0 to disable box)
box3_h = 0; // [0:6]


// The amount of extra spuport to add around each box
support=0; // [0:9]

// The thickness of the margin inside the powerpole box (adjust down if it's too tight, up if it's too loose)
pp_margin=0.75;

// The length desired for each powerpole box (how far behind the box to extend); 25mm will completely cover the powerpoles
pp_depth=25;

// How deep to make the plate total (the depth of the border and screw holes)
plate_depth=5;

// The thickness of the main (middle) part of the plate
plate_thickness=2;

// The width of the plate (side to side). def 70.5mm copied from levitron standard
plate_width=70.5;

// The height of the plate (top to bottom). def 115mm copied from levitron standard
plate_height=115;

// the width of the plate border
plate_border=4;

// The radius of the screw; note most printers will actually print this a bit smaller than
// specified due to expansion, so adjust this up if the screws don't fit. Actual exact value
// for most boxes would be 1.75, but we added an extra .5 diameter because it didn't fit.
// Set this to 0 to disable the screw holes
plate_screw_shank=2;

// The radius of the top of the countersink hole for the screw
plate_screw_top=3.75;

// How deep the counter-sink for the screw should go
plate_screw_top_depth=2;

// The radius of the rounded corners on the plate. 0 for squared corners
plate_corners=3;

// The distance between the screws (83.3mm is standard for US wall boxes)
screw_distance = 83.3;


include <MCAD/boxes.scad>

// all dimentions in mm

module powerpole_box(width=2, height=2, box_only=false, length=25, margin=0.75, support=0) {
    $fa=5;
    $fs=0.2;

    wall_width = 2;
    indent_wall_width = 1;
    indent_margin = margin; // This gives us extra space to play with inside the connector so it isn't too tight
    indent_adj_width = indent_wall_width*indent_margin;
    indent_adj_gap = indent_wall_width*(1-indent_margin); 
    combined_wall_width = wall_width+indent_wall_width;
    combined_wall_width_with_margin = wall_width + indent_adj_width;

    pp_diameter = 9;
    pp_length = length;
//    pp_length=15;

    pin_diameter=2.65;
    pin_radius = pin_diameter / 2;
    pin_offset = 10;

    pp_indent_width = 5;
    pp_indent_offset = (pp_diameter-pp_indent_width)/2;

    box_width = pp_diameter * width;
    box_height = pp_diameter * height;
    
    full_width = box_width + wall_width*2;
    full_height = box_height + wall_width*2;
    
    // This allows you to use the box_only mode to subtract and have it leave visible holes even in preview mode
    // since the walls won't line up perfectly and cause issues.
    v_offset = box_only ? -0.001 : 0;

    // Center the bottom of the box on the origin to make it easier to use in other models
    translate([-(full_width/2), -(full_height/2), v_offset])
    difference() {
        
        // Draw the outside box
        union() {
            cube([full_width, full_height, pp_length]);
            if (!box_only) {
                difference() {
                    // First Draw four boxes to add support
                    union() {
                        translate([-support, -support, 0]) {
                            cube([support, full_height + (support * 2), support]);
                            cube([full_width + (support * 2), support, support]);
                        }
                        translate([full_width+support, full_height+support, 0]) {
                            rotate([0,0,180]) cube([support, full_height + (support * 2), support]);
                            rotate([0,0,180]) cube([full_width + (support * 2), support, support]);
                        }
                    }
                    // Next chop those off so only half a box remains to give a slant
                    translate([-support, -support, 0]) {
                        rotate([0,-45,0]) cube([support*2, full_height + (support * 2), support]);
                        rotate([45,0,0]) cube([full_width + (support * 2), support*2, support]);
                    }
                    translate([full_width+support, full_height+support, 0]) {
                        rotate([0,-45,180]) cube([support*2, full_height + (support * 2), support]);
                        rotate([45,0,180]) cube([full_width + (support * 2), support*2, support]);
                    }
                }
            }
        }
        
        if (!box_only) {
            // Hollow out box_width + the indent_margin
            translate([combined_wall_width_with_margin, combined_wall_width_with_margin, -0.5]) cube([box_width-indent_adj_width*2, box_height-indent_adj_width*2, pp_length+1]);
            
            // Open the notches for the housings
            for (x = [0:width-1]) {
                offset=wall_width+(pp_diameter * x)+pp_indent_offset;
                translate([offset,wall_width,-0.5])
                    cube([pp_indent_width, indent_wall_width, pp_length+1]);
                translate([offset,full_height-wall_width-indent_wall_width,-0.5])
                    cube([pp_indent_width, indent_wall_width, pp_length+1]);
            }
            for (y = [0:height-1]) {
                offset=wall_width+(pp_diameter * y)+pp_indent_offset;
                translate([wall_width,offset,-0.5])
                    cube([indent_wall_width, pp_indent_width, pp_length+1]);
                translate([full_width - wall_width - indent_wall_width, offset,-0.5])
                    cube([indent_wall_width, pp_indent_width, pp_length+1]);
            }
            
            if (width>1) {
                // Add holes for the pin(s)
                for (x = [1:width-1]) {
                    translate([wall_width+(pp_diameter*x), -0.5, pin_offset])
                        rotate([-90,0,0])
                        cylinder( box_height + combined_wall_width*2+1, pin_radius, pin_radius );
                }
            }
            
            if (height>1) {
                // Add holes for the pin(s)
                for (y = [1:height-1]) {
                    translate([-0.5, wall_width+(pp_diameter*y), pin_offset])
                        rotate([0,90,0])
                        cylinder( box_width + combined_wall_width*2+1, pin_radius, pin_radius );
                }
            }
        }
    }
}

//powerpole_box(support=7, support=7, width=3, height=2);

// size - [x,y,z]
// radius - radius of corners
module bottomrounded_box(size, radius)
{
    intersection() {
        translate([size[0]/2, size[1]/2, size[2]])
            roundedBox([size[0], size[1], size[2]*2], radius);
        cube(size);
    }
}

module wall_plate(depth=4.5,
                  thickness=2,
                  width=70.5,
                  height=115,
                  border=4,
                  screw_separation = 83.3,
                  screw_shank=2,
                  screw_top=3.5,
                  screw_top_depth=2,
                  corners=5) {
    plate_width = width;
    plate_height = height;
    plate_depth = depth;
    plate_border_width = border;
    plate_middle_thickness = thickness;
    screw_distance = screw_separation;
    screw_base = screw_shank;
    screw_top = screw_top;
    screw_taper_depth = screw_top_depth;

    // calculate the plate offsets
    plate_padding_x = plate_width / 2;
    plate_padding_y = plate_height / 2;

    translate([-plate_padding_x, -plate_padding_y, 0]) difference() {
        union() {
            difference() {
                bottomrounded_box([plate_width, plate_height, plate_depth], corners);
                // Subtract the middle/base area
                translate([plate_border_width, plate_border_width, plate_middle_thickness])
                    cube([plate_width - (plate_border_width*2), plate_height - (plate_border_width * 2), plate_depth - plate_middle_thickness + 0.01]);
            }
            
            // Draw cylinders for the screw holes
            if (screw_base > 0) {
                screw_guide_radius = screw_base + plate_border_width;
                translate([plate_width / 2, plate_height / 2 - screw_distance / 2, 0]) {
                    cylinder(plate_depth, screw_guide_radius, screw_guide_radius);
                }
                translate([plate_width / 2, plate_height / 2 + screw_distance / 2, 0]) {
                    cylinder(plate_depth, screw_guide_radius, screw_guide_radius);
                }
            }
        }
        
        if (screw_base > 0) {
            // Draw the two screw holes
            translate([plate_width / 2, plate_height / 2 - screw_distance / 2, -0.01]) {
                cylinder(plate_depth + 0.05, screw_base, screw_base);
                cylinder(screw_taper_depth, screw_top, screw_base);
            }
            translate([plate_width / 2, plate_height / 2 + screw_distance / 2, -0.01]) {
                cylinder(plate_depth+0.05, screw_base, screw_base);
                cylinder(screw_taper_depth, screw_top, screw_base);
            }
        }
    }
}

//powerpole_box(2,2,length=5);

$fa=5;
$fs=0.2;

box1 = box1_w&&box1_h;
box2 = box2_w&&box2_h;
box3 = box3_w&&box3_h;

boxes = box1 && box2 && box3 ? [[box1_w,box1_h],[box2_w,box2_h],[box3_w,box3_h]] : 
    box1 && box2 ? [[box1_w,box1_h],[box2_w,box2_h]] : 
    box1 ? [[box1_w,box1_h]] : [];

screw_padding = 5;
usable_space = screw_distance - screw_padding;
separation = usable_space / len(boxes);
padding = separation / 2;
echo(separation);

// Draw the plate
difference() {
    wall_plate( depth=plate_depth,
                thickness=plate_thickness,
                width=plate_width,
                height=plate_height,
                border=plate_border,
                screw_separation=screw_distance,
                screw_shank=plate_screw_shank,
                screw_top=plate_screw_top,
                screw_top_depth=plate_screw_top_depth,
                corners=plate_corners);

    for (x=[0:len(boxes)-1]) {
        pos = (separation * x) - (usable_space / 2) + padding;
        echo(usable_space/2 - pos);
        translate([0,pos, 0])
            powerpole_box(width=boxes[x][0],height=boxes[x][1],margin=pp_margin,length=pp_depth,box_only=true);
    }
}

for (x=[0:len(boxes)-1]) {
    pos = (separation * x) - (usable_space / 2) + padding;
    echo(usable_space/2 - pos);
    translate([0,pos, 0])
        powerpole_box(width=boxes[x][0],height=boxes[x][1],margin=pp_margin,length=pp_depth,support=support,box_only=false);
}
