// Magnetic button/indicator
// disc with socket for common cylindrical magnets
// Author: Peter K. Johnson (PPK)

/* [Primary parameters] */
// changes curvature of button edge, 1=semi-circle, >1=tapered, <1=flatter
button_edge_scale = 1.2;
button_height = 5;
button_diameter = 30;
magnet_height = 3.2;
magnet_diameter = 12.75;

/* [Extra parameters] */
// scale of flat portion of button face used for the cap
cap_scale = 1;
cap_width_padding = 0.5;
magnet_height_padding = 0.3;
magnet_width_padding = 0.5;

/* [Hidden] */
// computed variables, shouldn't need modification
button_radius = button_diameter/2;
magnet_radius = magnet_diameter/2;
magnet_socket_height = magnet_height+magnet_height_padding;
magnet_socket_radius = magnet_radius+magnet_width_padding/2;
curve_offset = (button_height/2*button_edge_scale);
cap_height = (button_height-magnet_socket_height)/2;
cap_radius = (button_radius-curve_offset)*cap_scale;

$fn = 64;

// the button
difference() {
  // button body
  union() {
    rotate_extrude()
      translate([button_radius-curve_offset, button_height/2])
        scale([button_edge_scale,1])
          circle(button_height/2);
    cylinder(h = button_height, r = button_radius-curve_offset);
  }
    
  // magnet socket
  translate([0, 0, (button_height - magnet_socket_height)/2])
    cylinder(h = magnet_socket_height+0.1, r = magnet_socket_radius);
    
  // cap socket
  translate([0, 0, button_height-cap_height])
    cylinder(h = cap_height+0.1, r = cap_radius);
}

// the cap
translate([0, button_radius*2+5, 0])
  cylinder(h = cap_height, r = cap_radius-cap_width_padding/2);
