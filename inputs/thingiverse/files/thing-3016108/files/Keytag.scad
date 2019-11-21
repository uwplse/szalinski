$fn = 70;

variant = 0;        //[0;1] model variant
scale_height = 1.7;   //default dimensions: [1.0] approx 25mmx22mm
scale_width = 1.8;     
thickness = 2.5;
rim_height = 0.5;
rim_width = 1.2;
rounding = 0.9;

hole_diam = 4.4;
hole_rim = 1.6;
hole_x = 24;
hole_y = 29;

text_1 = "TEXT";
text_2 = "Text";
text_3 = "";
text_size = 6;
text_x = 0;
text_y = 9.6;
font = "Arial:style=Bold";


difference(){
    linear_extrude(thickness){
        offset(rim_width){
            house();
        }
    }
    translate([0, 0, thickness-rim_height])
    linear_extrude(thickness){
        house();
    }
    
    inner_hole();
}
hole();
text_();



module text_(){
    translate([text_x, text_y, 0.1])
    linear_extrude(thickness-0.1){
        text(text_1, text_size, font);
        translate([0, -text_size-text_size/5, 0])
        text(text_2, text_size, font);
        translate([0, (-text_size-text_size/5)*2, 0])
        text(text_3, text_size, font);
        }
}

module inner_hole(){
    translate([hole_x, hole_y, -0.1])
    cylinder(thickness+0.2, hole_diam/2, hole_diam/2);
}

module hole(){
    difference(){
        translate([hole_x, hole_y, 0])
        cylinder(thickness, hole_diam/2+hole_rim, hole_diam/2+hole_rim);
        inner_hole();
    }
}

module house(){
    scale([scale_width, scale_height]){
        offset(1*rounding)
        polygon([[0,1],[0,12],[6.5,18.5],[15,12],[15,1]]);
        translate([0.5, -0.8, 0])
        offset(0.9*rounding)
        if(variant == 1)
            polygon([[-2.5,10.7],[-3,11],[6,20],[17.5,11],[17.0,10.7],[6,19.3]]);
        else
            polygon([[-2.5,10.7],[-3,11],[6,20],[17.5,11],[17.0,10.7]]);   
    }
}
