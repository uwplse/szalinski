// Parametric Pulley

// Which part would you like to print?
printSelection = "Both";//[Pulley:Pulley only, Pulley Mount:Pulley Mount only, Both:Both]

// Choose the desired rope diameter in millimeters 
ropeDiameter = 5;//[5:30] 

// Choose a metric bolt size for the shaft
shaftBoltSize = 10;//[4.8:M4, 5.8:M5, 7:M6, 8:M7, 10:M8, 12:M10, 22:skate bearing]

// Choose a metric bolt size for mounting
mountBoltSize = 10;//[4.8:M4, 5.8:M5, 7:M6, 8:M7, 10:M8, 12:M10]

pulleyHeight = ropeDiameter+5;
// Choose the desired pulley radius in millimeters
pulleySize = 16;

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
	translate([0,2*pulleyHeight+pulleySize+15,pulleyHeight+25+pulleySize])rotate([-90,0,0])PulleyMount();
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
	translate([0,2*pulleyHeight+pulleySize+15,pulleyHeight+25+pulleySize])rotate([-90,0,0])PulleyMount();
}

// The module is the pulley wheel
module Pulley()
{
	
	$fn = 100;
	difference()
	{
		cylinder(r = pulleyHeight+pulleySize, h = pulleyHeight, center = true);
		rotate_extrude(convexity = 10) 
		translate([pulleyHeight+1+pulleySize, 0, 0]) 
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
			translate([0, (pulleyHeight+25+pulleySize)/2, 0])
            //I want the pulley to extend past the mount
			cube(size = [1*pulleyHeight+pulleySize, pulleyHeight+25+pulleySize, pulleyHeight+16], 
					center = true);
			cylinder(r= pulleySize+12.5, h = pulleyHeight+16, center = true);
            //Added catch to help keep rope on pulley
        translate([(pulleySize*2)-ropeDiameter, 0, 0])
		cylinder(r = ropeDiameter, h = pulleyHeight+16, center = true);
        translate([(pulleySize*-2)+ropeDiameter, 0, 0])
		cylinder(r = ropeDiameter, h = pulleyHeight+16, center = true);
		}
        //Modified to hopefully work with variable pulley sizes
		cube(size  = [2*(pulleySize+12.5),2*pulleyHeight+pulleySize+pulleySize+27.5, pulleyHeight+2], 
				center = true);

		// This is the hole for the shaft
		cylinder(r = mountBoltSize/2, h = pulleyHeight+26, center = true);
        
        //Removing a bit of the catch to make the bridge less severe
        translate([0,ropeDiameter,0])
        rotate([0,90,0])
        cylinder(r = ropeDiameter, h = 4*(pulleySize+12.5), center = true);
		// These are the holes for mounting
        //Since I'm not mounting with screws I'm commenting out this section
		//translate([pulleyHeight/2+5,0,0]) 
		//rotate([90,0,0])
		//cylinder(r=mountBoltSize/2, h = 1000, center = true);
			
		//translate([-pulleyHeight/2-5,0,0]) 
		//rotate([90,0,0])
		//cylinder(r=mountBoltSize/2, h = 1000, center = true);

        
	}
}
