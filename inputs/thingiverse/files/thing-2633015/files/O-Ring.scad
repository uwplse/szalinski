inside_diameter=14;
oring_width=3;
$fn=100;
color("red"){
    rotate_extrude(){
        translate([(inside_diameter+oring_width), 0]){
            circle(oring_width);
            }
        }
    }