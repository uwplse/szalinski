/*

  Board game tile edges
    by Mark van Renswoude

  https://www.thingiverse.com/thing:2954641
*/



/*

  Configuration for Thingiverse Customizer

*/

// Select part to output
part = "straight"; // [straight:Straight connector,cornermale:Corner male,cornerfemale:Corner female]

// The length of a tile for corner edges (millimeters)
TileLengthCorner = 255;

// The length of a tile for straight edges (millimeters)
TileLengthStraight = 246;

// The width of the edge (millimeters)
EdgeWidth = 15;

// The height of the edge (millimeters)
EdgeHeight = 5;

// The angle of the connectors (degrees)
ConnectorAngle = 75; // [45:5:80]

// How far the connector overlaps into the next piece (millimeters)
ConnectorDepth = 7;

// The width of the tip of the connector (millimeters)
ConnectorWidth = 8.5;

// Extra margin in the female connector (millimeters)
ConnectorMargin = 0.2;

// Offset for the corner connectors from the inside (percentage)
ConnectorCornerOffset = 25; // [0:5:100]


/*

  Part setup

*/
$fa = 1;
$fs = 0.3;

displayPart();



module displayPart()
{
  if (part == "straight")
  {
    partStraight();
  }
  else if (part == "cornermale")
  {
    partCornerMale();
  }
  else if (part == "cornerfemale")
  {
    partCornerFemale();
  }
}



/*

  Parts

*/
module partStraight()
{
  difference()
  {
    edge(TileLengthStraight);
    translate([0, EdgeWidth / 2, 0])
      connectorFemale();
  }

  translate([TileLengthStraight, EdgeWidth / 2, 0])
    connectorMale();
}


module partCornerMale()
{
  difference()
  {
    edge(TileLengthCorner + EdgeWidth);

    translate([0, EdgeWidth / 2, 0])
      connectorFemale();

    translate([TileLengthCorner, 0, 0])
      linear_extrude(EdgeHeight)
        polygon([
          [0, EdgeWidth],
          [EdgeWidth, EdgeWidth],
          [EdgeWidth, 0]
        ]);
  }

  connectorOffset = ConnectorCornerOffset / 100;

  translate([TileLengthCorner + (EdgeWidth * connectorOffset), EdgeWidth * (1 - connectorOffset), 0])
    rotate([0, 0, 45])
      connectorMale();
}


module partCornerFemale()
{
  difference()
  {
    edge(TileLengthCorner + EdgeWidth);

      linear_extrude(EdgeHeight)
        polygon([
          [0, 0],
          [0, EdgeWidth],
          [EdgeWidth, EdgeWidth]
        ]);

    connectorOffset = ConnectorCornerOffset / 100;

    translate([EdgeWidth * (1 - connectorOffset), EdgeWidth * (1 - connectorOffset), 0])
      rotate([0, 0, -45])
        connectorFemale();
  }

  connectorOffset = ConnectorCornerOffset / 100;

  translate([TileLengthCorner + EdgeWidth, EdgeWidth / 2, 0])
    connectorMale();
}


/*

  Basic elements

*/
module connector(depth, width)
{
  diff = depth / tan(ConnectorAngle);

  // Assume we're translated to the center of the edge
  //
  //        /|
  // 0,0 _ | |
  //       | |
  //        \|
  linear_extrude(EdgeHeight)
    polygon([
      [0, (width / 2) - diff],
      [depth, width / 2],
      [depth, -(width / 2)],
      [0, -((width / 2) - diff)]
    ]);
}


module connectorMale()
{
  connector(ConnectorDepth, ConnectorWidth);
}


module connectorFemale()
{
  connector(ConnectorDepth + ConnectorMargin, ConnectorWidth + ConnectorMargin);
}


module edge(length)
{
  rotate([90, 0, 90])
    linear_extrude(length)
      union()
      {
        // Rounded outer edge
        intersection()
        {
          square(EdgeHeight);
          translate([EdgeHeight, 0, 0])
            circle(EdgeHeight);
        }

        // Remaining width (assumes width > height)
        translate([EdgeHeight, 0, 0])
          square([EdgeWidth - EdgeHeight, EdgeHeight]);
      }
}