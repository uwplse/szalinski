include <MCAD/boxes.scad>

/* [Plate] */
length = 50;
width = 20;
thickness = 2;
hole_size = 2;
plate_color = "blue"; // [green, yellow, blue, red, silver, black]

/* [Text] */
text_string = "Bamf";
text_font = "Liberation Sans"; // [Liberation Mono, Liberation Sans, Liberation Sans Narrow, Liberation Serif]
text_color = "green"; // [green, yellow, blue, red, silver, black]
text_thickness = 1;

/* [Hidden] */
$fn = 10;
thickness_translate = thickness / 2;

module plate()
{
color(plate_color) roundedBox([length,width,thickness], 1);
}

module holes()
{
    translate([-(length / 2) + 3, (width / 2) - 3,-thickness_translate]) cylinder(thickness, hole_size / 2);
translate([(length / 2) - 3, (width / 2) - 3,-thickness_translate]) cylinder(thickness,hole_size / 2);
}

module letters()
{
        translate([0,0, thickness_translate]) color(text_color) linear_extrude(text_thickness) 
text(text_string, halign="center", valign = "center", font = text_font);
}

union()
{
    difference()
    {
        plate();
        holes();
    }
    
    letters();
}