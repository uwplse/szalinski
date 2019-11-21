// Title: Reminder
// Author: http://www.thingiverse.com/Jinja
// Date: 2/3/2013

use <write/Write.scad> 

/////////// START OF PARAMETERS /////////////////

// The height of the letter. mm =
letter_height = 20; //[10:100]

// The depth of the letter. mm =
letter_depth = 2; //[2:100]

// The top hook inner diameter. mm =
top_hook_diameter = 15; //[8:80]

// The top hook thickness. mm =
top_hook_thickness = 3; //[2:20]

// The botton hook inner diameter. mm =
bottom_hook_diameter = 15; //[8:80]

// The bottom hook thickness. mm =
bottom_hook_thickness = 3; //[2:20]

// The bottom hook thickness. mm =
reminder_text = "Laundry";

// Choose which colour to output for single or dual extruders
extruder_colour = "SingleExtrude"; // [DoubleExtrude1,DoubleExtrude2,SingleExtrude]

// The depth of the hooks. mm =
hook_depth = 1; //[1:10]

// The depth of the border that holds the letters
border_depth = 1; //[1:10]

// The thickness of the border that holds the letters
border_fullness = 20; //[5:100]


/////////// END OF PARAMETERS /////////////////

$fa=5*1;
$fs=0.3*1;

if( extruder_colour == "SingleExtrude" )
{
	reminder( reminder_text, letter_height, top_hook_diameter, top_hook_thickness, bottom_hook_diameter, bottom_hook_thickness );
}
else if ( extruder_colour == "DoubleExtrude1" )
{
	reminder_back( reminder_text, letter_height, top_hook_diameter, top_hook_thickness, bottom_hook_diameter, bottom_hook_thickness );
}
else
{
	reminder_letters( reminder_text, letter_height, top_hook_diameter, top_hook_thickness, bottom_hook_diameter, bottom_hook_thickness );
}


//big_hook( 30, 5 );

//male_hook( 5, 4 );
//translate([10,0,0])
//female_hook( 5, 4 );

module male_hook( width, height )
{
	length = 10+height;
	difference()
	{
		cube([width, length, height]);
		translate([0, 5-1,0])
		difference()
		{
			cube([width, (length-5), height*0.5]);
			translate([0,(length-5), height*0.5])
			rotate([-135,0,0])
			cube([width, (length-5), height*0.5]);
		}
	}
}

module female_hook( width, height )
{
	length = 10+height;
	translate([width,0,0])
	rotate([0,0,180])
	{
	translate([-0.5,0,height])
	scale([(width+1)/width,1,-1])
	male_hook( width, height );
	translate([-1.5,0,0])
	cube( [1,length,height]);
	translate([width+0.5,0,0])
	cube( [1,length,height]);
	}
}

module big_hook( diam, thickness )
{
	radius = diam/2;
	rad2 = thickness*0.5;
	
	translate([0,radius+rad2+(radius+thickness)*0.5,0])
	{
		difference()
		{
			cylinder( hook_depth, radius+thickness, radius+thickness );
			translate([0,0,-1])
			cylinder( hook_depth+2, radius, radius );
			translate([-diam-thickness,-diam-thickness,-1])
			cube([diam+thickness,diam+thickness,hook_depth+2]);
		}
		
		translate([-radius-rad2,0,0])
		cylinder( hook_depth, rad2, rad2 );
	
		translate([0,-radius-rad2,0])
		cylinder( hook_depth, rad2, rad2 );
	
		translate([0,-radius-rad2-(radius+thickness)*0.25,hook_depth*0.5])
		cube([rad2*2,(radius+thickness)*0.5,hook_depth],true);
	}
}

module reminder( word, height, top_diam, top_width, botton_diam, bottom_width )
{
	length = len(word);
	spacing = 1.1;
	char_width=4.125*(height/6);
	char_space=0.666667*(height/6);
	char_height=height*1.086;
	border_width=char_width*0.15;
	border_width2=((char_height-border_width)*border_fullness)/200;
	border_height=border_depth;
	hook_width=5;
	tborder_width = ((length*char_width)-char_space)*spacing-border_width;
	tborder_height = char_height-border_width;
	middle = (tborder_width-hook_width+border_width)*0.5;

	translate([border_width*0.5,border_width*0.5,0])
	difference()
	{
		cube([tborder_width, tborder_height, border_height]);
		translate([border_width2,border_width2,-1])
		cube([tborder_width-(2*border_width2), tborder_height-2*border_width2, border_height+2]);
	}

	write(word,h=height,t=letter_depth,font="write/orbitron.dxf",space=spacing);

/*	translate([middle-char_width*0.6,tborder_height,0])
	male_hook( hook_width, 3 );
	translate([middle+char_width*0.6,tborder_height,0])
	male_hook( hook_width, 3 );

	translate([middle-char_width*0.6,border_width,0])
	female_hook( hook_width, 3 );
	translate([middle+char_width*0.6,border_width,0])
	female_hook( hook_width, 3 );
*/

	translate([middle,tborder_height,0])
	big_hook( top_diam, top_width );

	translate([middle,border_width,0])
	rotate([0,0,180])
	big_hook( botton_diam, bottom_width );

}

module reminder_back( word, height, top_diam, top_width, botton_diam, bottom_width )
{
	length = len(word);
	spacing = 1.1;
	char_width=4.125*(height/6);
	char_space=0.666667*(height/6);
	char_height=height*1.086;
	border_width=char_width*0.15;
	border_width2=((char_height-border_width)*border_fullness)/200;
	border_height=border_depth;
	hook_width=5;
	tborder_width = ((length*char_width)-char_space)*spacing-border_width;
	tborder_height = char_height-border_width;
	middle = (tborder_width-hook_width+border_width)*0.5;

	translate([border_width*0.5,border_width*0.5,0])
	difference()
	{
		cube([tborder_width, tborder_height, border_height]);
		translate([border_width2,border_width2,-1])
		cube([tborder_width-(2*border_width2), tborder_height-2*border_width2, border_height+2]);
	}

//	write(word,h=height,t=2,font="write/orbitron.dxf",space=spacing);

/*	translate([middle-char_width*0.6,tborder_height,0])
	male_hook( hook_width, 3 );
	translate([middle+char_width*0.6,tborder_height,0])
	male_hook( hook_width, 3 );

	translate([middle-char_width*0.6,border_width,0])
	female_hook( hook_width, 3 );
	translate([middle+char_width*0.6,border_width,0])
	female_hook( hook_width, 3 );
*/

	translate([middle,tborder_height,0])
	big_hook( top_diam, top_width );

	translate([middle,border_width,0])
	rotate([0,0,180])
	big_hook( botton_diam, bottom_width );

}

module reminder_letters( word, height, top_diam, top_width, botton_diam, bottom_width )
{
	spacing = 1.1;

	difference()
	{
		write(word,h=height,t=2,font="write/orbitron.dxf",space=spacing);
		reminder_back( word, height, top_diam, top_width, botton_diam, bottom_width );
	}
}
