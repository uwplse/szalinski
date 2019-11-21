//Original file:
// http://www.thingiverse.com/thing:6884
//By whosawthatsis
// http://www.thingiverse.com/whosawhatsis
//Hacked a bit to make it beefier by MiseryBot
// http://www.thingiverse.com/MiseryBot


$fn=60;
height = 7;
holesize = 3.3;
holespacing = 20;
holepadding = 3.3;
rodsize = 6.6;
nutsize = 6.6;
nutthick = 2;

//Uncomment to make 4-up build
for (x = [1, -1]) for (y = [1, -1]) translate([(holespacing / 2 + holepadding + holesize) * x, (holespacing / 2 + holepadding + holesize) * y, 0])
difference()
  {
  linear_extrude(height = height, convexity = 2)
    difference()
      {
      union()
        {
        square([holespacing + holesize + holepadding * 2, holespacing], center = true);
        square([holespacing, holespacing + holesize + holepadding * 2], center = true);
        for (x = [1, -1]) for (y = [1, -1]) translate([holespacing / 2 * x, holespacing / 2 * y, 0])
          circle(holepadding + holesize / 2);
		}
      //Remove corner mounting holes
      for (x = [1, -1]) for (y = [1, -1])
        translate([holespacing / 2 * x, holespacing / 2 * y, 0])
          circle(holesize / 2, $fn = 60);
      //Remove main hole for rods
      circle(rodsize / 2);
      //Remove square to make it a "reprap" teardrop shape (why?)
      //rotate(-135) square(rodsize / 2);
	  }
  //remove hex recesses for 4 corner nuts
  for (x = [1, -1]) for (y = [1, -1])
    translate([holespacing / 2 * x, holespacing / 2 * y, height])
      cylinder(r = nutsize / 2, h = nutthick * 2, center = true, $fn = 6);

  translate([0, rodsize / 2, height / 2]) rotate([-90, 0, 0])
    {
    //remove hex hole for clamping nut, rotate to give maximum wall thickness
    rotate(360/12,[0,0,1])
      cylinder(r = nutsize / 2, h = nutthick * 3, center = true, $fn = 6);
    //Remove clamping bolt hole
    cylinder(r = holesize / 2, h = holespacing, center = false, $fn = 60);
    }
}