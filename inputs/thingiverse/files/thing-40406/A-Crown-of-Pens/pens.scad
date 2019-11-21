// Number of pens
num=30; // [1:100]

// Diameter of each pen in 1/10 mm
pen_dia=95; // [50:150]
pen_diam = pen_dia/10;

// Pen rotation (radial axis)
a1 = 30; // [-45:45]

// Pen rotation (tangential axis)
a2 = -15; // [-45:45]

// Length of each pen (only for display)
pen_length = 155; // [50:200]

// Remember to change to "no" before exporting.
show_pens = "yes"; // [yes, no]

// Space between pens in mm.
spacing = 3; // [0:10]

// Height in mm.
height = 20; // [4:30]

// Outer bevel in mm. 
bevel = 4; // [0:20]

// Outer radius offset in mm.
outer = 4; // [0:20]

// Inner radius offset in mm.
inner = 9; // [0:20]

// Calculate size of the pen holder
radius=(spacing+pen_diam/cos(a1))*num/3.1416/2;
r_offset = height/2*tan(a2);
r_grip = radius + outer;
r_inner = radius - inner;

$fs=1*1;
$fa=2*1;
da = 360/num;

module pen(n, r, offset)
{
	rotate([0,0, n*da]) 
		translate([r,0,height/2])
			rotate([a1,a2,0])
				translate([0,0,offset])
					cylinder(h=pen_length, r=pen_diam/2);
}

union()
{
	difference()
	{
		color([0.9,0.8,0])
		difference() {
			union() {
				cylinder(r1=r_grip-r_offset-bevel, r2=r_grip-r_offset/2, h=height/4);
				translate([0,0,height/4]) cylinder(r1=r_grip-r_offset/2, r2=r_grip+r_offset/2, h=height/2);
				translate([0,0,3*height/4]) cylinder(r1=r_grip+r_offset/2, r2=r_grip+r_offset-bevel, h=height/4);
			}
			// Remove this to get a solid shape.
			translate([0,0,-0.1]) cylinder(r1=r_inner-r_offset, r2=r_inner+r_offset, h=height+0.2);
		}
		for(n=[1:num])
		{
			pen(n=n, r=radius, offset = -pen_length/2);
		}
	}
	if(show_pens == "yes")
	{
		for(n=[1:num])
		{
			color([sin(n*da/2)*sin(n*da/2),0,cos(n*da/2)*cos(n*da/2)])
				pen(n=n, r=radius, offset = -height/2);
		}
	}
}

