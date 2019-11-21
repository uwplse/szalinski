// Filament Swatch / Sample Tag

/* [Dimensions] */

// Width of the tag
width = 64; //[24:1:128]
// Length of the tag
length = 24; //[16:1:48]
// Thickness of the tag
thickness = 1; //[1:0.5:8]

/* [Options] */

// Add frame around the border of the tag?
frame = true;
// Add thickness samples in the corner?
samples = true;

/* [Text] */

// The filament type
type = "PLA";
// Upper text
line1_text = "Brand";
// Lower text
line2_text = "Color";

/* [Font] */

// Font. Select Help -> Font List for possible values
font_family = "Roboto";
// Font weight
font_weight = "bold";
// Text size for upper text
line1_size = 7; //[6:1:16]
// Text size for lower text
line2_size = 6; //[6:1:16]

sample_width = samples? (length-3)/3 : 0;
font = str(font_family, ":style=", font_weight);

if (frame) {
    union() {
        difference() {
            difference() {
                translate([0, length / 2, 0])
                    cylinder(thickness * 2, length / 2, length / 2, $fn = 75);
                translate([0, length / 2, -0.1])
                    cylinder(thickness * 2 + 0.2, length / 2 - 1, length / 2 - 1, $fn = 75);
            }

            cube([width, length, thickness*2+0.2]);
        }

        difference() {
            cube([width, length, thickness * 2]);
            translate([-0.1,1,0])
                cube([width-1, length-2, thickness * 2+0.2]);
        }
    }
}

difference() {
    union() {
        cube([width, length, thickness]);

        difference() {
            translate([0, length / 2, 0])
                cylinder(thickness, length / 2, length / 2, $fn = 75);
            translate([-length / 4, length / 2, -1])
                cylinder(thickness+2, 3, 3, $fn = 50);
        }

        translate([2, length / 2, thickness])
            rotate([0, 0, 90])
            linear_extrude(1)
            text(
                text=type,
                size=6,
                font=font,
                halign="center",
                valign="center"
            );

        translate([(width-sample_width) / 2 + 2, length-length/4-1, thickness])
            linear_extrude(1)
            text(
                text=line1_text,
                size=line1_size,
                font=font,
                halign="center",
                valign="center"
            );

        translate([(width-sample_width) / 2 + 2, length/4+1, thickness])
            linear_extrude(1)
            text(
                text=line2_text,
                size=line2_size,
                font=font,
                halign="center",
                valign="center"
            );
    }

    if (samples) {
        translate([width-sample_width-1.5,1.5,thickness*0.25])
            cube([sample_width,sample_width,thickness]);
        translate([width-sample_width-1.5,1.5+sample_width,thickness*0.5])
            cube([sample_width,sample_width,thickness]);
        translate([width-sample_width-1.5,1.5+sample_width*2,thickness*0.75])
            cube([sample_width,sample_width,thickness]);
    }
}
