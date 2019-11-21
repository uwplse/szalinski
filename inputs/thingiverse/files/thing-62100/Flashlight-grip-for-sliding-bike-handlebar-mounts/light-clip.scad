/* [Cylinder] */
// Outer radius of the cylinder
outer_r = 14.9;
// Inner radius of the cylinder (diameter of flashlight + padding)
inner_r = 12.5;
// length of cylinder
length = 40;
//  width of screw gap
gap = 6;
/* [Slide] */
//  overall width of slide
slide_width = 22.8;
//  width of rail onto which slide should fit - you should probably add some wiggle room.
rail_width = 18;
//  how wide is the overhang under the rail?
overhang = 2.6;
//  how thick is the rail?
rail_thickness = 2.5;
//  how thick should the overhanging part of the slide be?
overhang_thickness = 2.4;
rail_wall = (slide_width - rail_width)/2;
//  Overall thickness of the slide (inc. rail and overhang)
slide_thickness = 7.3;
top_thickness = slide_thickness - rail_thickness - overhang_thickness;
/* [Flange and bolts] */
flange_width = 2.4;
flange_height = 12;
bolt_diameter = 3.8;
nut_diameter = 7.8;
/* [Hole in slide] */
// How far from the end of the slide is the spring-clip hole?
hole_height = 33.5;
hole_length = 4;
hole_width = 4;
hole_depth = 1;
/* [Hidden] */
$fn=100;

module grip()
{
  difference()
  {
    cylinder(r=outer_r, h=length);
    translate([0, 0, -1])
      cylinder(r=inner_r, h=length+2);
    translate([0, -gap/2, -1])
      cube([outer_r, gap, length+2]);
  }
}

module bolt_hole()
{
  rotate([-90, 0, 0])
    cylinder(r=bolt_diameter/2, h=flange_width + 2);
}

module flange()
{
  difference()
  {
    cube([flange_height, flange_width, length]);
    translate([flange_height/2, -1, length/4]) bolt_hole();
    translate([flange_height/2, -1, length/2]) bolt_hole();
    translate([flange_height/2, -1, 3*length/4]) bolt_hole();
  }
}

module nut_hole()
{
  rotate([-90, 0, 0])
    cylinder(r=nut_diameter/2, h=flange_width, $fn=6);
}

module flanges()
{
  translate([0, gap/2, 0])
    flange();
  translate([0, -gap/2 - flange_width, 0])
    difference()
    {
      flange();
      translate([flange_height/2, -1, length/4]) nut_hole();
      translate([flange_height/2, -1, length/2]) nut_hole();
      translate([flange_height/2, -1, 3*length/4]) nut_hole();
    }
}

module hole()
{
  translate([-top_thickness - 1, -hole_width/2, hole_height])
    cube([hole_depth + 1, hole_width, hole_length]);
}

module slide()
{
  difference()
  {
    cube([slide_thickness, slide_width, length]);
    translate([overhang_thickness, rail_wall, -1])
      cube([rail_thickness, rail_width, length + 2]);
    translate([-1, overhang + rail_wall, -1])
      cube([overhang_thickness + 2, slide_width-2*(rail_wall + overhang), length + 2]);
  }

}

difference()
{
  union()
  {
    translate([inner_r, 0, 0]) grip();
    translate([2 * inner_r, 0, 0]) flanges();
    translate([-slide_thickness, -slide_width/2, 0]) slide();
  }
  hole();
}
