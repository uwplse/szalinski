/*
 * Customizable Comb - https://www.thingiverse.com/thing:2789072
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2018-02-10
 * version v1.0
 *
 * Changelog
 * --------------
 * v1.0:
 *      - final design
 * --------------
 *
 * This work is licensed under the Creative Commons - Attribution - Non-Commercial - ShareAlike license.
 * https://creativecommons.org/licenses/by-nc-sa/3.0/
 */

// Choose between these profiles
profile = "none"; // [none,wing,full_3d]

// Choose between these wedge profiles
wedge_profile = "teeth"; // [none,teeth,full]

// Choose between these shapes
shape = "bow"; // [bow,rectangle,rounded_rectangle]

// Max height in Millimeter
max_height = 6;

// Min height in Millimeter
min_height = 1;

// The depth of the teeth section in Millimeter
teeth_depth = 20;

// The depth of the handle in Millimeter
handle_depth = 25;

// Gap between teeth_depth and handle_depth in Millimeter.
handle_teeth_gap = 5;

// The width of each tooth in Millimeter
tooth_width = 1;

// The gap between two teeth in Millimeter
tooth_gap = 1.5;

// The margin between the teeth section and the outline in Millimeter
teeth_side_margin = 5;

// Number of teeth.
number_of_teeth = 60; //[1:200]

// Radius of the corner in Millimeter. Can't be more than teeth_side_margin! Corner can't be used together with rectangle shape!
corner_radius = 8;

// Type in your personal text.
personal_text = "personal_text";

// The margin between the teeth section and the text in Millimeter
text_teeth_margin = 2;

// The font size
font_size = 12;  //[4:0.5:20]

// You can choose a font from https://fonts.google.com/ and type the name in here or just use the retro looking one YellowTail!
font_family = "YellowTail";

// You can reduce the quality to 8-16 to create a low poly effect.
quality = 32; //[1:200]

/* [Hidden] */
$fn = quality;
extra1 = 1;
extra2 = extra1 * 2;
total_depth = teeth_depth + handle_teeth_gap + handle_depth;
total_width = teeth_side_margin * 2 + number_of_teeth * (tooth_width + tooth_gap) + tooth_gap;
corner = corner_radius < teeth_side_margin ? corner_radius : teeth_side_margin;

echo(total_width);
echo(total_depth);

color("LightSeaGreen") comb();

module comb() {
    difference() {
        translate([0, total_depth - handle_depth, 0]) {
            rotate([0, 0, 270]) {
                translate([0, 0, 0]) {
                    if(profile == "wing") {
                        wing_profile_comb();
                    } else if(profile == "full_3d") {
                        full_3d_profile_comb();
                    } else if(profile == "none") {
                        no_profile_comb();
                    }
                }
            }
        }
        
        translate([total_width / 2 -1, teeth_depth + 2 + text_teeth_margin, max_height / 2]) {
            linear_extrude(height = max_height, convexity = 20) {
                text(text = personal_text, font = font_family, size = font_size, halign = "center", valign = "bottom", spacing = 0.96);
            }
        }
        
        translate([total_width + extra1, handle_teeth_gap + teeth_depth, 0]) {
            rotate([270, 180, 90]) {
                linear_extrude(height = total_width + extra2, convexity = 50) {
                    if(wedge_profile == "teeth") {
                        teeth_wedge_profile_2d();
                    } else if(wedge_profile == "full") {
                        full_wedge_profile_2d();
                    }
                }
            }
        }
    }
}

module no_profile_comb() {
    linear_extrude(height = max_height, convexity=50) {
        comb_2d();
    }
}


module wing_profile_comb() {
   intersection()  {
        no_profile_comb();
        translate([handle_teeth_gap, total_width, 0]) {
            rotate([90, 0, 0]) {
                linear_extrude(height = total_width, convexity=3) {
                    wing_profile_2d();
                }
            }
        }
    }
}

module full_3d_profile_comb() {
    difference() {
        union() {
            translate([0, total_width / 2, 0]) {
                bow_3d(handle_depth, total_width, max_height);
            
            }
            teeth_section_3d();
        }
        translate([handle_teeth_gap, teeth_side_margin, -extra1]) {
            cube([teeth_depth + extra1, total_width - teeth_side_margin * 2, max_height + extra2]);
        }

    }
    intersection() {
        teeth_section_3d();
        translate([handle_teeth_gap, teeth_side_margin + tooth_gap, 0]) {
            teeth_3d();
        }
    }
}

module comb_2d() {
    if(shape == "bow") {
        translate([0, total_width / 2]) {
            bow_2d();
        }
    } else if(shape == "rectangle") {
        translate([-handle_depth, 0]) {
            square([handle_depth, total_width]);
        }
    } else if(shape == "rounded_rectangle") {
        translate([-handle_depth, 0]) {
            chamfer(r = corner) {
                square([handle_depth, total_width]);
            }
            translate([handle_depth - corner, 0]) {
                square([corner, total_width]);
            }
        }
    }
        
    difference() {
        union() {
            if(shape == "rectangle") {
                square([teeth_depth + handle_teeth_gap, total_width]);
            } else {
                chamfer(r = corner) {
                    square([teeth_depth + handle_teeth_gap, total_width]);
                }
                square([corner, total_width]);
            }            
        }
        translate([handle_teeth_gap, teeth_side_margin]) {
            square([teeth_depth + extra1, total_width - teeth_side_margin * 2]);
        }
    }
    
    translate([handle_teeth_gap, teeth_side_margin + tooth_gap]) {
        teeth_2d();
    }
}

module teeth_section_3d() {
    hull() {
        translate([0, total_width / 2, 0]) {
            rotate([0, 0, 180]) {
                bow_3d(handle_teeth_gap + teeth_depth, total_width, max_height);
            }
        }
        if(shape == "rectangle") {
            translate([handle_teeth_gap + teeth_depth - extra1, 0, 0]) {
                cube([extra1,extra1,.2]);
            }
            
            translate([handle_teeth_gap + teeth_depth - extra1, total_width - extra1, 0]) {
                cube([extra1,extra1,.2]);
            }
        } else {
            translate([handle_teeth_gap + teeth_depth - corner, corner, 0]) {
                cylinder(r = corner, h = .2);
            }
            translate([handle_teeth_gap + teeth_depth - corner, total_width - corner, 0]) {
                cylinder(r = corner, h = .2);
            }
        }
    }
}

module bow_2d() {
    difference() {
        oval_2d(handle_depth * 2, total_width);
        translate([0, -total_width / 2 - extra1]) {
            square([handle_depth + extra1, total_width + extra2]);
        }
    }
}

module bow_3d(depth, width, height) {
    difference() {
        oval_3d(depth * 2, width, 2 * height);
        translate([0, -width / 2 - extra1, - height - extra1]) {
            cube([depth + extra1, width + extra2, 2 * height + extra2]);
        }
        translate([-depth, -width / 2 - extra1, -height - extra1]) {
            cube([depth + extra2, width + extra2, height + extra1]);
        }
    }
}

module teeth_2d() {
    for(tooth = [0:number_of_teeth - 1]) {
        translate([0, (tooth_gap + tooth_width) * tooth]) {
            square([teeth_depth - tooth_width / 2, tooth_width]);
            translate([teeth_depth - tooth_width / 2, tooth_width / 2]) {
                circle(r = tooth_width / 2, $fn=12);
            }
            translate([0, tooth_width / 2]) {
                circle(r = (tooth_width + tooth_gap - .1) / 2, $fn = 4);
            }
        }
    }
}

module teeth_3d() {
    translate([0, 0, -1]) {
        linear_extrude(height = max_height + 2, convexity=50) {
            teeth_2d();
        }
    }
}

module wing_profile_2d() {
    difference() {
        union() {
            difference() {
                oval_2d((total_depth - teeth_depth) * 2, max_height * 2);
                translate([0, -max_height]) {
                    square([total_depth - teeth_depth, max_height * 2]);
                }
            }
            difference() {
                oval_2d(teeth_depth * 2, max_height * 2);
                translate([-teeth_depth, -max_height]) {
                    square([teeth_depth, max_height * 2]);
                }
            }
        }
        translate([-teeth_depth -handle_teeth_gap - extra1, -max_height - extra1]) {
            square([total_depth + extra2, max_height + extra1]);
        }
    }
}

module teeth_wedge_profile_2d() {
    polygon(points=[[handle_teeth_gap, max_height], [handle_teeth_gap, max_height + extra1], [handle_teeth_gap + teeth_depth + extra1, max_height + extra1], [handle_teeth_gap + teeth_depth + extra1, min_height], [handle_teeth_gap + teeth_depth, min_height]]);
}

module full_wedge_profile_2d() {
    pos=-handle_depth - handle_teeth_gap;
    polygon(points=[[-handle_depth, max_height], [-handle_depth, max_height + extra1], [ teeth_depth + handle_teeth_gap + extra1, max_height + extra1], [teeth_depth + handle_teeth_gap + extra1, min_height], [pos + total_depth + handle_teeth_gap, min_height]]);
}

module oval_2d(d1, d2) {
    resize([d1, d2]) {
        circle($fn = quality);
    }
}

module oval_3d(d1, d2, h) {
    resize([d1, d2, h]) {
        sphere($fn = quality);
    }
}

module chamfer(r) {
    offset(r = r) {
        offset(delta = -r) {
            children();
        }
    }
}