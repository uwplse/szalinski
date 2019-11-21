// font
font1 = "Liberation Sans"; 

// Face Text
content = "40";

//scale
scale = 3;

rotate([0,0,-90]){
difference(){
    cube_ratio = 5;
    cube([scale*cube_ratio,scale*cube_ratio,scale*cube_ratio]);

    translate ([scale * cube_ratio - 1,.5 * scale,1 * scale]) {
        rotate ([90,0,90]) {
            linear_extrude(height = 2) {
                text(content, font = font1, 
                    size = 3*scale *.9, direction = "ltr", spacing = 1 );
            }
        }
    }
}
}