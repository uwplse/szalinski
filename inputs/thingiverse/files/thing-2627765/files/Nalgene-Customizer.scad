$fn=400;
include <write/Write.scad>

text="rx";

font_face="write/orbitron.dxf";
//font_face="write/BlackRose.dxf";
//font_face="write/Letters.dxf";
//font_face="write/braille.dxf";
//font_face="write/knewave.dxf";
//font_face="write/stencil_TNH.dxf";

ring_radius=65.5/2;
thickness=5;
height=5;
font_size=30;
font_spacing=0.95;
y_coord=-4.53;

// Halterung
//
difference()
{
	linear_extrude(height=height)
	circle(ring_radius+thickness);

	linear_extrude(height=height)
	circle(ring_radius);
}

// Schriftzug
//
writecylinder(text,[0,0,y_coord],ring_radius+thickness+0,rotate=0,center=true,h=font_size,space=font_spacing,font=font_face,t=3); 
