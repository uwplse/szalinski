// (C) Paul Oswald 2017
//	v1.0 First release

// Makerbot Customizer
// preview[view:south, tilt:top diagonal]

// Convert an array of strings into an array of string lengths
function lengths(v) = [for( i=v ) len(i)];

// Return a substring
function substr(string, start, end, p="") =
    (start >= end || start >= len(string))
        ? p
        : substr(string, start + 1, end, str(p, string[start]));

// Split string on match_value and return an array
function split(match_value, string, p=[]) =
    let(x = search(match_value, string)) 
    x == []
        ? concat(p, string)
        : let(i=x[0], l=substr(string, 0, i), r=substr(string, i+1, len(string)))
                split(match_value, r, concat(p, l));

// A list of names or words to use on the tags
name_input = "Alice,Bob,Charlie,David,Elenor,Frank,Georgia,Herbert,Irene,James";

// Select from basic fonts such as Helvetica or Google fonts (http://www.google.com/fonts)
font = "Helvetica";

// Z height above the print bed. This affects the number of layers.
charm_thickness = 2;

// Text size (height above the baseline) 10 would give 1 cm high capital letters
text_size = 5; // [1:1:20]

// Diameter of the hoop
hoop_size = 20; // [5:0.5:200]

// The width of the charms depends on the text length and the letters in the word. This can't be calculated directly. Use the following to adjust to make sure tags do not touch each other when using your chosen font.
x_multiple = 1.5; // [0.1:0.05:5]

// The character to use for splitting the name_input string
split_character = ",";

// Ratio between lower and upper pieces
thickness_ratio = 0.5; // [0:0.1:1]

// Ratio of text size to outline
outline_ratio = 0.25; // [0.1:0.1:1]

// Size of some smaller details like the hoop thickness
detail_size = 1.5; // [1:0.1:10]

// y-spacing between charms
y_space = 2;

/* [Hidden] */

names = split(split_character, name_input);

// calculate a width constant based on the longest name
name_lengths = lengths(names);
max_name_length = max(name_lengths);
echo("Longest name", max_name_length);

y_spacing = max(text_size + 2 * (text_size * outline_ratio), hoop_size) + y_space; // to get correct spacing between tags
x_spacing = hoop_size + text_size * (max_name_length / x_multiple);

// Rendering facets
$fn = 64;

module ring(inner_radius, outer_radius, thickness) {
    linear_extrude(height=thickness * thickness_ratio) {
        difference() {
            circle(r=outer_radius);
            circle(r=inner_radius);
        }
    }
}

// The name-tag part
module nametag(height, thickness, name) {
    linear_extrude(height=thickness * thickness_ratio) {
        offset (r=text_size * outline_ratio) text(name, font=font, size=text_size, valign="center");
    }
    color("DarkOrange") {
        linear_extrude(height=thickness) {
            text(name, font=font, size=text_size, valign="center");
        }
    }
}


module hoop(height, thickness) {
    offset_radius = detail_size;
    
    // create a tab to ensure a solid connection with the text
    width = text_size; // how far into the text should it go?
    tab_width = width + 2 * offset_radius;
    translate([tab_width / 2, 0 ,0]) {
        linear_extrude(height=thickness * thickness_ratio) {
            offset(r=2) {
                square([width, text_size/3], center=true);
            }
        }
    }
    
    ring_r = height/2;
    translate([-ring_r + offset_radius, 0, 0]) {
        union() {
            render(convexity = 10) // fixes a bug in display of the next difference command
            difference() {
                ring(ring_r - offset_radius, ring_r, thickness);
                linear_extrude(height=thickness * thickness_ratio) {
                    square([9999, offset_radius], center=true);
                }
            }
            // make end nubs
            translate([-ring_r + offset_radius/2, offset_radius * 1.25, 0]) {
                linear_extrude(height=thickness * thickness_ratio) {
                    circle(r=offset_radius);
                }
            }
            translate([-ring_r + offset_radius/2, -offset_radius * 1.25, 0]) {
                linear_extrude(height=thickness * thickness_ratio) {
                    circle(r=offset_radius);
                }
            }
        }
    }
}

// A single wine glass tag
module charm(height, thickness, name) {
    nametag(height, thickness, name);
    hoop(hoop_size, thickness);
}


// figure out how many columns we need to make a grid
divider = ceil(sqrt(len(names)));
echo("Names", len(names));
echo("Columns", divider);
echo("---");

for (i = [0 : len(names) - 1]) {    
    name = names[i];
    curr_column = floor(i / divider);
    curr_row = i % divider;
    echo(name, curr_column, curr_row);
    translate([curr_column * x_spacing, curr_row * y_spacing, 0]) {
        charm(text_size, charm_thickness, name);
    }    
}
