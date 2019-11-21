// Scraper Magnetic Holder

// Magnet Diameter
magnet_diam = 4.76;

// Magenet Length
magnet_len = 4.76;

holder(magnet_diam, magnet_len);

module holder(magnet_diam, magnet_len)
{
	$fn = 25;
	extra = .2;
	screw_lip = 2;

	// Add 1mm to the bottom, and 1mm slot for razor blade
	height = screw_lip + 7.5 + 1;
	width = 50;
	length = 41;

	handle_depth = 3;
	triange_width = sqrt(2) * 47 / 2;
	screw_shaft_r = (5 + extra + .1) / 2;
	screw_head_r = 9 / 2;
	screw1_y = 7;
	screw2_y = length - 9.75;

	difference()
	{
		// Base block
		translate([-width/2,0,0])
			minkowski() {
				cube([width - 10, length - 10, height - .01]);
				translate([5, 5, 0]) cylinder(r = 5, h = .01);
			}
		// Slot for razor blade
		translate([-20, length-15, height - 1]) cube([40, 10, 1.1]);
		// Slot for handle
		translate([-47/2, length - 19 - 14.5, height-handle_depth+.01]) cube([47, 19, handle_depth]);
		// Angled retainer for handle
		translate([0, length - 33.5 + .01, height - handle_depth/2+.01]) scale([1,.6,1])
			difference()
			{
				rotate([0, 0, 45]) cube([triange_width, triange_width, handle_depth], center=true);
				translate([-width/2,0,-height/2]) cube([width, width, height]);
			}
		//translate([0,0,height - handle_depth/2+.01]) cube([26, 10, handle_depth], center=true);

		// Mounting Screws
		translate([0, screw1_y, -.01]) cylinder(h = 2.1, r = screw_shaft_r);
		translate([0, screw1_y, screw_lip]) cylinder(h = height, r = screw_head_r);

		translate([0, screw2_y, -.01]) cylinder(h = 2.1, r = screw_shaft_r);
		translate([0, screw2_y, screw_lip]) cylinder(h = height, r = screw_head_r);

		// Magnet holes
		translate([-12, screw2_y, height - magnet_len - 1 - extra]) cylinder(h = magnet_len + 1, r = magnet_diam / 2 + extra/2);
		translate([12, screw2_y, height - magnet_len - 1 - extra]) cylinder(h = magnet_len + 1, r = magnet_diam / 2 + extra/2);
	}
}