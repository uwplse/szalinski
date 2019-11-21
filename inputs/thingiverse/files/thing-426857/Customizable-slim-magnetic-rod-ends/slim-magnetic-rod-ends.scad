// Effective rod length (bearings center-to-center) =
// rodLength + 2(height - magnetLength) + sphereDiameter

// The length of the tube to house your magnet and rod
height=20;

// The radius of your rods and magnets
radius=3.1;

// The width of the walls, set to a multiplier of your extrusion width
wallWidth=2.08;

// The diameter of your bearing of choice
sphereDiameter=7;

hidden_quality=100*1;

difference()
{
  // Main body
  cylinder(r=radius+wallWidth/2, h=height+radius, $fn=hidden_quality);
  union()
  {
    // Magnet and rod cutout
    translate([0,0,-1])cylinder(r=radius, h=height+1, $fn=hidden_quality);

    // Ball bearing cutout
    translate([0,0,height+(sphereDiameter/2)+0.5])sphere(r=sphereDiameter/2, $fn=hidden_quality);
    translate([0,0,height+radius-1])cylinder(r=1+radius+wallWidth/2, h=sphereDiameter, $fn=hidden_quality);

    // Chamfered edge
    difference()
    {
      translate([0,0,-1])cylinder(r=radius+(wallWidth/2)+1, h=2, $fn=hidden_quality);
      cylinder(r1=radius+(wallWidth/4)+0.1, r2=radius+wallWidth/2, h=1, $fn=hidden_quality);
    }
  }
}