tool_diameter = 24.6;         // [0.0:60.0]
tool_height = 7;              // [0.0:30.0]
magnet_diameter = 20.6;       // [0.0:60.0]
magnet_height = 2;            // [0.0:30.0]
wire_diameter = 3;            // [0.0:10.0]
distance_between_holes = 10;	// [0.0:60.0]

magnet_radius = magnet_diameter / 2;
tool_radius = tool_diameter / 2;
wire_radius = wire_diameter / 2;

difference()
{

  cylinder(h = tool_height, r = tool_radius, $fn=72);

  // magnet
  translate([0,0,tool_height-magnet_height])
  {
    cylinder(h = magnet_height + 0.01, r = magnet_radius, $fn=72);
  }

  // hole for left wire
  translate([distance_between_holes / 2, 0, -0.5])
  {
    cylinder(h = tool_height + 0.01, r = wire_radius, $fn=36);
  }

  // hole for right wire
  translate([- distance_between_holes / 2, 0, -0.5])
  {
    cylinder(h = tool_height + 0.1, r = wire_radius, $fn=36);
  }

  // space connecting left and right hole
  translate([-distance_between_holes/2, 0, tool_height-magnet_height-wire_radius])
  {
    translate([0, -wire_radius, 0])
    {
      cube(size = [distance_between_holes, wire_radius*2 , wire_radius+0.01]);
    }

    rotate([0,90,0])
    {
      cylinder(h = distance_between_holes, r = wire_radius, $fn=36);
    }
  }
}
