// text to engrave; to fit the frame properly, use capital letters only
engraved_text = "K+T";

// font size
font_size=13; // min/max:[8:1:13]

module half_heart_base(sizefactor=1, offset=0) {
    halfcircle_r = [ for (i = [0 : 1 : 225]) [sin(i)*(sizefactor-offset), cos(i)*(sizefactor-offset)-1*sizefactor+offset]];
    points = concat([[-2.5*sizefactor+2*offset,0]], halfcircle_r);
    polygon(points=points);
}

module half_extruded_filleted_heart() {
    hull() {
        linear_extrude(height=7) half_heart_base(15);
        linear_extrude(height=8) half_heart_base(15, offset=0.3);
        linear_extrude(height=9) half_heart_base(15, offset=1);
        linear_extrude(height=10) half_heart_base(15, offset=3);
    }
}

module extruded_filleted_heart() {
    union() {
        translate([0,0.1,0]) half_extruded_filleted_heart();
        mirror([0,1,0]) half_extruded_filleted_heart();
    }
}

module engraved_heart(text="K+T") {
    difference() {
        extruded_filleted_heart();
        translate([-font_size-(12-font_size)/2+0.25,0,9.4])
        linear_extrude(height=0.7) rotate([0,0,-90])
        text(text, halign="center", size=font_size, font="Liberation Sans:style=Bold");
    }
}

module text_border() {
    difference() {
        translate([-13,-20,-0.1]) cube([14,40,5]);
        translate([-12.5,-19.5,-0.2]) cube([13,39,6]);
    }
}

module heart_shell(text) {
    difference() {
        linear_extrude(height=11.2)
        offset(r=0.8) {
            half_heart_base(sizefactor=15);
            mirror([0,1,0]) half_heart_base(sizefactor=15);
        }
        translate([0,0,11.3]) rotate([180,0,0]) engraved_heart(text);
        text_border();
    }
}
   
heart_shell(engraved_text);



