// Configurator variables

// length of the bar in mm.
bar_length = 110;

// End of configurator variables

/* [Hidden] */

bar_height = 10;
bar_width = 8;
difference()
{
  union()
  {
    cube([bar_length, bar_width, bar_height]);
    translate([0, bar_width/2, bar_height]) rotate([0,90,0]) cylinder(d=bar_width, h=bar_length);
  }
  translate([8,0,0])
    cube([2,2,bar_height+bar_width]);
  translate([bar_length-10,0,0])
    cube([2,2,bar_height+bar_width]);
  translate([8,bar_width-2,0])
    cube([2,2,bar_height+bar_width]);
  translate([bar_length-10,bar_width-2,0])
    cube([2,2,bar_height+bar_width]);
}