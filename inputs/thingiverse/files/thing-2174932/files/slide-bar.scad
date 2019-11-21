// This is a custom powder drop bar slider for the Lee Micro Disk
// -- which is no longer in production. It features customizable settings.
//
// Warning -- some sanding and fitting may be required.
//
// This is licensed under the creative commons+attribution license
// My design was inspired by SBfarmer and his design at
// http://www.thingiverse.com/thing:2174123
//
// To fulfil the attribution requirement, please link to:
// http://www.thingiverse.com/thing:2174932

/* [Main] */

// Add slope to powder drop hole?
shape=1; // [0:Without sloped hole,1:With sloped hole]

// Bar thickness in mm
bar_height=6.3;

// Z axis fudge factor in mm
zff=0.125;

// Bar width in mm
bar_width=10.47;

// Bar lenght in mm
bar_length=85;

// Bushing height in mm
bushing_height=9.6;

// Bushing outer diameter in mm
bushing_diameter=11.45;

// Diameter of powder drop hole top in mm
top_diameter=9.14;

// Diameter of powder drop hole bottom in mm
bottom_diameter=8.64;

// Number of sides on inner hole surface (higher number = smoother)
sides=100;

module body()
{
	difference()
	{
		union()
		{
			translate([-8,00,00])
			intersection()
			{
				translate([bar_length/2-2,0,(bar_height+zff)/2]) cube([bar_length,bar_width,bar_height+zff],center=true);
				translate([bar_length/2-2,0,(bar_height+zff)/2]) cylinder(h=bar_height+zff,r=bar_length/2,center=true,$fn=100);
			}
			intersection()
			{
				translate([00,00,1.5]) cylinder(h=bushing_height,r=bushing_diameter/2,center=true,$fn=100);
				translate([00,00,1.5]) cube([bushing_diameter,bar_width,bushing_height],center=true);
			}
		}
		// Drill powder drop hole
		translate([0,0,1.5]) cylinder(h=bushing_height+1,r1=bottom_diameter/2,r2=top_diameter/2,center=true,$fn=sides);
	}
}

difference()
{
	body();

	// Remove some material from handle
	minkowski()
	{
		translate([41,00,00]) cube([.72*bar_length,.55*bar_width,.75*(bar_height+zff)],center=true);
		cylinder(r=1);
	}
	if(shape==1)
	{
		// Add slope for powder drop hole
		minkowski()
		{
			translate([2,00,6]) rotate([90,00,00])	cylinder(h=top_diameter-2.0,r=4,center=true,$fn=3);
			cylinder(r=1);
		}
	}
}