// Button soccer player (gombfoci) - 1.0
// by György Balássy 2016 (http://gyorgybalassy.wordpress.com)
// http://www.thingiverse.com/thing:1359651

// The diameter of the bottom ring in millimeters.
bottomDiameter = 50;

// The diameter of the top ring in millimeters.
topDiameter = 45;

// The total height of the player in millimeters.
height = 9; 

// The wall thickness in millimeters.
thickness=3;

/* [Hidden] */

$fa=1;   // Default minimum facet angle.
$fs=1;   // Default minimum facet size.
delta=1; // Ensures that no faces remains after boolean operations.

labelDiameter = 25;
labelDepth = 1;
holeDiameter = 8;

mainColor = [0.117, 0.565, 1];  // DodgerBlue: RGB(30, 144, 255)
highlightColor = [0.384, 0.726, 1]; // Lighter DodgerBlue: RGB(98, 185, 255)

echo(str("Drawing a ", bottomDiameter, "×", topDiameter, "×", height, " player..."));

difference()
{
  // Draw the outer shell.
  color(mainColor)
    cylinder(d1 = bottomDiameter, 
             d2 = topDiameter, 
              h = height);
  
  // Subtract the main body from the bottom.
  color(highlightColor)
    translate([0, 0, -delta])
      cylinder(d1 = bottomDiameter - 2 * thickness, 
               d2 = topDiameter - 2 * thickness, 
                h = height - thickness + delta);
  
  // Subtract the round shape for the label from the top.
  color(highlightColor)
    translate([0, 0, height - labelDepth])
      cylinder(d = labelDiameter,
               h = labelDepth + delta);
  
  // Drill the hole.
  color(highlightColor)
    cylinder(d = holeDiameter,
             h = height);
}
