// preview[view:south, tilt:bottom diagonal]

// Number of sides for the curves
$fn=100;

// Diameter of the tube this will slip over.
outer_diameter = 6.3;

// Diameter of the filament hole in the tube.
inner_diameter = 2.5;

// Thickness of the walls around the tube and the wall between the funnel and the sleeve.
wall_thickness = 0.8 ;

// Angle of slope for the funnel, where 90 is horizontal. Determines how tall the funnel will be. Don't exceed your printer's maximum overhang.
funnel_angle = 30;

// Height of the sleeve that slips over the end of the tubr
sleeve_height = 8;

outer_radius = outer_diameter / 2;
inner_radius = inner_diameter / 2;

funnel_height = (outer_diameter - inner_diameter) / (2 * tan(funnel_angle));

module funnel(outer_diameter = outer_diameter) {
  outer_radius = outer_diameter/2;

  // Best way in the world to make anything with rotational
  // symmetry: sculpt it as a polygon, then rotate_extrude.
	rotate_extrude()
	polygon([
	  [outer_radius, 0],
	  [outer_radius + wall_thickness, 0],
	  [outer_radius + wall_thickness, funnel_height + wall_thickness + sleeve_height],
	  [outer_radius, funnel_height + wall_thickness + sleeve_height],
	  [outer_radius, funnel_height + wall_thickness],
	  [inner_radius, funnel_height + wall_thickness],
	  [inner_radius, funnel_height]
	]);
}

funnel();