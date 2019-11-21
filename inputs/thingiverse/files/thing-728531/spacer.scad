// 'Customizable Spacer' Version 1.0 by wstein 
// is licensed under the Attribution - Non-Commercial - Share Alike license. 
// (c) March 2015 
// please refer the complete license here: http://creativecommons.org/licenses/by-nc-sa/3.0/legalcode

use <write/Write.scad>

//Please don't forget to add a little bit backlash if you need that.
inner_diameter=33;
outer_diameter=52;
height=10;

inner_number_of_fragments=100; //[3,4,5,6,7,8,9,10,12,15,100:round]
//set always to round if you want to write text on the spacers edge!
outer_number_of_fragments=100; //[3,4,5,6,7,8,9,10,12,15,100:round]

//to show (simply ignore this setting)
part = "spacer"; // [spacer,text_only]

/* [Edge Text] */

text_font = "orbitron.dxf"; //[orbitron.dxf,Letters.dxf,knewave.dxf,BlackRose.dxf,braille.dxf]
text_space_factor = 1.1;

edge_text="32x10x10";
edge_text_repeat=3; //[1:6]
edge_height=6; //[3:9]
edge_text_thickness=1.0;

/* [Top Text] */

top_text1="PRUSA i3";
top_text2="Hephestos";
top_text1_repeat=1; //[1:6]
top_text2_repeat=1; //[1:6]
top_text_height=6; //[3:9]
top_text_thickness=0.6;

/* [Bottom Text] */

bottom_text1="3D";
bottom_text2="";
bottom_text1_repeat=6; //[1:6]
bottom_text2_repeat=1; //[1:6]
bottom_text_height=6; //[3:9]
bottom_text_thickness=0.6;



/* [Hidden] */


backlash=0.0;

if(part == "spacer")
{
	build_spacer();
}
else
{
	build_text();
}

module build_spacer()
{	
	difference()
	{
		linear_extrude(height,convexity=10)
		difference()
		{
			circle((outer_diameter)/2,$fn=outer_number_of_fragments);
		
			circle(inner_diameter/2,$fn=inner_number_of_fragments);
		}
	
		build_text();
	}	
}

module build_text()
{
	translate([0,0,height-top_text_thickness/2])
	assign(text_height=top_text_height/10*(outer_diameter-(inner_diameter + backlash))/2)
	{
		write_text(((inner_diameter + backlash)+outer_diameter)/4, top_text1, top_text1_repeat, text_height, top_text_thickness+.1);
	
		if(top_text1_repeat<=1 || top_text2_repeat<=1)
		write_text(-((inner_diameter + backlash)+outer_diameter)/4, top_text2, top_text2_repeat, text_height, top_text_thickness+.1);		
	}

	translate([0,0,bottom_text_thickness/2-.1])
	rotate([180,0,0])
	assign(text_height=bottom_text_height/10*(outer_diameter-(inner_diameter + backlash))/2)
	{
		write_text(((inner_diameter + backlash)+outer_diameter)/4, bottom_text1, bottom_text1_repeat, text_height, bottom_text_thickness+.1);

		if(bottom_text1_repeat<=1 || bottom_text2_repeat<=1)
		write_text(-((inner_diameter + backlash)+outer_diameter)/4, bottom_text2, bottom_text2_repeat, text_height, bottom_text_thickness+.1);		
	}

	for(a=[0:360/edge_text_repeat:359])
	rotate([0,0,a])
	writecylinder(edge_text,[0,0,0],(outer_diameter)/2,height,h=height*bottom_text_height/10,t=edge_text_thickness,bold=.5);
}

module write_text(r, text, repeat, text_height, text_thickness)
for(a=[0:360/repeat:359])
rotate([0,0,a])
writecircle(text,[0,0,0],r,h=text_height,t=text_thickness,bold=.5, font=text_font, space=text_space_factor);



