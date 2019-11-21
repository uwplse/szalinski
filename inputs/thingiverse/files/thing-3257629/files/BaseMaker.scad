
diameter = 25.4;
label = "C";

text_offset_from_edge = 5;
text_depth = 0.4;
text_size = 5;
height = 3.0;
bevel = 0.5;
font = "Arial Rounded MT Bold";

module simple_base(radius=25.4/2) {
    translate([0,0,bevel]) minkowski() {
        cylinder(h=(height-2*bevel), r=radius-2*bevel, $fn=60);
        union() {
            cylinder(h=bevel, r1=bevel,r2=0, $fn=40);
            translate([0,0,-bevel]) cylinder(h=bevel, r2=bevel, r1=0);
        }
    }
}


module base(radius = 25.4/2, label) {
    difference() {
        simple_base(radius=radius);
        translate([0,-radius+text_offset_from_edge,height-text_depth]) 
            linear_extrude(1) 
                text(label, halign="center", valign="center", size=text_size, font=font);
    }
}

base(label=label, radius=diameter/2);