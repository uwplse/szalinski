part = "both";  // [first:Block only,second:Wedge only,both:Block and wedge]

width = 10; // [1:1:200]
height = 15; // [10:1:100]
length = 140; // [40:1:300]
paperThickness = 0.45; // [0.05:0.05:2]

/* [HIDDEN] */
$fs=0.5;

module wedge(width)
{
	hull()
	{
		translate([0,0,-15]) rotate([90,0,0]) cylinder(h=width,d=5,center=true);
		rotate([90,0,0]) cylinder(h=width,d=2,center=true);
	}
}

module block(width,height,length,paperThickness)
{
	difference()
	{
		difference()
		{
			/* MAIN BLOCK */
			hull()
			{
				rotate([90,0,0]) cylinder(h=width,d=1,center=true);
				translate([length-height/2,0,height/2])
					rotate([90,0,0])
					cylinder(h=width,d=height,center=true);
			}
			
			/* PAPER INSERT */
			translate([(length-height/2)*0.7,0,-2])
				rotate([0,-30,0])
				cube([paperThickness*2,width*1.1,15],center=true);
		}
		
		/* WEDGE INSERT */
		translate([(length-height/2)*0.9,0,6])
			rotate([0,30,0])
			wedge(width*1.1);
	}
}

module print_part(part)
{
	if (part == "first")
	{
		translate([0,0,width/2]) rotate([90,0,0]) block(width,height,length,paperThickness);
	}
	else if (part == "second")
	{
		translate([0,0,width/2]) rotate([90,0,-90]) wedge(width);
	}
	else if (part == "both")
	{
		translate([0,0,width/2]) rotate([90,0,0]) block(width,height,length,paperThickness);
		translate([15,15,width/2]) rotate([90,0,90]) wedge(width);
	}
	else
	{
		translate([0,0,width/2]) rotate([90,0,0]) block(width,height,length,paperThickness);
		translate([15,15,width/2]) rotate([90,0,90]) wedge(width);
	}
}

print_part(part);

