// Rodin coil donut generator for openpart.co.uk/999999 project
// *** Alpha software 20130201 by bobnet
// comment line can be a command in Customizer on MakerBot
// preview[view:south, tilt:top]
// swept axis
poloidal = 200;
// diameter
toroidial = 50; 
// The number of points on the coil
no_of_points = 13; // 3-99999
// Point Size
point_size = 10;

outside_edge = poloidal + toroidial;


// kludgy first attempt!

for ( i = [0:no_of_points] ) {
  rotate( i*360/no_of_points, [0, 0, 1])
   translate( [0, outside_edge, 0] )
   color("Red",0.5)
   sphere(r = point_size);
}

color("RoyalBlue",0.9)
 rotate_extrude(convexity = 99, $fn = 100)
 translate([poloidal, 0, 0])
 circle(r = toroidial, $fn = 75);

// the future...

// No of wires
// Winding gap (A)
// Seperate tracks [y/n]
// Point winding order  [calculate]
// Filar / BiFilar
// Wire Guage
// Metric / Imperial
// sectors [part chop for large builds]
// plating_info [for the printer, we will need to produce 2 halfs + fixings]
