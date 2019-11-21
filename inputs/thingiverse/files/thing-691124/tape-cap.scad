// 'Tape Protection-Cap' Version 1.0 by wstein 
// is licensed under the Attribution - Non-Commercial - Share Alike license. 
// (c) February 2015 
// please refer the complete license here: http://creativecommons.org/licenses/by-nc-sa/3.0/legalcode


label1="Blue Tape";
label2="3D Printing";

wallthickness = 1.2;
inner_wallthickness = 2;

//of the tape
inner_diameter = 76.5;
outer_diameter = 120;
height=10;

/* [Extra] */

text_font = "orbitron.dxf"; //[orbitron.dxf,Letters.dxf,knewave.dxf,BlackRose.dxf,braille.dxf]
text_height = 12;
text_thickness = .6;
text_space_factor = 1.1;

dot_diameter = 2.4;
dot_number = 8;

part = "print"; // [print,text_only]

/* [Hidden] */

// preview[view:north, tilt:bottom]

$fn=80;
cap_inner_diameter = inner_diameter-2*inner_wallthickness-wallthickness;
use <write/Write.scad>

//build thing
if(part == "print")
cap();
else
text();


module cap()
difference()
{
	union()
	{
		cylinder(r=outer_diameter/2,h=wallthickness);
		cylinder(r1=inner_diameter/2,r2=inner_diameter/2-wallthickness/2,h=height);

		for(a=[0:360/dot_number:359])
		rotate([0,0,a])
		translate([inner_diameter/2-wallthickness/3,0,height*2/3])
		sphere(r=dot_diameter/2,$fn=$fn/5);
	}	

	color("black")
	text(offset=0.1);

	translate([0,0,-0.1])
	cylinder(r=cap_inner_diameter/2,h=height+0.2);
}

module text(offset=0)
translate([0,0,text_thickness/2-offset/2])
rotate([0,180,0])
{
	writecircle(label1,[0,0,0],(cap_inner_diameter + outer_diameter)/4, h=text_height,t=text_thickness+offset, font=text_font, center=true, space=text_space_factor);
	writecircle(label2,[0,0,0],(cap_inner_diameter + outer_diameter)/-4, h=text_height,t=text_thickness+offset, font=text_font, center=true, space=text_space_factor);
}

