/* [General] */ // Sizes in millimeters
width       = 290;
length      = 100;
height      = 16;


/* [Advanced] */
// You can add feet to the pieces after printing
radius_of_feet  = 10;   // [0:10]
rfeet = radius_of_feet;

// Automatically split pieces to be smaller than this
max_print_width = 200; // [50:5:1000]

// Clearance is applied to pieces with pegs.
clearance       = 0.4;     // [0:0.1:1]


/* [Hidden] */
name    = "Riku Isokoski";
padding = 3;
step    = 2;
$fn     = 36;

// These settings may, and probably will cause issues. Use with caution.
corner_radius   = 0; // [100]
rcorner = min(corner_radius, length / 2);

bevel_height    = 0; // [100]
hbevel = min(bevel_height, rcorner, height);

// Hides the empty space inside the part. Splitting the object in stl will probably separate the hollow space inside as a separate part
flat_bottom     = false;


/*
 * END OF CUSTOMIZER
 */


// Prepare some variables
temp = ceil(width / max_print_width);
npieces = ceil((width + (temp * height * 2) - (temp * step * 4)) / max_print_width);

w = width / npieces;


if(npieces == 1)
{
	rest("single");
}

else if(npieces == 2)
{
	rest("left");
	translate([0, length + 6]) rest("right");
}

else if(npieces >= 3)
{
	rest("left");
	translate([0, length + 6]) rest("right");
	for(i = [2:npieces - 1])
		translate([0, (length * i) + (6 * i)]) rest("middle");
}


module rest(piece)
{
	difference()
	{
		if(piece == "single") difference()
		{
			roundcube([w, length, height], rcorner, hbevel);

			// Name on back
			translate([w - padding, length - 0.5, padding]) rotate([90, 0, 180]) linear_extrude(0.5) text(name, valign="bottom", size=6);

			// Extra feet on single piece
			translate([rfeet + 5, rfeet + 5])              cylinder(1, rfeet, rfeet);
			translate([rfeet + 5, length - rfeet - 5])     cylinder(1, rfeet, rfeet);
		}

		else if(piece == "left") difference()
		{
			roundcube([w + height - (step * 2), length, height], rcorner, hbevel);

			socket();

			// Extra feet on left piece
			translate([rfeet + 5, rfeet + 5])          cylinder(1, rfeet, rfeet);
			translate([rfeet + 5, length - rfeet - 5]) cylinder(1, rfeet, rfeet);
		}

		else if(piece == "right") difference()
		{
			translate([-height + (step * 2), 0]) roundcube([w + height - (step * 2), length, height], rcorner, hbevel);

			// Name on back
			if(w > 60) translate([w - padding, length - 0.5, padding]) rotate([90, 0, 180]) linear_extrude(0.5) text(name, valign="bottom", size=6);

			pegs();
		}

		else if(piece == "middle") difference()
		{
			translate([-height + (step * 2), 0]) cube([w + (height * 2) - (step * 4), length, height]);
			socket();
			pegs();
		}

		// Holes for feet on all pieces
		translate([w - rfeet - 5, rfeet + 5])          cylinder(1, rfeet, rfeet);
		translate([w - rfeet - 5, length - rfeet - 5]) cylinder(1, rfeet, rfeet);

		// Plastic saving
		r = length / 3;
		if(w / 2 > r + (length / 6)) hull()
		{
			hide= flat_bottom ? 1:0;
			translate([r + (length / 6), length / 2, hide])       cylinder(height - 2 - hide, r, r);
			translate([w - (r + (length / 6)), length / 2, hide]) cylinder(height - 2 - hide, r, r);
		}

		// Front and back side slope
		c = (height / 3) * sqrt(2);
		translate([w, 0, height])      rotate([45, 0]) cube([w * 2, c, c], center=true);
		translate([w, length, height]) rotate([45, 0]) cube([w * 2, c, c], center=true);
	}
}

module pegs()
{
	r = height - step * 2 + (clearance / 2);
	difference()
	{
		union()
		{
			rotate([0, -90]) cube([height, length, height]);
			intersection()
			{
				union()
				{
					translate([0, (length / 6) - (height / 4) - (clearance / 2), height - step]) rotate([0, 135]) cube([height, length - (length / 3) + (height / 2) + clearance, (height - (step * 2)) * sqrt(2)]);
					translate([height - (step * 3), (length / 6) - (height / 4) - (clearance / 2)]) cube([step, length - (length / 3) + (height / 2) + clearance, step]);
				}
				hull()
				{
					translate([0, (length / 6) - (height / 4) + r]) cylinder(height, r, r);
					translate([0, length - ((length / 6) - (height / 4)) - r]) cylinder(height, r, r);
				}
			}
		}
		intersection()
		{
		r = (height / 4) - (clearance / 2);
			union() hull() translate([height - (step * 2) - (clearance / 2), length / 3, height - step]) rotate([0, -135])
			{
										   cylinder((height + step) * sqrt(2), r, r);
				translate([0, length / 3]) cylinder((height + step) * sqrt(2), r, r);
			}
			translate([-height, 0]) cube([height * 2, length, height]);
		}
	}
}

module socket()
{
	r = height - step * 2;
	union()
	{
		difference()
		{
			translate([w, 0]) cube([height, length, (height - (step * 2)) * sqrt(2)]);
			intersection()
			{
				union()
				{
					translate([w, (length / 6) - (height / 4), height - step]) rotate([0, 135]) cube([height, length - (length / 3) + (height / 2), (height - (step * 2)) * sqrt(2)]);
					translate([w + height - (step * 3), (length / 6) - (height / 4)]) cube([step, length - (length / 3) + (height / 2), step]);
				}
				hull()
				{
					translate([w, (length / 6) - (height / 4) + r]) cylinder(height, r, r);
					translate([w, length - ((length / 6) - (height / 4)) - r]) cylinder(height, r, r);
				}
			}
		}

		hull() translate([w + height - (step * 2), length / 3, height - step]) rotate([0, -135])
		{
			                           cylinder((height + step) * sqrt(2), height / 4, height / 4);
			translate([0, length / 3]) cylinder((height + step) * sqrt(2), height / 4, height / 4);
		}
	}
}

module roundcube (dimensions=[1,1,1], radius=0, top=0)
{
	if(radius == 0) cube(dimensions);
	hull()
	{
		translate([radius, radius]) cylinder(dimensions[2] - top, radius, radius);
		translate([dimensions[0] - radius, radius]) cylinder(dimensions[2] - top, radius, radius);
		translate([radius, dimensions[1] - radius]) cylinder(dimensions[2] - top, radius, radius);
		translate([dimensions[0] - radius, dimensions[1] - radius]) cylinder(dimensions[2] - top, radius, radius);
		if(top > 0) translate([0, 0, dimensions[2] - top])
		{
			translate([radius, radius]) cylinder(top, radius, radius - top);
			translate([dimensions[0] - radius, radius]) cylinder(top, radius, radius - top);
			translate([radius, dimensions[1] - radius]) cylinder(top, radius, radius - top);
			translate([dimensions[0] - radius, dimensions[1] - radius]) cylinder(top, radius, radius - top);
		}
	}
}

