$fs=0.2;
$fa=1;

// a pointer for the output gear of the
// tiny planetary gears kit. 
// https://www.thingiverse.com/thing:23030

// just using the planet.stl direclty which has the same size as the output gear.
// also eyeballed the sizes. 
// this was quicker than digging into the upstream scad code. 

stl="./planet.stl";

d_stl=8.35;
h_stl_bevel=0.6;
h_stl=3.8 + 2*h_stl_bevel;

slack     = 0.75;
d_pointer = d_stl+slack+2;
h_pointer = h_stl - 2*h_stl_bevel;

difference() { 
  hull() { 
    translate([9,0,0]) cylinder(d=2,h=h_pointer); // outer radius < 10
    cylinder(d=d_pointer, h=h_pointer);
  }
  translate([0,0,-0.6]) resize([d_stl + slack, d_stl+slack, 0,h_stl]) import(stl, convexity=10);
  translate([0,0,-h_stl_bevel]) cylinder(d=d_stl/2, h=h_stl);
}
