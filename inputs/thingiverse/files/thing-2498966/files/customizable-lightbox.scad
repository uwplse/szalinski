/*
 * Customizable Lightbox - https://www.thingiverse.com/thing:2498966
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-08-24
 * version v1.0
 *
 * Changelog
 * --------------
 * v1.0:
 *      - final design
 * --------------
 * 
 * This work is licensed under the Creative Commons - Attribution - Non-Commercial license.
 * https://creativecommons.org/licenses/by-nc/3.0/
 */

 // Parameter Section //
//-------------------//

// preview[view:west, tilt:top]

/* [Lightbox Settings] */

// Choose, which part you want to see!
part = "all_parts__"; //[all_parts__:All Parts,box__:Lightbox,box_lid__:Lightbox Lid,character_plate_a__:Character Plate A,character_plate_b__:Character Plate B,character_plate_c__:Character Plate C,character_plate_d__:Character Plate D,character_plate_e__:Character Plate E,character_plate_f__:Character Plate F,character_plate_g__:Character Plate G,character_plate_h__:Character Plate H,character_plate_i__:Character Plate I,character_plate_j__:Character Plate J,character_plate_k__:Character Plate K,character_plate_l__:Character Plate L,character_plate_m__:Character Plate M,character_plate_n__:Character Plate N,character_plate_o__:Character Plate O,character_plate_p__:Character Plate P,character_plate_q__:Character Plate Q,character_plate_r__:Character Plate R,character_plate_s__:Character Plate S,character_plate_t__:Character Plate T,character_plate_u__:Character Plate U,character_plate_v__:Character Plate V,character_plate_w__:Character Plate W,character_plate_x__:Character Plate X,character_plate_y__:Character Plate Y,character_plate_z__:Character Plate Z,character_plate_0__:Character Plate 0,character_plate_1__:Character Plate 1,character_plate_2__:Character Plate 2,character_plate_3__:Character Plate 3,character_plate_4__:Character Plate 4,character_plate_5__:Character Plate 5,character_plate_6__:Character Plate 6,character_plate_7__:Character Plate 7,character_plate_8__:Character Plate 8,character_plate_9__:Character Plate 9,character_plate_ampersand__:Character Plate Ampersand,character_plate_question_mark__:Character Plate Question Mark,character_plate_exclamation_point__:Character Plate Exclamation Point,character_plate_comma__:Character Plate Comma,character_plate_point__:Character Plate Point,character_plate_minus__:Character Plate Minus,character_plate_dollar_sign__:Character Plate Dollar Sign,character_plate_slash__:Character Plate Slash,character_plate_equals__:Character Plate Equals,character_plate_plus__:Character Plate Plus,character_plate_asterisk__:Character Plate Asterisk,character_plate_hash__:Character Plate Hash,character_plate_blank__:Character Plate Blank]

// The width of the lightbox
lightbox_width_in_millimeter = 210.0; //[20:400]

// The height of the lightbox
lightbox_height_in_millimeter = 160.0; //[20:400]

// The depth of the lightbox. This means the distance of the back of the box to the back of the lid.
lightbox_depth_in_millimeter = 30.0; //[20:100]

// Wall thickness of the lightbox. The lower the value, the more light shines throw the box.
box_thickness_in_millimeter = 1.92; //[0.5:0.1:10]

// Wall tickness of the lid. The lower the value, the more light shines throw the lid.
lid_thickness_in_millimeter = 0.6;

// Thickness of the character plates.
plate_thickness_in_millimeter = 2;

// You can choose between two fonts
font = "siren"; //[siren:Siren Stencil,stardos:Stardos Stencil]

// Number of light sections
number_of_sections = 4; //[1:1:20]

// Diameter of the hole, allowing you to plug the lighting into the light box.
insert_hole_diameter_in_millimeter = 11.0;

// Radius of the corner.
rounded_corner_radius_in_millimeter = 0.0;

// Tolerance
tolerance_in_millimeter = 0.2;

/* [Hidden] */
box_width = lightbox_width_in_millimeter;
box_height = lightbox_height_in_millimeter;
box_depth = lightbox_depth_in_millimeter;
sections = number_of_sections;
box_th = box_thickness_in_millimeter;
lid_th = lid_thickness_in_millimeter;
mount_th = plate_thickness_in_millimeter;
insert_hole_dia = insert_hole_diameter_in_millimeter;
corner_radius = rounded_corner_radius_in_millimeter;
overall_lid_th = lid_th + mount_th;
tolerance = tolerance_in_millimeter;
tolerance2 = tolerance * 2;
tolerance3 = tolerance * 3;
tolerance4 = tolerance * 4;
box_th2 = box_th * 2;
box_th3 = box_th * 3;
lid_th2 = lid_th * 2;
lid_th3 = lid_th * 3;
lid_th4 = lid_th * 4;
inner_lid_width = box_height - box_th2 - lid_th4 - tolerance2;
letter_height = (inner_lid_width + lid_th4) / sections - lid_th4 - tolerance2;
letter_width = letter_height * 0.75;
google_font_siren = "Sirin Stencil:style=Regular";
google_font_stardos = "Stardos Stencil:style=Regular";
box_color = "DeepSkyBlue";
lid_color = "HotPink";
letter_color = "DimGray";

$fn=40;

char_and_margin_siren = [
    ["A", 0.15], ["B", 0.15], ["C", 0.16], ["D", 0.15], ["E", 0.18], ["F", 0.18], ["G", 0.12],
    ["H", 0.13], ["I", 0.27], ["J", 0.28], ["K", 0.14], ["L", 0.20], ["M", 0.08], ["N", 0.13],
    ["O", 0.12], ["P", 0.17], ["Q", 0.11], ["R", 0.15], ["S", 0.18], ["T", 0.16], ["U", 0.12],
    ["V", 0.15], ["W", 0.05], ["X", 0.16], ["Y", 0.15], ["Z", 0.14],
    ["0", 0.13], ["1", 0.22], ["2", 0.16], ["3", 0.16], ["4", 0.16], ["5", 0.17], ["6", 0.15],
    ["7", 0.22], ["8", 0.16], ["9", 0.16],
    ["&", 0.07], ["?", 0.18], ["!", 0.28], [",", 0.10], [".", 0.10], ["-", 0.16], ["$", 0.18],
    ["/", 0.20], ["=", 0.09], ["+", 0.09], ["*", 0.15], ["#", 0.10], ["",0]
];

char_and_margin_stardos = [
    ["A", 0.13], ["B", 0.12], ["C", 0.12], ["D", 0.11], ["E", 0.13], ["F", 0.15], ["G", 0.12],
    ["H", 0.10], ["I", 0.24], ["J", 0.19], ["K", 0.10], ["L", 0.15], ["M", 0.04], ["N", 0.10],
    ["O", 0.11], ["P", 0.15], ["Q", 0.09], ["R", 0.12], ["S", 0.15], ["T", 0.13], ["U", 0.09],
    ["V", 0.12], ["W", 0.02], ["X", 0.12], ["Y", 0.13], ["Z", 0.12],
    ["0", 0.16], ["1", 0.16], ["2", 0.17], ["3", 0.17], ["4", 0.16], ["5", 0.17], ["6", 0.16],
    ["7", 0.16], ["8", 0.17], ["9", 0.16],
    ["&", 0.06], ["?", 0.19], ["!", 0.24], [",", 0.10], [".", 0.10], ["-", 0.23], ["$", 0.15],
    ["/", 0.26], ["=", 0.08], ["+", 0.09], ["*", 0.19], ["#", 0.17], ["",0]
];

 // Program Section //
//-----------------//
echo(letter_height = letter_height);
echo(letter_width = letter_width);
if(part == "box__") {
    color(box_color) box();
} else if(part == "box_lid__") {
    color(lid_color) lid();
} else if(part == "character_plate_a__") {
    color(letter_color) character_plate(0);
} else if(part == "character_plate_b__") {
    color(letter_color) character_plate(1);
} else if(part == "character_plate_c__") {
    color(letter_color) character_plate(2);
} else if(part == "character_plate_d__") {
    color(letter_color) character_plate(3);
} else if(part == "character_plate_e__") {
    color(letter_color) character_plate(4);
} else if(part == "character_plate_f__") {
    color(letter_color) character_plate(5);
} else if(part == "character_plate_g__") {
    color(letter_color) character_plate(6);
} else if(part == "character_plate_h__") {
    color(letter_color) character_plate(7);
} else if(part == "character_plate_i__") {
    color(letter_color) character_plate(8);
} else if(part == "character_plate_j__") {
    color(letter_color) character_plate(9);
} else if(part == "character_plate_k__") {
    color(letter_color) character_plate(10);
} else if(part == "character_plate_l__") {
    color(letter_color) character_plate(11);
} else if(part == "character_plate_m__") {
    color(letter_color) character_plate(12);
} else if(part == "character_plate_n__") {
    color(letter_color) character_plate(13);
} else if(part == "character_plate_o__") {
    color(letter_color) character_plate(14);
} else if(part == "character_plate_p__") {
    color(letter_color) character_plate(15);
} else if(part == "character_plate_q__") {
    color(letter_color) character_plate(16);
} else if(part == "character_plate_r__") {
    color(letter_color) character_plate(17);
} else if(part == "character_plate_s__") {
    color(letter_color) character_plate(18);
} else if(part == "character_plate_t__") {
    color(letter_color) character_plate(19);
} else if(part == "character_plate_u__") {
    color(letter_color) character_plate(20);
} else if(part == "character_plate_v__") {
    color(letter_color) character_plate(21);
} else if(part == "character_plate_w__") {
    color(letter_color) character_plate(22);
} else if(part == "character_plate_x__") {
    color(letter_color) character_plate(23);
} else if(part == "character_plate_y__") {
    color(letter_color) character_plate(24);
} else if(part == "character_plate_z__") {
    color(letter_color) character_plate(25);
} else if(part == "character_plate_0__") {
    color(letter_color) character_plate(26);
} else if(part == "character_plate_1__") {
    color(letter_color) character_plate(27);
} else if(part == "character_plate_2__") {
    color(letter_color) character_plate(28);
} else if(part == "character_plate_3__") {
    color(letter_color) character_plate(29);
} else if(part == "character_plate_4__") {
    color(letter_color) character_plate(30);
} else if(part == "character_plate_5__") {
    color(letter_color) character_plate(31);
} else if(part == "character_plate_6__") {
    color(letter_color) character_plate(32);
} else if(part == "character_plate_7__") {
    color(letter_color) character_plate(33);
} else if(part == "character_plate_8__") {
    color(letter_color) character_plate(34);
} else if(part == "character_plate_9__") {
    color(letter_color) character_plate(35);
} else if(part == "character_plate_ampersand__") {
    color(letter_color) character_plate(36);
} else if(part == "character_plate_question_mark__") {
    color(letter_color) character_plate(37);
} else if(part == "character_plate_exclamation_point__") {
    color(letter_color) character_plate(38);
} else if(part == "character_plate_comma__") {
    color(letter_color) character_plate(39);
} else if(part == "character_plate_point__") {
    color(letter_color) character_plate(40);
} else if(part == "character_plate_minus__") {
    color(letter_color) character_plate(41);
} else if(part == "character_plate_dollar_sign__") {
    color(letter_color) character_plate(42);
} else if(part == "character_plate_slash__") {
    color(letter_color) character_plate(43);
} else if(part == "character_plate_equals__") {
    color(letter_color) character_plate(44);
} else if(part == "character_plate_plus__") {
    color(letter_color) character_plate(45);
} else if(part == "character_plate_asterisk__") {
    color(letter_color) character_plate(46);
} else if(part == "character_plate_hash__") {
    color(letter_color) character_plate(47);
} else if(part == "character_plate_blank__") {
    color(letter_color) character_plate(48);
} else if(part == "all_parts__") {
    all_parts();
} else {
    all_parts();
}

 // Module Section //
//----------------//

module box() {
    difference() {
        union() {
            rotate([90,0,0]) {
                linear_extrude(height = box_width, convexity = 20) {
                    polygon(
                        points=[
                        /*01*/[0, 0],
                        /*02*/[0, box_depth],
                        /*03*/[box_th + lid_th, box_depth],
                        /*04*/[box_th, box_depth - overall_lid_th],
                        /*05*/[box_th2, box_depth - overall_lid_th],
                        /*06*/[box_th, box_depth - overall_lid_th - box_th3],
                        /*07*/[box_th, box_th],
                        /*08*/[box_height - box_th, box_th],
                        /*09*/[box_height - box_th, box_depth - overall_lid_th - box_th3],
                        /*10*/[box_height - box_th2, box_depth - overall_lid_th],
                        /*11*/[box_height - box_th, box_depth - overall_lid_th],
                        /*12*/[box_height - box_th - lid_th, box_depth],
                        /*13*/[box_height, box_depth],
                        /*14*/[box_height, 0]
                        ]
                    );
                }
            }
            translate([0, -box_th, 0]) {
                cube([box_height, box_th, box_depth - overall_lid_th]);
            }
            translate([0, -box_width, 0]) {
                cube([box_height, box_th, box_depth]);
            }
        }
        translate([box_height/2, -box_width/2, -box_th]){
            cylinder(d = insert_hole_dia, h = box_th3);
        }
        translate([0, -box_width, -1]) {
            round_edges_precut_box(box_height, box_width, box_depth + 2, corner_radius);
        }
    }
    translate([0, -box_width, 0]) {
        round_edges_box(box_height, box_width, box_depth, box_th, overall_lid_th, corner_radius);
    }
}

module lid() {
    difference() {
        union() {
            rotate([90,0,0]) {
                linear_extrude(height = box_width - box_th, convexity = 20) {
                    polygon(
                        points=[
                        /*A*/[0, 0],
                        /*B*/[lid_th, overall_lid_th],
                        /*C*/[lid_th3, overall_lid_th],
                        /*D*/[lid_th2, lid_th],
                        /*E*/[inner_lid_width + lid_th2, lid_th],
                        /*F*/[inner_lid_width + lid_th, overall_lid_th],
                        /*G*/[inner_lid_width + lid_th3, overall_lid_th],
                        /*H*/[inner_lid_width + lid_th4, 0]
                        ]
                    );
                }
            }
            if(sections > 1) {
                for(section = [1:sections - 1]) {
                    translate([(inner_lid_width + lid_th4) / sections * section, 0, lid_th]) {
                        separator();
                    }
                }
            }
            translate([lid_th2, -box_th, 0]) {
                cube([box_height - box_th2 - tolerance2 - lid_th4, box_th, overall_lid_th]);
            }
        }
        translate([-box_th - tolerance, -box_width + box_th, -lid_th]) {
            round_edges_precut_lid(box_height, box_width - box_th, overall_lid_th + 1, corner_radius);
        }
    }
}

module all_parts() {
    color(box_color) box();
    translate([ -box_height - 2, 0, 0]) {
        color(lid_color) lid();
    }
    translate([ -box_height - letter_height - 8, 0, 0]) {
        color(letter_color) all_character_plates(10);
    }
}

module separator() {
    rotate([90,0,0]) {
        linear_extrude(height = box_width - box_th) {
            polygon(
                points=[
                /*  I*/[-lid_th2, 0],
                /* II*/[-lid_th3, mount_th],
                /*III*/[lid_th3, mount_th],
                /* IV*/[lid_th2, 0],
                ]
            );
        }
    }
}

module plate_template() {
    rotate([90,0,0]) {
        linear_extrude(height = letter_width, convexity = 20) {
            polygon(
                points=[
                /*  I*/[0, 0],
                /* II*/[lid_th, mount_th],
                /*III*/[letter_height - lid_th, mount_th],
                /* IV*/[letter_height, 0]
                ]
            );
        }
    }
}

module character_plate(char) {    
    union() {
        difference() {
            plate_template();
            if(font == "siren") {
                translate([letter_height * 0.2, -letter_height * char_and_margin_siren[char][1], -0.5]) {
                    rotate([0, 0, 270]) {
                        linear_extrude(height = mount_th + 1) {
                            text(text = char_and_margin_siren[char][0], size = letter_height * 0.6, font = google_font_siren, language = "en");
                        }
                    }
                }
            } else if(font == "stardos") {
                translate([letter_height * 0.2, -letter_height * char_and_margin_stardos[char][1], -0.5]) {
                    rotate([0, 0, 270]) {
                        linear_extrude(height = mount_th + 1) {
                            text(text = char_and_margin_stardos[char][0], size = letter_height * 0.6, font = google_font_stardos, language = "en");
                        }
                    }
                }
            }
        }
        if(char_and_margin_stardos[char][0] == "#" && font == "stardos") {
            translate([letter_height / 2, -letter_width, 0]) {
                cube([0.5,letter_width, mount_th]);
            }
        }
    }
}

module all_character_plates(chars_per_line) {
    for(x = [0:ceil(len(char_and_margin_siren) / chars_per_line - 1)]) {
        for(y = [0:chars_per_line - 1]) {
            translate([-x * (letter_height + 1), -y * (letter_width + 1), 0]) {
                if(y + (x * chars_per_line) < len(char_and_margin_siren)) {
                    character_plate(y + (x * chars_per_line));
                }
            }
        }
    }        
}

module round_edges(h, r, box_th, lid_th, edge) {
    difference() {
        cylinder(r = r, h = h);
        translate([0, 0, box_th]) {
            cylinder(r = r - box_th, h = h + 0.2);
        }
        translate([0, r, h]) {
            cube([(r - box_th) * 2, r * 2, lid_th * 2], center = true);
        }
        cut(h, r, edge);
    }
}

module round_edges_precut(h, r, edge) {
    difference() {
        translate([0, 0, h / 2]) {
            cube([r * 2 + 10, r * 2 + 10, h + 1], center = true);
        }
        translate([0, 0, -1]) {
            cylinder(r = r, h = h + 2);
        }
        cut(h, r, edge);
    }
}

module cut(h, r, edge) {
   if(edge == 1) {
        translate([r + 10, 0, h / 2]) {
            cube([r * 2 + 20, r * 2 + 20, h + 2], center = true);
        }
        translate([0, r + 10, h / 2]) {
            cube([r * 2 + 20, r * 2 + 20, h + 2], center = true);
        }
    }
    if(edge == 2) {
        translate([-r - 10, 0, h / 2]) {
            cube([r * 2 + 20, r * 2 + 20, h + 2], center = true);
        }
        translate([0, r + 10, h / 2]) {
            cube([r * 2 + 20, r * 2 + 20, h + 2], center = true);
        }
    }
    if(edge == 3) {
        translate([-r - 10, 0, h / 2]) {
            cube([r * 2 + 20, r * 2 + 20, h + 2], center = true);
        }
        translate([0, -r - 10, h / 2]) {
            cube([r * 2 + 20, r * 2 + 20, h + 2], center = true);
        }
    }
    if(edge == 4) {
        translate([r + 10, 0, h / 2]) {
            cube([r * 2 + 20, r * 2 + 20, h + 2], center = true);
        }
        translate([0, -r - 10, h / 2]) {
            cube([r * 2 + 20, r * 2 + 20, h + 2], center = true);
        }
    }
}

module round_edges_box(x, y, h, box_th, lid_th, r) {
    if(r > 0.0) {
        translate([r, r, 0]) {
            round_edges(h, r, box_th, lid_th, 1);
        }
        translate([x - r, r, 0]) {
            round_edges(h, r, box_th, lid_th, 2);
        }
        translate([x - r, y - r, 0]) {
            round_edges(h, r, box_th, lid_th, 3);
        }
        translate([r, y - r, 0]) {
            round_edges(h, r, box_th, lid_th, 4);
        }
    }
}

module round_edges_precut_box(x, y, h, r) {
    if(r > 0.0) {
        translate([r, r, 0]) {
            round_edges_precut(h, r, 1);
        }
        translate([x - r, r, 0]) {
            round_edges_precut(h, r, 2);
        }
        translate([x - r, y - r, 0]) {
            round_edges_precut(h, r, 3);
        }
        translate([r, y - r, 0]) {
            round_edges_precut(h, r, 4);
        }
    }
}

module round_edges_precut_lid(x, y, h, r) {
    if(r > 0.0) {
        translate([r, r - box_th, 0]) {
            round_edges_precut(h, r - box_th, 1);
        }
        translate([x - r, r - box_th, 0]) {
            round_edges_precut(h, r - box_th, 2);
        }
        translate([x - r, y - r, 0]) {
            round_edges_precut(h, r, 3);
        }
        translate([r, y - r, 0]) {
            round_edges_precut(h, r, 4);
        }
    }
}
