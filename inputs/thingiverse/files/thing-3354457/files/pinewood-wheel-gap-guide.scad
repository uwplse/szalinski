$fn=30;
wheel_diameter=30;
card_depth = 0.4;
card_width=wheel_diameter+10;
card_height=wheel_diameter/2 +10;

axel_diameter=3;

difference() {
    minkowski() {
        cube(size = [card_width, card_height, card_depth]);
        cylinder(r=card_depth,h=card_depth);
    }
    translate([card_width/2, card_height/3, -1]) 
        cylinder(r=axel_diameter/2, h=card_depth+2);
        
    translate([card_width/2-axel_diameter/2, -1, -1]) 
        #cube(size = [axel_diameter, card_height/3+1, card_depth+2]);
}
