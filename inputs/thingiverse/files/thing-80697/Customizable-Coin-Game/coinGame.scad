use <write/Write.scad>
// ----------------------------------------------------------------------------
// Customizer Variables
// ----------------------------------------------------------------------------

// preview[view:south east, tilt:top]

/* [Global] */
part = "Preview"; //[Preview, Top, Coins, Bottom]

/* [Sizes] */
coin_diameter = 18.1;
coin_height   = 1.2;
coin_number   = 5; //[4,5,6]

line_number = 3; //[3,4,5,6]
line_margin = 3; //[3,4,5,6,7,8,9,10]

layer_height    = 0.2;
extrusion_width = 0.5;

// To allow moving parts
xy_margin = 0.2;
// To allow moving parts
z_margin  = 0.2;

top_plate_height = 2;
plate_min_height = 1.2;

slider_min_radius = 2;
slider_increment  = 1;

// thickness of the hinge
coin_catcher_hardness = 1;
// must be smaller or equal to coin_height
coin_catcher_height   = 1;
coin_catcher_margin   = 2;

/* [Text] */
text           = "Coin Game v1";
text_font      = "write/knewave.dxf"; //[write/Letters.dxf:Letters,write/BlackRose.dxf:BlackRose,write/orbitron.dxf:Orbitron,write/knewave.dxf:Knewave,write/braille.dxf:Braille]
text_space     = 0.8;
text_height    = 9; // set to zero to hide the text
font_thickness = 1;


// ----------------------------------------------------------------------------
/* [Hidden] */
// ----------------------------------------------------------------------------
$fn = 50;

font_depth = (ceil(font_thickness / layer_height) * layer_height);

depth_margin = (ceil(z_margin / layer_height) * layer_height);

coin_depth  = (ceil(coin_height / layer_height) * layer_height);
coin_width  = (ceil(coin_diameter / extrusion_width) * extrusion_width);
coin_radius = coin_width / 2;
coin_limit1 = coin_number - 1;
coin_limit2 = coin_number - 2;

line_limit         = line_number - 1;
line_radius        = coin_radius + xy_margin;
line_depth         = coin_depth + depth_margin;
line_width         = line_radius * 2;
line_width_margin  = line_width + line_margin;
line_radius_margin = line_radius + line_margin;

plate_min_depth = (ceil(plate_min_height / layer_height) * layer_height);
plate_width     = (line_number * line_width_margin) + line_margin;
plate_height    = (coin_number * line_width) + (line_margin * 2) + text_height;

slider_radius = (slider_increment * coin_limit2) + slider_min_radius;
slider_depth  = (ceil(1.2 / layer_height) * layer_height);

step_radius   = slider_radius + xy_margin;
step_depth    = slider_depth + depth_margin;
step_diameter = step_radius * 2;

first_step_width = line_width_margin - ((step_radius - slider_increment) * 2);

top_plate_depth    = (ceil(top_plate_height / layer_height) * layer_height);
bottom_plate_depth = plate_min_depth + step_depth + line_depth;	
//top_plate_padding  = (first_step_width / 2) - (line_margin / 2);	
top_plate_padding  = line_width / 4;


// ----------------------------------------------------------------------------
// Simple Rounded Corners Plate
// ----------------------------------------------------------------------------
module plate(width, height, depth, corners_radius = 2)
{
	diameter   = corners_radius * 2;
	half_depth = depth / 2;
	
	minkowski() 
	{
		cube([width - diameter, height - diameter, half_depth]);
		translate([corners_radius, corners_radius, 0]) 
			cylinder(r = corners_radius, h = half_depth);
	}
}


// ----------------------------------------------------------------------------
// Coins Modules
// ----------------------------------------------------------------------------
module coins()
{
	translate([line_width_margin * line_limit, 0, 0])
		for (i = [0:coin_limit1]) 
		{
			translate([line_radius_margin, line_radius_margin + (line_width * i), 0]) 
			{
				// Coin Guide
				if (i < coin_limit1)
				{
					cylinder(r = slider_radius - (slider_increment * i), h = slider_depth + 0.1);
				}
				
				// Coin Base
				translate([0, 0, slider_depth]) 
					cylinder(r = coin_radius, h = coin_depth);
			}
		}
}


// ----------------------------------------------------------------------------
// Steps Modules
// ----------------------------------------------------------------------------
module steps()
{
	for (i = [0:line_limit]) 
	{
		translate([line_width_margin * i, 0, 0]) 
		{
			for (y = [0:coin_limit1]) 
			{
				translate([line_radius_margin, line_radius_margin + (line_width * y), 0]) 
				{
					if (y < coin_limit1)
					{
						cylinder(r = step_radius - (slider_increment * y), h = step_depth + 0.1);
						
						if (y < coin_limit2)
						{
							translate([-(step_radius - (slider_increment * (y + 1))), 0, 0]) 
								cube([(step_radius - (slider_increment * (y + 1))) * 2, line_width, step_depth + 0.1]);
						}
					}
				}
			}

			if (i < line_limit)
			{
				translate([line_radius_margin, line_radius_margin - step_radius, 0]) 
				{
					difference()
					{
						cube([line_width_margin, step_diameter + 1, step_depth + 0.1]);
						translate([step_radius - slider_increment, step_diameter, -1])
							plate(first_step_width, 4, step_depth + 2, 1);
					}
				}
			}
		}
	}
}


// ----------------------------------------------------------------------------
// Lines Modules
// ----------------------------------------------------------------------------
module lines(padding = 0, depth = line_depth)
{
	radius      = line_radius - padding;
	cube_width  = radius * 2;
	
	for (i = [0:line_limit]) 
	{
		translate([line_radius_margin + line_width_margin * i, line_radius_margin, 0]) 
		{
			hull()
			{
				translate([0, line_width * coin_limit1, 0])
					cylinder(r = radius, h = depth);
				cylinder(r = radius, h = depth);
			}

			if (i < line_limit)
			{
				translate([0, -radius, 0]) 
				{
					difference()
					{
						cube([line_width_margin, cube_width + 1, depth]);
						translate([radius, cube_width, -1])
							plate(line_margin + (padding * 2), 4, depth + 2, 1);
					}
				}
			}
		}
	}
}


// ----------------------------------------------------------------------------
// Coin Catcher/Exit
// ----------------------------------------------------------------------------
module coin_catch_exit()
{
	height = (ceil(coin_catcher_height / layer_height) * layer_height);
	depth  = (ceil(coin_catcher_hardness / layer_height) * layer_height);

	translate([line_margin, plate_height - line_radius_margin, 0])
	{
		// Exit
		cube([line_width, line_radius_margin + 0.1, line_depth + 0.1]);

		// Catcher
		translate([line_width_margin * line_limit, 0, 0])
		{
			cube([line_width, line_radius, line_depth]);
			//translate([line_radius, 0, 0])
				//cylinder(r = line_radius, h = line_depth + 0.1);
			
			translate([0, 0, -(plate_min_depth + step_depth + 0.1)])
			{
				cube([coin_catcher_margin, line_radius_margin, bottom_plate_depth + 0.2]);
				translate([line_width - coin_catcher_margin, 0, 0])
					cube([coin_catcher_margin, line_radius_margin, bottom_plate_depth + 0.2]);
			}
			
			// ...bisot
			translate([0, 0, height])
			{
				cube([line_width, line_radius_margin, line_depth + 0.1]);
			
				translate([0, line_radius + extrusion_width, 0])
					rotate([-45, 0, 0])
						cube([line_width, line_radius, line_depth * 2]);
			}

			// ... hardness ?
			translate([0, 0, -depth])
				rotate([-135, 0, 0])
					cube([line_width, bottom_plate_depth, bottom_plate_depth]);
		}
	}
}


// ----------------------------------------------------------------------------
// Parts Creation
// ----------------------------------------------------------------------------
// Bottom
module bottom_plate()
{
	color("Silver")
	difference()
	{
		plate(plate_width, plate_height, bottom_plate_depth);
		translate([0, text_height, plate_min_depth])
			steps();
		translate([0, text_height, plate_min_depth + step_depth])
		{
			lines(0, line_depth + 0.1);
		}
		translate([0, 0, plate_min_depth + step_depth])
		{
			coin_catch_exit();
		}
	}
}

// Coins
module coins_plate()
{
	color("DarkRed")
	translate([0, text_height, plate_min_depth + depth_margin])
		coins();
}

// Top
module top_plate()
{
	layers = (top_plate_depth / layer_height) - 1;

	color("Yellow")
	translate([0, 0, bottom_plate_depth])
	{
		for (i = [0:layers]) 
		{
			translate([0, 0, layer_height * i])
			{	
				difference()
				{
					plate(plate_width, plate_height, layer_height);
					translate([0, text_height, -0.1])
						lines(top_plate_padding - (layer_height * i), layer_height + 0.2);
				}
			}
		}

		translate([plate_width / 2, (text_height / 2) + (line_margin / 2), (layer_height * layers) + (font_depth / 2)])
		{
			#write(text, t = font_depth, h = text_height, font = text_font, space = text_space, rotate = 180, center = true);
		}
	}
}

// ----------------------------------------------------------------------------
// Parts Display
// ----------------------------------------------------------------------------
rotate([0, 0, 180])
	translate([-(plate_width / 2), -(plate_height / 2), 0])
	{
		if (part == "Preview")
		{
			top_plate();
			coins_plate();
			bottom_plate();
		}
		else if (part == "Top")
		{
			translate([0, 0, -bottom_plate_depth])
				top_plate();
		}
		else if (part == "Coins")
		{
			rotate([180, 0, 0])
			translate([
				-(line_width_margin * (line_limit - 1)), 
				-plate_height-(text_height/2), 
				-bottom_plate_depth
			])
				coins_plate();
		}
		else if (part == "Bottom")
		{
			bottom_plate();
		}
	}


