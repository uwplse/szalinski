
// 'Crossing Out Label' by wstein 
// is licensed under the Attribution - Non-Commercial - Share Alike license. 
// Version 1.0 (c) March 2015
// please refer the complete license here: http://creativecommons.org/licenses/by-nc-sa/3.0/legalcoe

// preview[view:south, tilt:top]

/* [Text] */
line1 = "Enter Text";
line2 = "Here or Leave";
line3 = "it Empty!";
line4 = "";
alignment = 1; //[0: left, 1: center, 2: right]

/* [Appearance] */
//set to none for simple plate
build_lug=1; //[1:key-chain, 0:none]
hole_diameter=4.0;

//type
stroke=3; //[3:cross, 2:up, 1:down, 0:none]
stroke_width=7;//[1:25] 

base_plate_rounding = 3;
base_plate_outline = 2.0;

/* [Font] */

text_font = "knewave.dxf"; //[orbitron.dxf,Letters.dxf,knewave.dxf,BlackRose.dxf]
text_height = 8;
//corrects the kerning - depends on font
text_space_factor = 0.75;
line_space_factor = 1.05;

/* [Output] */
base_plate_level = 1.0; // white

base_plate_outline_level = 2.0;
stroke_level = 2.0;

// height of words
text_level = 1.5; // red

/* [Hidden] */

text = 
	(len(line4) > 0 ? [line1, line2, line3, line4] :
	(len(line3) > 0 ? [line1, line2, line3] :
	(len(line2) > 0 ? [line1, line2] : [line1])));

lug_level=base_plate_outline_level;

char_width = 11 / 16 * text_height * text_space_factor; // this is the formular write.scad internal uses
line_start = [0, 0, 0, 0];

max_line_len = max(
	len(line1)+line_start[0]/char_width,
	len(line2)+line_start[1]/char_width,
	len(line3)+line_start[2]/char_width,
	len(line4)+line_start[3]/char_width);
line_width = max_line_len * char_width;
max_level = max(base_plate_level, text_level);

lug_diameter=hole_diameter+2*lug_level;		

x_edge=[base_plate_rounding - char_width * 0.4, max_line_len * char_width - base_plate_rounding + char_width * 0.7];
y_edge=[line_space_factor * text_height - base_plate_rounding, -1.25 * line_space_factor * text_height + base_plate_rounding - line_space_factor * text_height * (len(text) - 2)];

echo("len(text)",len(text));
use <write/Write.scad>

$fn = 50; // only relevant for neodym holes[ 2.45, -148.21, 52.02 ]

//Ok, lets start building...
build_key_chain_label();

// builds a doubled heart
// builds the tagged heart sticker
module build_key_chain_label()
union()
{
	color("red")
	build_text();

	difference()
	{
		union()
		{
			if(build_lug)
			translate([x_edge[0], y_edge[0],0])
			build_lug();


			color("black")
			build_frame(base_plate_outline, base_plate_outline_level);
		}

		build_plate(0, lug_level+.1);
	}

	color("white")
	build_plate(0, base_plate_level);

	if(stroke!=0)
	color("black")
	build_stroke();
}

stroke_values=[
	[],
	[
		[[x_edge[0],y_edge[0]],[x_edge[1],y_edge[1]]]
	],
	[
		[[x_edge[0],y_edge[1]],[x_edge[1],y_edge[0]]]
	],
	[
		[[x_edge[0],y_edge[0]],[x_edge[1],y_edge[1]]],
		[[x_edge[0],y_edge[1]],[x_edge[1],y_edge[0]]]
	]
];

module build_stroke()
linear_extrude(height=stroke_level,convexity=10)
for(values=stroke_values[stroke])
hull()
for(pos=values)
//for(pos=value)
translate(pos)
//echo("value",value);
circle(r=stroke_width*text_height/80, $fn=10);



module build_frame(outline, level)
difference()
{
	build_plate(-outline, level);

	build_plate(0, level + .1);
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
for(x=x_edge,y=y_edge)
translate([x, y, 0])
circle(r=base_plate_rounding-offset, $fn=20);

module build_lug()
translate([-lug_diameter/2-base_plate_rounding*sqrt(.2),lug_diameter/2+base_plate_rounding*sqrt(.2),0])
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








