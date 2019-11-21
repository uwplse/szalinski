//Molecular Puzzle

//Emboss or raised text. Set to 1 for embossed text.
emboss = 1;//[0:1:1]

//Text here appears on the top
text_top = "182,943g/mol";

//Size of the top text
size_top = 8;//[2:1:16]

//Text here appears on the center
text_center = "Co(NO3)2";
//Size of the center text
size_center = 10;//[2:1:16]

//Text here appears on the bottom
text_bottom = "Cobalt(II)Nitrate";

//Size of the bottom text
size_bottom = 8;//[2:1:16]

//Mount position, more negative is to the left
mount_position = -30;//[-42:1:0]

//Font. Type in the font name
font_family = "Tahoma";
// Font weight. bold/italic/light
font_weight = "bold";

//Resolution. 
resolution = 100;//[10:10:100]

$fn=resolution;

translate ([mount_position,0,3+emboss])
difference () {
    cylinder(h=8,r=5,center=true);
    cylinder(h=9,r=3,center=true);
}

if (emboss==1); else {
    
translate([0,0,-0.5])
cube([100,60,1],center=true);
translate([48,0,0])
linear_extrude(height=1) {
text(
    text_center,
    font = str(font_family, ":style=", font_weight),
    size=size_center,
    halign="right",
    valign="center");
}
translate ([48,14,0])
linear_extrude(height=1) {
text(
    text_top,
    font = str(font_family, ":style=", font_weight),
    size=size_top,
    halign="right",
    valign="bottom");
}
translate ([0,-12,0])
linear_extrude(height=1) {
text(
    text_bottom,
    font = str(font_family, ":style=", font_weight),
    size=size_bottom,
    halign="center",
    valign="top");
}
}

difference () {
    
translate([0,0,-2+emboss])
cube([100,60,4],center=true);
translate([48,0,0])
linear_extrude(height=1) {
text(
    text_center,
    font = str(font_family, ":style=", font_weight),
    size=size_center,
    halign="right",
    valign="center");
}
translate ([48,14,0])
linear_extrude(height=1) {
text(
    text_top,
    font = str(font_family, ":style=", font_weight),
    size=size_top,
    halign="right",
    valign="bottom");
}
translate ([0,-12,0])
linear_extrude(height=1) {
text(
    text_bottom,
    font = str(font_family, ":style=", font_weight),
    size=size_bottom,
    halign="center",
    valign="top");
}
}
