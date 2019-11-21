parts = 2; // [0:Box,1:Lid,2:Both]
height = 30;
width = 66;
length = 66;
thickness = 2;
hex_size = 2.5;
hex_spacing = 1;
// Adjust the fit. .5 seems about right for my setup
clearance = .5;

/*[Hidden]*/
overhang = 2.5;
scale = hex_size * 1.4;
row_spacing = (hex_size + hex_spacing) * sqrt(3);
col_spacing = 2 * (hex_size + hex_spacing);

if (parts == 0)
	box();
if (parts == 1)
	lid();
if (parts == 2) {
	translate([-width / 2 - 1, 0, 0])
		box();
	translate([width / 2 + 1, 0, 0])
		lid();
}

module box() 
{

difference() {
	translate([-width / 2, -length / 2,0])
	{
		union() {
		difference() {
			cube(size=[width, length, height]);
			// box center
			translate([thickness, thickness, thickness])
				cube(size=[width - 2 * thickness, length - 2 * thickness, height - 4 * thickness - clearance * 2]);
			// slide area
			translate([thickness, 0, height - 2 * thickness - 2 * clearance])
				cube(size=[width - 2 * thickness, length - thickness, thickness + 2 * clearance]);
			// above slide
			translate([thickness + overhang, 0, height - 2 * thickness - 2 * clearance - .1])
				cube(size=[width - 2 * thickness - 2 * overhang, length - thickness - overhang, 3 * thickness + .2]);
			// below slide
			translate([thickness + overhang, thickness, height - 3 * thickness - 2 * clearance])
				cube(size=[width - 2 * thickness - 2 * overhang, length - 2 * thickness - overhang, thickness + .1]);
		}
		translate([thickness,0,height - thickness])
			slants(width - 2 * thickness, length - thickness);
		translate([thickness,0,height - 3 * thickness - 2 * clearance])
			slants(width - 2 * thickness, length - thickness);
		}
	}
	// bottom hex array
	intersection() {
		hex_array(-ceil(width / 2 / row_spacing), ceil(width / 2 / row_spacing), width - 2 * thickness, length - 2 * thickness, thickness);
		translate([(2 * thickness - width) / 2, (2 * thickness - length) / 2, -.1])
			cube(size=[width - 2 * thickness, length - 2 * thickness, thickness + .2]);
	}

	// front/back hex array
	intersection() {
		translate([0, length / 2 + .1, 0])
			rotate([90, -90, 0])
				hex_array(1, floor(height / row_spacing) - 1, width - 2 * thickness, height - 4 * thickness - 2 * clearance, length + .2);
		translate([(2 * thickness - width) / 2, -length / 2, 0])
			cube(size=[width - 2 * thickness, length, height - 3 * thickness - 2 * clearance]);
		}

	// left/right hex array
	intersection() {
		translate([width / 2 + .1, 0, 0])
			rotate([-90, -90, 90])
				hex_array(1, floor(height / row_spacing) - 1, length - 2 * thickness, height - 4 * thickness - 2 * clearance, width + .2);
		translate([-width / 2, (2 * thickness - length) / 2, 0])
			cube(size=[width, length - 2 * thickness, height - 3 * thickness - 2 * clearance]);
		}
	}
}

module lid() {
difference() {
	translate([-width / 2 + thickness + clearance, -length / 2, 0])
	union() {
		difference() {
		// main lid
		cube(size=[width - 2 * thickness - 2 * clearance, length - thickness - clearance, thickness]);
		translate([0, 0, thickness])
			slants(width - 2 * thickness - 2 * clearance, length - thickness);
		}
		translate([overhang, 0, thickness])
			// grip
			cube(size=[width - 2 * overhang - 2 * thickness - 2 * clearance, thickness + overhang, thickness + clearance]);
	}
	intersection() {
		hex_array(-ceil((width - 5) / 2 / row_spacing), ceil((width - 5) / 2 / row_spacing), width - 4 * thickness - 2 * clearance, length - 2 * clearance - 3 * thickness, thickness);
		translate([-width / 2 + thickness + overhang, (2 * thickness - length + overhang) / 2 + 1, 0])
			cube(size=[width - 2 * thickness - 2 * overhang, length - 2 * thickness - 2 * overhang, thickness + clearance]);
	}
}
}

module hex_array(row_start, row_end, width, height, thick) {
	start = ceil((width / 2) / col_spacing) + 1;
	for (y = [-start : start])
		for (x = [row_start : row_end]) {
			translate([x * row_spacing, y * col_spacing + (abs(x) % 2 == 1 ? col_spacing / 2 : 0), 0])
				hexagon(thick);
		}
}

module hexagon(t) {
	linear_extrude(t + .2) {polygon(
		points = [[scale * cos(0), scale * sin(0)],
					  [scale * cos(60), scale * sin(60)],
					  [scale * cos(120), scale * sin(120)],
					  [scale * cos(180), scale * sin(180)],
					  [scale * cos(240), scale * sin(240)],
					  [scale * cos(300), scale * sin(300)]]
	);
	}
	
}

module slants(w, l) {
	translate([0,l,0])
		rotate([90,0,0])
			linear_extrude(l)
				polygon([[-.1,.1],[overhang,.1],[-.1,-1]]);
	translate([w,l,0])
		rotate([90,0,0])
			linear_extrude(l)
				polygon([[.1,.1],[-overhang,.1],[.1,-1]]);
	translate([w,l,0])
		rotate([90,0,-90])
			linear_extrude(w)
				polygon([[-.1,.1],[overhang,.1],[-.1,-1]]);
}