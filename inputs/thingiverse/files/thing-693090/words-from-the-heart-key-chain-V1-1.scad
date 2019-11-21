
// 'Words from the Heart Key Chain' by wstein 
// is licensed under the Attribution - Non-Commercial - Share Alike license. 
// Version 1.1 (c) February 2015
// please refer the complete license here: http://creativecommons.org/licenses/by-nc-sa/3.0/legalcoe

// preview[view:south, tilt:top]

/* [Text] */
line1 = "Enter Text";
line2 = "Here!";
alignment = 0; //[0: left, 1: center, 2: right]

/* [Appearance] */
//set to false if no lug is desired
build_lug=1; // [0:false, 1:true]
hole_diameter=4.0;

base_plate_rounding = 2;
base_plate_outline_1 = 1.0;
base_plate_outline_2 = 1.0;

// of heart
outline_width = 3;
heart_fringe = 1.0;

/* [Font] */

text_font = "knewave.dxf"; //[orbitron.dxf,Letters.dxf,knewave.dxf,BlackRose.dxf]
text_height = 8;
//corrects the kerning - depends on font
text_space_factor = 0.75;
line_space_factor = 1.05;

/* [Output] */
lug_level=2.0;

base_plate_level = 1.0; // white

base_plate_outline_1_level = 1.5;

base_plate_outline_2_level = 2.0;


// height of big heart
big_heart_level = 1.0; // white

// height of big heart outline
big_heart_outline_level = 1.5; // red

// height of small heart
small_heart_level = 1.5; // red

// height of small heart outline
small_heart_outline_level = 2.0; // black

// height of words
text_level = 2.0; // black

/* [Hidden] */

big_heart_size = 70.0;
big_heart_x = 70.0;
big_heart_y = 70.0;

small_heart_size = 35.0;
small_heart_pos = [6, -7];

text = [line1, line2];

//big_heart_size = 12;
//small_heart_size = 8;


char_width = 11 / 16 * text_height * text_space_factor; // this is the formular write.scad internal uses
line_start = [-3, 18];

max_line_len = max(len(text[0])+line_start[0]/char_width,len(text[1])+line_start[1]/char_width);
line_width = max_line_len * char_width;
max_level = max(base_plate_level, big_heart_level, big_heart_outline_level, small_heart_level, small_heart_outline_level, text_level = 2.0);

lug_diameter=hole_diameter+2*lug_level;		

use <write/Write.scad>

$fn = 50; // only relevant for neodym holes[ 2.45, -148.21, 52.02 ]



// http://en.wikipedia.org/wiki/File:GJL-fft-herz.svg
function get_heart_x(t) = 12 * sin(t) - 4 * sin(3 * t);
function get_heart_y(t) = 13 * cos(t) - 5 * cos(2 * t) - 2 * cos(3 * t) - cos(4 * t);

function get_link_length(str) = char_width * (len(str) - 0.3);


//Ok, lets start building by calling process_word()...
words_from_the_heart();

// builds an outlined heart
module outline_heart(height, width, outline_width, outline_level, depth,col1,col2)
union()
{
	difference()
	{
		color(col2)
		heart(height, width, outline_level);

		heart(height-2*outline_width, width-2*outline_width, outline_level+.1);
	}
	

	color(col1)
	heart(height-2*outline_width, width-2*outline_width, depth);

	color("white")
	build_heart_fringe(height, width, base_plate_level);
}

// builds a simple heart
module heart(height, width, depth)
scale([height/90, width/90, 1])
linear_extrude(height=depth,convexity=10)
assign(step=5)
for(a=[0:step:360])
polygon(points=[[0,0],[get_heart_x(a),get_heart_y(a)],[get_heart_x(a+step),get_heart_y(a+step)]]);

// builds a fringe of heart
module build_heart_fringe(height, width, depth)
linear_extrude(height=depth,convexity=10)
assign(step=5)
for(a=[0:step:360])
hull()
{
	translate([get_heart_x(a)*height/90, width/90*get_heart_y(a)])
	circle(r=heart_fringe);

	translate([get_heart_x(a+step)*height/90, width/90*get_heart_y(a+step)])
	circle(r=heart_fringe);

	circle(r=heart_fringe);
}

// builds a doubled heart
// builds the tagged heart sticker
module words_from_the_heart()
translate([-5,-1.2,0])
union()
{
	difference()
	{
		translate([5,1.2,0])
		union()
		{
			difference()
			{
				outline_heart(big_heart_size, big_heart_size, 1.6*outline_width,big_heart_outline_level,big_heart_level,"white","red");
			
				translate(small_heart_pos)
				build_heart_fringe(small_heart_size, small_heart_size,max_level+.1);
			}
			
			translate(small_heart_pos)
			outline_heart(small_heart_size, small_heart_size,outline_width,small_heart_outline_level,small_heart_level,"red","black");
		}

		
		for(line_no=[0:len(text)-1])
		build_text();
	}

	color("black")
	build_text();

	difference()
	{
		union()
		{
			if(build_lug)
			translate([-base_plate_rounding + char_width * 0.4, 1.2 * line_space_factor * text_height - base_plate_rounding])
			build_lug();


			color("red")
			build_frame(base_plate_outline_2+base_plate_outline_1, base_plate_outline_1_level);
	
			color("black")
			build_frame(base_plate_outline_2, base_plate_outline_2_level);
		}

		build_plate(0, lug_level+.1);

		translate([5,1.2,0])
		union()
		{
			build_heart_fringe(big_heart_size,big_heart_size,max_level+.1);

			translate(small_heart_pos)
			build_heart_fringe(small_heart_size, small_heart_size,max_level+.1);
		}
	}

	color("white")
	build_plate(0, base_plate_level);
}


module build_frame(outline, level)
difference()
{
	build_plate(-outline, level);

	build_plate(0, level + .1);

	translate([5,1.2,0])
	build_heart_fringe(big_heart_size,big_heart_size,max_level+.1);
}


module build_text()
for(line_no=[0:len(text)-1])
assign(line=text[line_no])
assign(start=line_start[line_no] / char_width)
translate([start * char_width + (max_line_len - start - len(line)) * char_width * alignment / 2, -line_no * text_height * line_space_factor,0])
write(line, h=text_height, t=text_level, font=text_font, center=false, space=text_space_factor);

module build_plate(offset, level)
linear_extrude(height=level,convexity=10)
hull()
for(x=[base_plate_rounding - char_width * 0.4, max_line_len * char_width - base_plate_rounding + char_width * 0.7],y=[-1.15 * line_space_factor * text_height + base_plate_rounding, 1.1 * line_space_factor * text_height - base_plate_rounding])
translate([x, y - 1, 0])
circle(r=base_plate_rounding-offset, $fn=20);

module build_lug()
translate([-lug_diameter/2,lug_diameter/2,0])
difference()
{
	color("black")
	union()
	{
		cylinder(r=lug_diameter/2,h=lug_level, $fn=25);

		rotate([0,0,-45])
		translate([0,-lug_diameter/2,0])
		cube([lug_diameter,lug_diameter,lug_level]);
	}

	translate([0,0,-.1])
	cylinder(r=hole_diameter/2,h=lug_level+.2, $fn=25);
}







