// Variable BANHAMMER!!!

// Variables:
handle_length = 50;
handle_thickness = 5;
head_length = 30;
head_thickness = 10;

head_text = "BAN";
font = "Monospace";
text_depth = 1;
text_size = 6;

// handle
cylinder(h = handle_length,
	r1 = handle_thickness, r2 = handle_thickness);

// head
translate(v = [(head_length/2), 0, handle_length+(head_thickness/2)])
	rotate([0, -90, 0])
		difference() {
			cylinder(h = head_length,
				r1 = head_thickness, r2 = head_thickness);
			translate([0, 0, text_depth])
				rotate([180, 0, 90])
					linear_extrude(text_depth)
						text(head_text, font = font, size = text_size,
							halign = "center", valign = "center");
			translate([0, 0, (head_length-text_depth)])
				rotate([180, 180, 90])
					linear_extrude(text_depth)
						text(head_text, font = font, size = text_size,
							halign = "center", valign = "center");
		};