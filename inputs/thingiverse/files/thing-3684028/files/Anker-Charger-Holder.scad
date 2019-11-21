$fn=100;

depth=27;
width=59;
height=70;
corner_radius=5;
wall=2;
plug_width=25;
plug_depth=17;
plug_radius=3;

difference(){
    linear_extrude(height) {
        offset(corner_radius) { 
            square([(width+(wall*2))-(corner_radius*2),(depth+(wall*2))-(corner_radius*2)]);
        }
    }
    translate([wall,wall,wall])
        linear_extrude(height-wall) {
            offset(corner_radius) { 
                square([width-(corner_radius*2),depth-(corner_radius*2)]);
            }
        }
    translate([wall-corner_radius+((width-plug_width)/2),wall-corner_radius+((depth-plug_depth)/2),0])
        linear_extrude(wall) {
                square([plug_width,plug_depth]);
        }
}