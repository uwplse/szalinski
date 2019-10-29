cover_length = 20; // the length of the cover

/* [Hidden] */
wing_width = 1.5;

module cover(cover_len)
{

	union() {

		translate([0, -2.2/2 - .95, 0])

			intersection() {
				cube([20.5/2, 1.6, cover_len], center=true);
				translate([0, 3.5, 0])
					cylinder(r=6, h=cover_len, $fn=50, center=true);
	
			}

		translate([-6.5/2 + wing_width/2,0,0])
			cube([wing_width,  2.75, cover_len], center=true);

		translate([6.5/2 - wing_width/2,0,0])
			cube([wing_width, 2.75, cover_len], center=true);

		translate([6.5/2 - wing_width/2 + 0.15, 2.2/2 + 0.35, 0])
			cylinder(r=1.05, h=cover_len, center=true, $fn=50);

		translate([-6.5/2 + wing_width/2 - 0.15, 2.2/2 + 0.35, 0])
			cylinder(r=1.05, h=cover_len, center=true, $fn=50);
	}
}

rotate([90, 0, 0])
	cover(cover_length);