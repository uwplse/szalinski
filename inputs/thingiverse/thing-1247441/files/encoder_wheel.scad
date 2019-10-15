/* [Slots] */
slot_outer_margin = 2;
slot_count = 180;
slot_length= 10;
slot_width = 1;
/* [Disc] */
disc_radius = 60;
disc_thickness = 0.9;


module main() {
	difference() {
		cylinder(h=disc_thickness, r=disc_radius , $fn=900);
		for (i = [0:slot_count]) {
			rotate([0,0, (i * (360 / slot_count))]) {
				translate([disc_radius  - slot_outer_margin - slot_length , 0, -1]) {
					cube([slot_length, slot_width, disc_thickness + 2]);
				}
			}
		}

	}
}

main();
