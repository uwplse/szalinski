// All measurements are in mm.

// The length of the tag.
length = 60;

// The width of the tag.
width = 20;

// The thickness of the tag.
thickness = 2;

// The filament type.
type = "PLA";

// The line 1 text.
line1_text = "Hatchbox";

// The line 1 text size.
line1_size = 6;

// The line 2 text.
line2_text = "Green";

// The line 2 text size.
line2_size = 6;

// The font. Select Help -> Font List for possible values.
font_family = "Arimo";

// The font weight.
font_weight = "bold";

// How deep font text is recessed
text_depth = 0.4;

// The line spacing method. 1 usually works better when you have short strings in a big font. 2 usually works better when you have long strings in a small font.
spacing = 1;

// The line 1 Y axis tweak. Used to fine-tune the text position. Usually not needed.
line1_y_tweak = 0;

// The line 1 Y axis tweak. Used to fine-tune the text position. Usually not needed.
line2_y_tweak = 0;

line1_y = (spacing == 1 ? (width * 0.75) : (width - (13 - line1_size))) + line1_y_tweak;
line1_valign = spacing == 1 ? "center" : "top";
line2_y = (spacing == 1 ? (width * 0.25) : (13 - line2_size)) + line2_y_tweak;
line2_valign = spacing == 1 ? "center" : "bottom";

font = str(font_family, ":style=", font_weight);

difference() {
    difference() {
        union() {
            cube([length, width, thickness]);

            translate([0, width / 2, 0])
                cylinder(thickness, width / 2, width / 2, $fn = 75);
        }
        translate([-width / 7, width / 2, -1])
            cylinder(thickness+ 2, 4, 4, $fn = 50);
    }

    translate([6, width / 2, thickness - text_depth])
        rotate([0, 0, 90])
        linear_extrude(text_depth + 0.1)
        text(
            text=type,
            size=6,
            font=font,
            halign="center",
            valign="center"
        );

    translate([12, line1_y, thickness - text_depth]) 
        linear_extrude(text_depth + 0.1)
        text(
            text=line1_text,
            size=line1_size,
            font=font,
            halign="left",
            valign=line1_valign
        );

    translate([12, line2_y, thickness - text_depth])
        linear_extrude(text_depth + 0.1)
        text(
            text=line2_text,
            size=line2_size,
            font=font,
            halign="left",
            valign=line2_valign
        );
}
