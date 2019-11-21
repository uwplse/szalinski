/* [Text] */

// Depending on your text, you may have to add spaces at beginning and end.
text_lines = "0 1 2;3 4 5 6;7 8 9";
//text_lines = " YOUR ;; STENCIL! ";
//text_lines = "I;am;so; CUSTOM! ";
//text_lines = "As;many;lines;as;you; want! ";
// Separator for text_lines; use something else, if you need a semicolon in your text
line_separator = ";";
fontsize = 30;

/* [Stencil] */

// Additional Border
border = 0;  // [0:30]
height = 1.5;
form = "convex hull"; // [convex hull,rectangular]

/* [Hidden] */

// Make text slanted for easier use with a pen. WARNING: causes very long rendering time!
slanted = 0;  // [0:no,1:yes]


lines = split_string(text_lines, line_separator);
rectangular = (form == "rectangular");
$fs = 0.1;
epsilon = 0.0001;
fontwidth = 0.7*fontsize;
fontheight = 1.5*fontsize;
cornerradius = fontwidth/2;

stencil();

module stencil() {
    difference() {
        stencil_body();
        if (slanted) {
            minkowski() {
                stencil_text(epsilon);
                cylinder(h=height, r1=0, r2=height/2, center=true);
            }
        } else {
            stencil_text(height);
        }
    }
}

module stencil_body() {
    minkowski() {
        hull() {
            totalwidth = max([for (line = lines) len(line)]);
            offset = 2*(border - cornerradius);
            for (i = [0:len(lines)-1]) {
                box_width = max(epsilon, (rectangular ? totalwidth : len(lines[i]))*fontwidth + offset);
                box_height = max(epsilon, fontheight + offset);
                translate([0, -i*fontheight, 0])
                    cube([box_width, box_height,height/2], center=true);
            }
        }
        cylinder(r=cornerradius, h=height/2, center=true);
    }
}

module stencil_text(height) {
    union() {
        for (i = [0:len(lines)-1]) {
            translate([0, -i*fontheight, 0])
                linear_extrude(height=height, center=true)
                text(lines[i], font="Allerta Stencil", "center", size=fontsize, valign="center", halign="center");
        }
    }    
}

/*
 * NOTE: These super cool string manipulation functions are only needed,
 *       because the thingiverse customizer cannot create a form to enter
 *       a vector of strings.
 *       Anyway, it was fun implementing them =)
 */


// split a string with a given separator and return an array of sub strings
function split_string(s, separator, sub_strings=[]) =
    len(search(separator, s)) == 0
        ? concat(sub_strings, s)
        :  split_string(sub_string(s,-(len(s) - search(separator, s)[0]-1)),
                                 separator,
                                 concat(sub_strings, sub_string(s,search(separator, s)[0])));

/*
 * return sub string of given length.
 * for positive lengths, the sub string starts at the beginning of s
 * for negative lengths, the sub string is from the end of s
 */
function sub_string(s, length) =
    length > 0
        ? vector_to_string([for (i = [0:length-1]) s[i]])
        : length < 0
            ? vector_to_string([for (i = [len(s)+length:len(s)-1]) s[i]])
            : "";

// concatenate a vector of strings to a single string
function vector_to_string(v) =
    len(v) == 0
        ? ""
        : len(v) == 1
            ? v[0]
            : str(v[0], vector_to_string([for (i=[1:len(v)-1]) v[i]]));
