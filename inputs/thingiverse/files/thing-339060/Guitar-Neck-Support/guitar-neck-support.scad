/* [Global] */

// The height of the base
base_height=5;

// The width of the support
support_width=80;

// The height of the support
support_height=40;

/* [Hidden] */
$fn=128;

translate([-5, -5, 0])
cube([support_width+10, 50, base_height]);

translate([0, 0, base_height])
difference() {
  cube([support_width, 40, support_height]);

  translate([0, 0, support_height-18])
  rotate(a=[90,0,0])
  linear_extrude(h=support_width/2, center=true, convexity=10, twist=0)
  polygon(points=[[support_width/2,0], [support_width,20], [0,20]], paths=[[0,1,2]]);
}
