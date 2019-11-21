// 'Lofty Container' by wstein 
// is licensed under the Attribution - Non-Commercial - Share Alike license. 
// (c) January 2015
// please refer the complete license here: http://creativecommons.org/licenses/by-nc-sa/3.0/legalcode
//
// Version 1.1: 
// - workaround for current customizer global parameter bug


/* [Dimensions] */

//top hole diameter
size=50;

//only to be compatible with thing http://www.thingiverse.com/thing:634383. Use 2mm up to size 60, 2.5mm from 61 - 100. 3mm for larger
wall_thickness=2.0;

/* [Appearance] */

count=6;
twist=180;

// default 75, use lower values for faster preview (no need to use more than 100!) 
quality=75;

/* [Hidden] */

// ratio top hole / ball diameter
ratio=.7;

d4=size;
d3=d4+wall_thickness;
d2=d3/sqrt(1-ratio*ratio);
d1=d3/sqrt(1-ratio*ratio)/20; // d2/20!

r1=d1/2;
r2=d2/2;
r3=d3/2;
r4=d4/2;

echo(d1,d2,d3,d4,d1+d2);

thread_height=(d4>20?d4/6:20/6);
height=d2*ratio;

gn=twist/360;

a_step=360/quality;
z_step=height/quality/gn;
ta_step=250/quality;
tz_step=thread_height/quality;

thread_thickness=min(wall_thickness,thread_height/2);
echo(thread_thickness);

translate([0,0,height/2])
intersection(convexity=10)
{
	cylinder(r=r3+wall_thickness,h=thread_height+r1+wall_thickness,$fn=quality);
	
	union()
	{
		cylinder(r=r3,h=thread_height+r1+wall_thickness,$fn=quality);
	
		translate([0,0,r1+wall_thickness/2])
		for(m=[0:180:359])
		rotate([0,0,m])
		for(n=[0:quality-1])
		thread_part(n,a_step,z_step);
	}
}

intersection(convexity=10)
{
	translate([0,0,-height/2])
	cylinder(r=r2+r1,h=height+r1+wall_thickness,$fn=quality);

	union()
	{
		sphere(r=r2,$fn=quality);

		for(m=[0:360/count:359])
		rotate([0,0,m])
		for(n=[-gn*quality/2:gn*quality/2])
		thread_sphere_part(n,a_step,z_step);
	}
}

module thread_sphere_part(n)
hull()
{
	for(m=[n,n+1])
	assign(a=m*a_step)
	assign(z=m*z_step)
	rotate([0,0,a])
	translate([sqrt(r2*r2-z*z),0,z])
	rotate([90,0,0])
	sphere(d=d1,$fn=12);
}

module thread_part(n)
hull()
{
	for(m=[n,n+1])
	assign(a=m*ta_step)
	assign(z=m*tz_step)
	rotate([0,0,40+a])
	translate([r3,0,z])
	resize([wall_thickness,wall_thickness,thread_thickness])
	rotate([90,0,0])
	sphere(d=wall_thickness,$fn=12);
}

