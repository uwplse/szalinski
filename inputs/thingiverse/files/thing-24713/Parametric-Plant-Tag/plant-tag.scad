use <write/Write.scad>

// Text to show on tag
text = "Thai Basil";

// Font to use
font = "Letters.dxf"; // [Letters.dxf:Letters, BlackRose.dxf:Black Rose, orbitron.dxf:Orbitron]

// Size of text
text_size = 6;

// Thickness of text
text_thickness = 0.8;

// Y-Offset of text
text_offset_y = 0.4;

// Text emboss/deboss
emboss = 1; // [1:Emboss, 0:Deboss]

// Tag height
tag_height = 10;

// Tag width
tag_width = 45;

// Spike height
spike_height = 40;

// Spike width
spike_width = 6;

// Spike thickness
spike_thickness = 1;


if (emboss)
create_plant_tag(
    name=text,
    font=str("write/",font),
    text_size=text_size, text_thickness=text_thickness, text_offset_y=text_offset_y,
    height=tag_height, width=tag_width,
    spike_height=spike_height, spike_width=spike_width,
    thickness=spike_thickness);
else
create_plant_tag_inset(
    name=text,
    font=str("write/",font),
    text_size=text_size, text_thickness=text_thickness, text_offset_y=text_offset_y,
    height=tag_height, width=tag_width,
    spike_height=spike_height, spike_width=spike_width,
    thickness=spike_thickness);



module create_plant_tag(
    name,
    font,
    text_size,
    text_thickness,
    text_offset_y,
    height,
    width,
    spike_height,
    spike_width,
    thickness)
{
    smidge = 0.01;

    union()
    {
        linear_extrude(height=thickness) union()
        {
            translate([0,height/2-smidge]) square([width,height+smidge], center=true);
            polygon(points=[ [-spike_width/6,-spike_height], [+spike_width/6,-spike_height],
                             [+spike_width/2,0], [-spike_width/2,0] ],
                    paths=[ [0,1,2,3] ]);
        }

        translate([0,height/2+text_offset_y,thickness+text_thickness/2-smidge]) color("red")
            write(name, center=true, h=text_size, t=text_thickness, font=font, space=1);
    }
}

module create_plant_tag_inset(
    name,
    font,
    text_size,
    text_thickness,
    text_offset_y,
    height,
    width,
    spike_height,
    spike_width,
    thickness)
{
    smidge = 0.01;

    difference()
    {
        linear_extrude(height=thickness) union()
        {
            translate([0,height/2-smidge]) square([width,height+smidge], center=true);
            polygon(points=[ [-spike_width/6,-spike_height], [+spike_width/6,-spike_height],
                             [+spike_width/2,0], [-spike_width/2,0] ],
                    paths=[ [0,1,2,3] ]);
        }

        translate([0,height/2+text_offset_y,thickness-text_thickness/2]) color("red")
            write(name, center=true, h=text_size, t=text_thickness, font=font, space=1);
    }
}
