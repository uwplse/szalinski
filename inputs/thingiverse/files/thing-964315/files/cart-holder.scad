// Gameboy Cartridge Holder version 2.0
// Design by Patrick Connelly (patrick@deadlypenguin.com)

// preview[view:south east, tilt:top diagonal]

/* [Cartridge] */
cartridge_type = "gba"; //[gba: Gameboy Advanced,gbc:Gameboy Classic,both: Both]
number_of_cartridges = 10; //[5:15]
allow_cartridge_removal = "no"; // [yes,no]

/* [Hidden] */
cart_width = 58;
cart_depth = 8;
gba_cart_height = 35;
gbc_cart_height = 65;

cart_pocket_height = 14;
cart_pocket_gap = 2;

base_height = 16;

no_remove_padding = 10;

support_rod_width = 7;
support_rod_depth = support_rod_width;

support_pocket_inner_padding = 1;

support_pocket_width = support_rod_width + support_pocket_inner_padding;
support_pocket_depth = support_rod_depth + support_pocket_inner_padding;
support_pocket_height = 10;
support_pocket_padding = 1;

cart_height = (cartridge_type == "gba") ? gba_cart_height : gbc_cart_height;
cart_padding = (allow_cartridge_removal == "no") ? no_remove_padding : no_remove_padding + cart_height;

// Default to gba with no-remove
support_rod_height = (cart_height - cart_pocket_height) + cart_padding + support_pocket_height;

echo(support_rod_height);
support_rod_padding = support_pocket_padding + ((support_pocket_width - support_rod_width) / 2);

base_depth = (cart_depth + cart_pocket_gap) * number_of_cartridges + cart_pocket_gap;

side_rail_width = support_pocket_width + support_pocket_padding * 2;

base_width = cart_width + side_rail_width * 2;

module base() {
	cube([base_width, base_depth, base_height]);
}

module support_pockets() {
	support_pocket_x = base_width - support_pocket_padding - support_pocket_width;
	support_pocket_y = base_depth - support_pocket_padding - support_pocket_width;
	union() {
		translate([support_pocket_padding,support_pocket_padding,-1])
			cube([support_pocket_width, support_pocket_depth, support_pocket_height + 1]);
		translate([support_pocket_x, support_pocket_padding, -1])
		cube([support_pocket_width, support_pocket_depth, support_pocket_height + 1]);
		translate([support_pocket_padding, support_pocket_y, -1])
		cube([support_pocket_width, support_pocket_depth, support_pocket_height + 1]);
		translate([support_pocket_x, support_pocket_y, -1])
		cube([support_pocket_width, support_pocket_depth, support_pocket_height + 1]);
	}
}

module support_rods() {
	support_rod_x = base_width - support_rod_padding - support_rod_width;
	support_rod_y = base_depth - support_rod_padding - support_rod_width;
	
	union() {
		translate([support_rod_padding,support_rod_padding,base_height])
			cube([support_rod_width, support_rod_depth, support_rod_height + 1]);
		translate([support_rod_x, support_rod_padding, base_height])
		cube([support_rod_width, support_rod_depth, support_rod_height + 1]);
		translate([support_rod_padding, support_rod_y, base_height])
		cube([support_rod_width, support_rod_depth, support_rod_height]);
		translate([support_rod_x, support_rod_y, base_height])
		cube([support_rod_width, support_rod_depth, support_rod_height + 1]);
	}
}

module cartridge_slots() {
	union() {
		for (i = [0:number_of_cartridges - 1]) {
			current_y = cart_pocket_gap + ((cart_depth + cart_pocket_gap) * i);
			translate([side_rail_width, current_y, base_height - cart_pocket_height + 1])
			cube([cart_width, cart_depth, cart_pocket_height + 1]);
		}
	}
}

difference() {
	union() {
		base();
		support_rods();
	}
	support_pockets();
	cartridge_slots();
}