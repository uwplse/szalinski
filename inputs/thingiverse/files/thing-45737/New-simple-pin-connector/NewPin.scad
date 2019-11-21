// The total length of the pin.
pin_length = 67;
// The radius of the pin shaft.
pin_radius = 3.5;
// The length of the head of the pin.
pin_head_length = 4;
// The lip around the pin head. This is the bit that grips the sides of the pin hole.
pin_head_lip = 0.6;
// The length of the slot on the pin.
slot_length = 10;
// The width of the slot in the pin.
slot_width = 2;
// The number of sides of the pin shaft and pin head.
sides = 30;
// The fractional falttening of the shaft. For example with a pin shaft radius of 5mm, then 0.1 puts 0.5mm deep flats on the pin.
flat = 0.2;

total_pin_radius = pin_radius + pin_head_lip;

module pin_head()
{
	union()
	{
		cylinder( r1 = pin_radius*0.75, r2 = pin_radius+pin_head_lip, h = pin_head_length*2/4, $fn = sides);
		translate([0,0, pin_head_length*3/4])cylinder( r1 = pin_radius+pin_head_lip, r2 = pin_radius, h = pin_head_length*1/4, $fn = sides);
		translate([0,0, pin_head_length*2/4])cylinder( r1 = pin_radius+pin_head_lip, r2 = pin_radius+pin_head_lip, h = pin_head_length*1/4, $fn = sides);
	}
}

module slot()
{
	slot_depth = 2*total_pin_radius + 0.1;
	union()
	{
		translate([ -slot_depth/2, -slot_width/2, 0])cube([slot_depth, slot_width, slot_length]);
		rotate([0, 90, 0])cylinder( r1 = slot_width/2, r2 = slot_width/2, h = slot_depth, center = true, $fn = sides);
		translate([0, 0, slot_length])rotate([0, 90, 0])cylinder( r1 = slot_width/2, r2 = slot_width/2, h = slot_depth, center = true, $fn = sides);
	}
}

module shaft()
{
	union()
	{
		pin_head();
		translate([0,0, pin_head_length])cylinder( r1 = pin_radius, r2 = pin_radius, h = pin_length - 2*pin_head_length + 0.1, $fn = sides);
		translate([0, 0, pin_length ])rotate([0,180,0])pin_head();
	}
}


module flat()
{
	flat_depth = flat*total_pin_radius;
	flat_width = 2*total_pin_radius;
	union()
	{
		translate([total_pin_radius - flat_depth, 0, pin_length/2])cube([flat_depth*2, 2*total_pin_radius, pin_length + 0.1], center = true);
		translate([-(total_pin_radius - flat_depth), 0, pin_length/2])cube([flat_depth*2, 2*total_pin_radius, pin_length + 0.1], center = true);
	}
}

module pin()
{
	rotate([0, 90, 0])
	difference()
	{
		shaft();
		slot();
		translate([0,0,pin_length - slot_length])slot();
		flat();
	}
}

pin();








