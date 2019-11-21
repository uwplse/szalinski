/* [Main] */

// preview:[view:south west, tilt:top diagonal]

// Diameter of the hole
bore_diameter = 64;

// Depth of the inner wall
bore_depth = 15;

// Size of the outer brim
brim_size = 5;

// Number of aperture slices
cap_slices = 6; //[2:1:24]

/* [Advanced] */

// Width of the inner wall
wall_width = 1.2; //0.4*3

// Thickness of the external brim and cap
cap_height = 1.2; //0.2*6

// Diameter of the pin
pin_diameter = 4.8; //0.4*12

// External and internal padding
padding = 1.2; //0.4*3


module _() {};

// default for measures in mm
$fa = 1;
$fs = 0.5;


// basic geometry
module cylinder2(h, r1, r2)
{
  difference()
  {
    cylinder(h=h, r=r2);
    translate([0, 0, -0.1]) cylinder(h=h+0.2, r=r1);
  }
}

module wedge(h, r1, r2, a)
{
  linear_extrude(h)
  {
    intersection()
    {
      difference()
      {
	circle(r2);
	circle(r1);
      }
      polygon([[0, 0], [0, r2*2], [r2*2*sin(a), r2*2*cos(a)]]);
    }
  }
}


// intermediate geometry
module holes(h, r1, r2, s)
{
  for(i = [2:s+1])
  {
    rotate([0, 0, 360/s*i])
      wedge(h, r1, r2, 180/s);
  }
}


// final geometry
module inner_pin_walls()
{
  inner_margin = 0.2;
  rotate_extrude()
  {
    polygon([[0, 0],
	     [pin_diameter/2, 0],
	     [pin_diameter/2, cap_height*3],
	     [pin_diameter/2+inner_margin, cap_height*3],
	     [pin_diameter/2+inner_margin, cap_height*3+inner_margin],
	     [pin_diameter/4, cap_height*4+inner_margin],
	     [0, cap_height*4+inner_margin]]);
  }
}

module cap()
{
  difference()
  {
    cylinder(h=cap_height, r=bore_diameter/2+padding);
    translate([0, 0, -0.1])
      holes(h=cap_height+0.2, r1=pin_diameter/2+cap_height*2+padding, r2=bore_diameter/2-wall_width, s=cap_slices);
  }
  inner_pin_walls();
}

module outer_pin_walls()
{
  inner_margin = 0.1;
  rotate_extrude()
  {
    polygon([[pin_diameter/2+inner_margin, cap_height/2],
	     [pin_diameter/2+cap_height, 0],
	     [pin_diameter/2+cap_height*2, 0],
	     [pin_diameter/2+cap_height*2, cap_height],
	     [pin_diameter/2+cap_height, cap_height*2],
	     [pin_diameter/2+inner_margin, cap_height*2]]);
  }
}

module adapter()
{
  difference()
  {
    cylinder(h=cap_height, r=bore_diameter/2+brim_size);
    translate([0, 0, -0.1])
    {
      holes(h=cap_height+0.2, r1=pin_diameter/2+cap_height*2+padding, r2=bore_diameter/2-wall_width, s=cap_slices);
      cylinder(h=cap_height+0.2, d=pin_diameter+cap_height*2);
    }
  }
  outer_pin_walls();
  cylinder2(h=bore_depth+cap_height, r1=bore_diameter/2-wall_width, r2=bore_diameter/2);
}


// render
adapter();
translate([bore_diameter+wall_width*2+brim_size+padding, 0, 0]) cap();
