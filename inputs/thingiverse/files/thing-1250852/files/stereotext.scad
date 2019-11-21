text1 = "MIA";
text2 = "MIA";
// See https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Using_the_2D_Subsystem#Using_Fonts_.26_Styles
text_font = "DejaVu Sans:style=Bold";
offset_angle = 90; // [0:90]
base_thickness = 1;


module letters() {
     rotate([90, 0, 0])
     render(convexity=10)
     intersection() {
	  translate([0, 0, -500]) linear_extrude(1000) text(text1, font=text_font);
	  rotate([0, offset_angle, 0]) translate([0, 0, -500]) linear_extrude(1000) text(text2, font=text_font);
     }
}

module base() {
     translate([0, 0, -base_thickness + 0.1]) linear_extrude(base_thickness) hull() projection() letters();
}

union() {
     base();
     letters();
}
