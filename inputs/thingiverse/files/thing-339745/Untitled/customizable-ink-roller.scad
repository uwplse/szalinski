use <write/Write.scad>



/*[Basic Settings]*/
//Type in a message for your roller
text = "Customizable Roller!";
//pick your font
font = 0;	//[0:Futuristic, 1:Basic, 2:Fancy]
//in mm from the flat roller surface
text_thickness = 1; //[1:Shallow, 2:Deep, 3:Deeper]
//turn this on to have the letters cut out of the surface instead of extruded from it (inverts the colors of the roller)
inset_letters = 0; //[0:Off,1:On]
//how slanted with the lines of text be, in degrees
text_angle = 60; //[45:90]

/*[Advanced Settings]*/
//in mm
roller_height = 120;
//in mm
outer_diameter = 35;
//where the roller dowel goes, in mm
inner_diameter = 12;
//how tightly packed the lines of text will be, as a percent
line_density = 50; //[30:90]
//character spacing percent, in letter widths
font_kerning_percent = 50; //[0:400]
//how much empty space (without text) at each end of the roller, in mm
padding = 5; //[0:20]


/*[Hidden]*/
preview_tab = "final";
epsilon = .1;
max_char_height = 16 - (text_angle / 90 * 4);
font_kerning = 1 + font_kerning_percent / 100;
base_char_width = 8.50769 * font_kerning;
density = line_density / 100;
outer_radius = outer_diameter / 2;
inner_radius = inner_diameter / 2;
echo(8.46 / 1.3);
roller_circumference = outer_radius * 2 * PI;
helix_lead = tan(text_angle) * roller_circumference;
echo("helix_lead", helix_lead);

revolutions = (roller_height - (padding * 2)) / helix_lead;
echo("revolutions", revolutions);

actual_line_length = sqrt(pow(roller_circumference, 2) + pow(helix_lead, 2)) * revolutions + (((90 - text_angle) / 45) * ((padding) + 30)); //that last part is a hack to make spiral text extend as far on the roller, discrepency might be caused by how write.scad constructs the spiral
echo("actual_line_length", actual_line_length);

actual_char_width = actual_line_length / len(text);
echo("actual_char_width", actual_char_width);

scale_factor = actual_char_width >= base_char_width ? 1 : actual_char_width / base_char_width;
actual_char_height = max_char_height * scale_factor;
echo("actual_char_height", actual_char_height);


rotated_character_width_contribution = abs(sin(text_angle - 90) * actual_char_width);
rotated_character_height_contribution = abs(sin(text_angle) * actual_char_height);
echo("width contribution", rotated_character_width_contribution);
echo("height contribution", rotated_character_height_contribution);


total_width = rotated_character_width_contribution + rotated_character_height_contribution;
echo("total", total_width);

number_of_lines = floor(roller_circumference / total_width * density);
function fonts() = ["write/orbitron.dxf", "write/Letters.dxf", "write/BlackRose.dxf"];


if(preview_tab == "final")
{
	if(inset_letters == 0)
	{
		difference()
		{
			cylinder(r = outer_radius, h = roller_height, $fn = 50);
			translate([0,0,-epsilon])
				cylinder(r = inner_radius, h = roller_height + epsilon * 2, $fn = 50);
		}




		color([1,1,1])
		translate([0,0,roller_height])
		scale([1,1,-1])
		intersection()
		{
		for(i = [0:number_of_lines - 1])
		{
		rotate([0,0,360 / number_of_lines * i])
		writecylinder
		(
			text,
			[0,0,roller_height / 2],
			outer_radius,
			center=true,
			down=0,
			rotate= -text_angle,
			space = font_kerning,
			font = fonts()[font],
			t = text_thickness * 4,
			h = actual_char_height,
			middle = 10
		);
		}
		translate([0,0,padding])
		cylinder(r = outer_radius + text_thickness, h = roller_height - padding * 2, $fn = 50);
		}
	}
	else
	{
		difference(){
			difference()
			{
				cylinder(r = outer_radius, h = roller_height, $fn = 50);
				translate([0,0,-epsilon])
					cylinder(r = inner_radius, h = roller_height + epsilon * 2, $fn = 50);
			}




			color([1,1,1])
			translate([0,0,roller_height])
			scale([1,1,-1])
			intersection()
			{
			for(i = [0:number_of_lines - 1])
			{
			rotate([0,0,360 / number_of_lines * i])
			writecylinder
			(
				text,
				[0,0,roller_height / 2],
				outer_radius,
				center=true,
				down=0,
				rotate= -text_angle,
				space = font_kerning,
				font = fonts()[font],
				t = text_thickness * 4,
				h = actual_char_height,
				middle = text_thickness
			);
			}
			translate([0,0,padding])
			cylinder(r = outer_radius + text_thickness, h = roller_height - padding * 2, $fn = 50);
			}
		}
	}
}
else
{
	if(inset_letters == 0)
	{
		difference()
		{
			cylinder(r = outer_radius, h = roller_height, $fn = 32);
			translate([0,0,-epsilon])
				cylinder(r = inner_radius, h = roller_height + epsilon * 2, $fn = 32);
		}




		color([1,1,1])
			translate([0,0,roller_height])
				scale([1,1,-1])
					for(i = [0:number_of_lines - 1])
					{
						rotate([0,0,360 / number_of_lines * i])
							writecylinder
							(
								text,
								[0,0,roller_height / 2],
								outer_radius,
								center=true,
								down=0,
								rotate= -text_angle,
								space = font_kerning,
								font = fonts()[font],
								t = text_thickness,
								h = actual_char_height,
								middle = 10
							);
					}
	}
	else
	{
		difference()
		{
			difference()
			{
				cylinder(r = outer_radius, h = roller_height, $fn = 32);
				translate([0,0,-epsilon])
					cylinder(r = inner_radius, h = roller_height + epsilon * 2, $fn = 32);
			}


			color([1,1,1])
				translate([0,0,roller_height])
					scale([1,1,-1])
						for(i = [0:number_of_lines - 1])
						{
							rotate([0,0,360 / number_of_lines * i])
								writecylinder
								(
									text,
									[0,0,roller_height / 2],
									outer_radius,
									center=true,
									down=0,
									rotate= -text_angle,
									space = font_kerning,
									font = fonts()[font],
									t = text_thickness * 4,
									h = actual_char_height,
									middle = text_thickness
								);
						}
		}

	}

}