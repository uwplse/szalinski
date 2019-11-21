// *************************
// Customizable Sign Creator
// By BaranCODE
// *************************

// in mm
plate_length = 150;
// in mm
plate_width = 65;
// in mm
plate_height = 10;
// in mm
text_height = 5;
// use \n to add a new line
text_content = "Hello,\nWorld!";
font_size = 20;
// in mm (if you have multiple lines)
line_separation = 30;

color("gray") cube([plate_length, plate_width, plate_height], true);

contents = split(text_content, "\n");
color("white")
translate([0, (len(contents)-1)*line_separation/2, 0])
for (i = [0 : len(contents)-1]){
    translate([0, -i*line_separation, plate_height/2])
    linear_extrude(height = text_height, center = false)
    text(contents[i], font_size,
        "Open Sans:style=Bold",
        halign="center", valign="center");
}



// From OpenSCAD Library by roipoussiere
// http://www.thingiverse.com/thing:1237203
function split(str, sep=" ", i=0, word="", v=[]) =
	i == len(str) ? concat(v, word) :
	str[i] == sep ? split(str, sep, i+1, "", concat(v, word)) :
	split(str, sep, i+1, str(word, str[i]), v);