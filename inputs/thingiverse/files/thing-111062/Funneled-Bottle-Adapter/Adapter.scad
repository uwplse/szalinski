/* [Important] */

// Inner diameter of lower hole
bottom_diameter = 40;

// Inner diameter of upper hole
top_diameter = 43;

// Inset of inner funnel (gap to lower tube)
inset = 5;

/* [Adjustments] */

// Height of lower connection tube
bottom_height = 9;

// Height of upper connection tube
top_height = 9;

// Height of outer conical section
outer_conus_height = 5;

// Height of inner conical section (funnel)
inner_conus_height = 8.4;

// Wall thickness
thickness = 1.6;

bottom_radius = bottom_diameter / 2;
top_radius = top_diameter / 2;
height = top_height+outer_conus_height+bottom_height;

rotate([180,0,0])union() {
  rotate_extrude($fn=200)polygon([[top_radius,0],[top_radius,top_height],[bottom_radius-inset,top_height+inner_conus_height],[bottom_radius-inset, height],[bottom_radius-inset+thickness,height],[bottom_radius-inset+thickness,top_height+inner_conus_height],[top_radius+thickness,top_height],[top_radius+thickness,0],[top_radius,0]]);

  rotate_extrude($fn=200)polygon([[top_radius,top_height],[bottom_radius,height-bottom_height],[bottom_radius,height],[bottom_radius+thickness,height],[bottom_radius+thickness, top_height+outer_conus_height],[top_radius+thickness,top_height],[top_radius,top_height]]);
};