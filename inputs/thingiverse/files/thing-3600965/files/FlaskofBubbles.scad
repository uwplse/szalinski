//Flask of Bubbles

//Your text
text = "FoB";
//Size of the font
size = 17;//[2:1:24]
//Text vertical position
position = 2;//[-10:1:10]


//Font. Type in the font name
font_family = "French Script MT";
// Font weight. bold/italic/light
font_weight = "bold";

//Resolution. 
resolution = 100;//[10:10:100]

$fn=resolution;
   

difference () {
cylinder(h=2,r=18.8,center=true);
translate([-0.6,position,0]){
linear_extrude(height=2) {
text(
    text,
    font = str(font_family, ":style=", font_weight),
    size=size,
    halign="center",
    valign="center");
}
}
}
