// Thingiverse customizer parameters

// How wide?
Stand_width = 85;					// [50: Narrow (50mm - e.g. phone), 85: Default (85mm - e.g. tablet or large phone), 120: Wide (120mm - e.g. small mammal)

// How tall?
Stand_height = 75;					// [65: Short (65mm), 75: Default (75mm), 95: Tall (95mm)

// How thick is your device (in mm)?
Slot_depth = 16;					// [5: 30]

// Angle in degrees (90 = vertical)
Front_rake = 75;					// [15: 5: 90]

// Angle in degrees (90 = vertical)
Rear_rake = 60;					// [15: 5: 90]

//use <../OpenSCAD_lib/common.scad>;
module position(translate = [], rotate = [], mirror = [0, 0, 0], colour)
{
	for (i = [0 : $children-1])
		translate(translate)
			rotate(rotate)
				mirror(mirror)
					if (colour == undef)
						children(i);
					else
						color(colour)
							children(i);
}

$fn = 25;
ff = 0.05;

def_width = Stand_width;
def_height = Stand_height;
def_slot_width = Slot_depth;
def_angle1 = Front_rake;
def_angle2 = Rear_rake;

def_ww = 2.0;

if (1)
	print();
else
	preview();

function default_if_undef(variable, default) = 
	variable == undef ? default : variable;

module print()
{
	stand();
}

module preview()
{
	position(
		colour = "lightblue",
		rotate = [90, 0, 45],
		translate = [0, 0, def_height])
		stand();
}

module stand(width, height, slot_width, angle1, angle2, wall_width)
{
	width = (width == undef ? def_width : width);
	height = (height == undef ? def_height : height);
	slot_width = (slot_width == undef ? def_slot_width : slot_width);
	angle1 = (angle1 == undef ? def_angle1 : angle1);
	angle2 = (angle2 == undef ? def_angle2 : angle2);
	wall_width = (wall_width == undef ? def_ww : wall_width);

	echo(str("QP056 ", width, "Wx", height,"H stand"));

	slot_ext = slot_width + 2*wall_width;

	side1_plate = (
		height									// total height
		- wall_width/2							// rounded top
		- (slot_ext/2 - (slot_ext/2) * sin(90-angle1))		// rounded bottom
		) / sin(angle1);

	side2_plate = (
		height									// total height
		- wall_width/2							// rounded top
		- (slot_ext/2 - (slot_ext/2) * sin(90-angle2))	// rounded bottom
		) / sin(angle2);

	position(
		rotate = [0, 0, 90 - angle1],
		translate = [])
			side(width = width, plate_length = side1_plate, slot_width = slot_width, wall_width = wall_width);

	position(
		mirror = [1, 0, 0],
		rotate = [0, 0, -90 + angle2],
		translate = [])
			side(width = width, plate_length = side2_plate, slot_width = slot_width, wall_width = wall_width);

}

module side(width, plate_length, slot_width, wall_width)
{
	slot_ext = slot_width + 2*wall_width;

	// slot
	translate([(slot_width + wall_width)/2, -plate_length, 0])
		difference()
		{
			// slot - external perimeter
			cylinder(h = width, r = slot_ext/2);

			// slot - internal perimiter
			translate([0, 0, -ff/2])
				cylinder(h = width + ff, r = slot_width/2);

			// mask
			translate([-(slot_ext + ff)/2, 0, -ff/2])
				cube([slot_ext + ff, slot_ext + ff, width+ff]);

			// slot bevel
			position(
				rotate = [0, 0, -30],
				translate = [0, 0, -ff/2])
				cube([slot_ext + ff, slot_ext + ff, width+ff]);
		}

	// main plate
	translate([-wall_width/2, -plate_length, 0])
		cube([wall_width, plate_length, width]);

	// rounded top
	cylinder(h = width, r = wall_width/2);
}