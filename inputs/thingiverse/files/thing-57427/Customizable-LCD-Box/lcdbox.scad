// Customizable LCD Holder Box
// 2013 Frank Avery
// dieselpoweredrobotics.com

//Settable Variables

// Defines the length of the box
box_length = 160; // Numeric vaue highter than Screen Length

// Defines the width of the box
box_width = 80; // Numeric value higher than Screen Width

// Defines the LCD screen length
screen_length = 100; // Numeric value smaller than Box Length

// Defines the LCD screen height
screen_width = 40; // Numeric value smaller than Box Width

// Determines the thickness of the box walls
wall_thickness = 5; // Top may not fix if thickness is reduced below 2.

// Determines how tall the box is (height of the sidewalls)
wall_height = 30; // Any numeric value

// Generate a cover for the other side of the box
generate_top = "yes"; // [Yes,No]


//Calculated Variables
wall_offset = wall_thickness / 2;
screen_offset_y = (box_length - screen_length) / 2;
screen_offset_x = (box_width - screen_width) / 2;

module lcdbox()
{
	//lcd screen box
	module screen()
	{
		translate([screen_offset_x,screen_offset_y,-5]) 
		cube([screen_width,screen_length,30]);
	}

	//front faceplate
	module holder()
	{
		cube([box_width,box_length,wall_thickness]);
	}

	//sidewalls of the box
	module sidewalls()
	{
		difference()
		{
			translate([0,0,wall_thickness]) cube([box_width,box_length,wall_height]);
			translate([wall_offset,wall_offset,-5]) cube([box_width-wall_thickness,box_length-wall_thickness,wall_height+20]);
		}
		
	}

	//join sidewalls to difference between holder and screen
	union()
	{
		sidewalls();
		difference()
		{
			holder();
			screen();
		}
	}
}

//top to be printed
module lcdbottom()
{
	translate([-100,0,0])
	cube([box_width, box_length,wall_thickness]);

	translate([-100+wall_offset,wall_offset,wall_thickness])
	cube([box_width-wall_thickness,box_length-wall_thickness,wall_thickness]);
}

lcdbox();

if (generate_top == "Yes")
{
	lcdbottom();
}

