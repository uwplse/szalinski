/* [General] */

// "whole" gives you the entire part, to be printed as a piece. It can be difficult to print. "split" gives you the top half of the part, for you to print twice and glue together.
layout = "split"; // [whole, split]

// Thickness of all the walls except the handle cylinder.
wall_thickness = 6;

// Specify the diameter of your filament. Holes are provided for alignment pins to aid in gluing, if printing in halves. Put in pieces of filament in the alignment holes to help you glue the halves. If you're going to do this, measure your filament.
pin_diameter = 1.75;

// Extra clearance for alignment pins.
hole_clearance = 0.1;

// Also need to know the layer height you are printing at.
layer_height = 0.25;

// And the extrusion width.
extrusion_width = 0.38;

/* [Handle] */
handle_length = 125;
handle_outer_diameter = 30;

// Determines size of hole in handle. If you don't want a hole in the handle, make this greater than or equal to handle_outer_diameter / 2.
handle_wall_thickness = 15;

// Set this to zero to require fewer supports if printing as one piece.
handle_flange_border = 3;

/* [Clamp] */
// Diameter of the thing you're going to be clamping onto.
clamp_inner_diameter = 30;

// Setting clamp_length to handle_outer_diameter + 2*handle_flange_border will reduce the number of supports required.
clamp_length = 50; 

// Resting distance between the clamps. Don't make this too big, or you won't be able to bring the clamps together properly. Too small, though, and you may not be able to get it around your object. Partly depends on the material you are using, and the wall thickness you have chosen.
clamp_gap = 3;

// #10 screws
screw_od = 5.1;

// and #10 washers
washer_od = 12.7;

// Allow enough space to fit your washers. Wing nut screws may require some more clearance.
clamp_flange_length = 13;

// Angle from vertical for the sidewalls.
side_angle = 40;

/* [Hidden] */
// To avoid coincident faces.
slop = 1;
$fn = 50;
clamp_outer_diameter = clamp_inner_diameter + 2 * wall_thickness;


module screw() {
    rotate([0, 90, 0])
    cylinder(r = screw_od/2 + hole_clearance, h = clamp_gap + 2*wall_thickness + 2*slop, center = true, $fn = 20);
}

module clamp() {
  screw_z = clamp_length/2 - washer_od/2;
  screw_y = clamp_inner_diameter/2 + wall_thickness + clamp_flange_length / 2;

  difference() {
    union() {
      // Clamp outside shell
      hull() {
        translate([-clamp_gap/2, 0, 0])
        cylinder(h = clamp_length, r = clamp_outer_diameter/2, center = true);

        translate([clamp_gap/2, 0, 0])
        cylinder(h = clamp_length, r = clamp_outer_diameter/2, center = true);
      }

      // Flange
      cube([clamp_gap + 2*wall_thickness, clamp_outer_diameter + 2*clamp_flange_length, clamp_length], center = true);
    }
    // Clamp hole
    hull() {
      translate([-clamp_gap/2, 0, 0])
      cylinder(h = clamp_length + slop, r = clamp_inner_diameter/2, center = true);

      translate([clamp_gap/2, 0, 0])
      cylinder(h = clamp_length + slop, r = clamp_inner_diameter/2, center = true);
    }

    // Gap
    cube([clamp_gap, clamp_outer_diameter + 2*clamp_flange_length + slop, clamp_length + slop], center = true);

    // Screw holes
    translate([0, screw_y, screw_z]) screw();
    translate([0, screw_y, -screw_z]) screw();    
    translate([0, -screw_y, screw_z]) screw();
    translate([0, -screw_y, -screw_z]) screw();
  }
}

handle_flange_length = handle_outer_diameter + 2*handle_flange_border;

module handle_flange() {
  cylinder(h = wall_thickness, r = handle_flange_length/2);

  translate([-handle_flange_length/2, -handle_flange_length/2, 0])
  cube([handle_flange_length, handle_flange_length/2, wall_thickness]);
}

module handle() {
  translate([0, handle_flange_length/2, 0])
  rotate([0, 90, 0])
  difference() {
    union() {
      // Handle outer shell
      cylinder(h = handle_length, r = handle_outer_diameter/2, center = true);

      // Flanges
      translate([0, 0, handle_length/2])
      handle_flange();

      translate([0, 0, -handle_length/2 - wall_thickness])
      handle_flange();
    }
    cylinder(h = handle_length + 2*wall_thickness + slop, r = handle_outer_diameter/2 - handle_wall_thickness, center = true);
    cube([handle_outer_diameter + 2*wall_thickness, ]);
  }
}

// We want the side walls to coincide with the outside corner of the clamp, but the inside corner of the handle.
// Math is hard.
W = wall_thickness / cos(side_angle);
x = W - wall_thickness;
clamp_y_intercept = (handle_length - clamp_gap) / 2 / tan(side_angle) + x / tan(side_angle);

//Title: Wedge Module
//Author: Alex English - ProtoParadigm
//Date: 1/4/2013
//License: Creative Commons - Share Alike - Attribution

//Usage: Include in your other .scad projects and call wedge with arguments for the height of the wedge, the radius of the wedge, and the angle of the wedge in degrees.  The resulting wedge will be placed with the point at the origin, extending into the z axis, with the angle starting at the x axis and extending counter-clockwise as per the right-hand rule.

//Updated: 1/12/2013 - Increased dimensions of wedge to be revoved when angle is more than 180 as per suggestion from kitwallace.

module wedge_180(h, r, d)
{
  rotate(d) difference()
  {
    rotate(180-d) difference()
    {
      cylinder(h = h, r = r);
      translate([-(r+1), 0, -1]) cube([r*2+2, r+1, h+2]);
    }
    translate([-(r+1), 0, -1]) cube([r*2+2, r+1, h+2]);
  }
}

module wedge(h, r, d)
{
  if(d <= 180)
    wedge_180(h, r, d);
  else
    rotate(d) difference()
    {
      cylinder(h = h, r = r);
      translate([0, 0, -1]) wedge_180(h+2, r+1, 360-d);
    }
}

module side_wall() {
  side_length = clamp_y_intercept / cos(side_angle) - W * sin(side_angle);

  translate([-handle_length/2, clamp_y_intercept])
  rotate([90, 0, -(90 - side_angle)])
  linear_extrude(height = wall_thickness)
  polygon([
    [0, handle_flange_length/2],
    [side_length, clamp_length/2],
    [side_length, -clamp_length/2],
    [0, -handle_flange_length/2]
  ]);

  translate([-clamp_gap/2 - wall_thickness, 0, -clamp_length/2])
  wedge(h = clamp_length, r = wall_thickness, d = side_angle + 1);

  translate([-handle_length/2, clamp_y_intercept, -handle_flange_length/2])
  rotate([0, 0, 180])
  wedge(h = handle_flange_length, r = wall_thickness, d = side_angle + 1);
}

//-- Locating pin hole with glue recess
// http://softsolder.com/2013/11/12/improved-alignment-pin-hole-for-split-3d-prints/ 

module PolyCyl(Dia,Height,ForceSides=0) {           // based on nophead's polyholes
  Sides = (ForceSides != 0) ? ForceSides : (ceil(Dia) + 2);
  FixDia = Dia / cos(180/Sides);
  cylinder(r=FixDia/2 + hole_clearance,
           h=Height,
           $fn=Sides);
}

module LocatingPin(Dia=pin_diameter,Len=5.00) {
   
  translate([0,0,-layer_height])
  PolyCyl((Dia + 2*extrusion_width),2*layer_height,4);
   
  translate([0,0,-2*layer_height])
  PolyCyl((Dia + 1*extrusion_width),4*layer_height,4);
   
  translate([0,0,-(Len/2 + layer_height)])
  PolyCyl(Dia,(Len + 2*layer_height),4);
}

module part() {
  translate([0, clamp_y_intercept, 0])
  handle();

  translate([0, -clamp_outer_diameter/2 - clamp_flange_length, 0])
  clamp();

  side_wall();
  mirror([1, 0, 0]) side_wall();
}

module tabs() {
  top_left_y = clamp_y_intercept + handle_flange_length;
  top_left_x = -handle_length/2 - wall_thickness;

  translate([top_left_x - 5, top_left_y - 5, 0])
  cube([10 + wall_thickness, 10, layer_height]);

  translate([handle_length/2 - 5, top_left_y - 5, 0])
  cube([10 + wall_thickness, 10, layer_height]);

  translate([-(clamp_gap/2 + wall_thickness + 5), -(2*clamp_flange_length + 2*wall_thickness + clamp_inner_diameter + 5), 0])
  cube([10 + 2*wall_thickness + clamp_gap, 10, layer_height]);
}

module split() {
  difference() {
    part();
    translate([-200, -200, -100])
    cube([400, 400, 100]);

    translate([clamp_gap/2 + wall_thickness/2, -(1.5*clamp_flange_length + 2*wall_thickness + clamp_inner_diameter)])
    LocatingPin();

    translate([-(clamp_gap/2 + wall_thickness/2), -(1.5*clamp_flange_length + 2*wall_thickness + clamp_inner_diameter)])
    LocatingPin();

    translate([(handle_length + wall_thickness)/2, clamp_y_intercept + handle_flange_length - handle_flange_border - handle_wall_thickness/2, 0])
    LocatingPin();

    translate([-(handle_length + wall_thickness)/2, clamp_y_intercept + handle_flange_length - handle_flange_border - handle_wall_thickness/2, 0])
    LocatingPin();
  }
  tabs();
}

if (layout == "whole") part();
else split();