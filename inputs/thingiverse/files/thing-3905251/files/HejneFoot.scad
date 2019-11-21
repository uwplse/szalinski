/* [General] */

// Height for the sleeve.
height = 10;

// Adjust this parameter, if the sleeve is to tight or to loose.
gap = 0.5;

// The thickness of the sleeve (and the bottom).
thickness = 1.5;

// The height of the bottom. Can be used to angle the shelf.
height_spacer = 0;

/* [Screw] */

// Create a hole for a screw to fix the feet.
screw = true;

// Diameter of the screw hole.
screw_hole_diameter = 2.5;

// Diameter of the screw head. For embedding the head in the sleeve.
screw_head_diameter = 5;

/* [Label] */

// Embed the version number and the height of the bottom in the bottom.
label = true;

// Text for the version number.
version_number = "v1.1";

// The font type for the label.
font_type = "";

// The text height in mm.
text_size = 6;

// The depth for the text. Adjust to first layer height.
text_depth = 0.28;

/* [Hidden] */

// The length of the feet.
length = 70;

// The width of the feet.
width = 14;

// The diameter of the rounded corners.
corner_diameter = 6;

$fa = 1;
$fs = 0.01;

module shape(length, width, height, diameter)
{
    hull()
    {
        translate([diameter/2, diameter/2, 0])
        {
            for(i = [0,1])
            {
                for(j = [0,1])
                {
                    translate([i*(length-diameter), j*(width-diameter), 0])
                    {
                        cylinder(d=diameter, h=height);
                    }
                }
            }
        }
    }
}

module label(text)
{
    linear_extrude(text_depth)
    {
        rotate([180,0,0])
        {
//            resize([0,text_size], auto=true)
            {
                text(text, font=font_type, halign="center", valign="center", size=text_size);
            }
        }
    }
}

module feet()
{
    h = height_spacer < thickness ? thickness : height_spacer;
    difference()
    {
        shape(length+2*(thickness+gap), width+2*(thickness+gap), height+h, corner_diameter+2*thickness);
        translate([thickness, thickness, h])
        {
            shape(length+2*gap, width+2*gap, height, corner_diameter);
        }
        if(screw)
        {
            translate([length/2+(thickness+gap), 0, h+height/2])
            {
                rotate([-90, 0, 0])
                {
                    cylinder(h=thickness, d1=screw_head_diameter, d2=screw_hole_diameter);
                }
            }
        }
        if(label)
        {
            translate([(length+2*(thickness+gap))/4, (width+2*(thickness+gap))/2, 0])
            {
                label(version_number);
            }
            translate([3*(length+2*(thickness+gap))/4, (width+2*(thickness+gap))/2, 0])
            {
                label(str(h, "mm"));
            }
        }
    }
}

feet();