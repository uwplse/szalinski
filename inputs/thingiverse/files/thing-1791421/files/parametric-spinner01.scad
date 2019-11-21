//parametric tri-spinner fidget toy
//2016-08-30 rev. 0001
// Set the values for the diameter and thickness of your bearings in millimeters
// Set the wall thickness if you want, default is 2mm

// (number of arms)
spinner_style = 3; // [3:Standard, 2:Straight]

// (608=22mm)
bearing_diameter=22;

// (608=7mm)
bearing_thickness=7;

// (part around the bearing)
wall_thickness=2;

// (beyond the wall thickness)
extra_arm_length = 0; // [0:0.5:5]

// (default = .5)
part_quality = 0.5; // [0:0.25:1]

/* [Hidden] */
$fa=1;
$fs=part_quality;

degree=360/spinner_style;
number=spinner_style;

outer=bearing_diameter/2 + wall_thickness;
inner=bearing_diameter/2;
arm=inner*2+wall_thickness+extra_arm_length;


difference()
//make the arms
{
	for(n = [1:number])
	{
		rotate([0,0,n*degree])
		{
			hull()
			{
				translate([0,0,0])
					cylinder(r=outer, h=bearing_thickness, center=false);
				translate([-arm,0,0])
					cylinder(r=outer,h=bearing_thickness, center=false);
			}
		}
	}
//make the holes	
translate([0,0,-1])
	#cylinder(r=inner,h=bearing_thickness+2);
for(n = [1:number])
	{
		rotate([0,0,n*degree])
		{
			translate([-arm,0,-1])
				#cylinder(r=inner,h=bearing_thickness+2);
		}
	}
}
