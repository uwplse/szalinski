// Pen-style Clip for Cylindrical Things
// (c) 2013, Christopher "ScribbleJ" Jansen

// Diameter of Pen
pen_d = 14.5;
// Thickness of Pen-Holding Part
pen_thick = 2;
// Length of Pen-holding Part
pen_l = 7.5;
// Clip Length
clip_l = 30;
// Clip Thickness
clip_thick = 3;
// Clip Width
clip_w     = 5;
// Clip Bump Thickness
clip_bump  = 5;

/* [Hidden] */

huge = 500;

union()
{
difference()
{
  cylinder(r=pen_d/2 + pen_thick, h=pen_l);
  translate([0,0,-0.5]) cylinder(r=pen_d/2, h=pen_l+1);
}
translate([-clip_w/2,0,0])
{
  translate([0,pen_d/2 + (clip_bump-clip_thick),0]) cube([clip_w,clip_thick,clip_l]);
  translate([0,pen_d/2,0]) cube([clip_w, clip_bump, pen_l]);
  //#translate([0,pen_d/2 + clip_thick,clip_l]) 
  translate([0,pen_d/2 + clip_bump,clip_l]) difference() 
  {
    rotate([0,90,0]) cylinder(r=clip_bump, h=clip_w);
    translate([-huge/2,0,-huge/2]) cube([huge,huge,huge]);
  }
}
}
