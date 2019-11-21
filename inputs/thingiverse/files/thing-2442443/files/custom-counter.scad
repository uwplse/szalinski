// The space between each ring. This should be set to the minimum tolerance you can print and still separate so that the rings can move but with engouh resistance that they stay set.
slip_spacing = 0.4;

// Diameter of the outer ring. This is the maximum diameter of the part.
outer_dia = 60;

// Lowest number on the outer ring. This will normally be 1 or 0.
outer_start = 1;

// Highest number on the outer ring
outer_end = 20;

// Lowest number on the inner ring.
inner_start = 0;

// Highest number on the inner ring.
inner_end = 6;

// Height/thickness of the disc
disc_h = 5;

// Height of the font
text_size = 4.5;

// Thickness of the text. This is how high above the disc the numbers will be raised.
text_h = 0.8;

// Space between the bottom of the numbers and the outer perimiter of the ring
text_margin_bottom = 2;

// Radius of the pip indicating the current value
pip_r = 1.5;

// How much to cut out of the bottom edge at the ring interfaces. This helps avoid welding on the first layer.
foot_cut_r = 1;

outer_cut_r = outer_dia/2 - text_size - text_margin_bottom;
mid_cut_r = outer_cut_r - disc_h/2 - pip_r*2;

inner_dia = mid_cut_r*2 - slip_spacing*2 - disc_h/2;

dimple_sr = outer_dia/2;
dimple_cr = inner_dia/2 - text_size - text_margin_bottom - 0.4;
dimple_h = dimple_sr * cos(asin(dimple_cr/dimple_sr)) + disc_h;

module cut_numbers(start, end, z, dia) {
	count = abs(end-start);
	step = 360 / (count + 1);
	for (i = [start:end]) {
		rotate([0,0,step * i]) translate([0,text_margin_bottom - dia/2,z - 0.1])
			linear_extrude(height = text_h + 0.1)
				text(str(i), text_size, halign="center", valign="bottom", font="style:bold");
	}
}

module bicone(r, z) {
	translate([0,0,z]) rotate_extrude($fn=40)
		polygon([[0,-r], [r,0], [0,r]]);
}

module foot_cut(r) {
	translate([0,0,-2])
		cylinder(h=disc_h/2 + 2, r=r - disc_h/2 + foot_cut_r);
}

// Outer ring
difference() {
	union() {
		cylinder(h=disc_h, d=outer_dia);
		cut_numbers(outer_start, outer_end, disc_h, outer_dia);
	}


	// translate([0,0,-1])
	// 	cylinder(h=disc_h + 2, r=outer_cut_r);

	bicone(outer_cut_r, disc_h/2);

	foot_cut(outer_cut_r);
}

// Pip ring
union() {
	difference() {
		intersection() {
			cylinder(h=disc_h, d=outer_dia);
			bicone(outer_cut_r - slip_spacing, disc_h/2);
		}

		bicone(mid_cut_r, disc_h/2);

		translate([0,mid_cut_r, disc_h])
			sphere(pip_r, $fs=0.5);

		foot_cut(mid_cut_r);
	}

	difference() {
		translate([0,0,disc_h])
			cube([outer_cut_r*2 - slip_spacing*2 - disc_h - 0.5, 2, 1.5], center=true);

		cylinder(r=mid_cut_r - disc_h/2 + 0.5, h = disc_h*2);
	}
}

// Inner ring
union() {
	difference() {
		intersection() {
			cylinder(h=disc_h, d=outer_dia);
			bicone(mid_cut_r - slip_spacing, disc_h/2);
		}

		translate([0,0,dimple_h])
			sphere(r=dimple_sr, $fa=0.01, $fs=1);
	}

	rotate([0,0,360/14])
			cut_numbers(inner_start, inner_end, disc_h, inner_dia);
}
