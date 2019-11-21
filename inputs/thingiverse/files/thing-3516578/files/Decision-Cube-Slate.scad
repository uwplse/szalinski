//Decision Cube

//Emboss or raised text. Set to 1 for embossed text.
emboss = 1;//[0:1:1]

//Text here appears on the top
text_top = "TOP";
//Size of the top text
size_top = 3;//[2:1:16]
//Vertical position of top text
top_position = 9;//[0:1:11]

//Text here appears on the center
text_center = "CENTER";
//Size of the center text
size_center = 4;//[2:1:16]

//Text here appears on the bottom
text_bottom = "BOTTOM";
//Size of the bottom text
size_bottom = 4;//[2:1:16]
//Vertical position of bottom text
bottom_position = -7;//[-11:1:0]

//Font. Type in the font name
font_family = "Comic Sans MS";
// Font weight. bold/italic/light
font_weight = "bold";

//Resolution. 
resolution = 20;//[10:10:100]

if (emboss==1); else {
    
translate([0,0,-0.5])
cube([30,30,1],center=true);
linear_extrude(height=1) {
text(
    text_center,
    font = str(font_family, ":style=", font_weight),
    size=size_center,
    halign="center",
    valign="center");
}
translate ([0,top_position,0])
linear_extrude(height=1) {
text(
    text_top,
    font = str(font_family, ":style=", font_weight),
    size=size_top,
    halign="center",
    valign="bottom");
}
translate ([0,bottom_position,0])
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
    
translate([0,0,-0.7+emboss])
cube([30,30,1],center=true);
linear_extrude(height=1) {
text(
    text_center,
    font = str(font_family, ":style=", font_weight),
    size=size_center,
    halign="center",
    valign="center");
}
translate ([0,top_position,0])
linear_extrude(height=1) {
text(
    text_top,
    font = str(font_family, ":style=", font_weight),
    size=size_top,
    halign="center",
    valign="bottom");
}
translate ([0,bottom_position,0])
linear_extrude(height=1) {
text(
    text_bottom,
    font = str(font_family, ":style=", font_weight),
    size=size_bottom,
    halign="center",
    valign="top");
}
}
$fn=resolution;
