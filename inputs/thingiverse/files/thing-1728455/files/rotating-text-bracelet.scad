chars = "|PI|3.141592653589793238462643383279502884197169399375105820974944592307816406286";
inner_radius = 35;
font_size = 10;
ch_thickness = 2.5;
spacing = 0.8;
seperated = "TRUE"; // [TRUE, FALSE]

module text_ring(chars, radius, font_size, thickness) {
	ch_number = ceil(2 * 3.14159 * radius / font_size);
	angle_step = 360 / ch_number;

	for(i = [0:ch_number - 1]) {
	    ch_idx = ch_number - i - 1;
		rotate((i + 0.5) * angle_step - 90) 
			translate([0, radius, chars[ch_idx] == "." ?  font_size * 0.35: 0]) 
				rotate([-90, 0, 0]) 
				    linear_extrude(thickness) 
					    text(chars[ch_idx], valign = "center", halign = "center", font = "Courier New:style=Bold", size = font_size);
	}

	module ring() {
		linear_extrude(thickness, center = true) difference() {
			circle(radius + thickness,  $fn = ch_number);
			circle(radius,  $fn = ch_number);
		}
	}
	 
	translate([0, 0, -0.5 * font_size]) ring();
	translate([0, 0, 0.5 * font_size]) ring(); 
}

module inner_ring(radius, height, thickness, spacing, fn, seperated = false) {

    module outer() {
		linear_extrude(thickness) difference() {
			circle(radius + thickness * 4 + spacing * 3, $fn = fn);
			circle(radius + thickness + spacing, $fn = fn);
		}
		
		linear_extrude(height) difference() {
			circle(radius + thickness + spacing + thickness, $fn = fn);
			circle(radius + thickness + spacing, $fn = fn);
		}
	}
	
	module inner() {
		translate([0, 0, height]) linear_extrude(thickness) difference() {
			circle(radius + thickness * 4 + spacing * 3, $fn = fn);
			circle(radius, $fn = fn);
		}
		
		linear_extrude(height) difference() {
			circle(radius + thickness, $fn = fn);
			circle(radius, $fn = fn);
		}
	}
	
	outer();
	
	if(seperated) {
	    translate([0, radius * 2.5, height + thickness]) mirror([0, 0, 1]) inner();
	} else {
	    inner();
	}
}

module rotating_text_bracelet(chars, inner_radius, font_size, ch_thickness, spacing, seperated = false) {
    text_ring_radius = inner_radius + ch_thickness + spacing * 0.5 + spacing;
	inner_ring_height = font_size + ch_thickness * 1.5 + 2 * spacing;
	inner_ring_thickness = ch_thickness / 2;
	
	color("white") translate([0, 0, seperated ? font_size / 2 + ch_thickness / 2 : font_size / 2 + ch_thickness + spacing])
	    rotate([0, seperated ? 180 : 0, 0]) text_ring(chars, text_ring_radius, font_size, ch_thickness);

	color("yellow") translate([seperated ? inner_radius * 2.5 : 0, 0, 0]) inner_ring(
	    inner_radius, 
		inner_ring_height, 
		inner_ring_thickness, 
		spacing / 2, 
		ceil(2 * 3.14159 * text_ring_radius / font_size),
		seperated
	);

}

rotate([0, seperated == "TRUE" ? 0 : 180, 0]) rotating_text_bracelet(chars, inner_radius, font_size, ch_thickness, spacing, seperated == "TRUE");