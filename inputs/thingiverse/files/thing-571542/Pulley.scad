// Parametric Pulley

// Which part would you like to print?
printSelection = "Both";//[Pulley:Pulley only, Pulley Mount:Pulley Mount only, Both:Both]

// Choose the desired rope diameter in millimeters 
ropeDiameter = 10;//[5:30] 

// Choose a metric bolt size for the shaft
shaftBoltSize = 10;//[4.8:M4, 5.8:M5, 7:M6, 8:M7, 10:M8, 12:M10]

// Choose a metric bolt size for mounting
mountBoltSize = 10;//[4.8:M4, 5.8:M5, 7:M6, 8:M7, 10:M8, 12:M10]

pulleyHeight = ropeDiameter+10;

print_part();

// This module chooses which part to display
module print_part() 
{
	if (printSelection == "Pulley") 
	{
		translate([0,0,pulleyHeight/2]) Pulley();
	} 
	else if (printSelection == "Pulley Mount") 
	{
		translate([0,2*pulleyHeight+5,pulleyHeight+25])rotate([-90,0,0])PulleyMount();
	} 
	else if (printSelection == "Both") 
	{
		both();
	} 
	else 
	{
		both();
	}
}

// This module populates both parts
module both() 
{
	translate([0,0,pulleyHeight/2]) Pulley();
	translate([0,2*pulleyHeight+5,pulleyHeight+25])rotate([-90,0,0])PulleyMount();
}

// The module is the pulley wheel
module Pulley()
{
	
	$fn = 100;
	difference()
	{
		cylinder(r = pulleyHeight, h = pulleyHeight, center = true);
		rotate_extrude(convexity = 10) 
		translate([pulleyHeight+1, 0, 0]) 
		circle(r = ropeDiameter/2);

		// This is the hole for the shaft
		cylinder(r = shaftBoltSize/2, h = pulleyHeight+1, center = true);
	}
}

// This module is the pulley mount
module PulleyMount()
{
	$fn = 100;
	difference()
	{
		union()
		{
			translate([0, (pulleyHeight+25)/2, 0])
			cube(size = [2*pulleyHeight+25, pulleyHeight+25, pulleyHeight+20], 
					center = true);
			cylinder(r= pulleyHeight+12.5, h = pulleyHeight+20, center = true);
		}
		cube(size  = [2*pulleyHeight+26,2*pulleyHeight+27.5, pulleyHeight+2.5], 
				center = true);

		// This is the hole for the shaft
		cylinder(r = shaftBoltSize/2, h = pulleyHeight+26, center = true);
		
		// These are the holes for mounting
		translate([pulleyHeight/2+5,0,0]) 
		rotate([90,0,0])
		cylinder(r=mountBoltSize/2, h = 1000, center = true);
			
		translate([-pulleyHeight/2-5,0,0]) 
		rotate([90,0,0])
		cylinder(r=mountBoltSize/2, h = 1000, center = true);
		
	}
}
