$fn = 64;

diameter = 20.1;
height = 10.8;
hole_diameter = 6.35;
wall = 0.96;

reinforcement_height = 1.5 * wall;

// fudge to get slip parts to *stay* together
slop = 0.15;

top_outer_diameter = hole_diameter + 4 * wall;
top_inner_diameter = top_outer_diameter - 2 * wall;
top_height = height - 2.5 * wall;

bottom_outer_diameter = hole_diameter + 2 * wall;
bottom_inner_diameter = hole_diameter;
bottom_height = height - 3.5 * wall;

module holes() {
  count = 7;
  cutout_diameter = 4;
  center_offset = diameter / 3;
  for (i = [1:1:count])
    translate([sin(360 * i / count) * center_offset, cos(360 * i / count) * center_offset, 0])
      rotate([0, 0, atan2(cos(360 * i / count) * center_offset, sin(360 * i / count) * center_offset)])
        cylinder(d=cutout_diameter, h=3, center=true, $fn = 3);
}


module top() {
  difference() {
    group() {
      color("Red")
        cylinder(d=diameter, h=1.5 * wall, center=true);
      color("Magenta")
        cylinder(d=top_outer_diameter + slop, h=top_height);
      color("Pink")
        cylinder(d1=diameter, d2=top_outer_diameter, h=reinforcement_height);
    }
    group() {
      color("Blue")
        holes();
      color("Orange")
        translate([0, 0, -1 * wall])
          cylinder(d=bottom_inner_diameter + 0.5 * wall, h = 3.1);
      color("Turquoise")
        translate([0, 0, 2*wall])
          cylinder(d1=top_outer_diameter - 2 * wall + slop, d2=top_outer_diameter - 2 * wall, h=top_height + 2 * wall);
    }
  }
}

// slips inside of top
module bottom() {
  difference() {
    group() {
      color("Green")
        cylinder(d=diameter, h=1.5 * wall, center=true);
      color("Turquoise")
        cylinder(d1=bottom_outer_diameter, d2=bottom_outer_diameter + slop, h=bottom_height);
      color("LightCyan")
        cylinder(d1=diameter, d2=bottom_outer_diameter + 2 * wall, h=reinforcement_height);
    }
    group() {
      color("Orange")
        translate([0, 0, -1 * wall])
          cylinder(d=bottom_inner_diameter + 0.5 * wall, h=1.75 * wall);
      color("MediumBlue")
        translate([0, 0, 0.5 * wall]) 
          cylinder(d=bottom_inner_diameter, h=bottom_height + 2 * wall);      
    }
  }
}

top();
translate([diameter, diameter])
  scale([1, -1, 1])   // this line can go away but need to test print first to be 100% sure
    bottom();