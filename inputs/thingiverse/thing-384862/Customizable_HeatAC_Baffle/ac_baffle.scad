// Customizable Air Conditioner Baffle
// designed by knarfishness for DieselPoweredRobotics
// 07.04.2014

baffle_length = 30;
baffle_radius = 7.5;
baffle_thickness = 1;
baffle_endwall_thickness = 1;

baffle_bracket_size = 3;
baffle_bracket_thickness = 0.3;



module quarter_pipe()
{
	intersection()
	{
		cube([baffle_radius*2,baffle_radius*2,baffle_length]);
		cylinder(baffle_length,baffle_radius,baffle_radius);
	}
}

module quarter_pipe_inner()
{
	translate([0,0,baffle_endwall_thickness])
	intersection()
	{
		cube([baffle_radius*2,baffle_radius*2,baffle_length-(baffle_endwall_thickness*2)]);
		cylinder(baffle_length-(baffle_endwall_thickness*2),baffle_radius,baffle_radius);
	}
}

module baffle_wall()
{
	difference()
	{
		quarter_pipe();
		translate([-baffle_thickness,-baffle_thickness,0])
		quarter_pipe_inner();
		
	}
}

module bracket_piece()
{
	cube([baffle_radius,baffle_bracket_thickness,baffle_bracket_size]);
}

module brackets()
{
	translate([0,0,-baffle_bracket_size])
	bracket_piece();
	
	translate([0,0,baffle_length])
	bracket_piece();
}

brackets();
baffle_wall();



