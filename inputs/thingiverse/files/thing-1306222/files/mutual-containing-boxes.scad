inner_h = 70;
thickness = 0.6;
spacing = 0.6;

function outer_h(inner_h, thickness) = inner_h + thickness;

function inner_w(inner_h, thickness) = outer_h(inner_h, thickness) + 2 * thickness;

function outer_w(inner_h, thickness) = inner_w(inner_h, thickness) + 2 * thickness;

function inner_l(inner_h, thickness) = outer_w(inner_h, thickness) + 2 * thickness;

function outer_l(inner_h, thickness) = inner_l(inner_h, thickness) + 2 * thickness;

module box_without_upper(w, h, l, thickness) {
	difference() {
	    cube([w, l, h], center = true);
	    translate([0, 0, thickness]) 
		    cube([w - 2 * thickness, l - 2 * thickness, h - thickness], center = true);
    }    
}

module inner_box(inner_h, thickness, spacing) {
    w = inner_w(inner_h, thickness + spacing);
	h = inner_h;
	l = inner_l(inner_h, thickness + spacing);
	
	box_without_upper(w, h, l, thickness);
}

module outer_box(inner_h, thickness, spacing) {
    w = outer_w(inner_h, thickness + spacing);
    h = outer_h(inner_h, thickness + spacing);
    l = outer_l(inner_h, thickness + spacing);

    difference() {	
        box_without_upper(w, h, l, thickness);
	    translate([0, 0, -h / 2]) linear_extrude(thickness * 2) circle(w / 6, $fn=96);
	}
}

inner_box(inner_h, thickness, spacing);
translate([inner_w(inner_h, thickness) + 20 * thickness, 0, thickness / 2 + spacing / 2]) 
    outer_box(inner_h, thickness, spacing);





