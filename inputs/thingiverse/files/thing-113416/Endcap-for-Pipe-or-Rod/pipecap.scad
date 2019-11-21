// Pipe or Rod Endcap
// (c) 2013, Christopher "ScribbleJ" Jansen

// Pipe or Rod Outer Diameter
pipe_outer_d = 25;
// Pipe Inner Diameter -- Set to 0 for Rod
pipe_inner_d = 20;
// Minimum Thickness of Part
cap_thickness = 2.5;
// Roundness of Endcap -- Set 0 for Flat, 1 for Sphere, in-between for rounded.
cap_roundness = 0.25;
// Length of Endcap along Pipe or Rod
cap_length = 25;

// Number of Setscrew Holes -- 0 for None
setscrew_num = 1;
// Diameter of Setscrew Holes
setscrew_d = 5;


difference()
{
  union()
  {
    cylinder(r=pipe_outer_d/2 + cap_thickness, h=cap_length + cap_thickness);
    if(cap_roundness > 0)
    {
      translate([0,0,cap_length + cap_thickness]) scale([1,1,cap_roundness]) sphere(r=pipe_outer_d/2 + cap_thickness);
    }
  }

  translate([0,0,-1])
  {
    cylinder(r=pipe_inner_d/2 - cap_thickness, h=cap_length+1);
  
    difference()
    {
      cylinder(r=pipe_outer_d/2, h=cap_length+1);
      cylinder(r=pipe_inner_d/2, h=cap_length+1);
    }
  }

  if(setscrew_num > 0)
  {
    for(x=[0:360/setscrew_num:setscrew_num*(360/setscrew_num)])
    {
      translate([0,0,cap_length/2]) rotate([90,0,x]) cylinder(r=setscrew_d/2, h=pipe_outer_d);
    }
  }
}
