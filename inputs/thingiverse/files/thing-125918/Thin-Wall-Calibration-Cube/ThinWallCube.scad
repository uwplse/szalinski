// set to your nozzle size in mm
wall_thickness = .40;

// outside width of square in mm
width = 20;

// mm
height = 10;

// mm
corner_radius = 1;

/* [Hidden] */

$fn = 50;

linear_extrude(height=height)
difference() {
	minkowski()
	{
	 square([width-(corner_radius*2), width-(corner_radius*2)], center=true);
	 circle(r=corner_radius);
	}

	minkowski()
	{
	 square([width-(corner_radius*2)-wall_thickness,width-(corner_radius*2)-wall_thickness], center=true);
	 circle(r=corner_radius);
	}
}	
