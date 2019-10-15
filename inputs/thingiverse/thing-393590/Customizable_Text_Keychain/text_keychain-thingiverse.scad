use <write/Write.scad>

/* [Hidden] */

$fn=30;

/* [Text] */

text="Test";
font_size=2;
font_height=.5;

/* [Size] */

width=5;
length=8;
thickness=1;

/* [Ring] */

ring_radius=1;
hole_radius=.6;

difference()
{
	union() 
	{
		cylinder(h=thickness,r=ring_radius);
		cube([width,length,thickness]);
	}
	cylinder(h=thickness + 1, r=hole_radius, center = true);
}

translate([width/2,length/2,thickness+font_height/2])
{
	rotate(a=90,v=[0,0,1])
	{
		write(text,t=font_height,h=font_size,center=true);
	}
}