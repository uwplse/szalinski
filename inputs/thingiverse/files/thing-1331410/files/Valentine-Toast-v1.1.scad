/* [Line 1] */
Line1_text = "LOVE";
Line1_mirror = "Yes"; // [Yes:No]

Line1_font_size = 20; // [10:1:30]
Line1_x_adjust = -7; // [-10:1:10]
Line1_y_adjust = 16; // [10:1:30]

Line1_letter_1_font = "Dancing Script"; //[ Open Sans Extrabold, PT Serif, Chewy, Dancing Script, Indie Flower, Lobster, Snowburst One, Londrina Outline, Arial ]

Line1_letter_2_space = .9; // [-2:0.05:2]
Line1_letter_2_font = "Dancing Script"; //[ Open Sans Extrabold, PT Serif, Chewy, Dancing Script, Indie Flower, Lobster, Snowburst One, Londrina Outline, Arial ]

Line1_letter_3_space = .9; // [-2:0.05:2]
Line1_letter_3_font = "Dancing Script"; //[ Open Sans Extrabold, PT Serif, Chewy, Dancing Script, Indie Flower, Lobster, Snowburst One, Londrina Outline, Arial ]

Line1_letter_4_space = .9; // [-2:0.05:2]
Line1_letter_4_font = "Dancing Script"; //[ Open Sans Extrabold, PT Serif, Chewy, Dancing Script, Indie Flower, Lobster, Snowburst One, Londrina Outline, Arial ]

Line1_letter_5_space = 1; // [-2:0.05:2]
Line1_letter_5_font = "PT Serif"; //[ Open Sans Extrabold, PT Serif, Chewy, Dancing Script, Indie Flower, Lobster, Snowburst One, Londrina Outline, Arial ]

Line1_letter_6_space = 1; // [-2:0.05:2]
Line1_letter_6_font = "PT Serif"; //[ Open Sans Extrabold, PT Serif, Chewy, Dancing Script, Indie Flower, Lobster, Snowburst One, Londrina Outline, Arial ]


/* [Line 2] */
Line2_text = "YOU";
Line2_mirror = "Yes"; // [Yes:No]

Line2_font_size = 30; // [10:1:30]
Line2_x_adjust = -10; // [-10:1:10]
Line2_y_adjust = 5; // [10:1:30]

Line2_letter_1_font = "PT Serif"; //[ Open Sans Extrabold, PT Serif, Chewy, Dancing Script, Indie Flower, Lobster, Snowburst One, Londrina Outline, Arial ]

Line2_letter_2_space = 1; // [-2:0.05:2]
Line2_letter_2_font = "PT Serif"; //[ Open Sans Extrabold, PT Serif, Chewy, Dancing Script, Indie Flower, Lobster, Snowburst One, Londrina Outline, Arial ]

Line2_letter_3_space = 1; // [-2:0.05:2]
Line2_letter_3_font = "PT Serif"; //[ Open Sans Extrabold, PT Serif, Chewy, Dancing Script, Indie Flower, Lobster, Snowburst One, Londrina Outline, Arial ]

Line2_letter_4_space = 1; // [-2:0.05:2]
Line2_letter_4_font = "PT Serif"; //[ Open Sans Extrabold, PT Serif, Chewy, Dancing Script, Indie Flower, Lobster, Snowburst One, Londrina Outline, Arial ]

Line2_letter_5_space = 1; // [-2:0.05:2]
Line2_letter_5_font = "PT Serif"; //[ Open Sans Extrabold, PT Serif, Chewy, Dancing Script, Indie Flower, Lobster, Snowburst One, Londrina Outline, Arial ]

Line2_letter_6_space = 1; // [-2:0.05:2]
Line2_letter_6_font = "PT Serif"; //[ Open Sans Extrabold, PT Serif, Chewy, Dancing Script, Indie Flower, Lobster, Snowburst One, Londrina Outline, Arial ]

/* [Hidden */

$fn=64;

text_height = 13;

Line1_font_names = [Line1_letter_1_font,Line1_letter_2_font,Line1_letter_3_font,Line1_letter_4_font,Line1_letter_5_font,Line1_letter_6_font];
Line1_spacing = [0,Line1_letter_2_space,Line1_letter_3_space,Line1_letter_4_space,Line1_letter_5_space,Line1_letter_6_space];


Line2_font_names = [Line2_letter_1_font,Line2_letter_2_font,Line2_letter_3_font,Line2_letter_4_font,Line2_letter_5_font,Line2_letter_6_font];
Line2_spacing = [0,Line2_letter_2_space,Line2_letter_3_space,Line2_letter_4_space,Line2_letter_5_space,Line2_letter_6_space];

module rcube(x,y,z,rad) {
    translate([-(x/2), -(y/2),0])
    hull() {
        translate([rad,rad,0]) cylinder(r=rad,h=z);
        translate([x-rad,rad,0]) cylinder(r=rad,h=z);
        translate([rad,y-rad,0]) cylinder(r=rad,h=z);
        translate([x-rad,y-rad,0]) cylinder(r=rad,h=z);
    }
}

module toasttop(x,y,z,rad) {
    translate([-(x/2), -y*2,0])
    hull() {
        translate([rad,rad,0]) cylinder(r=rad,h=z);
        translate([x-rad,rad,0]) cylinder(r=rad,h=z);
        translate([rad*2,y-rad,0]) cylinder(r=rad*2,h=z);
        translate([x-rad*2,y-rad,0]) cylinder(r=rad*2,h=z);
        translate([x/2,y-rad-25,0]) cylinder(r=40,h=z);
    }
}

module line_of_letters(letters, spacing, center, font_name, font_size) {
    for (i = [0 : len(letters) -1]) {
       linear_extrude(height = 10, twist = 0, $fn = 64) {
            translate ([(spacing[i]*i*font_size)-center,0,0])
            text(size = font_size, text = letters[i], font = font_name[i], halign = "center", valign= "bottom", $fn = 100);
           echo(font_name[i]);
        } 
    }    
}

rcube(95,76,3,5);
translate([0,76,0]) toasttop(95,16,3,5);

if(Line1_mirror == "Yes") {
mirror([1,0,0]) translate([Line1_x_adjust,Line1_y_adjust,0]) line_of_letters(Line1_text, Line1_spacing, 20, Line1_font_names, Line1_font_size);
} else {
   translate([Line1_x_adjust,Line1_y_adjust,0]) line_of_letters(Line1_text, Line1_spacing, 20, Line1_font_names, Line1_font_size); 
}

if(Line2_mirror == "Yes") {
mirror([1,0,0]) translate([Line2_x_adjust,Line2_y_adjust-Line2_font_size,0]) line_of_letters(Line2_text, Line2_spacing, 20, Line2_font_names, Line2_font_size);
} else {
translate([Line2_x_adjust,Line2_y_adjust-Line2_font_size,0]) line_of_letters(Line2_text, Line2_spacing, 20, Line2_font_names, Line2_font_size);
}    