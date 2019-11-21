//Book Hide (Small)

//Text here appears on the top
text_top = "TOP";
//Size of the top text
size_top = 14;//[2:1:20]
//Vertical position of top text
top_position = 10;//[0:1:24]

//Text here appears on the center
text_center = "Center";
//Size of the center text
size_center = 14;//[2:1:20]

//Text here appears on the bottom
text_bottom = "BOTTOM";
//Size of the bottom text
size_bottom = 9;//[2:1:20]
//Vertical position of bottom text
bottom_position = -14;//[-26:1:0]

//Font. Type in the font name
font_family = "Pristina";
// Font weight. bold/italic/light
font_weight = "bold";

//Resolution. 
resolution = 20;//[10:10:100]

difference () {
    
translate([0,0,0])
cube([54,70,0.8],center=true);
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
translate([0,41.271,-0.4]) rotate([45,0,0]){
cube([54,10,10],center=true);
}
translate([0,-41.271,-0.4]) rotate([45,0,0]){
cube([54,10,10],center=true);
}
translate([33.271,0,-0.4]) rotate([0,45,0]){
cube([10,70,10],center=true);
}
translate([-33.271,0,-0.4]) rotate([0,45,0]){
cube([10,70,10],center=true);
}
}
$fn=resolution;