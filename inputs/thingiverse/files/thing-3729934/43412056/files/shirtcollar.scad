$fn=100;


textstring = "@MattPLees";
textsize = 5;
collarheight = 1;
 

module collar(cheight=1) {
    linear_extrude(height = cheight) {
        hull() {
            hull() {
                circle(5);
                translate([47,0,0]) circle(5);
            }
            translate([58.5,0,0]) circle(2);
        }
    }
}


module embedtext(textstring = "", cheight=1, tsize = 7) {
    color("Red") {
        translate([5,-(tsize/2), cheight-0.25]) {
            linear_extrude(10) {
                text(textstring, font = "Liberation Sans", size = tsize, direction = "ltr", spacing = 1);
            }
        }
    }
}
 

difference() {
    collar(collarheight);
    //embedtext(textstring, collarheight, textsize);
}

