//Book Hide (Large)

//Text here appears on the top
text_top = "Book Hide";
//Size of the top text
size_top = 22;//[2:1:20]
//Vertical position of top text
top_position = 36;//[0:1:60]

//Text here appears on the center
text_center = "of";
//Size of the center text
size_center = 24;//[2:1:20]

//Text here appears on the bottom
text_bottom = "Wisdom";
//Size of the bottom text
size_bottom = 24;//[2:1:20]
//Vertical position of bottom text
bottom_position = -30;//[-50:1:0]

//Font. Type in the font name
font_family = "Mistral";
// Font weight. bold/italic/light
font_weight = "italic";

//Resolution. 
resolution = 20;//[10:10:100]

difference () {
    
translate([0,0,0])
cube([110,150,0.8],center=true);
linear_extrude(height=0.4) {
text(
    text_center,
    font = str(font_family, ":style=", font_weight),
    size=size_center,
    halign="center",
    valign="center");
}
translate ([0,top_position,0])
linear_extrude(height=0.4) {
text(
    text_top,
    font = str(font_family, ":style=", font_weight),
    size=size_top,
    halign="center",
    valign="bottom");
}
translate ([0,bottom_position,0])
linear_extrude(height=0.4) {
text(
    text_bottom,
    font = str(font_family, ":style=", font_weight),
    size=size_bottom,
    halign="center",
    valign="top");
}
translate([0,81.271,-0.4]) rotate([45,0,0]){
cube([110,10,10],center=true);
}
translate([0,-81.271,-0.4]) rotate([45,0,0]){
cube([110,10,10],center=true);
}
translate([61.271,0,-0.4]) rotate([0,45,0]){
cube([10,150,10],center=true);
}
translate([-61.271,0,-0.4]) rotate([0,45,0]){
cube([10,150,10],center=true);
}
}
$fn=resolution;